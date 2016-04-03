xquery version '1.0-ml';

import module namespace functx = "http://www.functx.com" at "/MarkLogic/functx/functx-1.0-nodoc-2007-01.xqy";

declare namespace html = "http://www.w3.org/1999/xhtml";
declare namespace ml-demo = "http://kode1100.com/namespaces/ml-demo";

declare variable $start-date external;

let $number-of-daily-transactions := 100
return
      for $i in (1 to $number-of-daily-transactions)
      return 
        let $uuid as xs:string := sem:uuid-string()
        let $identifier as xs:string := "MSG" || $uuid
        let $rate := "1." || xs:string(xdmp:random(1000))
        let $amount := ((xdmp:random(1000) + 1) * 1000) 
        let $converted-amount := xs:double($rate) * $amount
        return 
          let $db-identifier as xs:string := "/transactions/" || $identifier || ".xml"
          let $collections := ("urn:kode1100.com:collection:records", "urn:kode1100.com:collection:transactions")
          let $xml := 
          <FpML xmlns="http://www.fpml.org/2007/FpML-4-4" xmlns:fpml="http://www.fpml.org/2007/FpML-4-4" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="4-4" xsi:schemaLocation="http://www.fpml.org/2007/FpML-4-4 ../../fpml-main-4-4.xsd http://www.w3.org/2000/09/xmldsig# ../../xmldsig-core-schema.xsd" xsi:type="PositionReport">
             <header>
                <messageId messageIdScheme="http://www.recserv.com/mid">{$identifier}</messageId>
                <sentBy>RECSERV</sentBy>
                <sendTo>ABCDUS33</sendTo>
                <creationTimestamp>{$start-date}</creationTimestamp>
             </header>
             <asOfDate>{$start-date}</asOfDate>
             <dataSetName>fundPortfolio1</dataSetName>
             <position>
                <positionId positionIdScheme="http://www.abc.com/positionId">Position-01</positionId>
                <version>3</version>
                <reportingRoles>
                   <baseParty href="fund"/>
                   <positionProvider href="dealer"/>
                </reportingRoles>
                <constituent>
                   <trade>
                      <tradeHeader>
                         <partyTradeIdentifier>
                            <partyReference href="dealer"/>
                            <tradeId tradeIdScheme="http://www.abc.com/fx/trade-id">111</tradeId>
                         </partyTradeIdentifier>
                         <tradeDate>{$start-date}</tradeDate>
                      </tradeHeader>
                      <fxSingleLeg>
                         <exchangedCurrency1>
                            <payerPartyReference href="fund"/>
                            <receiverPartyReference href="dealer"/>
                            <paymentAmount>
                               <currency>GBP</currency>
                               <amount>{$amount}</amount>
                            </paymentAmount>
                         </exchangedCurrency1>
                         <exchangedCurrency2>
                            <payerPartyReference href="dealer"/>
                            <receiverPartyReference href="fund"/>
                            <paymentAmount>
                               <currency>USD</currency>
                               <amount>{$converted-amount}</amount>
                            </paymentAmount>
                         </exchangedCurrency2>
                         <valueDate>{$start-date}</valueDate>
                         <exchangeRate>
                            <quotedCurrencyPair>
                               <currency1>GBP</currency1>
                               <currency2>USD</currency2>
                               <quoteBasis>Currency2PerCurrency1</quoteBasis>
                            </quotedCurrencyPair>
                            <rate>{$rate}</rate>
                         </exchangeRate>
                      </fxSingleLeg>
                   </trade>
                </constituent>
                <valuation>
                   <quote>
                      <value>12200.00</value>
                      <measureType>NPV</measureType>
                      <currency>USD</currency>
                   </quote>
                </valuation>
             </position>
             <party id="dealer">
                <partyId>ABCDUS33</partyId>
                <partyName>ABCD Securities Inc.</partyName>
             </party>
             <party id="fund">
                <partyId>HEGDUS33</partyId>
                <partyName>HedgeCo Capital L.L.C.</partyName>
             </party>
          </FpML>
          
          return xdmp:document-insert ($db-identifier, $xml, xdmp:default-permissions(), $collections)