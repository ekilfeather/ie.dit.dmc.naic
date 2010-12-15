xquery version "1.0";

import module namespace  functx="http://www.functx.com" at "xmldb:exist:///db/functions/functionxlib/functx-1.0-doc-2007-01.xq";
import module namespace kwic="http://exist-db.org/xquery/kwic";

declare namespace marc = "http://www.loc.gov/MARC21/slim";
declare variable $raw-records := collection('/db/marc/')//marc:collection/marc:record;
declare option exist:serialize "method=html media-type=text/plain omit-xml-declaration=yes indent=yes encoding=ISO-8859-1";
    
let $catalogue-dump :=
    for $record in $raw-records
    let $vtls := data($record//marc:controlfield[@tag="001"])
    let $creator := data($record//marc:datafield[@tag="100"]/marc:subfield[@code="a"])
    let $datedata := data($record//marc:datafield[@tag="100"]/marc:subfield[@code="d"])
    let $title := normalize-space(data($record//marc:datafield[@tag="245"]/marc:subfield[@code="a"]))
    let $subtitle := normalize-space(data($record//marc:datafield[@tag="245"]/marc:subfield[@code="b"]))
    let $attribution := normalize-space(data($record//marc:datafield[@tag="245"]/marc:subfield[@code="c"]))
    return ( text{concat("http://naic.ie/record.xql?vtls=", $vtls), "*", $creator, "*", $datedata, "*", $title, "*", $subtitle, $attribution} )
        
return $catalogue-dump
