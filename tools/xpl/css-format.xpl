<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                name="main">
<p:input port="source"/>
<p:option name="css" required="true"/>
<p:option name="pdf" required="true"/>

<p:declare-step type="cx:css-formatter">
  <p:input port="source" primary="true"/>
  <p:input port="parameters" kind="parameter"/>
  <p:output port="result" primary="false"/>
  <p:option name="href" required="true"/>
  <p:option name="css" required="false"/>
  <p:option name="content-type"/>
</p:declare-step>

<p:add-attribute match="/*" attribute-name="xml:base">
  <p:with-option name="attribute-value" select="resolve-uri($pdf)"/>
</p:add-attribute>

<cx:css-formatter content-type="application/pdf">
  <p:input port="parameters">
    <p:empty/>
  </p:input>
  <p:with-option name="href" select="$pdf"/>
  <p:with-option name="css" select="$css"/>
</cx:css-formatter>

</p:declare-step>
