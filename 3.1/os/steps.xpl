<p:library xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           xmlns:p="http://www.w3.org/ns/xproc"
           version="3.1">
   <p:declare-step type="p:os-info" xml:id="os-info">
      <p:output port="result" content-types="application/xml" primary="true"/>
   </p:declare-step>
   <p:declare-step type="p:os-exec" xml:id="os-exec">
      <p:input port="source" sequence="true" content-types="any"/>
      <p:output port="result"
                primary="true"
                sequence="true"
                content-types="any"/>
      <p:output port="error" sequence="true" content-types="any"/>
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
</p:library>
