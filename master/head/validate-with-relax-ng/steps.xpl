<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="1.0">
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
</p:library>
