<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="3.0">
   <p:declare-step type="p:run" xml:id="run">
      <p:input port="source"
               primary="true"
               sequence="true"
               content-types="*/*"/>
      <p:output port="result" primary="true" content-types="*/*"/>
   </p:declare-step>
</p:library>
