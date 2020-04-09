<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="3.0">
   <p:declare-step type="p:directory-list" xml:id="directory-list">
      <p:output port="result" content-type="application/xml"/>
      <p:option name="path" required="true" as="xs:anyURI"/>
      <p:option name="detailed" as="xs:boolean" select="false()"/>
      <p:option name="max-depth" as="xs:string?" select="'1'"/>
      <p:option name="include-filter" as="xs:string*"/>
      <p:option name="exclude-filter" as="xs:string*"/>
      <p:option name="override-content-types" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:file-copy" xml:id="file-copy">
      <p:output port="result" primary="true" content-types="application/xml"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="target" required="true" as="xs:anyURI"/>
      <p:option name="fail-on-error" as="xs:boolean" select="true()"/>
   </p:declare-step>
   <p:declare-step type="p:file-delete" xml:id="file-delete">
      <p:output port="result" primary="true" content-types="application/xml"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="recursive" as="xs:boolean" select="false()"/>
      <p:option name="fail-on-error" as="xs:boolean" select="true()"/>
   </p:declare-step>
   <p:declare-step type="p:file-info" xml:id="file-info">
      <p:output port="result" primary="true" content-types="application/xml"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="fail-on-error" as="xs:boolean" select="true()"/>
      <p:option name="override-content-types" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:file-mkdir" xml:id="file-mkdir">
      <p:output port="result" primary="true" content-types="application/xml"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="fail-on-error" as="xs:boolean" select="true()"/>
   </p:declare-step>
   <p:declare-step type="p:file-move" xml:id="file-move">
      <p:output port="result" primary="true" content-types="application/xml"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="target" required="true" as="xs:anyURI"/>
      <p:option name="fail-on-error" as="xs:boolean" select="true()"/>
   </p:declare-step>
   <p:declare-step type="p:file-create-tempfile" xml:id="file-create-tempfile">
      <p:output port="result" primary="true" content-types="application/xml"/>
      <p:option name="href" as="xs:anyURI?"/>
      <p:option name="suffix" as="xs:string?"/>
      <p:option name="prefix" as="xs:string?"/>
      <p:option name="delete-on-exit" as="xs:boolean" select="false()"/>
      <p:option name="fail-on-error" as="xs:boolean" select="true()"/>
   </p:declare-step>
   <p:declare-step type="p:file-touch" xml:id="file-touch">
      <p:output port="result" primary="true" content-types="application/xml"/>
      <p:option name="href" required="true" as="xs:anyURI"/>
      <p:option name="timestamp" as="xs:dateTime?"/>
      <p:option name="fail-on-error" as="xs:boolean" select="true()"/>
   </p:declare-step>
</p:library>
