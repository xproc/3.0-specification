<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="3.0">
   <p:declare-step type="p:css-formatter" xml:id="css-formatter">
      <p:input port="source" content-types="xml html"/>
      <p:input port="stylesheet" content-types="text" sequence="true">
         <p:empty/>
      </p:input>
      <p:output port="result" content-types="any"/>
      <p:option name="parameters" as="xs:string"/>
      <p:option name="content-type" as="xs:string?"/>
   </p:declare-step>
   <p:declare-step type="p:xsl-formatter" xml:id="xsl-formatter">
      <p:input port="source" content-types="xml"/>
      <p:output port="result" content-types="any"/>
      <p:option name="parameters" as="xs:string"/>
      <p:option name="content-type" as="xs:string?"/>
   </p:declare-step>
</p:library>
