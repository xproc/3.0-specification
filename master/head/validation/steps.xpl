<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="3.0">
   <p:declare-step type="p:validate-with-relax-ng" xml:id="validate-with-relax-ng">
      <p:input port="source"
               primary="true"
               content-types="application/xml text/xml */*+xml"/>
      <p:input port="schema" content-types="application/xml */*+xml text/*"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="dtd-attribute-values" select="false()" as="xs:boolean"/>
      <p:option name="dtd-id-idref-warnings" select="false()" as="xs:boolean"/>
      <p:option name="assert-valid" select="true()" as="xs:boolean"/>
   </p:declare-step>
   <p:declare-step type="p:validate-with-schematron" xml:id="validate-with-schematron">
      <p:input port="source"
               primary="true"
               content-types="application/xml text/xml */*+xml"/>
      <p:input port="schema" content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" primary="true" content-types="application/xml"/>
      <p:output port="report" sequence="true" content-types="application/xml"/>
      <p:option name="parameters" as="xs:string"/>
      <p:option name="phase" select="'#ALL'" as="xs:string"/>
      <p:option name="assert-valid" select="true()" as="xs:boolean"/>
   </p:declare-step>
   <p:declare-step type="p:validate-with-xml-schema" xml:id="validate-with-xml-schema">
      <p:input port="source"
               primary="true"
               content-types="application/xml text/xml */*+xml"/>
      <p:input port="schema"
               sequence="true"
               content-types="application/xml text/xml */*+xml"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="use-location-hints" select="false()" as="xs:boolean"/>
      <p:option name="try-namespaces" select="false()" as="xs:boolean"/>
      <p:option name="assert-valid" select="true()" as="xs:boolean"/>
      <p:option name="mode"
                select="'strict'"
                as="xs:token"
                values="('strict','lax')"/>
      <p:option name="version" as="xs:string?"/>
   </p:declare-step>
</p:library>
