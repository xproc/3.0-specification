<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="1.0">
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
</p:library>
