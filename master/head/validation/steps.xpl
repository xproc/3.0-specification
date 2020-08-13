<p:library xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
           version="3.0">
   <p:declare-step type="p:validate-with-nvdl" xml:id="validate-with-nvdl">
      <p:input port="source" primary="true" content-types="xml html"/>
      <p:input port="nvdl" content-types="xml"/>
      <p:input port="schemas" sequence="true" content-types="text xml">
         <p:empty/>
      </p:input>
      <p:output port="result" primary="true" content-types="xml html"/>
      <p:output port="report" sequence="true" content-types="xml json"/>
      <p:option name="assert-valid" select="true()" as="xs:boolean"/>
      <p:option name="report-format" select="'xvrl'" as="xs:string"/>
      <p:option name="parameters" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:validate-with-relax-ng" xml:id="validate-with-relax-ng">
      <p:input port="source" primary="true" content-types="xml html"/>
      <p:input port="schema" content-types="text xml"/>
      <p:output port="result" primary="true" content-types="xml html"/>
      <p:output port="report" sequence="true" content-types="xml json"/>
      <p:option name="dtd-attribute-values" select="false()" as="xs:boolean"/>
      <p:option name="dtd-id-idref-warnings" select="false()" as="xs:boolean"/>
      <p:option name="assert-valid" select="true()" as="xs:boolean"/>
      <p:option name="report-format" select="'xvrl'" as="xs:string"/>
      <p:option name="parameters" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:validate-with-schematron" xml:id="validate-with-schematron">
      <p:input port="source" primary="true" content-types="xml html"/>
      <p:input port="schema" content-types="xml"/>
      <p:output port="result" primary="true" content-types="xml html"/>
      <p:output port="report" sequence="true" content-types="xml json"/>
      <p:option name="parameters" as="xs:string"/>
      <p:option name="phase" select="'#DEFAULT'" as="xs:string"/>
      <p:option name="assert-valid" select="true()" as="xs:boolean"/>
      <p:option name="report-format" select="'svrl'" as="xs:string"/>
   </p:declare-step>
   <p:declare-step type="p:validate-with-xml-schema" xml:id="validate-with-xml-schema">
      <p:input port="source" primary="true" content-types="xml html"/>
      <p:input port="schema" sequence="true" content-types="xml"/>
      <p:output port="result" primary="true" content-types="xml html"/>
      <p:output port="report" sequence="true" content-types="xml json"/>
      <p:option name="use-location-hints" select="false()" as="xs:boolean"/>
      <p:option name="try-namespaces" select="false()" as="xs:boolean"/>
      <p:option name="assert-valid" select="true()" as="xs:boolean"/>
      <p:option name="parameters" as="xs:string"/>
      <p:option name="mode"
                select="'strict'"
                as="xs:token"
                values="('strict','lax')"/>
      <p:option name="version" as="xs:string?"/>
      <p:option name="report-format" select="'xvrl'" as="xs:string"/>
   </p:declare-step>
</p:library>
