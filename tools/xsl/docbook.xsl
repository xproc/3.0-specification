<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:f="http://docbook.org/xslt/ns/extension"
		xmlns:h="http://www.w3.org/1999/xhtml"
		xmlns:db="http://docbook.org/ns/docbook"
                xmlns:mp="http://docbook.org/xslt/ns/mode/private"
                xmlns:tp="http://docbook.org/xslt/ns/template/private"
                xmlns:m="http://docbook.org/xslt/ns/mode"
		xmlns:t="http://docbook.org/xslt/ns/template"
		xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="f h db m mp t xlink xs tp"
                version="2.0">

<xsl:import href="https://cdn.docbook.org/release/xsl20/current/xslt/base/html/final-pass.xsl"/>

<xsl:param name="js-navigation" select="false()"/>

<xsl:param name="w3c-doctype" select="/db:specification/@class"/>

<xsl:param name="toc.section.depth">3</xsl:param>

<xsl:param name="publication.root.uri"
	   select="if (/processing-instruction(publication-root))
                   then xs:string(processing-instruction(publication-root))
		   else 'http://www.w3.org/TR/'"/>

<xsl:param name="latest.version.uri"
	   select="if (/processing-instruction(latest-version))
                   then xs:string(processing-instruction(latest-version))
		   else ()"/>

<xsl:param name="section.label.includes.component.label" as="xs:boolean" select="true()"/>

<!-- ============================================================ -->

<xsl:variable name="pubdate"
	      select="(xs:date(db:specification/db:info/db:pubdate),
                       current-date())[1]"/>

<xsl:variable name="dtz"
              select="adjust-dateTime-to-timezone(current-dateTime(),
                                                  xs:dayTimeDuration('PT0H'))"/>

<xsl:variable name="pubdt" as="xs:string">
  <xsl:choose>
    <xsl:when test="db:specification/db:info/db:pubdate">
      <!-- If this isn't a valid date, we'll already have errored out -->
      <xsl:value-of select="db:specification/db:info/db:pubdate"/>
    </xsl:when>
    <xsl:otherwise>
      <!-- get rid of fractional seconds -->
      <xsl:value-of select="replace(string($dtz), '\.[0-9]+', '')"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="thisuri" as="xs:string">
  <xsl:value-of>
    <xsl:value-of select="$publication.root.uri"/>

    <xsl:if test="not(/processing-instruction(publication-root))">
      <xsl:value-of select="format-date($pubdate,'[Y0001]')"/>
      <xsl:text>/</xsl:text>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$w3c-doctype = 'fpwd'">WD</xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="upper-case($w3c-doctype)"/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:text>-</xsl:text>
    <xsl:value-of select="db:specification/db:info/db:w3c-shortname"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="format-date($pubdate,'[Y0001][M01][D01]')"/>
    <xsl:text>/</xsl:text>
  </xsl:value-of>
</xsl:variable>

<!-- ============================================================ -->

