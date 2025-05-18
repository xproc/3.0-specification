<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="3.0">
   <p:declare-step type="p:add-attribute" xml:id="add-attribute">
      <p:input port="source" content-types="xml html"/>
      <p:output port="result" content-types="xml html"/>
      <p:option name="match"
                as="xs:string"
                select="'/*'"
                e:type="XSLTSelectionPattern"/>
      <p:option name="attribute-name" required="true" as="xs:QName"/>
      <p:option name="attribute-value" required="true" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:add-xml-base" xml:id="add-xml-base">
      <p:input port="source" content-types="xml html"/>
      <p:output port="result" content-types="xml html"/>
      <p:option name="all" as="xs:boolean" select="false()"/>
      <p:option name="relative" as="xs:boolean" select="true()"/>
   </p:declare-step>
   <p:declare-step type="p:archive" xml:id="archive">
      <p:input port="source"
               primary="true"
               content-types="any"
               sequence="true"/>
      <p:input port="manifest" content-types="xml" sequence="true">
         <p:empty/>
      </p:input>
      <p:input port="archive" content-types="any" sequence="true">
         <p:empty/>
      </p:input>
      <p:output port="result"
                primary="true"
                content-types="any"
                sequence="false"/>
      <p:output port="report" content-types="application/xml" sequence="false"/>
      <p:option name="format" as="xs:QName" select="'zip'"/>
      <p:option name="relative-to" as="xs:anyURI?"/>
      <p:option name="parameters" as="map(xs:QName, item()*)?"/>
   </p:declare-step>
   <p:declare-step type="p:archive-manifest" xml:id="archive-manifest">
      <p:input port="source"
               primary="true"
               content-types="any"
               sequence="false"/>
      <p:output port="result"
                primary="true"
                content-types="application/xml"
                sequence="false"/>
      <p:option name="format" as="xs:QName?"/>
      <p:option name="parameters" as="map(xs:QName, item()*)?"/>
      <p:option name="relative-to" as="xs:anyURI?"/>
      <p:option name="override-content-types" as="array(array(xs:string))?"/>
   </p:declare-step>
   <p:declare-step type="p:cast-content-type" xml:id="cast-content-type">
      <p:input port="source" content-types="any"/>
      <p:output port="result" content-types="any"/>
      <p:option name="content-type" required="true" as="xs:string"/>
      <p:option name="parameters" as="map(xs:QName,item()*)?"/>
   </p:declare-step>
   <p:declare-step type="p:compare" xml:id="compare">
      <p:input port="source" primary="true" content-types="any"/>
      <p:input port="alternate" content-types="any"/>
      <p:output port="result" content-types="application/xml"/>
      <p:output port="differences" content-types="any" sequence="true"/>
      <p:option name="parameters" as="map(xs:QName,item()*)?"/>
      <p:option name="method" as="xs:QName?"/>
      <p:option name="fail-if-not-equal" as="xs:boolean" select="false()"/>
   </p:declare-step>
   <p:declare-step type="p:compress" xml:id="compress">
      <p:input port="source"
               primary="true"
               content-types="any"
               sequence="false"/>
      <p:output port="result"
                primary="true"
                content-types="any"
                sequence="false"/>
      <p:option name="format" as="xs:QName" select="'gzip'"/>
      <p:option name="serialization" as="map(xs:QName,item()*)?"/>
      <p:option name="parameters" as="map(xs:QName, item()*)?"/>
   </p:declare-step>
   <p:declare-step type="p:count" xml:id="count">
      <p:input port="source" content-types="any" sequence="true"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="limit" as="xs:integer" select="0"/>
   </p:declare-step>
   <p:declare-step type="p:css-formatter" xml:id="css-formatter">
      <p:input port="source" content-types="xml html"/>
      <p:input port="stylesheet" content-types="text" sequence="true">
         <p:empty/>
      </p:input>
      <p:output port="result" content-types="any"/>
      <p:option name="parameters" as="map(xs:QName,item()*)?"/>
      <p:option name="content-type" as="xs:string?"/>
   </p:declare-step>
   <p:declare-step type="p:delete" xml:id="delete">
      <p:input port="source" content-types="xml html"/>
      <p:output port="result" content-types="text xml html"/>
      <p:option name="match"
                required="true"
                as="xs:string"
                e:type="XSLTSelectionPattern"/>
   </p:declare-step>
   <p:declare-step type="p:directory-list" xml:id="directory-list">
      <p:output port="result" content-types="application/xml"/>
      <p:option name="path" required="true" as="xs:anyURI"/>
      <p:option name="detailed" as="xs:boolean" select="false()"/>
      <p:option name="max-depth" as="xs:string?" select="'1'"/>
      <p:option name="include-filter" as="xs:string*"/>
      <p:option name="exclude-filter" as="xs:string*"/>
      <p:option name="override-content-types" as="array(array(xs:string))?"/>
   </p:declare-step>
   <p:declare-step type="p:error" xml:id="error">
      <p:input port="source" sequence="true" content-types="text xml"/>
      <p:output port="result" sequence="true" content-types="any"/>
      <p:option name="code" required="true" as="xs:QName"/>
   </p:declare-step>
   <p:declare-step type="p:file-copy" xml:id="file-copy">
      <p:output port="result" primary="true" content-types="application/xml"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="target" required="true" as="xs:anyURI"/>
      <p:option name="fail-on-error" as="xs:boolean" select="true()"/>
      <p:option name="overwrite" as="xs:boolean" select="true()"/>
   </p:declare-step>
   <p:declare-step type="p:file-create-tempfile" xml:id="file-create-tempfile">
      <p:output port="result" primary="true" content-types="application/xml"/>
      <p:option name="href" as="xs:anyURI?"/>
      <p:option name="suffix" as="xs:string?"/>
      <p:option name="prefix" as="xs:string?"/>
      <p:option name="delete-on-exit" as="xs:boolean" select="false()"/>
      <p:option name="fail-on-error" as="xs:boolean" select="true()"/>
   </p:declare-step>
   <p:declare-step type="p:file-delete" xml:id="file-delete">
      <p:output port="result" primary="true" content-types="application/xml"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="recursive" as="xs:boolean" select="false()"/>
      <p:option name="fail-on-error" as="xs:boolean" select="true()"/>
   </p:declare-step>
   <p:declare-step type="p:file-info" xml:id="file-info">
      <p:output port="result" primary="true" content-types="application/xml"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="fail-on-error" as="xs:boolean" select="true()"/>
      <p:option name="override-content-types" as="array(array(xs:string))?"/>
   </p:declare-step>
   <p:declare-step type="p:file-mkdir" xml:id="file-mkdir">
      <p:output port="result" primary="true" content-types="application/xml"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="fail-on-error" as="xs:boolean" select="true()"/>
   </p:declare-step>
   <p:declare-step type="p:file-move" xml:id="file-move">
      <p:output port="result" primary="true" content-types="application/xml"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="target" required="true" as="xs:anyURI"/>
      <p:option name="fail-on-error" as="xs:boolean" select="true()"/>
   </p:declare-step>
   <p:declare-step type="p:file-touch" xml:id="file-touch">
      <p:output port="result" primary="true" content-types="application/xml"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="timestamp" as="xs:dateTime?"/>
      <p:option name="fail-on-error" as="xs:boolean" select="true()"/>
   </p:declare-step>
   <p:declare-step type="p:filter" xml:id="filter">
      <p:input port="source" content-types="xml html"/>
      <p:output port="result" sequence="true" content-types="text xml html"/>
      <p:option name="select"
                required="true"
                as="xs:string"
                e:type="XPathExpression"/>
   </p:declare-step>
   <p:declare-step type="p:hash" xml:id="hash">
      <p:input port="source" primary="true" content-types="xml html"/>
      <p:output port="result" content-types="text xml html"/>
      <p:option name="parameters" as="map(xs:QName,item()*)?"/>
      <p:option name="value" required="true" as="xs:string"/>
      <p:option name="algorithm" required="true" as="xs:QName"/>
      <p:option name="match"
                as="xs:string"
                select="'/*/node()'"
                e:type="XSLTSelectionPattern"/>
      <p:option name="version" as="xs:string?"/>
   </p:declare-step>
   <p:declare-step type="p:http-request" xml:id="http-request">
      <p:input port="source" content-types="any" sequence="true"/>
      <p:output port="result"
                primary="true"
                content-types="any"
                sequence="true"/>
      <p:output port="report" content-types="application/json"/>
      <p:option name="href" as="xs:anyURI" required="true"/>
      <p:option name="method" as="xs:string?" select="'GET'"/>
      <p:option name="serialization" as="map(xs:QName,item()*)?"/>
      <p:option name="headers" as="map(xs:string, xs:string)?"/>
      <p:option name="auth" as="map(xs:string, item()+)?"/>
      <p:option name="parameters" as="map(xs:QName, item()*)?"/>
      <p:option name="assert" as="xs:string" select="'.?status-code lt 400'"/>
   </p:declare-step>
   <p:declare-step type="p:identity" xml:id="identity">
      <p:input port="source" sequence="true" content-types="any"/>
      <p:output port="result" sequence="true" content-types="any"/>
   </p:declare-step>
   <p:declare-step type="p:insert" xml:id="insert">
      <p:input port="source" primary="true" content-types="xml html"/>
      <p:input port="insertion" sequence="true" content-types="xml html"/>
      <p:output port="result" content-types="xml html"/>
      <p:option name="match"
                as="xs:string"
                select="'/*'"
                e:type="XSLTSelectionPattern"/>
      <p:option name="position"
                values="('first-child','last-child','before','after')"
                select="'after'"/>
   </p:declare-step>
   <p:declare-step type="p:json-join" xml:id="json-join">
      <p:input port="source" sequence="true" content-types="any"/>
      <p:output port="result" content-types="application/json"/>
      <p:option name="flatten-to-depth" as="xs:string?" select="'0'"/>
   </p:declare-step>
   <p:declare-step type="p:json-merge" xml:id="json-merge">
      <p:input port="source" sequence="true" content-types="any"/>
      <p:output port="result" content-types="application/json"/>
      <p:option name="duplicates"
                values="('reject', 'use-first', 'use-last', 'use-any', 'combine')"
                select="'use-first'"/>
      <p:option name="key"
                as="xs:string"
                select="'concat(&#34;_&#34;,$p:index)'"
                e:type="XPathExpression"/>
   </p:declare-step>
   <p:declare-step type="p:label-elements" xml:id="label-elements">
      <p:input port="source" content-types="xml html"/>
      <p:output port="result" content-types="xml html"/>
      <p:option name="attribute" as="xs:QName" select="'xml:id'"/>
      <p:option name="label"
                as="xs:string"
                select="'concat(&#34;_&#34;,$p:index)'"
                e:type="XPathExpression"/>
      <p:option name="match"
                as="xs:string"
                select="'*'"
                e:type="XSLTSelectionPattern"/>
      <p:option name="replace" as="xs:boolean" select="true()"/>
   </p:declare-step>
   <p:declare-step type="p:load" xml:id="load">
      <p:output port="result" content-types="any"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="parameters" as="map(xs:QName,item()*)?"/>
      <p:option name="content-type" as="xs:string?"/>
      <p:option name="document-properties" as="map(xs:QName, item()*)?"/>
   </p:declare-step>
   <p:declare-step type="p:make-absolute-uris" xml:id="make-absolute-uris">
      <p:input port="source" content-types="xml html"/>
      <p:output port="result" content-types="xml html"/>
      <p:option name="match"
                required="true"
                as="xs:string"
                e:type="XSLTSelectionPattern"/>
      <p:option name="base-uri" as="xs:anyURI?"/>
   </p:declare-step>
   <p:declare-step type="p:markdown-to-html" xml:id="markdown-to-html">
      <p:input port="source" primary="true" content-types="text"/>
      <p:output port="result" primary="true" content-types="html"/>
      <p:option name="parameters" as="map(xs:QName, item()*)?"/>
   </p:declare-step>
   <p:declare-step type="p:namespace-delete" xml:id="namespace-delete">
      <p:input port="source" content-types="xml html"/>
      <p:output port="result" content-types="xml html"/>
      <p:option name="prefixes" required="true" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:namespace-rename" xml:id="namespace-rename">
      <p:input port="source" content-types="xml html"/>
      <p:output port="result" content-types="xml html"/>
      <p:option name="from" as="xs:anyURI?"/>
      <p:option name="to" as="xs:anyURI?"/>
      <p:option name="apply-to"
                select="'all'"
                values="('all','elements','attributes')"/>
   </p:declare-step>
   <p:declare-step type="p:os-exec" xml:id="os-exec">
      <p:input port="source" sequence="true" content-types="any"/>
      <p:output port="result" primary="true" content-types="any"/>
      <p:output port="error" content-types="any"/>
      <p:output port="exit-status" content-types="application/xml"/>
      <p:option name="command" required="true" as="xs:string"/>
      <p:option name="args" select="()" as="xs:string*"/>
      <p:option name="cwd" as="xs:string?"/>
      <p:option name="result-content-type" select="'text/plain'" as="xs:string"/>
      <p:option name="error-content-type" select="'text/plain'" as="xs:string"/>
      <p:option name="path-separator" as="xs:string?"/>
      <p:option name="failure-threshold" as="xs:integer?"/>
      <p:option name="serialization" as="map(xs:QName,item()*)?"/>
   </p:declare-step>
   <p:declare-step type="p:os-info" xml:id="os-info">
      <p:output port="result" content-types="application/xml" primary="true"/>
   </p:declare-step>
   <p:declare-step type="p:pack" xml:id="pack">
      <p:input port="source"
               content-types="text xml html"
               sequence="true"
               primary="true"/>
      <p:input port="alternate" sequence="true" content-types="text xml html"/>
      <p:output port="result" sequence="true" content-types="application/xml"/>
      <p:option name="wrapper" required="true" as="xs:QName"/>
   </p:declare-step>
   <p:declare-step type="p:rename" xml:id="rename">
      <p:input port="source" content-types="xml html"/>
      <p:output port="result" content-types="xml html"/>
      <p:option name="match"
                as="xs:string"
                select="'/*'"
                e:type="XSLTSelectionPattern"/>
      <p:option name="new-name" required="true" as="xs:QName"/>
   </p:declare-step>
   <p:declare-step type="p:replace" xml:id="replace">
      <p:input port="source" primary="true" content-types="xml html"/>
      <p:input port="replacement" content-types="text xml html"/>
      <p:output port="result" content-types="text xml html"/>
      <p:option name="match"
                required="true"
                as="xs:string"
                e:type="XSLTSelectionPattern"/>
   </p:declare-step>
   <p:declare-step type="p:set-attributes" xml:id="set-attributes">
      <p:input port="source" primary="true" content-types="xml html"/>
      <p:output port="result" content-types="xml html"/>
      <p:option name="match"
                as="xs:string"
                select="'/*'"
                e:type="XSLTSelectionPattern"/>
      <p:option name="attributes"
                required="true"
                as="map(xs:QName, xs:anyAtomicType)"/>
   </p:declare-step>
   <p:declare-step type="p:set-properties" xml:id="set-properties">
      <p:input port="source" content-types="any"/>
      <p:output port="result" content-types="any"/>
      <p:option name="properties" required="true" as="map(xs:QName,item()*)"/>
      <p:option name="merge" select="true()" as="xs:boolean"/>
   </p:declare-step>
   <p:declare-step type="p:sink" xml:id="sink">
      <p:input port="source" content-types="any" sequence="true"/>
   </p:declare-step>
   <p:declare-step type="p:split-sequence" xml:id="split-sequence">
      <p:input port="source" content-types="any" sequence="true"/>
      <p:output port="matched"
                sequence="true"
                primary="true"
                content-types="any"/>
      <p:output port="not-matched" sequence="true" content-types="any"/>
      <p:option name="initial-only" as="xs:boolean" select="false()"/>
      <p:option name="test"
                required="true"
                as="xs:string"
                e:type="XPathExpression"/>
   </p:declare-step>
   <p:declare-step type="p:store" xml:id="store">
      <p:input port="source" content-types="any"/>
      <p:output port="result" content-types="any" primary="true"/>
      <p:output port="result-uri" content-types="application/xml"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="serialization" as="map(xs:QName,item()*)?"/>
   </p:declare-step>
   <p:declare-step type="p:string-replace" xml:id="string-replace">
      <p:input port="source" content-types="xml html"/>
      <p:output port="result" content-types="text xml html"/>
      <p:option name="match"
                required="true"
                as="xs:string"
                e:type="XSLTSelectionPattern"/>
      <p:option name="replace"
                required="true"
                as="xs:string"
                e:type="XPathExpression"/>
   </p:declare-step>
   <p:declare-step type="p:text-count" xml:id="text-count">
      <p:input port="source"
               primary="true"
               sequence="false"
               content-types="text"/>
      <p:output port="result"
                primary="true"
                sequence="false"
                content-types="application/xml"/>
   </p:declare-step>
   <p:declare-step type="p:text-head" xml:id="text-head">
      <p:input port="source"
               primary="true"
               sequence="false"
               content-types="text"/>
      <p:output port="result"
                primary="true"
                sequence="false"
                content-types="text"/>
      <p:option name="count" required="true" as="xs:integer"/>
   </p:declare-step>
   <p:declare-step type="p:text-join" xml:id="text-join">
      <p:input port="source" sequence="true" content-types="text"/>
      <p:output port="result" content-types="text"/>
      <p:option name="separator" as="xs:string?"/>
      <p:option name="prefix" as="xs:string?"/>
      <p:option name="suffix" as="xs:string?"/>
      <p:option name="override-content-type" as="xs:string?"/>
   </p:declare-step>
   <p:declare-step type="p:text-replace" xml:id="text-replace">
      <p:input port="source"
               primary="true"
               sequence="false"
               content-types="text"/>
      <p:output port="result"
                primary="true"
                sequence="false"
                content-types="text"/>
      <p:option name="pattern" required="true" as="xs:string"/>
      <p:option name="replacement" required="true" as="xs:string"/>
      <p:option name="flags" as="xs:string?"/>
   </p:declare-step>
   <p:declare-step type="p:text-sort" xml:id="text-sort">
      <p:input port="source"
               primary="true"
               sequence="false"
               content-types="text"/>
      <p:output port="result"
                primary="true"
                sequence="false"
                content-types="text"/>
      <p:option name="sort-key"
                as="xs:string"
                select="'.'"
                e:type="XPathExpression"/>
      <p:option name="order"
                as="xs:string"
                select="'ascending'"
                values="('ascending', 'descending')"/>
      <p:option name="case-order"
                as="xs:string?"
                values="('upper-first', 'lower-first')"/>
      <p:option name="lang" as="xs:language?"/>
      <p:option name="collation"
                as="xs:string"
                select="'https://www.w3.org/2005/xpath-functions/collation/codepoint'"/>
      <p:option name="stable" as="xs:boolean" select="true()"/>
   </p:declare-step>
   <p:declare-step type="p:text-tail" xml:id="text-tail">
      <p:input port="source"
               primary="true"
               sequence="false"
               content-types="text"/>
      <p:output port="result"
                primary="true"
                sequence="false"
                content-types="text"/>
      <p:option name="count" required="true" as="xs:integer"/>
   </p:declare-step>
   <p:declare-step type="p:unarchive" xml:id="unarchive">
      <p:input port="source"
               primary="true"
               content-types="any"
               sequence="false"/>
      <p:output port="result"
                primary="true"
                content-types="any"
                sequence="true"/>
      <p:option name="include-filter" as="xs:string*" e:type="RegularExpression"/>
      <p:option name="exclude-filter" as="xs:string*" e:type="RegularExpression"/>
      <p:option name="format" as="xs:QName?"/>
      <p:option name="parameters" as="map(xs:QName, item()*)?"/>
      <p:option name="relative-to" as="xs:anyURI?"/>
      <p:option name="override-content-types" as="array(array(xs:string))?"/>
   </p:declare-step>
   <p:declare-step type="p:uncompress" xml:id="uncompress">
      <p:input port="source"
               primary="true"
               content-types="any"
               sequence="false"/>
      <p:output port="result"
                primary="true"
                content-types="any"
                sequence="false"/>
      <p:option name="format" as="xs:QName?"/>
      <p:option name="parameters" as="map(xs:QName,item()*)?"/>
      <p:option name="content-type"
                as="xs:string"
                select="'application/octet-stream'"/>
   </p:declare-step>
   <p:declare-step type="p:unwrap" xml:id="unwrap">
      <p:input port="source" content-types="xml html"/>
      <p:output port="result" content-types="text xml html"/>
      <p:option name="match"
                as="xs:string"
                select="'/*'"
                e:type="XSLTSelectionPattern"/>
   </p:declare-step>
   <p:declare-step type="p:uuid" xml:id="uuid">
      <p:input port="source" primary="true" content-types="xml html"/>
      <p:output port="result" content-types="text xml html"/>
      <p:option name="match"
                as="xs:string"
                select="'/*'"
                e:type="XSLTSelectionPattern"/>
      <p:option name="version" as="xs:integer?"/>
   </p:declare-step>
   <p:declare-step type="p:validate-with-json-schema" xml:id="validate-with-json-schema">
      <p:input port="source" primary="true" content-types="json"/>
      <p:input port="schema" sequence="false" content-types="json"/>
      <p:output port="result" primary="true" content-types="json"/>
      <p:output port="report" sequence="true" content-types="xml json"/>
      <p:option name="assert-valid" select="true()" as="xs:boolean"/>
      <p:option name="default-version" as="xs:string"/>
      <p:option name="parameters" as="map(xs:QName,item()*)?"/>
      <p:option name="report-format" select="'xvrl'" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:validate-with-nvdl" xml:id="validate-with-nvdl">
      <p:input port="source" primary="true" content-types="xml html"/>
      <p:input port="nvdl" content-types="xml"/>
      <p:input port="schemas" sequence="true" content-types="text xml">
         <p:empty/>
      </p:input>
      <p:output port="result" primary="true" content-types="xml html"/>
      <p:output port="report" sequence="true" content-types="xml json"/>
      <p:option name="assert-valid" select="true()" as="xs:boolean"/>
      <p:option name="report-format" select="'xvrl'" as="xs:string"/>
      <p:option name="parameters" as="map(xs:QName,item()*)?"/>
   </p:declare-step>
   <p:declare-step type="p:validate-with-relax-ng" xml:id="validate-with-relax-ng">
      <p:input port="source" primary="true" content-types="xml html"/>
      <p:input port="schema" content-types="text xml"/>
      <p:output port="result" primary="true" content-types="xml html"/>
      <p:output port="report" sequence="true" content-types="xml json"/>
      <p:option name="dtd-attribute-values" select="false()" as="xs:boolean"/>
      <p:option name="dtd-id-idref-warnings" select="false()" as="xs:boolean"/>
      <p:option name="assert-valid" select="true()" as="xs:boolean"/>
      <p:option name="report-format" select="'xvrl'" as="xs:string"/>
      <p:option name="parameters" as="map(xs:QName,item()*)?"/>
   </p:declare-step>
   <p:declare-step type="p:validate-with-schematron" xml:id="validate-with-schematron">
      <p:input port="source" primary="true" content-types="xml html"/>
      <p:input port="schema" content-types="xml"/>
      <p:output port="result" primary="true" content-types="xml html"/>
      <p:output port="report" sequence="true" content-types="xml json"/>
      <p:option name="parameters" as="map(xs:QName,item()*)?"/>
      <p:option name="phase" select="'#DEFAULT'" as="xs:string"/>
      <p:option name="assert-valid" select="true()" as="xs:boolean"/>
      <p:option name="report-format" select="'svrl'" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:validate-with-xml-schema" xml:id="validate-with-xml-schema">
      <p:input port="source" primary="true" content-types="xml html"/>
      <p:input port="schema" sequence="true" content-types="xml"/>
      <p:output port="result" primary="true" content-types="xml html"/>
      <p:output port="report" sequence="true" content-types="xml json"/>
      <p:option name="use-location-hints" select="false()" as="xs:boolean"/>
      <p:option name="try-namespaces" select="false()" as="xs:boolean"/>
      <p:option name="assert-valid" select="true()" as="xs:boolean"/>
      <p:option name="parameters" as="map(xs:QName,item()*)?"/>
      <p:option name="mode" select="'strict'" values="('strict','lax')"/>
      <p:option name="version" as="xs:string?"/>
      <p:option name="report-format" select="'xvrl'" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:wrap" xml:id="wrap">
      <p:input port="source" content-types="xml html"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="wrapper" required="true" as="xs:QName"/>
      <p:option name="match"
                required="true"
                as="xs:string"
                e:type="XSLTSelectionPattern"/>
      <p:option name="group-adjacent" as="xs:string?" e:type="XPathExpression"/>
   </p:declare-step>
   <p:declare-step type="p:wrap-sequence" xml:id="wrap-sequence">
      <p:input port="source" content-types="text xml html" sequence="true"/>
      <p:output port="result" sequence="true" content-types="application/xml"/>
      <p:option name="wrapper" required="true" as="xs:QName"/>
      <p:option name="group-adjacent" as="xs:string?" e:type="XPathExpression"/>
   </p:declare-step>
   <p:declare-step type="p:www-form-urldecode" xml:id="www-form-urldecode">
      <p:output port="result" content-types="application/json"/>
      <p:option name="value" required="true" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:www-form-urlencode" xml:id="www-form-urlencode">
      <p:output port="result" content-types="text/plain"/>
      <p:option name="parameters"
                required="true"
                as="map(xs:string,xs:anyAtomicType+)"/>
   </p:declare-step>
   <p:declare-step type="p:xinclude" xml:id="xinclude">
      <p:input port="source" content-types="xml html"/>
      <p:output port="result" content-types="xml html"/>
      <p:option name="fixup-xml-base" as="xs:boolean" select="false()"/>
      <p:option name="fixup-xml-lang" as="xs:boolean" select="false()"/>
   </p:declare-step>
   <p:declare-step type="p:xquery" xml:id="xquery">
      <p:input port="source"
               content-types="any"
               sequence="true"
               primary="true"/>
      <p:input port="query" content-types="text xml"/>
      <p:output port="result" sequence="true" content-types="any"/>
      <p:option name="parameters" as="map(xs:QName,item()*)?"/>
      <p:option name="version" as="xs:string?"/>
   </p:declare-step>
   <p:declare-step type="p:xsl-formatter" xml:id="xsl-formatter">
      <p:input port="source" content-types="xml"/>
      <p:output port="result" content-types="any"/>
      <p:option name="parameters" as="map(xs:QName,item()*)?"/>
      <p:option name="content-type" as="xs:string?"/>
   </p:declare-step>
   <p:declare-step type="p:xslt" xml:id="xslt">
      <p:input port="source"
               content-types="any"
               sequence="true"
               primary="true"/>
      <p:input port="stylesheet" content-types="xml"/>
      <p:output port="result"
                primary="true"
                sequence="true"
                content-types="any"/>
      <p:output port="secondary" sequence="true" content-types="any"/>
      <p:option name="parameters" as="map(xs:QName,item()*)?"/>
      <p:option name="static-parameters" as="map(xs:QName,item()*)?"/>
      <p:option name="global-context-item" as="item()?"/>
      <p:option name="populate-default-collection" as="xs:boolean?" select="true()"/>
      <p:option name="initial-mode" as="xs:QName?"/>
      <p:option name="template-name" as="xs:QName?"/>
      <p:option name="output-base-uri" as="xs:anyURI?"/>
      <p:option name="version" as="xs:string?"/>
   </p:declare-step>
</p:library>
