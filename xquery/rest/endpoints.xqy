xquery version "1.0-ml";

module namespace endpoints="urn:kode1100:rest:modules:endpoints";

import module namespace rce="urn:kode1100:rest:modules:common:endpoints" at "lib-rest/common-endpoints.xqy";

declare namespace rest="http://marklogic.com/appservices/rest";

(: ---------------------------------------------------------------------- :)

declare private variable $endpoints as element(rest:options) :=
	<options xmlns="http://marklogic.com/appservices/rest">
		<!-- root -->
		<request uri="^(/?)$" endpoint="/xquery/default.xqy" />

        <request uri="^/load(/)?$" endpoint="/xquery/handlers/load.xqy" user-params="allow">
			<http method="GET"/>
		</request>
		
		<request uri="^/rates(/)?$" endpoint="/xquery/handlers/get-rates.xqy" user-params="allow">
			<http method="GET"/>
		</request>



		<!-- ================================================================= -->

		{ $rce:DEFAULT-ENDPOINTS }
	</options>;

(: ---------------------------------------------------------------------- :)

declare function endpoints:options (
) as element(rest:options)
{
	$endpoints
};
