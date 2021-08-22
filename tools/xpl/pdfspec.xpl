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
<p:option name="postprocess" select="''"/>
<p:option name="diffkey" select="''"/>
<p:option name="webid" select="'xproc'"/>
<p:option name="diffloc" select="'/tmp/diff.html'"/>
<p:option name="pdf" select="'/tmp/spec.pdf'"/>
<p:option name="css" select="'/src/main/css/print.css'"/>

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

<dbp:docbook name="format-docbook" format="xhtml">
  <p:input port="source">
    <p:pipe step="main" port="source"/>
  </p:input>
  <p:with-option name="style"
                 select="resolve-uri($style)"/>

  <p:with-param name="circleci"
                select="string(/c:result/c:env[@name='CIRCLECI']/@value)"/>
  <p:with-param name="circleci-commit"
                select="string(/c:result/c:env[@name='CIRCLE_SHA1']/@value)"/>
  <p:with-param name="circleci-tag"
                select="string(/c:result/c:env[@name='CIRCLE_TAG']/@value)"/>
  <p:with-param name="circleci-build-number"
                select="string(/c:result/c:env[@name='CIRCLE_BUILD_NUM']/@value)"/>
  <p:with-param name="circleci-branch"
                select="string(/c:result/c:env[@name='CIRCLE_BRANCH']/@value)"/>
  <p:with-param name="circleci-user"
                select="string(/c:result/c:env[@name='CIRCLE_PROJECT_USERNAME']/@value)"/>
  <p:with-param name="circleci-repo"
                select="string(/c:result/c:env[@name='CIRCLE_PROJECT_REPONAME']/@value)"/>
  <p:with-param name="auto-diff" select="false()"/>
</dbp:docbook>

<p:choose>
  <p:when test="$postprocess = ''">
    <p:identity>
      <p:input port="source">
        <p:pipe step="format-docbook" port="result"/>
      </p:input>
    </p:identity>
  </p:when>
  <p:otherwise>
    <p:load name="post">
      <p:with-option name="href"
                     select="resolve-uri($postprocess)"/>
    </p:load>
    <p:xslt>
      <p:input port="source">
        <p:pipe step="format-docbook" port="result"/>
      </p:input>
      <p:input port="stylesheet">
        <p:pipe step="post" port="result"/>
      </p:input>
    </p:xslt>
  </p:otherwise>
</p:choose>

</p:declare-step>
