<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="3.0">
   <p:declare-step type="p:os-info" xml:id="os-info">
      <p:output port="result" content-types="application/xml" primary="true"/>
   </p:declare-step>
   <p:declare-step type="p:os-exec" xml:id="os-exec">
      <p:input port="source" sequence="true" content-types="any"/>
      <p:output port="result" primary="true" content-types="any"/>
      <p:output port="errors" content-types="any"/>
      <p:output port="exit-status" content-types="application/xml"/>
      <p:option name="command" required="true" as="xs:string"/>
      <p:option name="args" select="''" as="xs:string"/>
      <p:option name="cwd" as="xs:string?"/>
      <p:option name="source-is-xml" select="true()" as="xs:boolean"/>
      <p:option name="result-is-xml" select="true()" as="xs:boolean"/>
      <p:option name="wrap-result-lines" select="false()" as="xs:boolean"/>
      <p:option name="errors-is-xml" select="false()" as="xs:boolean"/>
      <p:option name="wrap-error-lines" select="false()" as="xs:boolean"/>
      <p:option name="path-separator" as="xs:string?"/>
      <p:option name="failure-threshold" as="xs:integer?"/>
      <p:option name="arg-separator" select="' '" as="xs:string"/>
      <p:option name="serialization" as="xs:string"/>
   </p:declare-step>
</p:library>
