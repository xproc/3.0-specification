<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:exf="http://exproc.org/standard/functions">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>
<p:output port="result"/>
<p:serialization port="result" method="xml" indent="true"/>

<p:xslt>
  <p:input port="stylesheet">
    <p:document href="../xsl/typed-pipeline-library.xsl"/>
  </p:input>
</p:xslt>

</p:declare-step>
