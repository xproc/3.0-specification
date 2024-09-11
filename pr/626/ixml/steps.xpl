<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="3.1">
   <p:declare-step type="p:ixml" xml:id="ixml">
      <p:input port="grammar" sequence="true" content-types="text xml"/>
      <p:input port="source" primary="true" content-types="any -xml -html"/>
      <p:output port="result" sequence="true" content-types="any"/>
      <p:option name="parameters" as="map(xs:QName, item()*)?"/>
      <p:option name="fail-on-error" as="xs:boolean" select="true()"/>
   </p:declare-step>
</p:library>