<xsl:template match="db:specification">
  <xsl:variable name="revisionflags" select="//*[@revisionflag][1]"/>

  <xsl:if test="'step' = tokenize(@role, '\s+')
                and //db:error[starts-with(@code,'C')]
                and not(//processing-instruction('step-error-list'))">
    <xsl:message terminate="yes">
      <xsl:text>Step has errors but no error list glossary</xsl:text>
    </xsl:message>
  </xsl:if>

  <xsl:if test="$revisionflags">
    <div class="augment">
      <p>The presentation of this document has been augmented to
      identify changes from a previous version. Three kinds of changes
      are highlighted: <span class="revision-added">new, added text</span>,
      <span class="revision-changed">changed text</span>, and
      <span class="revision-deleted">deleted text</span>.</p>
      <hr/>
    </div>
  </xsl:if>

  <xsl:choose>
    <xsl:when test="$w3c-doctype = 'namespace'">
      <xsl:call-template name="format-namespace"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="format-specification"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="format-specification">
  <xsl:variable name="revisionflags" select="//*[@revisionflag][1]"/>

  <div class="head" id='spec.head'>
    <a class="logo" href="https://www.w3.org/">
      <img alt="W3C"
           height="48"
           src="https://www.w3.org/StyleSheets/TR/2016/logos/W3C"
           width="72"/>
    </a>

    <xsl:apply-templates select="db:info/db:title[1]"
			 mode="m:titlepage-mode"/>

    <h2>
      <xsl:choose>
        <xsl:when test="$w3c-doctype='ed'">
          <xsl:text>Draft Community Group Report </xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>Community Group Report </xsl:text>
        </xsl:otherwise>
      </xsl:choose>

      <time class="dt-published">
        <xsl:attribute name="datetime"
                       select="format-date($pubdate, '[Y0001]-[M01]-[D01]')"/>
        <xsl:value-of select="format-date($pubdate, '[D1] [MNn] [Y0001]')"/>
      </time>
    </h2>

    <xsl:if test="$w3c-doctype='ed'">
      <div class="editors-draft">
	<xsl:choose>
	  <xsl:when test="count(/*/db:info//db:editor) &gt; 1">
	    <xsl:text>Editors' Draft </xsl:text>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:text>Editor's Draft </xsl:text>
	  </xsl:otherwise>
	</xsl:choose>

        <xsl:if test="$revisionflags">
	  <xsl:text> (with revision marks)</xsl:text>
        </xsl:if>

        <xsl:text> </xsl:text>

        <xsl:if test="not(db:info/db:pubdate)">
          <xsl:text> at </xsl:text>
          <time class="dt-timestamp">
            <xsl:attribute name="datetime"
                           select="format-dateTime($dtz,
                                      '[Y0001][M01][D01]T[H01]:[m01]:[s01]Z')"/>
            <xsl:value-of select="format-dateTime($dtz, '[H01]:[m01]&#160;UTC')"/>
          </time>
          <xsl:if test="$ci-build-number != ''">
            <xsl:text> (</xsl:text>
            <a href="https://github.com/{$ci-user}/{$ci-repo}/commit/{$ci-commit}">
              <xsl:text>build </xsl:text>
              <xsl:value-of select="$ci-build-number"/>
            </a>
            <xsl:text>)</xsl:text>
          </xsl:if>
        </xsl:if>
      </div>
    </xsl:if>

    <dl>
      <xsl:choose>
        <xsl:when test="contains-token(@version, 'final')">
          <dt>Specification:</dt>
          <dd>
            <a href="{db:info/db:bibliomisc[@role='final-uri']}">
              <xsl:sequence select="string(db:info/db:bibliomisc[@role='final-uri'])"/>
            </a>
          </dd>
        </xsl:when>
        <xsl:otherwise>
          <dt>Latest editor’s draft:</dt>
          <dd>
            <a href="https://spec.xproc.org/master/head/{$spec}">
              <xsl:value-of select="concat('https://spec.xproc.org/master/head/', $spec)" />
            </a>
          </dd>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:if test="db:info/db:bibliorelation[@type='replaces']">
	<xsl:variable name="vers"
                      select="db:info/db:bibliorelation[@type='replaces']"/>
	<dt>
	  <xsl:text>Previous version</xsl:text>
	  <xsl:if test="count($vers) &gt; 1">s</xsl:if>
	  <xsl:text>:</xsl:text>
	</dt>
	<dd>
	  <xsl:for-each select="$vers">
	    <xsl:choose>
	      <xsl:when test="starts-with(@xlink:href, 'http:')">
		<a href="{@xlink:href}">
		  <xsl:value-of select="@xlink:href"/>
		</a>
	      </xsl:when>
	      <xsl:otherwise>
		<a href="{$publication.root.uri}{@xlink:href}/">
		  <xsl:value-of select="$publication.root.uri"/>
		  <xsl:value-of select="@xlink:href"/>
		</a>
	      </xsl:otherwise>
	    </xsl:choose>
	    <br/>
	  </xsl:for-each>
	</dd>
      </xsl:if>

      <xsl:variable name="editors"
		    select="db:info/db:authorgroup/*
			    |db:info/db:author
			    |db:info/db:editor"/>

      <dt>
	<xsl:text>Editor</xsl:text>
	<xsl:if test="count($editors) &gt; 1">s</xsl:if>
	<xsl:text>:</xsl:text>
      </dt>

      <xsl:for-each select="$editors">
	<dd>
	  <xsl:apply-templates select="db:personname"/>
	  <xsl:if test="db:affiliation">
	    <xsl:text>, </xsl:text>
	    <xsl:apply-templates select="db:affiliation/db:orgname"/>
	  </xsl:if>
	  <xsl:if test="db:email">
	    <xsl:text> </xsl:text>
	    <xsl:apply-templates select="db:email"/>
	  </xsl:if>
	</dd>
      </xsl:for-each>

      <xsl:variable name="repo"
                    select="db:info/db:bibliomisc[@role='github-repo']"/>

      <dt>Participate:</dt>
      <dd>
        <a href="http://github.com/{$repo}">
          <xsl:text>GitHub </xsl:text>
          <xsl:value-of select="$repo"/>
        </a>
      </dd>
      <dd>
        <a href="http://github.com/{$repo}/issues">
          <xsl:text>Report an issue</xsl:text>
        </a>
      </dd>

      <xsl:if test="($ci-build-number != '' or $auto-diff)
                    and not(db:info/db:bibliomisc[@role='final-uri'])">
        <dt>Changes:</dt>
        <xsl:if test="/*/@xml:id = 'xproc'">
          <dd>
            <a href="lcdiff.html">Diff against the 3.0 specification</a>
          </dd>
        </xsl:if>
        <xsl:if test="$auto-diff">
          <dd>
            <a href="diff.html">Diff against current “status quo” draft</a>
          </dd>
        </xsl:if>
        <xsl:if test="$ci-build-number != ''">
          <dd>
            <a href="http://github.com/{$ci-user}/{$ci-repo}/commits/{$ci-branch}">
              <xsl:text>Commits for this specification</xsl:text>
            </a>
          </dd>
        </xsl:if>
      </xsl:if>

      <xsl:if test="contains-token(@version, 'final')">
        <dt>Errata:</dt>
        <dd>
          <a href="{db:info/db:bibliomisc[@role='final-uri']}errata.html">
            <xsl:sequence select="db:info/db:bibliomisc[@role='final-uri'] || 'errata.html'"/>
          </a>
        </dd>
      </xsl:if>
    </dl>

    <xsl:apply-templates
        select="db:info/db:bibliorelation[@type='references'
                                          and @role='errata']"/>

    <xsl:apply-templates
        select="db:info/db:bibliorelation[@type='references'
                                          and @role='translations']"/>

    <xsl:if test="db:info/db:bibliorelation[@type='isformatof']">
      <p>
	<xsl:text>This document is also available in these </xsl:text>
	<xsl:text>non-normative formats: </xsl:text>
	<xsl:for-each select="db:info/db:bibliorelation[@type='isformatof']">
	  <a href="{@xlink:href}">
	    <xsl:value-of select="."/>
	  </a>
	  <xsl:if test="position() &lt; last()">, </xsl:if>
	</xsl:for-each>

        <xsl:if test="$auto-diff
                      and not(db:info/db:bibliomisc[@role='final-uri'])">
          <xsl:text> and HTML with automatic change markup </xsl:text>
          <xsl:text> courtesy of </xsl:text>
          <a href="http://www.deltaxml.com/">DeltaXML</a>
        </xsl:if>

        <xsl:text>.</xsl:text>
      </p>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="db:info/db:copyright">
        <xsl:apply-templates select="db:info/db:copyright"/>
      </xsl:when>
      <xsl:otherwise>
        <p class="copyright">Copyright © 2018 FIXME: NO COPYRIGHT ELEMENT?</p>
      </xsl:otherwise>
    </xsl:choose>

    <hr title="Separator for header"/>

    <xsl:apply-templates select="db:info/db:abstract"
			 mode="m:titlepage-mode"/>

    <xsl:apply-templates select="db:info/db:legalnotice"
			 mode="m:titlepage-mode"/>
  </div>

  <xsl:apply-templates select="." mode="m:toc"/>

  <article class="{local-name(.)}">
    <xsl:apply-templates/>
    <xsl:call-template name="t:process-footnotes"/>
  </article>

  <xsl:if test="$js-navigation">
    <div id="jsnavbar" class="navbar">&#160;</div>
  </xsl:if>
