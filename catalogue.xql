xquery version "1.0";

import module namespace  functx="http://www.functx.com" at "xmldb:exist:///db/functions/functionxlib/functx-1.0-doc-2007-01.xq";
import module namespace kwic="http://exist-db.org/xquery/kwic";

declare namespace marc = "http://www.loc.gov/MARC21/slim";
declare variable $raw-records := collection('/db/marc/')//marc:collection;
declare variable $clean-records := collection('/db/marc/')//records;
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=no indent=yes 
        doctype-public=-//W3C//DTD&#160;HTML&#160;4.01&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/loose.dtd";

declare function local:filter-title($titletext) as xs:string {
    let $filteredtext := replace($titletext, "[\\=:]", "")
    return $filteredtext
};

declare function local:filter-name($nametext) as xs:string {
    let $filteredtext := replace($nametext, ",$", "")
    return $filteredtext
};
    

let $perpage := xs:integer(request:get-parameter("perpage", "6"))
let $start := xs:integer(request:get-parameter("start", "0"))
let $order-request := xs:string(request:get-parameter("order", "creator"))
let $exact-q := xs:string(request:get-parameter("exact", "false"))


let $creator-select := if ($order-request = "creator") then ( <option value="creator" selected="selected">Composer</option> ) else ( <option value="creator">Composer</option> )
let $title-select := if ($order-request = "title") then ( <option value="title" selected="selected">Title</option> ) else ( <option value="title">Title</option> )

let $raw-q := request:get-parameter("q", "")
let $q := replace(lower-case($raw-q), "[&amp;&quot;-*;-`~!@#$%^*()_+-=\[\]\{\}\|';:/.,?(:]", "")
(::)

let $vtls := xs:string(request:get-parameter("vtls", ""))
let $url-params-without-vtls := replace(request:get-query-string(), concat('&amp;vtls=', $vtls ) , '')
let $url-params-without-q := replace(request:get-query-string(), concat('&amp;q=', $q ) , '')
let $url-params-without-q-or-vtls := replace($url-params-without-vtls, concat('&amp;q=', $q ) , '')

