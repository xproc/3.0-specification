<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:exf="http://exproc.org/standard/functions">

<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>
<p:output port="result"/>

<p:option name="schema" select="'../../build/schema/dbspec.rng'"/>
<p:option name="schematron" select="'../../build/schema/docbook.sch'"/>

<p:xinclude xmlns:cx="http://xmlcalabash.com/ns/extensions"
            cx:trim="true">
</p:xinclude>

<!-- If the glossary is empty, remove it ... -->
<p:delete xmlns:db="http://docbook.org/ns/docbook"
          match="db:appendix[db:title='Glossary' and db:glosslist[count(*)=0]]"/>


<p:xslt>
  <p:input port="stylesheet">
    <p:document href="../xsl/masterbib.xsl"/>
  </p:input>
</p:xslt>

<p:identity name="doc">
<!--
  <p:log port="result" href="/tmp/xi.xml"/>
-->
</p:identity>

<p:choose name="rngschema">
  <p:when test="$schema = ''">
    <p:output port="result"/>
    <p:identity/>
  </p:when>
  <p:otherwise>
    <p:output port="result"/>
    <p:load>
      <p:with-option name="href" select="$schema"/>
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
    <p:load name="schschema">
      <p:with-option name="href" select="$schematron"/>
    </p:load>
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
