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
<p:option name="diffkey" select="''"/>
<p:option name="webid" select="'xproc'"/>
<p:option name="diffloc" select="'/tmp/diff.html'"/>

<p:import href="https://cdn.docbook.org/release/2.3.7/xslt/base/pipelines/docbook.xpl"/>

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
  <p:with-param name="auto-diff" select="$diffkey != ''"/>
</dbp:docbook>

<p:wrap match="/" wrapper="c:body"/>
<p:add-attribute match="/c:body" attribute-name="content-type"
                 attribute-value="application/xml+html"/>

<p:escape-markup/>

<p:wrap match="/" wrapper="c:request"/>
<p:add-attribute match="/c:request" attribute-name="method"
                 attribute-value="post"/>
<p:add-attribute match="/c:request" attribute-name="href">
  <p:with-option name="attribute-value"
                 select="concat('https://dataapi.nwalsh.com/dxml/cgi-bin/deltaxml.pl?',
                                'key=', $diffkey, '&amp;webid=', $webid)"/>
</p:add-attribute>

<p:choose>
  <p:when test="$diffkey != ''">
    <p:http-request/>
    <p:unescape-markup/>
    <p:unwrap match="/c:body"/>
    <p:store method="html">
      <p:with-option name="href" select="$diffloc"/>
    </p:store>
  </p:when>
  <p:otherwise>
    <p:sink/>
  </p:otherwise>
</p:choose>

<p:for-each>
  <p:iteration-source>
    <p:pipe step="format-docbook" port="secondary"/>
  </p:iteration-source>
  <p:store name="store-chunk" encoding="utf-8" indent="true" method="xml">
    <p:with-option name="href" select="base-uri(/)"/>
  </p:store>
</p:for-each>

</p:declare-step>
