xquery version "1.0";

import module namespace  functx="http://www.functx.com" at "xmldb:exist:///db/functions/functionxlib/functx-1.0-doc-2007-01.xq";

declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=no indent=yes 
        doctype-public=-//W3C//DTD&#160;HTML&#160;4.01&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/strict.dtd
        charset=UTF-8";

let $displaydiv := xs:integer(request:get-parameter("display", "1")) - 1

return
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="refresh" content="0;url=index.html"/>
        <link rel="stylesheet" type="text/css" href="stylesheets/main.css" />
        <link rel="stylesheet" type="text/css" href="stylesheets/grids.css" />
        <link rel="stylesheet" type="text/css" href="stylesheets/titletext.css" />
        <link rel="shortcut icon" href="images/name.ico" type="images/x-icon" />
        <script type="text/javascript" src="javascript/mootools-core-1.3-full-compat.js"></script>
        <script type="text/javascript" src="javascript/mootools-more.js"></script>
        <script type="text/javascript" src="javascript/naic.js"></script>
        <script type="text/javascript">var displaydiv = {$displaydiv}</script>
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
                                <li class="selected"><a href="composers.xql">COMPOSERS</a></li>
                                <li class="space">//</li>
                                <li><a href="catalogue.xql">DIGITAL LIBRARY</a></li>
                                <li class="space">//</li>
                                <li><a href="credits.html">CREDITS</a></li>
                        </ul>
         </div><!-- close navigation -->
        <div class="textbrand"></div>
        <!-- close textbrand -->
        <div class="imagebrand"></div>
        <!-- close imagebrand -->
        <div class="line">
            <h1 class="header fl">Composers</h1>
        </div>
        <!-- close line -->
        <div class="size5 bbdash"> <span class="titleselect on">John Field</span>
            <div class="blind">
                <p>John Field was born in Dublin where he performed at the Rotunda Assembly Rooms as a child prodigy at the age of nine. The Dublin Evening Post noted his appearance as ‘an astonishing performance by such a child’. After moving to London, Field was apprenticed to Muzio Clementi acting as demonstrator on Clementi’s pianos and later travelled with him to Russia to set up a piano showroom. Thereafter, Field established himself as a popular performer and teacher and Russia became his home until his death.</p>
                <p>Field developed a new style of piano playing with his insistence on singing tone and the ‘floating’ feeling he achieved in his passagework.  His lightness of touch and the sweetness of his cantabile phrases became legendary throughout Europe where the ‘school of Field’ was followed by many of the leading teachers including Chopin’s early mentor Jozef Elsner and Friedrich Wieck, father and teacher of Clara Schumann. Field was most noted for his invention of the nocturne, a work reflecting mood and atmosphere, at a time when the piano ‘piece’ was far from commonplace. The style of his nocturnes influenced Chopin most prominently but also affected Liszt, Mendelssohn and countless other composers. </p>
                <p>Field’s rondo on A Favorite Scotch Air is a closely-related transcription of the slow movement of his Piano Concerto no. 1 which the composer first performed in London at the age of seventeen.  It uses the popular melody from James Hook’s song: Twas within a Mile of Edinboro’ Town. </p>
                <p>The Irish air Go to the Devil and shake Yourself  appears to have been very popular in the last years of the eighteenth century; other works based on the tune were composed by Osmond Saffery, T. Haigh, T. Latour, Karl Kambra, and Joseph Dale between c1796 and 1800.  Field’s authorship of the work is very likely, as Clementi was an investor in the firm of Longman and Broderip, the publishers of the work, before setting up a business under his own name.</p>
            </div>
        </div>
        <!-- close size5 bbdash -->
        <div class="size5 bbdash"> <span class="titleselect">Thomas Augustine Geary</span>
            <div class="blind">
                <p>Thomas Augustine Geary was a pianist and organist whose early death cut short a promising career as a composer. He was a choirboy at St. Patrick’s Cathedral and also trained as an organist there. At the age of fourteen he was awarded the Amateur Society’s Prize Medal for a 6-part song, With Wine that Blissful Joy bestows. He often performed at charity concerts in Dublin at which he played his own compositions. His sets of keyboard variations on popular airs and folk tunes were widely published in Dublin and London. Wolfe Tone was one of the subscribers to the publication of a set of canzonets for one and two voices, dedicated to Mrs Cradock, wife of the Dean of St Patrick’s. Presumably his change of name from Timothy to Thomas Augustine was inspired by his admiration of the composer Arne.</p>
            </div>
        </div>
        <!-- close size5 bbdash -->
        <div class="size5 bbdash"> <span class="titleselect">Charlotte Maria Despard</span>
            <div class="blind">
                <p>A number of female composers are represented in the National Library’s collections, one of whom is Charlotte Maria Despard.  Little is known about this composer; her compositions were published some years before the birth of her celebrated namesake Charlotte Despard (née French, 1844 – 1939), the suffragette, novelist and Sinn Féin activist. However, the identity of the composer remains a mystery, although the unusual name does suggest a connection, particularly as her music has not been identified outside Ireland.</p>
                <p>Two Dublin musicians, Thomas (Tom) Cooke and John Field, had similar backgrounds. Both were born in the same year and belonged to musical families. Both were child prodigies and pupils of Giordani. Unlike his famous contemporary Cooke served his apprenticeship as a musician in Dublin as a performer, conductor and composer. He also opened a music shop at 45 Dame St. He led the orchestra and became music director at Crow Street Theatre and eventually went on the stage as a singer. This was such a success that he decided to move to London where he had a highly successful theatrical career. There are five portraits of him in the National Portrait Gallery. </p>
                <p>In 1804 Cooke displayed his versatility as a performer at a benefit concert in Dublin by playing a concertante for eight instruments including the pedal harp. St Patrick’s Day, the tune that he chose for this arrangement was closely associated with Irish identity, and audiences in Crow Street Theatre called for it as an anthem on patriotic occasions. In 1745 it was one of the tunes played by the pipers of the Irish Brigade at the Battle of Fontenoy. When Edward Bunting transcribed it from the harper Patrick Quin at the Belfast Harp Festival in 1792, George Petrie claimed that it had been published in Playford’s Dancing Master more than a hundred years earlier.</p>
            </div>
        </div>
        <!-- close size5 bbdash -->
        <div class="size5 bbdash"> <span class="titleselect">William Vincent Wallace</span>
            <div class="blind">
                <p>Waterford-born William Vincent Wallace, composer of the opera Maritana, had an interesting life. In 1835 he left Ireland and traversed the globe, beginning with a two-year stay in Australia, where he is still regarded as the first outstanding instrumentalist to visit that continent. Crossing the Pacific to Chile, Wallace made his way northwards to New York and when he arrived back in London in 1845, romantic tales of his travels helped to attract audiences. As a virtuoso on both the piano and the violin, it is likely that he was honing his extemporisations for several years as he travelled around the world, before committing his pieces to print. In both pieces on this programme Wallace pays homage to the Irish Melodies by using the titles of Moore’s songs. It is not difficult to imagine these melodramatic works as hugely successful crowd-pleasers. In the Minstrel Boy and Rory O’More the story is told as the piano represents the harp. A funeral march is introduced as the minstrel boy enters the ranks of death. This is followed by an operatic-style episode signifying the rise of the minstrel’s soul to heaven, before launching into the lively Rory O’More theme and the dazzling coda. </p>
            </div>
        </div>
        <!-- close size5 bbdash -->
        <div class="size5"> <span class="titleselect">Thomas Moore</span>
            <div class="blind">
                <p>The celebrated poet Thomas Moore is best known for his enormously popular drawing-room songs, the Irish Melodies, published in ten volumes between 1808 and 1834. Their immediate appeal to the public was enhanced by the music that Moore chose for his poetry with airs drawn largely from anthologies of ancient harp music, particularly the collections of Edward Bunting first published after the Belfast Harp Festival in 1792. Taking on a new life, Moore’s songs brought the ancient music of Ireland before a global audience for the first time and were acclaimed both for the beauty of the melodies and their symbolic significance. </p>
                <p>The musical arrangements presented are those of the first editions by the prominent Dublin composer, Sir John Stevenson. Stevenson’s collaboration with Moore lasted until 1821; thereafter, the arrangements of the final volumes were composed by Henry Rowley Bishop. Considered by many to be too elaborate and out-of-step with the simple beauty of the airs, Stevenson’s arrangements caused controversy in their day. However, it is worth remembering that they were written in the prevailing style of the time, and are heard at their best when performed on a period instrument.</p>
                <p>Silent, oh Moyle, also known as The Song of Fionnuala intertwines the story of the legend of The Children of Lir with a political message. Moore glorifies the power of music and Irish culture with the symbolic destruction of the harp in the story of The Minstrel Boy. Finally, a song that has enjoyed so much celebrity, it even found its way into several Bugs Bunny and Daffy Duck cartoons. Believe me, if All those Endearing Young Charms is one of Moore’s most internationally recognised creations. In its original form it was justly celebrated, a simple and sincere lyric and a song of true and undying love.</p>
            </div>
        </div>
        <!-- close size5 bbdash -->
        <div class="clearfix"></div>
        <!-- close clearfix -->
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
                video form.</div>
            <!-- close basetext -->
        </div>
        <!-- close base -->
    </div>
    <!-- close wrapper -->
    </body>
</html>