<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="3.0">
   <p:declare-step type="p:markdown-to-html" xml:id="markdown-to-html">
      <p:input port="source"
               primary="true"
               sequence="false"
               content-types="text/*"/>
      <p:output port="result"
                primary="true"
                sequence="false"
                content-types="application/xhtml+xml"/>
      <p:option name="parameters" as="xs:string"/>
   </p:declare-step>
</p:library>