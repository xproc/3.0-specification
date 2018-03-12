<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:dbp="http://docbook.github.com/ns/pipeline"
                xmlns:exf="http://exproc.org/standard/functions"
                xmlns:pos="http://exproc.org/proposed/steps/os"
                exclude-inline-prefixes="cx exf pos dbp"
                name="main">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>
<p:output port="result">
  <p:pipe step="format-docbook" port="result"/>
</p:output>
<p:serialization port="result" indent="false" method="xhtml"/>
<p:option name="style" select="'dbspec.xsl'"/>

<p:import href="https://cdn.docbook.org/release/latest/xslt/base/pipelines/docbook.xpl"/>

<p:declare-step type="cx:message">
  <p:input port="source" sequence="true"/>
  <p:output port="result" sequence="true"/>
  <p:option name="message" required="true"/>
</p:declare-step>

<p:declare-step type="pos:env">
  <p:output port="result"/>
</p:declare-step>

<pos:env/>

<dbp:docbook name="format-docbook" format="html" return-secondary="true">
  <p:input port="source">
    <p:pipe step="main" port="source"/>
  </p:input>
  <p:with-option name="style"
                 select="resolve-uri($style)"/>

  <p:with-param name="travis"
                select="string(/c:result/c:env[@name='TRAVIS']/@value)"/>
  <p:with-param name="travis-commit"
                select="string(/c:result/c:env[@name='TRAVIS_COMMIT']/@value)"/>
  <p:with-param name="travis-tag"
                select="string(/c:result/c:env[@name='TRAVIS_TAG']/@value)"/>
  <p:with-param name="travis-build-number"
                select="string(/c:result/c:env[@name='TRAVIS_BUILD_NUMBER']/@value)"/>
  <p:with-param name="travis-branch"
                select="string(/c:result/c:env[@name='TRAVIS_BRANCH']/@value)"/>
  <p:with-param name="travis-user"
                select="substring-before(
                          /c:result/c:env[@name='TRAVIS_REPO_SLUG']/@value,
                          '/')"/>
  <p:with-param name="travis-repo"
                select="substring-after(
                          /c:result/c:env[@name='TRAVIS_REPO_SLUG']/@value,
                          '/')"/>
  <p:with-param name="auto-diff" select="''"/>
<!--
  <p:with-param name="auto-diff"
                select="string((/c:result/c:env[@name='DELTA_BASE' or @name='DELTA_LOCAL'])[1]/@value)"/>
-->
</dbp:docbook>

<p:for-each>
  <p:iteration-source>
    <p:pipe step="format-docbook" port="secondary"/>
  </p:iteration-source>
  <p:store name="store-chunk" encoding="utf-8" indent="true" method="xml">
    <p:with-option name="href" select="base-uri(/)"/>
  </p:store>
</p:for-each>

</p:declare-step>