let $records :=
    if ($q != '' and $exact-q = "true") then ( 
        for $hit in $raw-records//marc:datafield[@tag="100"]/marc:subfield[@code="a"]
        where $hit = $raw-q
        return $hit/../.. ) 
    else if ( $q != '' ) then (
        for $hit in functx:distinct-nodes($raw-records//marc:subfield[ft:query(., concat($q, '~'))]/ancestor::marc:record) 
        return $hit ) 
    else  ( 
        $raw-records//ancestor::marc:record 
        )
    
let $total-result-count := count($records)
let $start := if ($start ge $total-result-count) then ( 0 ) else ( $start )
let $end := 
    if ($total-result-count lt $perpage) then 
        $total-result-count
    else 
        $start + $perpage
let $number-of-pages := 
    xs:integer(ceiling($total-result-count div $perpage))
let $current-page := xs:integer(($start + $perpage) div $perpage)
let $url-params-without-start := replace(request:get-query-string(), '&amp;start=\d+', '')
let $url-params-without-perpage := replace(request:get-query-string(), '&amp;perpage=\d+', '')
let $order-values := ('&amp;order=title','&amp;order=creator')
let $url-params-without-order := functx:replace-multi(request:get-query-string(), $order-values, ('','',''))

let $results-set := 
    for $record in $records
    
    let $vtls := data($record//marc:controlfield[@tag="001"])
    let $marc-creator := $record//marc:datafield[@tag="100"]/marc:subfield[@code="a"]
    let $clean-record := $clean-records/record/identifier[contains(.,$vtls)]/..
    let $creator := data($clean-record/creator)
    let $dates := data($clean-record/dates)
    let $title := data($clean-record/title)
    let $marc-title := $record//marc:datafield[@tag="245"]/marc:subfield[@code="a"]
    (: let $subtitle := data($record//marc:datafield[@tag="245"]/marc:subfield[@code="b"])
    let $attribution := data($record//marc:datafield[@tag="245"]/marc:subfield[@code="c"]) :)
    
    order by (if ($order-request = "title") then ($marc-title) else ($marc-creator) )
    
    return 
  
        
        <div>
            <h2 class="name">{local:filter-name($creator)}</h2> 
            <p class="title">
               <a href="record.xql?vtls={$vtls}">{local:filter-title($title)}</a>
            </p>
            <a href="record.xql?vtls={$vtls}"><img src="sheet_music/cutouts/{$vtls}_cutout.jpg" alt="Composer" width="280" height="180" border="0" /></a>  
        </div>
         


let $sorted-results :=
    if (count($results-set) eq 0) then (
        <div>
            <p class="note">Sorry. Nothing matches your search query "{$raw-q}". Please try searching again.</p>
        </div>
    ) else (
        for $record at $count in $results-set[position() = ($start + 1) to $end]
        let $islast := if ($count > 2 and $count mod 3 = 0 ) then ("last") else ("")
        return
        <div class="size1 viewicon {$islast}">
            {$record}
        </div>
    )

let $page-index := 
    <span class="options fl">Showing Items {$start + 1} - { if ($end le $total-result-count) then ( $end  ) else ( $total-result-count ) } of {$total-result-count}
    </span>
    
let $search-input :=
    <input id="searchtext" name="q" type="text" class="ss" alt="{if ($q = "") then ( "Search the Library" ) else ( $q )}" value="{$q}" />
        
let $order-links :=
    if ($order-request = "title") then (
    <div>
        <span>Sort by: </span>
        <span>Title</span>
        <span><a href="{concat('?', $url-params-without-order, '&amp;order=creator')}">Composer</a></span>
    </div> ) else (
    <div>
        <span>Sort by: </span>
        <span><a href="{concat('?', $url-params-without-order, '&amp;order=title')}">Title</a></span>
        <span>Composer</span>
    </div> )

let $perpage-links :=
    if ($perpage = 6) then (
        <span class="options fr">View  
            <a class="on" href="{concat('?', $url-params-without-perpage, '&amp;perpage=6')}">6</a> // 
            <a href="{concat('?', $url-params-without-perpage, '&amp;perpage=12')}">12</a> // 
            <a href="{concat('?', $url-params-without-perpage, '&amp;perpage=24')}">24</a>
        </span>
     ) else if ($perpage = 12) then (
        <span class="options fr">View  
            <a href="{concat('?', $url-params-without-perpage, '&amp;perpage=6')}">6</a> // 
            <a class="on" href="{concat('?', $url-params-without-perpage, '&amp;perpage=12')}">12</a> // 
            <a href="{concat('?', $url-params-without-perpage, '&amp;perpage=24')}">24</a>
        </span>
     ) else (
        <span class="options fr">View  
            <a href="{concat('?', $url-params-without-perpage, '&amp;perpage=6')}">6</a> // 
            <a href="{concat('?', $url-params-without-perpage, '&amp;perpage=12')}">12</a> // 
            <a class="on" href="{concat('?', $url-params-without-perpage, '&amp;perpage=24')}">24</a>
        </span>
     )

let $pagination-links := 
    if ($total-result-count = 0) then ()
    else
    <div id="result-pagination" class="size3 last">
        <span class="options fl"> Page {$current-page} of {$number-of-pages}</span>
        <span class="options fr">
                {
                (: Show 'Previous' for all but the 1st page of results :)
                    if ($current-page = 1) then ()
                    else
                       ( <a href="{concat('?', $url-params-without-start, '&amp;start=', $perpage * ($current-page - 2)) }">previous</a>, <span>|</span>  )
                }
             
                {
                (: Show links to each page of results :)
                    let $max-pages-to-show := 3
                    
                    let $start-page := 
                        if ($current-page le ($max-pages-to-show - 1)) then
                            1
                        else $current-page - 1
                    let $end-page := 
                        if ($number-of-pages le ($current-page + 1)) then
                            $number-of-pages
                        else $current-page + 1
                    for $page in ($start-page to $end-page)
                    let $newstart := $perpage * ($page - 1)
                    return
                        (
                        if ($newstart eq $start) then 
                            (<a class="on" href="{concat('?', $url-params-without-start, '&amp;start=', $page)}">{$page}</a>)
                        else (
                            <a href="{concat('?', $url-params-without-start, '&amp;start=', $newstart)}">{$page}</a>
                        )
                        )
                }
 
                {
                (: Shows 'Next' for all but the last page of results :)
                    if ($start + $perpage ge $total-result-count) then ()
                    else
                        ( <span>|</span>,<a href="{concat('?', $url-params-without-start, '&amp;start=', $start + $perpage)}">next</a> )
                }
            </span>
        </div>
        
return

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" type="text/css" href="stylesheets/main.css" />
        <link rel="stylesheet" type="text/css" href="stylesheets/grids.css" />
        <link rel="stylesheet" type="text/css" href="stylesheets/titletext.css" />
        <link rel="shortcut icon" href="images/name.ico" type="images/x-icon" />
        <script type="text/javascript" src="javascript/mootools-core-1.3-full-compat.js"></script>
        <script type="text/javascript" src="javascript/mootools-more.js"></script>
        <script type="text/javascript" src="javascript/naic.js"></script>

        <title>National Archive of Irish Composers</title>
    </head>
    <body>
        <div class="wrapper">           
            <div class="navigation">
                         <ul>
                                <li><a href="index.html">HOME</a></li>
                                <li class="space">//</li>
                                <li><a href="performance.html">PERFORMANCE</a></li>
                                <li class="space">//</li>
                                <li class="selected"><a href="catalogue.xql">DIGITAL LIBRARY</a></li>
                                <li class="space">//</li>
                                <li><a href="credits.html">ACKNOWLEDGEMENTS</a></li>
                        </ul>
            </div><!-- close navigation -->
            
            <div class="textbrand"></div> <!-- close textbrand -->  
            
            <div class="imagebrand"></div><!-- close imagebrand -->
                
            <div class="line">
                <h1 class="header fl">Browse the Digital Library</h1>
                <div class="size7 last fr">    

                        {$search-input}
                        <img id="gobut" src="images/gobut.jpg" class="gobut" alt="Go"/>
                        <!-- input id="gobut" name="" type="submit" class="gobut" value="Go" /-->

                </div>
            </div><!-- close line -->
        
            <div class="size3">
                <span class="options">Sort Library by
                    <select id="sortoptions" name="sortoptions" class="sort">                
                        {$creator-select}
                        {$title-select}
                    </select>
                </span>
            </div><!-- close size3 -->
            <div class="size3">
                {$page-index}            
                {$perpage-links}
            </div><!-- close size3 -->        
            {$pagination-links}
            
            
            <div class="line">
                {$sorted-results}  
            </div><!-- close line -->
            <div class="clearfix"></div><!-- close clearfix -->
            <div class="base">
                <a id="v_toggle" href="#">
                    <span id="vertical_status">&#169; NAIC 2010</span>
                </a>
                <div class="basetext" id="vertical_slide">Materials available on this web site are for the purpose of research
                    and private study.  For all other uses, including publication, mirroring, performance, recording and broadcasting, permission must be
                    sought in advance and proper acknowledgement made to the National
                    Library of Ireland, The National Archive of Irish Composer’s website:
                    www.naic.ie, and to any composers, performers or writers involved. It
                    is also a condition of permission that a published copy of all
                    reproduced materials be supplied, whether they be in written, audio or
                    video form. email:permissions@nli.ie</div><!-- close basetext -->    
            </div><!-- close base -->    
        </div><!-- close wrapper -->
    </body>
</html>