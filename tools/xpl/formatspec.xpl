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
<p:option name="diffloc" select="'build/diff.html'"/>
<p:option name="lcdiffloc" select="''"/>
<p:option name="diff" select="''"/>
<p:option name="specid" select="''"/>

<p:import href="https://cdn.docbook.org/release/xsl20/current/xslt/base/pipelines/docbook.xpl"/>

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

  <p:with-param name="ci"
                select="string(/c:result/c:env[@name='CIWORKFLOW']/@value)"/>
  <p:with-param name="ci-commit"
                select="string(/c:result/c:env[@name='CI_SHA1']/@value)"/>
  <p:with-param name="ci-tag"
                select="string(/c:result/c:env[@name='CI_TAG']/@value)"/>
  <p:with-param name="ci-build-number"
                select="string(/c:result/c:env[@name='CI_BUILD_NUM']/@value)"/>
  <p:with-param name="ci-branch"
                select="string(/c:result/c:env[@name='CI_BRANCH']/@value)"/>
  <p:with-param name="ci-user"
                select="string(/c:result/c:env[@name='CI_PROJECT_USERNAME']/@value)"/>
  <p:with-param name="ci-repo"
                select="string(/c:result/c:env[@name='CI_PROJECT_REPONAME']/@value)"/>
  <p:with-param name="auto-diff" select="$diff != '' and $specid != ''"/>
</dbp:docbook>

<p:choose>
  <p:when test="$diff != '' and $specid != ''"
          xmlns:html="http://www.w3.org/1999/xhtml">
    <!-- The id values on paragraphs that contain code often change;
         these changed ids confuse the diff tool. Just remove them.
         It might break a link or two, but it's worth it for clean
         differences.
    -->
    <p:load>
      <p:with-option name="href"
                     select="concat('https://spec.xproc.org/master/head/', $specid)"/>
    </p:load>
    <p:delete match="html:p[//html:code]/@id"/>
    <p:store name="fix1">
      <p:with-option name="href" select="concat('../../build/', $specid, '-current.html')"/>
    </p:store>

   <p:delete match="html:p[//html:code]/@id" cx:depends-on="fix1">
      <p:input port="source">
        <p:pipe step="format-docbook" port="result"/>
      </p:input>
    </p:delete>
    <p:store name="fix2">
      <p:with-option name="href" select="concat('../../build/', $specid, '-updated.html')"/>
    </p:store>

    <!-- This is exec'd instead of cx:delta-xml'd because the newest version
         of Delta XML seems to require SaxonPE which it ships with but
         we don't have. :-( -->
    <p:exec command="java" result-is-xml="false" cx:depends-on="fix2">
      <p:input port="source"><p:empty/></p:input>
      <p:with-option name="args"
                     select="concat('-jar deltaxml/command-10.3.1.jar compare xhtml-patch ',
                                    'build/', $specid, '-current.html build/', $specid, '-updated.html ', $diffloc)">
        <p:empty/>
      </p:with-option>
    </p:exec>
    <p:sink/>
  </p:when>
  <p:otherwise>
    <p:sink/>
  </p:otherwise>
</p:choose>

<p:choose>
  <p:when test="$diff != '' and $specid != '' and $lcdiffloc != ''"
          xmlns:html="http://www.w3.org/1999/xhtml">
    <!-- The id values on paragraphs that contain code often change;
         these changed ids confuse the diff tool. Just remove them.
         It might break a link or two, but it's worth it for clean
         differences.
    -->
    <p:load>
      <p:with-option name="href"
                     select="'https://spec.xproc.org/3.0/xproc/index.html'"/>
    </p:load>
    <p:delete match="html:p[//html:code]/@id"/>
    <p:store name="fix1">
      <p:with-option name="href" select="concat('../../build/', $specid, '-lc.html')"/>
    </p:store>

   <p:delete match="html:p[//html:code]/@id" cx:depends-on="fix1">
      <p:input port="source">
        <p:pipe step="format-docbook" port="result"/>
      </p:input>
    </p:delete>
    <p:store name="fix2">
      <p:with-option name="href" select="concat('../../build/', $specid, '-updated.html')"/>
    </p:store>

    <!-- This is exec'd instead of cx:delta-xml'd because the newest version
         of Delta XML seems to require SaxonPE which it ships with but
         we don't have. :-( -->
    <p:exec command="java" result-is-xml="false" cx:depends-on="fix2">
      <p:input port="source"><p:empty/></p:input>
      <p:with-option name="args"
                     select="concat('-jar deltaxml/command-10.3.1.jar compare xhtml-patch ',
                                    'build/', $specid, '-lc.html build/', $specid, '-updated.html ', $lcdiffloc)">
        <p:empty/>
      </p:with-option>
    </p:exec>
    <p:sink/>
  </p:when>
  <p:otherwise>
    <p:sink>
      <p:input port="source">
        <p:empty/>
      </p:input>
    </p:sink>
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
