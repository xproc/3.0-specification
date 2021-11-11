<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="3.0">
   <p:declare-step type="p:send-mail" xml:id="send-mail">
      <p:input port="source" sequence="true" content-types="any"/>
      <p:output port="result" content-types="application/xml"/>
      <p:option name="serialization" as="map(xs:QName,item()*)?"/>
      <p:option name="auth" as="map(xs:string, item()+)?"/>
      <p:option name="parameters" as="map(xs:QName, item()*)?"/>
   </p:declare-step>
</p:library>
