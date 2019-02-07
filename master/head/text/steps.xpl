<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="3.0">
   <p:declare-step type="p:text-head" xml:id="text-head">
      <p:input port="source"
               primary="true"
               sequence="false"
               content-types="text/*"/>
      <p:output port="result"
                primary="true"
                sequence="false"
                content-types="text/*"/>
      <p:option name="count" required="true" as="xs:integer"/>
   </p:declare-step>
   <p:declare-step type="p:text-join" xml:id="text-join">
      <p:output port="source"
                primary="true"
                sequence="true"
                content-types="text/*"/>
      <p:output port="result"
                primary="true"
                sequence="false"
                content-types="text/*"/>
      <p:option name="separator" required="false" as="xs:string"/>
      <p:option name="prefix" required="false" as="xs:string"/>
      <p:option name="suffix" required="false" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:text-tail" xml:id="text-tail">
      <p:input port="source"
               primary="true"
               sequence="false"
               content-types="text/*"/>
      <p:output port="result"
                primary="true"
                sequence="false"
                content-types="text/*"/>
      <p:option name="count" required="true" as="xs:integer"/>
   </p:declare-step>
</p:library>
