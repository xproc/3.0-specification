<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="1.0">
   <p:declare-step type="p:add-attribute" xml:id="add-attribute">
      <p:input port="source" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="match"
                select="'/*'"
                as="xs:string"
                e:type="XSLTMatchPattern"/>
      <p:option name="attribute-name" required="true" as="xs:QName"/>
      <p:option name="attribute-prefix" as="xs:NCName"/>
      <p:option name="attribute-namespace" as="xs:anyURI"/>
      <p:option name="attribute-value" required="true" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:add-xml-base" xml:id="add-xml-base">
      <p:input port="source" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="all" select="false()" as="xs:boolean"/>
      <p:option name="relative" select="true()" as="xs:boolean"/>
   </p:declare-step>
   <p:declare-step type="p:cast-content-type" xml:id="cast-content-type">
      <p:input port="source" content-types="*/*"/>
      <p:output port="result" content-types="*/*"/>
      <p:option name="content-type" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:compare" xml:id="compare">
      <p:input port="source" primary="true" content-types="*/*"/>
      <p:input port="alternate" content-types="*/*"/>
      <p:output port="result" content-types="application/xml"/>
      <p:output port="differences" content-types="*/*" sequence="true"/>
      <p:option name="method" as="xs:QName"/>
      <p:option name="fail-if-not-equal" select="false()" as="xs:boolean"/>
      <p:option name="parameters" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:count" xml:id="count">
      <p:input port="source" content-types="*/*" sequence="true"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="limit" select="0" as="xs:integer"/>
   </p:declare-step>
   <p:declare-step type="p:delete" xml:id="delete">
      <p:input port="source" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="match"
                required="true"
                as="xs:string"
                e:type="XSLTMatchPattern"/>
   </p:declare-step>
   <p:declare-step type="p:directory-list" xml:id="directory-list">
      <p:output port="result" content-type="application/xml"/>
      <p:option name="path" required="true" as="xs:anyURI"/>
      <p:option name="include-filter" as="xs:string" e:type="RegularExpression"/>
      <p:option name="exclude-filter" as="xs:string" e:type="RegularExpression"/>
   </p:declare-step>
   <p:declare-step type="p:error" xml:id="error">
      <p:input port="source" sequence="true" content-types="*/*"/>
      <p:output port="result" sequence="true" content-types="*/*"/>
      <p:option name="code" required="true" as="xs:QName"/>
      <p:option name="code-prefix" as="xs:NCName"/>
      <p:option name="code-namespace" as="xs:anyURI"/>
   </p:declare-step>
   <p:declare-step type="p:escape-markup" xml:id="escape-markup">
      <p:input port="source" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="serialization" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:filter" xml:id="filter">
      <p:input port="source" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" sequence="true" content-types="application/xml"/>
      <p:option name="select"
                required="true"
                as="xs:string"
                e:type="XPathExpression"/>
   </p:declare-step>
   <p:declare-step type="p:http-request" xml:id="http-request">
      <p:input port="source" content-types="*/*"/>
      <p:output port="result" sequence="true" content-types="*/*"/>
      <p:option name="serialization" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:identity" xml:id="identity">
      <p:input port="source" content-types="*/*" sequence="true"/>
      <p:output port="result" sequence="true" content-types="*/*"/>
   </p:declare-step>
   <p:declare-step type="p:insert" xml:id="insert">
      <p:input port="source"
               primary="true"
               content-types="application/xml text/xml */*+xml"/>
      <p:input port="insertion"
               sequence="true"
               content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="match"
                select="'/*'"
                as="xs:string"
                e:type="XSLTMatchPattern"/>
      <p:option name="position"
                required="true"
                as="xs:token"
                e:type="first-child|last-child|before|after"/>
   </p:declare-step>
   <p:declare-step type="p:label-elements" xml:id="label-elements">
      <p:input port="source" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="attribute" select="'xml:id'" as="xs:QName"/>
      <p:option name="attribute-prefix" as="xs:NCName"/>
      <p:option name="attribute-namespace" as="xs:anyURI"/>
      <p:option name="label"
                select="'concat(&#34;_&#34;,$p:index)'"
                as="xs:string"
                e:type="XPathExpression"/>
      <p:option name="match"
                select="'*'"
                as="xs:string"
                e:type="XSLTMatchPattern"/>
      <p:option name="replace" select="'true'" as="xs:boolean"/>
   </p:declare-step>
   <p:declare-step type="p:load" xml:id="load">
      <p:output port="result" sequence="true" content-types="*/*"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="parameters" as="xs:string"/>
      <p:option name="document-properties" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:make-absolute-uris" xml:id="make-absolute-uris">
      <p:input port="source" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="match"
                required="true"
                as="xs:string"
                e:type="XSLTMatchPattern"/>
      <p:option name="base-uri" as="xs:anyURI"/>
   </p:declare-step>
   <p:declare-step type="p:namespace-rename" xml:id="namespace-rename">
      <p:input port="source" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="from" as="xs:anyURI"/>
      <p:option name="to" as="xs:anyURI"/>
      <p:option name="apply-to"
                select="'all'"
                as="xs:token"
                e:type="all|elements|attributes"/>
   </p:declare-step>
   <p:declare-step type="p:pack" xml:id="pack">
      <p:input port="source"
               content-types="application/xml text/xml */*+xml"
               sequence="true"
               primary="true"/>
      <p:input port="alternate" sequence="true" content-types="application/xml"/>
      <p:output port="result" sequence="true"/>
      <p:option name="wrapper" required="true" as="xs:QName"/>
      <p:option name="wrapper-prefix" as="xs:NCName"/>
      <p:option name="wrapper-namespace" as="xs:anyURI"/>
   </p:declare-step>
   <p:declare-step type="p:parameters" xml:id="parameters">
      <p:output port="result" content-types="application/xml"/>
      <p:option name="parameters" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:rename" xml:id="rename">
      <p:input port="source" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="match"
                select="'/*'"
                as="xs:string"
                e:type="XSLTMatchPattern"/>
      <p:option name="new-name" required="true" as="xs:QName"/>
      <p:option name="new-prefix" as="xs:NCName"/>
      <p:option name="new-namespace" as="xs:anyURI"/>
   </p:declare-step>
   <p:declare-step type="p:replace" xml:id="replace">
      <p:input port="source"
               primary="true"
               content-types="application/xml text/xml */*+xml"/>
      <p:input port="replacement" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="match"
                required="true"
                as="xs:string"
                e:type="XSLTMatchPattern"/>
   </p:declare-step>
   <p:declare-step type="p:set-attributes" xml:id="set-attributes">
      <p:input port="source"
               primary="true"
               content-types="application/xml text/xml */*+xml"/>
      <p:input port="attributes" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="match"
                select="'/*'"
                as="xs:string"
                e:type="XSLTMatchPattern"/>
   </p:declare-step>
   <p:declare-step type="p:set-properties" xml:id="set-properties">
      <p:input port="source" content-types="*/*"/>
      <p:output port="result" content-types="*/*"/>
      <p:option name="properties" required="true" as="xs:string"/>
      <p:option name="merge" default="false()" as="xs:boolean"/>
   </p:declare-step>
   <p:declare-step type="p:sink" xml:id="sink">
      <p:input port="source" content-types="*/*" sequence="true"/>
   </p:declare-step>
   <p:declare-step type="p:split-sequence" xml:id="split-sequence">
      <p:input port="source"
               content-types="application/xml text/xml */*+xml"
               sequence="true"/>
      <p:output port="matched"
                sequence="true"
                primary="true"
                content-types="application/xml"/>
      <p:output port="not-matched" sequence="true" content-types="application/xml"/>
      <p:option name="initial-only" select="false()" as="xs:boolean"/>
      <p:option name="test"
                required="true"
                as="xs:string"
                e:type="XPathExpression"/>
   </p:declare-step>
   <p:declare-step type="p:store" xml:id="store">
      <p:input port="source" content-types="*/*"/>
      <p:output port="result" content-types="application/xml" primary="true"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="serialization" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:string-replace" xml:id="string-replace">
      <p:input port="source" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="match"
                required="true"
                as="xs:string"
                e:type="XSLTMatchPattern"/>
      <p:option name="replace"
                required="true"
                as="xs:string"
                e:type="XPathExpression"/>
   </p:declare-step>
   <p:declare-step type="p:unescape-markup" xml:id="unescape-markup">
      <p:input port="source" content-types="application/xml text/xml */*+xml text/*"/>
      <p:output port="result" content-types="application/xml text/xml */*+xml"/>
      <p:option name="namespace" as="xs:anyURI"/>
      <p:option name="content-type" select="'application/xml'" as="xs:string"/>
      <p:option name="encoding" as="xs:string"/>
      <p:option name="charset" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:unwrap" xml:id="unwrap">
      <p:input port="source" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="match"
                select="'/*'"
                as="xs:string"
                e:type="XSLTMatchPattern"/>
   </p:declare-step>
   <p:declare-step type="p:wrap" xml:id="wrap">
      <p:input port="source" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="wrapper" required="true" as="xs:QName"/>
      <p:option name="wrapper-prefix" as="xs:NCName"/>
      <p:option name="wrapper-namespace" as="xs:anyURI"/>
      <p:option name="match"
                required="true"
                as="xs:string"
                e:type="XSLTMatchPattern"/>
      <p:option name="group-adjacent" as="xs:string" e:type="XPathExpression"/>
   </p:declare-step>
   <p:declare-step type="p:wrap-sequence" xml:id="wrap-sequence">
      <p:input port="source"
               content-types="application/xml text/xml */*+xml"
               sequence="true"/>
      <p:output port="result" sequence="true" content-types="application/xml"/>
      <p:option name="wrapper" required="true" as="xs:QName"/>
      <p:option name="wrapper-prefix" as="xs:NCName"/>
      <p:option name="wrapper-namespace" as="xs:anyURI"/>
      <p:option name="group-adjacent" as="xs:string" e:type="XPathExpression"/>
   </p:declare-step>
   <p:declare-step type="p:xinclude" xml:id="xinclude">
      <p:input port="source" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml text/xml */*+xml"/>
      <p:option name="fixup-xml-base" select="'false'" as="xs:boolean"/>
      <p:option name="fixup-xml-lang" select="'false'" as="xs:boolean"/>
   </p:declare-step>
   <p:declare-step type="p:xslt" xml:id="xslt">
      <p:input port="source"
               content-types="application/xml text/xml */*+xml"
               sequence="true"
               primary="true"/>
      <p:input port="stylesheet" content-types="application/xml text/xml */*+xml"/>
      <p:option name="parameters" as="xs:string"/>
      <p:output port="result"
                primary="true"
                sequence="true"
                content-types="*/*"/>
      <p:output port="secondary" sequence="true"/>
      <p:option name="initial-mode" as="xs:QName"/>
      <p:option name="template-name" as="xs:QName"/>
      <p:option name="output-base-uri" as="xs:anyURI"/>
      <p:option name="version" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:exec" xml:id="exec">
      <p:input port="source"
               primary="true"
               sequence="true"
               content-types="*/*"/>
      <p:output port="result" primary="true" content-types="*/*"/>
      <p:output port="errors"/>
      <p:output port="exit-status"/>
      <p:option name="command" required="true" as="xs:string"/>
      <p:option name="args" select="''" as="xs:string"/>
      <p:option name="cwd" as="xs:string"/>
      <p:option name="source-is-xml" select="true()" as="xs:boolean"/>
      <p:option name="result-is-xml" select="true()" as="xs:boolean"/>
      <p:option name="wrap-result-lines" select="false()" as="xs:boolean"/>
      <p:option name="errors-is-xml" select="false()" as="xs:boolean"/>
      <p:option name="wrap-error-lines" select="false()" as="xs:boolean"/>
      <p:option name="path-separator" as="xs:string"/>
      <p:option name="failure-threshold" as="xs:integer"/>
      <p:option name="arg-separator" select="' '" as="xs:string"/>
      <p:option name="serialization" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:hash" xml:id="hash">
      <p:input port="source" primary="true" content-types="*/*"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="parameters" as="xs:string"/>
      <p:option name="value" required="true" as="xs:string"/>
      <p:option name="algorithm" required="true" as="xs:QName"/>
      <p:option name="match"
                select="'/*'"
                as="xs:string"
                e:type="XSLTMatchPattern"/>
      <p:option name="version" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:in-scope-names" xml:id="in-scope-names">
      <p:output port="result" primary="false" content-types="application/xml"/>
   </p:declare-step>
   <p:declare-step type="p:template" xml:id="template">
      <p:input port="source"
               sequence="true"
               primary="true"
               content-types="application/xml text/xml */*+xml"/>
      <p:input port="template" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="parameters" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:uuid" xml:id="uuid">
      <p:input port="source"
               primary="true"
               content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="match"
                select="'/*'"
                as="xs:string"
                e:type="XSLTMatchPattern"/>
      <p:option name="version" as="xs:integer"/>
   </p:declare-step>
   <p:declare-step type="p:www-form-urldecode" xml:id="www-form-urldecode">
      <p:output port="result" content-types="application/xml"/>
      <p:option name="value" required="true" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:www-form-urlencode" xml:id="www-form-urlencode">
      <p:input port="source"
               primary="true"
               content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="parameters" as="xs:string"/>
      <p:option name="match"
                required="true"
                as="xs:string"
                e:type="XSLTMatchPattern"/>
   </p:declare-step>
   <p:declare-step type="p:xquery" xml:id="xquery">
      <p:input port="source"
               content-types="application/xml text/xml */*+xml"
               sequence="true"
               primary="true"/>
      <p:input port="query" content-types="application/xml */*+xml text/*"/>
      <p:output port="result" sequence="true" content-types="*/*"/>
      <p:option name="parameters" as="xs:string"/>
      <p:option name="version" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:xsl-formatter" xml:id="xsl-formatter">
      <p:input port="source" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="*/*"/>
      <p:option name="parameters" as="xs:string"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="content-type" as="xs:string"/>
   </p:declare-step>
</p:library>