</xsl:template>

<xsl:template match="db:copyright">
  <p class="copyright">
    <a href="https://www.w3.org/Consortium/Legal/ipr-notice#Copyright"
       >Copyright</a>

    <xsl:text>&#160;©&#160;</xsl:text>

    <span class="years">
      <xsl:call-template name="t:copyright-years">
        <xsl:with-param name="years" select="db:year"/>
        <xsl:with-param name="print.ranges" select="$make.year.ranges"/>
        <xsl:with-param name="single.year.ranges"
                        select="$make.single.year.ranges"/>
      </xsl:call-template>
    </span>

    <xsl:variable name="cg" select="../db:bibliomisc[@role='w3c-cg']"/>

    <xsl:text> the Contributors to the </xsl:text>
    <cite>
      <xsl:value-of select="/db:specification/db:info/db:title"/>
    </cite>
    <xsl:text> specification, published by the </xsl:text>
    <a href="{$cg/@xlink:href}">
      <xsl:value-of select="$cg"/>
      <xsl:text> Community Group</xsl:text>
    </a>
    <xsl:text> under the </xsl:text>
    <a href="https://www.w3.org/community/about/agreements/cla/">W3C
    Community Contributor License Agreement (CLA)</a>
    <xsl:text>. A human-readable </xsl:text>
    <a href="https://www.w3.org/community/about/agreements/cla-deed/">summary</a>
    <xsl:text> is available.</xsl:text>
  </p>
