<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="1.0">
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
</p:library>
