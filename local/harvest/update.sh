#!/bin/bash
#
# Bash script to start the import of MARC-XML data harvested via OAI-PMH
#
# VUFIND_HOME
#   Path to the vufind installation
#
# usage:
#	update.sh DATE
#
# arguments:
#	DATE in YYYY-MM-DD format sets the from argument for OAI-PMH
#

##################################################
# Set VUFIND_HOME
##################################################
if [ -z "$VUFIND_HOME" ]
then
  VUFIND_HOME="/usr/local/vufind"
fi

today=$(date +"%Y-%m-%d")

#php $VUFIND_HOME/harvest/harvest_oai.php DAI_ALL --from $1
ruby $VUFIND_HOME/local/import/collect-marc-xml.rb $VUFIND_HOME/local/harvest/DAI_ALL/
$VUFIND_HOME/harvest/batch-import-marc.sh DAI_ALL > $VUFIND_HOME/local/harvest/DAI_ALL/log/import_$today.log
$VUFIND_HOME/harvest/batch-delete.sh DAI_ALL
