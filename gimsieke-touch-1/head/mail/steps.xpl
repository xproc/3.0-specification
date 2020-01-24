<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="3.0">
   <p:declare-step type="p:send-mail" xml:id="send-mail">
      <p:input port="source" sequence="true" content-types="xml"/>
      <p:output port="result"/>
   </p:declare-step>
</p:library>
