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
<p:output port="result"/>
<p:serialization port="result" indent="false" method="xhtml"/>
<p:option name="style" select="'dbspec.xsl'"/>

<p:import href="../../build/docbook/xslt/base/pipelines/docbook.xpl"/>

<p:declare-step type="pos:env">
  <p:output port="result"/>
</p:declare-step>

<pos:env/>

<dbp:docbook format="html">
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

</p:declare-step>
