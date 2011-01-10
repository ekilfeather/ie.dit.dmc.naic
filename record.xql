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

let $vtls-q := xs:string(request:get-parameter("vtls", "null"))
let $start-q := xs:string(request:get-parameter("start", "1"))
let $padded-start := functx:pad-integer-to-length($start-q, 2)
let $start := xs:integer($start-q) 
let $url-params-without-start := replace(request:get-query-string(), '&amp;start=\d+', '')

let $record := $raw-records//marc:controlfield[@tag='001'][.=$vtls-q]/..
let $clean-record := $clean-records/record/identifier[contains(.,$vtls-q)]/..
    
let $creator := data($record//marc:datafield[@tag="100"]/marc:subfield[@code="a"])
let $clean-creator := data($clean-record/creator)
let $clean-dates := if (functx:all-whitespace($clean-record/dates)) then () else (concat("(", normalize-space(data($clean-record/dates)), ")"))
let $clean-title := data($clean-record/title)
let $clean-subtitle := data($clean-record/subtitle)
let $top-audio := if ($clean-record/audio) then ( <span class="selection"><a href="audio/{$vtls-q}.mp3"><img src="images/mp3_play.png"  border="0"/></a></span> ) else ()
let $bottom-audio := if ($clean-record/audio) then ( <p class="record"><a href="audio/{$vtls-q}.mp3">Download MP3</a></p> ) else ()

let $file-count := count($record//marc:datafield[@tag="856"]/marc:subfield[@code="u"])
let $other-records := 
    for $record at $count in $raw-records//marc:datafield[@tag="100"]/marc:subfield[@code="a"][.=$creator]
    let $other-vtls := data($record/../../marc:controlfield[@tag="001"])
    let $anchor := if ($other-vtls eq $vtls-q) then ( <a class="selected" href="record.xql?vtls={$other-vtls}">{$count}</a> ) else ( <a href="record.xql?vtls={$other-vtls}">{$count}</a> )
    return $anchor

let $composers :=
    for $hit in distinct-values(($raw-records//marc:datafield[@tag="100"]/marc:subfield[@code="a"]))
    let $hit-record := $raw-records//marc:datafield[@tag="100"]/marc:subfield[@code="a"][.=$hit][1]/../..
    let $first-work := data($hit-record//marc:controlfield[@tag="001"])
    let $selected := 
        if (data($hit) = $creator) then  
        ( <li class="on"><a href="record.xql?vtls={$first-work}">{local:filter-name(data($hit))}</a></li> ) else 
        ( <li><a href="record.xql?vtls={$first-work}">{local:filter-name(data($hit))}</a></li> )
        order by $hit
    return $selected
    
let $perpage := xs:integer('2')
    
let $total-result-count := count($other-records)      

let $vtls := data($record//marc:controlfield[@tag="001"])

let $details := 
    for $subfield in $record//marc:datafield[@tag="650"]/marc:subfield
    return <span>{data($subfield)}&#160;-</span>

        
let $previous-nav :=                     
    if ($start = 1) then 
    ( <span class="previousnav">&#160;</span> )
    else
    ( <a href="{concat('?', $url-params-without-start, '&amp;start=', ($start - 1)) }">Previous</a> )
                       
let $next-nav := 
    if ($start ge $file-count) then 
    ( <span class="nextnav">&#160;</span> )
    else
    ( <a href="{concat('?', $url-params-without-start, '&amp;start=', $start + 1)}">Next</a> )

let $pagination-links := 

    <div id="result-pagination" class="linesml mt10 navNum">
        <span>
                {
                (: Show 'Previous' for all but the 1st page of results :)
                    if ($start = 1) then ( <span>&#160;</span> )
                    else
                       ( <a href="{concat('?', $url-params-without-start, '&amp;start=', ($start - 1)) }">&lt;&lt;</a>  )
                }
             
                {
                (: Show links to each page of results :)
                    let $max-pages-to-show := 5
                    
                    let $start-page := 
                            if ($start le 3 ) then
                            ( 1 ) else if
                            ( $file-count - $start eq 2 ) then
                            ( $start - 2 ) else if
                            ( $file-count - $start eq 1 ) then
                            ( $start - 3 ) else if
                            ( $file-count - $start eq 0 ) then
                            ( $start - 4 ) else
                            ( $start - 2 )
                    let $end-page := 
                            if ( $start + 4 le $file-count and $start eq 1 ) then
                            ( $start + 4 ) else if
                            ( $start + 3 le $file-count and $start eq 2 ) then
                            ( $start + 3 ) else if
                            ( $start + 2 le $file-count ) then
                            ( $start + 2 ) else if
                            ( $start + 1 le $file-count ) then 
                            ( $start + 1 ) else
                            ( $file-count )
                    for $page in ($start-page to $end-page)
                    let $newstart := ( $page  )
                    return
                        (
                            if ($newstart eq $start) then 
                            ( <a class="on" href="{concat('?', $url-params-without-start, '&amp;start=', $page)}">{$page}</a> )
                            else 
                            ( <a href="{concat('?', $url-params-without-start, '&amp;start=', $newstart)}">{$page}</a> )
                        )
                }
 
                {
                (: Shows 'Next' for all but the last page of results :)
                    if ($start ge $file-count) then ( <span>&#160;</span> )
                    else
                        (<a href="{concat('?', $url-params-without-start, '&amp;start=', $start + 1 )}">&gt;&gt;</a> )
                }
            </span>
        </div> 

let $pdf := if ($vtls-q != "null") then (<span class="selection"><a href="sheet_music/pdfs/{$vtls}.pdf">Download PDF</a></span>) else ()
let $navnum := if ($vtls-q != "null") then (
                        <div class="navNum">
                            Page {$start} of {$file-count}
                        </div>
                        ) else ()
                        
                        
let $size6 := if ($vtls-q = "null") then 
                (
                    <div class="size6">
                        <p>Please select a composer on the left or else carry out a search.</p>
                    </div>
                
                ) else (                 
                <div class="size6">
                    <div class="size3">
                        <h2 class="title">Title</h2>
                        <p class="record">{$clean-title}&#160;{$clean-subtitle}</p>
                        <h2 class="title">Details</h2>
                        <p>{$details}<br/>
                            <a href="http://catalogue.nli.ie/Record/{$vtls}">Read more...</a>
                        </p>
                        {$bottom-audio}
                    </div>
    
                </div> )
let $size2 := if ($vtls-q != "null") then (                
                <div class="size2">
                    <div class="linesml">
                        <span class="previousnav">
                            {$previous-nav}
                        </span>
                        <span class="nextnav">
                            {$next-nav}
                        </span>
                    {$navnum}
                    </div>
                    <img src="sheet_music/{$vtls}/{$vtls}_{$padded-start}.jpg" alt="" />
                    {$pagination-links}  
                </div> ) else (
                <div class="size2">
                    <div class="linesml">
                        <span class="previousnav">

                        </span>
                        <span class="nextnav">

                        </span>

                    </div> 
                </div>
                )
        
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
            <div class="textbrand"></div>   <!-- close textbrand -->  
            <div class="imagebrand"></div>  <!-- close imagebrand -->
                
            <div class="line">
            <h1 class="header fl">{$clean-title}</h1>

                <div class="size7"> 
                    <input id="searchtext" name="q" type="text" class="ss" alt="Search the Library" />
                    <img id="gobut" src="images/gobut.jpg" class="gobut" alt="Go"/>
                </div><!-- close size7 -->
            </div><!-- close line -->
        
            <div class="size8">
                <h2 class="title">{normalize-space($clean-creator)}&#160;{$clean-dates}</h2>
            </div><!-- close size3 -->
            <div class="size9">
                {$top-audio}
                {$pdf}
            </div><!-- close size3 -->
            <div class="size3  last pages">
                Records for this Composer 
                {$other-records}
            </div><!-- close size3 pages -->
            
            <div class="line">  
{$size2}
            
            
                <div class="size4 last">
                    <h2 class="label">Composers</h2>
                    <ul class="namelist"> 
                        {$composers}
                    </ul>
                </div><!-- close size4 last-->
                {$size6}
                
                

            </div><!-- close line -->
            <div class="clearfix"></div><!-- close clearfix -->
            <div class="base">
                <a id="v_toggle" href="#"><span id="vertical_status">&#169; NAIC 2010</span></a>
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