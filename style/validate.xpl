<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:exf="http://exproc.org/standard/functions">

<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>
<p:output port="result"/>

<p:option name="schema" select="''"/>
<p:option name="schematron" select="''"/>

<p:xinclude name="doc" xmlns:cx="http://xmlcalabash.com/ns/extensions"
            cx:trim="true"/>

<p:choose name="rngschema">
  <p:when test="$schema = ''">
    <p:output port="result"/>
    <p:identity/>
  </p:when>
  <p:when test="not(contains($schema, '.'))">
    <p:output port="result"/>
    <p:load>
      <p:with-option name="href" select="concat($schema, '.rng')"/>
    </p:load>
  </p:when>
  <p:otherwise>
    <p:output port="result"/>
    <p:load>
      <p:with-option name="href" select="resolve-uri($schema, exf:cwd())"/>
    </p:load>
  </p:otherwise>
</p:choose>

<p:choose name="rngvalid">
  <p:when test="$schema = ''">
    <p:output port="result"/>
    <p:identity/>
  </p:when>
  <p:otherwise>
    <p:output port="result"/>

    <p:validate-with-relax-ng>
      <p:input port="source">
        <p:pipe step="doc" port="result"/>
      </p:input>
      <p:input port="schema">
        <p:pipe step="rngschema" port="result"/>
      </p:input>
    </p:validate-with-relax-ng>
  </p:otherwise>
</p:choose>

<p:choose>
  <p:when test="$schematron = ''">
    <p:output port="result"/>
    <p:identity/>
  </p:when>
  <p:otherwise>
    <p:output port="result"/>
    <p:choose name="schschema">
      <p:when test="not(contains($schematron, '.'))">
        <p:output port="result"/>
        <p:load>
          <p:with-option name="href" select="concat($schematron, '.sch')"/>
        </p:load>
      </p:when>
      <p:otherwise>
        <p:output port="result"/>
        <p:load>
          <p:with-option name="href" select="resolve-uri($schematron, exf:cwd())"/>
        </p:load>
      </p:otherwise>
    </p:choose>

    <p:validate-with-schematron>
      <p:input port="source">
        <p:pipe step="rngvalid" port="result"/>
      </p:input>
      <p:input port="schema">
        <p:pipe step="schschema" port="result"/>
      </p:input>
    </p:validate-with-schematron>
  </p:otherwise>
</p:choose>

</p:declare-step>
