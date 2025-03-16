<p:library xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           xmlns:p="http://www.w3.org/ns/xproc"
           version="3.1">
   <p:declare-step type="p:markdown-to-html" xml:id="markdown-to-html">
      <p:input port="source" primary="true" content-types="text"/>
      <p:output port="result" primary="true" content-types="html"/>
      <p:option name="parameters" as="map(xs:QName, item()*)?"/>
   </p:declare-step>
</p:library>
