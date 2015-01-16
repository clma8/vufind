#!/usr/bin/env ruby
#
# Ruby script for aleph sequential to marc binary conversion
#

require 'marc'
require 'marc_alephsequential'
require 'pp'

vufind_home = ENV['VUFIND_HOME'] || '/usr/local/vufind'

name = File.basename(ARGV[0], File.extname(ARGV[0]))
reader = MARC::AlephSequential::Reader.new(ARGV[0])
marc_dir = vufind_home + "/local/import/mrc/"
Dir.mkdir marc_dir unless File.exists? marc_dir
writer = MARC::Writer.new(marc_dir + name + ".mrc")
log_dir = vufind_home + "/local/import/log/"
Dir.mkdir log_dir unless File.exists? log_dir
logger = Logger.new(vufind_home + log_dir + name + ".log")

begin
	reader.each do |r|
		begin
			# filter out duplicate thesaurus fields
			r.find_all { |f| f.tag =~ /^T../ }.each do |f|
				r.fields.delete f
			end
    		writer.write r
    	rescue => e
    		logger.error "Error while writing record #{r['001']} to MARC: #{e.message}"
    	end
	end  
rescue MARC::AlephSequential::Error => e
	logger.error "Error while parsing record #{e.record_id} at/near #{e.line_number}: #{e.message}"
    retry # may or may not work the way you'd hope/expect
rescue => e
	logger.error "Other error of some sort. quitting. #{e.message}"
end

writer.close()
puts "finished"