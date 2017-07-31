<?php
/**
 * Record link view helper
 *
 * PHP version 5
 *
 * Copyright (C) Villanova University 2010.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2,
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
 * @category Zenon
 * @package  View_Helpers
 * @author   Simon Hohl <simon.hohl@dainst.org>
 * @license  http://opensource.org/licenses/gpl-2.0.php GNU General Public License
 * @link     https://vufind.org/wiki/development Wiki
 */
namespace Zenon\View\Helper\Root;
use VuFind\View\Helper\Root\RecordLink as ParentRecordLink;
/**
 * Record link view helper for Zenon Module
 *
 * @category Zenon
 * @package  View_Helpers
 * @author   Simon Hohl <simon.hohl@dainst.org>
 * @license  http://opensource.org/licenses/gpl-2.0.php GNU General Public License
 * @link     https://vufind.org/wiki/development Wiki
 */
class RecordLink extends ParentRecordLink
{
    /**
     * Given a record driver, generate a URL to fetch all child records for it.
     *
     * @param \VuFind\RecordDriver\AbstractBase $driver Host Record.
     *
     * @return string
     */
    public function getChildRecordSearchUrl($driver)
    {
        $urlHelper = $this->getView()->plugin('url');
        $url = $urlHelper('search-results')
            . '?lookfor='
            . urlencode(addcslashes($driver->getRawData()['is_hierarchy_id'], '"'))
            . '&type=ParentID';
// Make sure everything is properly HTML encoded:
        $escaper = $this->getView()->plugin('escapehtml');
        return $escaper($url);
    }
}