</xsl:template>

<xsl:template match="db:bibliorelation[@type='references'
                                       and @role='errata']">
  <p>
    <xsl:text>Please refer to the </xsl:text>
    <a href="{@xlink:href}">
      <strong>errata</strong>
    </a>
    <xsl:text> for this document,</xsl:text>
    <xsl:text> which may include some normative corrections.</xsl:text>
  </p>
</xsl:template>

<xsl:template match="db:bibliorelation[@type='references'
                                       and @role='translations']">
  <p>See also <a href="{@xlink:href}"> <strong>translations</strong></a>.</p>
</xsl:template>

<xsl:template name="format-namespace">
  <div class="head">
    <p>
      <a href="http://www.w3.org/">
	<img height="48" width="72" alt="W3C"
	     src="http://www.w3.org/Icons/w3c_home"/>
      </a>
    </p>

    <xsl:apply-templates select="db:info/db:title[1]"
			 mode="m:titlepage-mode"/>
  </div>

  <hr/>

  <article class="{local-name(.)}">
    <xsl:apply-templates/>
    <xsl:call-template name="t:process-footnotes"/>
  </article>
</xsl:template>

<xsl:template match="db:specification/db:info/db:title"
	      mode="m:titlepage-mode"
	      priority="100">
  <h1 id="title" class="title p-name">
    <xsl:apply-templates/>
  </h1>
</xsl:template>

<xsl:template match="db:specification/db:info/db:abstract"
	      mode="m:titlepage-mode"
	      priority="100">
  <section id="abstract" class="introductory">
    <h2>Abstract</h2>
    <xsl:apply-templates/>
  </section>
</xsl:template>

<xsl:template match="db:specification/db:info/db:legalnotice"
	      mode="m:titlepage-mode"
	      priority="100">
  <section id="sotd" class="introductory">
    <h2>Status of this Document</h2>

    <xsl:if test="/db:specification/@class='ed'">
      <p>
	<strong>
	  <xsl:text>This document is an </xsl:text>
	  <xsl:choose>
	    <xsl:when test="count(/*/db:info//db:editor) &gt; 1">
	      <xsl:text>editors' </xsl:text>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:text>editor's </xsl:text>
	    </xsl:otherwise>
	  </xsl:choose>
	  <xsl:text> draft that has no official standing.</xsl:text>
	</strong>
      </p>
    </xsl:if>

    <xsl:apply-templates/>
  </section>
</xsl:template>

<xsl:template name="t:user-localization-data">
  <l:l10n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
	  language="en" english-language-name="English">

    <l:context name="title">
      <l:template name="specification" text="%t"/>
    </l:context>

    <l:context name="title-numbered">
      <l:template name="appendix" text="%n&#160;%t"/>
      <l:template name="bridgehead" text="%n&#160;%t"/>
      <l:template name="sect1" text="%n&#160;%t"/>
      <l:template name="sect2" text="%n&#160;%t"/>
      <l:template name="sect3" text="%n&#160;%t"/>
      <l:template name="sect4" text="%n&#160;%t"/>
      <l:template name="sect5" text="%n&#160;%t"/>
      <l:template name="section" text="%n&#160;%t"/>
      <l:template name="simplesect" text="%t"/>
    </l:context>
  </l:l10n>
</xsl:template>

<!-- ============================================================ -->

<xsl:param name="generate.toc" as="element()*">
  <tocparam path="specification" toc="1"/>
  <tocparam path="appendix" toc="0" title="1"/>
  <tocparam path="section" toc="0" title="1"/>
</xsl:param>

<xsl:template match="db:specification" mode="m:toc">
  <xsl:param name="toc.params"
             select="f:find-toc-params(., $generate.toc)"/>

  <xsl:call-template name="t:make-lots">
    <xsl:with-param name="toc.params" select="$toc.params"/>
    <xsl:with-param name="toc">
      <xsl:call-template name="t:component-toc"/>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="db:section[@role='tocsuppress']" mode="m:toc">
  <!-- nop -->
</xsl:template>

<xsl:template name="tp:make-toc">
  <xsl:param name="toc-context" select="."/>
  <xsl:param name="toc.title" select="true()"/>
  <xsl:param name="nodes" select="()"/>

  <xsl:variable name="toc.title">
    <xsl:if test="$toc.title">
      <xsl:call-template name="t:format-toc-title">
        <xsl:with-param name="toc-context" as="element()" select="$toc-context"/>
        <xsl:with-param name="toc-title" as="node()*">
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">TableofContents</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:variable>

  <xsl:if test="$nodes">
    <nav id="toc">
      <xsl:copy-of select="$toc.title"/>
      <ol class="toc">
        <xsl:apply-templates select="$nodes" mode="mp:toc">
          <xsl:with-param name="toc-context" select="$toc-context"/>
        </xsl:apply-templates>
      </ol>
    </nav>
  </xsl:if>
