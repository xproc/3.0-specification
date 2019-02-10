<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="3.0">
   <p:declare-step type="p:text-head" xml:id="text-head">
      <p:output port="result" primary="true" content-types="text/plain"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="count" required="true" as="xs:integer"/>
   </p:declare-step>
   <p:declare-step type="p:text-join" xml:id="text-join">
      <p:output port="result"
                primary="true"
                sequence="true"
                content-types="text/plain"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
   </p:declare-step>
   <p:declare-step type="p:text-tail" xml:id="text-tail">
      <p:output port="result" primary="true" content-types="text/plain"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="count" required="true" as="xs:integer"/>
   </p:declare-step>
</p:library>
