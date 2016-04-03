xquery version '1.0-ml';

declare namespace fpml = "http://www.fpml.org/2007/FpML-4-4";

let $results := cts:search ( fn:collection ('urn:kode1100.com:collection:transactions'), cts:element-range-query (xs:QName("fpml:rate"), "<=", xs:double("1.5")))/fpml:FpML/fpml:position/fpml:constituent/fpml:trade/fpml:fxSingleLeg/fpml:exchangeRate/fpml:rate/string() [1 to 100000]
let $output :=
              <results>
              <estimate>{xdmp:estimate(cts:search( fn:collection ('urn:kode1100.com:collection:transactions'), cts:element-range-query (xs:QName("fpml:rate"), "<=", xs:double("1.5"))))}</estimate>
              <qtime>{xdmp:elapsed-time()}</qtime>
              {for $result in $results [1 to 100]
              return <result>{$result}</result>
              }</results>  
              
return $output