</xsl:template>

<xsl:template name="t:format-toc-title">
  <xsl:param name="toc-context" as="element()"/>
  <xsl:param name="toc-title" as="node()*"/>
  <h2 id="TableOfContents">
    <xsl:sequence select="$toc-title"/>
  </h2>
</xsl:template>

<xsl:template name="tp:toc-line">
  <xsl:param name="toc-context" select="."/>
  <xsl:param name="depth" select="1"/>
  <xsl:param name="depth.from.context" select="8"/>

  <xsl:attribute name="class" select="'tocline'"/>

  <a class="tocxref" href="{f:href(/,.)}">
    <bdi class="secno">
      <xsl:apply-templates select="." mode="m:label-content"/>
      <xsl:if test="not($toc-context/parent::db:section)">.</xsl:if>
      <xsl:text> </xsl:text>
    </bdi>
    <xsl:apply-templates select="." mode="m:titleabbrev-content"/>
  </a>
</xsl:template>

<xsl:template match="h:li" mode="fixup-toc" priority="10">
  <dt>
    <xsl:apply-templates select="@*,node()" mode="fixup-toc"/>
  </dt>
  <xsl:if test="h:ul">
    <dd>
      <dl class="toc">
        <xsl:apply-templates select="h:ul/node()" mode="fixup-toc"/>
      </dl>
    </dd>
  </xsl:if>
</xsl:template>

<xsl:template match="h:ul[parent::h:li]" mode="fixup-toc" priority="15"/>

<xsl:template match="h:ul" mode="fixup-toc" priority="10">
  <dl class="toc">
    <xsl:apply-templates mode="fixup-toc"/>
  </dl>
</xsl:template>

<xsl:template match="*" mode="fixup-toc">
  <xsl:copy>
    <xsl:apply-templates select="@*,node()" mode="fixup-toc"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="comment()|text()|attribute()|processing-instruction()"
              mode="fixup-toc">
  <xsl:copy/>
</xsl:template>

<xsl:template match="db:section|db:appendix" mode="m:object-title-markup">
  <bdi class="secno">
    <xsl:apply-templates select="." mode="m:label-content"/>
    <xsl:text>. </xsl:text>
  </bdi>
  <xsl:apply-templates select="." mode="m:title-content">
    <xsl:with-param name="template" select="'%t'"/>
  </xsl:apply-templates>
  <a aria-label="§" class="self-link" href="#{@xml:id}"/>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="db:rfc2119">
  <span class="rfc2119">
    <xsl:sequence select="f:html-attributes(., f:node-id(.))"/>
    <xsl:if test="@lang or @xml:lang">
      <xsl:call-template name="lang-attribute"/>
    </xsl:if>
    <xsl:call-template name="t:xlink"/>
  </span>
</xsl:template>

<xsl:template match="db:assert">
  <span class="assert">
    <xsl:sequence select="f:html-attributes(., f:node-id(.))"/>
    <xsl:if test="@lang or @xml:lang">
      <xsl:call-template name="lang-attribute"/>
    </xsl:if>
    <xsl:call-template name="t:xlink"/>
  </span>
</xsl:template>

<!-- ============================================================ -->

<xsl:function name="f:syntax-highlight-class" as="xs:string*">
  <xsl:param name="node"/>

  <xsl:variable name="numbered" select="f:syntax-highlight($node)"/>

  <!-- We do this irrespective of whether or not syntax highlighting is enabled.
       If it's not enabled, these values may allow a downstream process
       to do the highlighting. Also, output the language value untransformed. -->

  <xsl:variable name="language" select="$node/@language/string()"/>
  <xsl:variable name="mapped-language"
                select="($syntax.highlight.map[@key=$language]/@value/string(),
                         $language)[1]"/>

  <xsl:variable name="language" as="xs:string?"
                select="if ($mapped-language)
                        then concat('language-', $mapped-language)
                        else 'language-none'"/>

  <!-- Prism numbers listings that have the 'line-numbers' class. -->
  <!-- Turn off line numbers. -->
  <xsl:variable name="numbers" as="xs:string?" select="()"/>

  <xsl:sequence select="($language,$numbers,$node/@language,$node/@role)"/>
</xsl:function>

</xsl:stylesheet>
