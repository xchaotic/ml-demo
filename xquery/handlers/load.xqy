xquery version '1.0-ml';

import module namespace functx = "http://www.functx.com" at "/MarkLogic/functx/functx-1.0-nodoc-2007-01.xqy";

declare namespace ml-demo = "http://kode1100.com/namespaces/ml-demo";
declare namespace e = "http://kode1100.com/namespaces/errors";

declare variable $start-date as xs:date := xs:date ("1970-01-01");
   
for $j in (1 to 100)
let $date := if ($j = 1) then ($start-date) else (functx:next-day($start-date))
return 
	 xdmp:spawn("./generate-fpml.xqy", (xs:QName("start-date"), $date),
	  <options xmlns="xdmp:eval">
	    <result>{fn:true()}</result>
	  </options>)
	  