<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:f="http://docbook.org/xslt/ns/extension"
                xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:doc="http://nwalsh.com/xmlns/schema-doc/"
                xmlns:m="http://docbook.org/xslt/ns/mode"
                xmlns:ml="http://nwalsh.com/ns/ml-macro#"
                xmlns:n="http://docbook.org/xslt/ns/normalize"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:t="http://docbook.org/xslt/ns/template"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="f h db doc m ml n rng t xlink xs"
                version="2.0">

<!-- Stylesheet for langspec/steps/steps.xml -->
<xsl:import href="dbspec.xsl"/>

<xsl:key name="errcode" match="db:error" use="@code"/>

<xsl:param name="otherspec" select="'../xproc20/,xproc20.xml'"/>
<xsl:param name="otherlabel" select="'XProc 2.0'"/>

<xsl:param name="otherprefix" select="''"/>
<xsl:param name="othersuffix" select="''"/>

<xsl:param name="otherhref"
           select="concat($otherprefix,
                          substring-after(substring-before($otherspec, '/,'),'/'),
                          $othersuffix)"/>

<xsl:function name="f:ospec" as="element()">
  <xsl:param name="context"/>

  <xsl:variable name="fn" select="resolve-uri($otherspec, base-uri($context))"/>
  <xsl:sequence select="doc($fn)/*"/>
</xsl:function>

<xsl:template match="db:tag">
  <xsl:variable name="name" select="."/>
  <xsl:variable name="local" select="substring-after($name,':')"/>

  <xsl:choose>
    <xsl:when test="starts-with(.,'p:') or starts-with(.,'c:')">
      <xsl:variable name="id" as="xs:string">
	<xsl:choose>
	  <xsl:when test="starts-with(.,'p:') and key('id', concat('p.',$local))">
	    <xsl:value-of select="concat('p.',$local)"/>
	  </xsl:when>
	  <xsl:when test="starts-with(.,'c:') and key('id', concat('cv.',$local))">
	    <xsl:value-of select="concat('cv.',$local)"/>
	  </xsl:when>
	  <xsl:when test="key('id', concat('p.',$local))">
	    <xsl:value-of select="concat('p.',$local)"/>
	  </xsl:when>
	  <xsl:when test="key('id', concat('c.',$local))">
	    <xsl:value-of select="concat('c.',$local)"/>
	  </xsl:when>
	  <xsl:when test="key('id', concat('cv.',$local))">
	    <xsl:value-of select="concat('cv.',$local)"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="translate($name,':','.')"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="ospec-id" as="xs:string">
	<xsl:choose>
	  <xsl:when test="starts-with(.,'p:') and key('id', concat('p.',$local), f:ospec(.))">
	    <xsl:value-of select="concat('p.',$local)"/>
	  </xsl:when>
	  <xsl:when test="starts-with(.,'c:') and key('id', concat('cv.',$local), f:ospec(.))">
	    <xsl:value-of select="concat('cv.',$local)"/>
	  </xsl:when>
	  <xsl:when test="key('id', concat('p.',$local), f:ospec(.))">
	    <xsl:value-of select="concat('p.',$local)"/>
	  </xsl:when>
	  <xsl:when test="key('id', concat('c.',$local), f:ospec(.))">
	    <xsl:value-of select="concat('c.',$local)"/>
	  </xsl:when>
	  <xsl:when test="key('id', concat('cv.',$local), f:ospec(.))">
	    <xsl:value-of select="concat('cv.',$local)"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="translate($name,':','.')"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="def" select="key('id', $id)"/>

      <xsl:choose>
        <xsl:when test="$def">
          <xsl:next-match/>
        </xsl:when>
        <xsl:when test="key('id', $ospec-id, f:ospec(.))">
	  <a href="{$otherhref}#{$ospec-id}">
	    <xsl:apply-templates/>
	  </a>
          <sup class="xrefspec"><a href="{$otherhref}"><xsl:value-of select="$otherlabel"/></a></sup>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:message>Warning: No anchor for <xsl:value-of select="$id"/></xsl:message>
	  <xsl:apply-imports/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-imports/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="db:link" name="db:link">
  <xsl:param name="title" select="string(db:alt[1])" as="xs:string"/>
  <xsl:param name="href" select="iri-to-uri(string(@xlink:href))" as="xs:string"/>

  <xsl:choose>
    <xsl:when test="node()">
      <xsl:choose>
	<xsl:when test="$href = '' and not(f:findid(@linkend,.))">
	  <a href="{$otherhref}#{@linkend}">
            <xsl:sequence select="f:html-attributes(.)"/>
	    <xsl:if test="$title != ''">
	      <xsl:attribute name="title" select="$title"/>
	    </xsl:if>
	    <xsl:apply-templates/>
	  </a>
          <sup class="xrefspec"><a href="{$otherhref}"><xsl:value-of select="$otherlabel"/></a></sup>
	</xsl:when>
        <xsl:otherwise>
          <xsl:next-match/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:next-match/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="db:xref">
  <xsl:param name="linkend"
             select="(@linkend, if (starts-with(@xlink:href, '#'))
                                then substring-after(@xlink:href, '#')
                                else ())[1]"/>

  <xsl:variable name="target" select="f:findid($linkend,.)[1]"/>
  <xsl:variable name="refelem" select="node-name($target)"/>

  <xsl:choose>
    <xsl:when test="count($target) = 0">
      <xsl:variable name="target" select="key('id', $linkend, f:ospec(.))"/>
      <xsl:variable name="refelem" select="node-name($target)"/>

      <xsl:choose>
        <xsl:when test="count($target) = 0">
          <xsl:message>
            <xsl:text>XRef to nonexistent id: </xsl:text>
            <xsl:value-of select="$linkend"/>
          </xsl:message>
          <span class="formatting-error">
            <xsl:sequence select="f:html-attributes(., @xml:id, ())"/>
	    <xsl:text>@@LINKEND: </xsl:text>
            <xsl:value-of select="$linkend"/>
	    <xsl:text>@@</xsl:text>
          </span>
        </xsl:when>

        <xsl:when test="@endterm">
          <xsl:variable name="etarget" select="f:findid(@endterm,f:ospec(.))[1]"/>

          <xsl:if test="count(f:findid(@endterm,f:ospec(.))) &gt; 1">
	    <xsl:message>
	      <xsl:text>Warning: the ID '</xsl:text>
	      <xsl:value-of select="@endterm"/>
	      <xsl:text>' is not unique.</xsl:text>
	    </xsl:message>
          </xsl:if>

          <xsl:choose>
	    <xsl:when test="count($etarget) = 0">
              <xsl:message>
                <xsl:text>Endterm points to nonexistent id: </xsl:text>
	        <xsl:value-of select="@endterm"/>
              </xsl:message>
	      <a href="{$otherhref}#{@endterm}">
                <xsl:sequence select="f:html-attributes(., @xml:id, ())"/>
	        <span class="formatting-error">
                  <xsl:text>@@ENDTERM: </xsl:text>
                  <xsl:value-of select="@endterm"/>
                  <xsl:text>@@</xsl:text>
	        </span>
	      </a>
              <sup class="xrefspec"><a href="{$otherhref}"><xsl:value-of select="$otherlabel"/></a></sup>
            </xsl:when>
            <xsl:otherwise>
	      <a href="{$otherhref}#{@endterm}">
                <xsl:sequence select="f:html-attributes(., @xml:id, ())"/>
	        <xsl:apply-templates select="$etarget" mode="m:endterm"/>
	      </a>
              <sup class="xrefspec"><a href="{$otherhref}"><xsl:value-of select="$otherlabel"/></a></sup>
	    </xsl:otherwise>
          </xsl:choose>
        </xsl:when>

        <xsl:when test="$target/@xreflabel">
	  <a href="{$otherhref}#{$linkend}">
	    <xsl:call-template name="t:xref-xreflabel">
	      <xsl:with-param name="target" select="$target"/>
	    </xsl:call-template>
          </a>
          <sup class="xrefspec"><a href="{$otherhref}"><xsl:value-of select="$otherlabel"/></a></sup>
        </xsl:when>

        <xsl:otherwise>
          <xsl:apply-templates select="$target" mode="m:xref-to-prefix"/>

	  <a href="{$otherhref}#{$linkend}">
	    <xsl:if test="$target/db:info/db:title">
	      <xsl:attribute name="title" select="string($target/db:info/db:title)"/>
	    </xsl:if>
	    <xsl:apply-templates select="$target" mode="m:xref-to">
	      <xsl:with-param name="referrer" select="."/>
	      <xsl:with-param name="xrefstyle">
	        <xsl:choose>
	          <xsl:when test="@role and not(@xrefstyle)
			          and $use.role.as.xrefstyle != 0">
		    <xsl:value-of select="@role"/>
	          </xsl:when>
	          <xsl:otherwise>
		    <xsl:value-of select="@xrefstyle"/>
	          </xsl:otherwise>
	        </xsl:choose>
	      </xsl:with-param>
	    </xsl:apply-templates>
	  </a>
          <sup class="xrefspec"><a href="{$otherhref}"><xsl:value-of select="$otherlabel"/></a></sup>

          <xsl:apply-templates select="$target" mode="m:xref-to-suffix"/>
        </xsl:otherwise>
      </xsl:choose>

    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="db:xref">
        <xsl:with-param name="linkend" select="$linkend"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="db:glossterm">
  <xsl:variable name="term" select="string(.)"/>
  <xsl:variable name="anchorterm"
                select="if (@baseform) then @baseform else normalize-space($term)"/>
  <xsl:variable name="anchor" select="translate($anchorterm,' ','-')"/>
  <xsl:variable name="termdef" select="key('id',concat('dt-', $anchor))"/>

  <xsl:if test="($anchorterm = 'static error' or $anchorterm = 'dynamic error')
                and (not(ancestor::db:error)
		     and not(ancestor::db:termdef)
		     and not(ancestor::db:glossentry)
		     and not(@role = 'unwrapped'))">
    <xsl:message>
      <xsl:text>Unwrapped </xsl:text>
      <xsl:value-of select="$anchorterm"/>
      <xsl:text> (</xsl:text>
      <xsl:value-of select="name(parent::*)"/>
      <xsl:text> ) in </xsl:text>
      <xsl:value-of select="parent::*"/>
    </xsl:message>
  </xsl:if>

  <xsl:if test="($anchorterm = 'implementation-defined'
		 or $anchorterm = 'implementation-dependent')
                and (not(ancestor::db:impl)
		     and not(@role='unwrapped')
		     and not(ancestor::db:glossentry))">
    <xsl:message>
      <xsl:text>Unwrapped </xsl:text>
      <xsl:value-of select="$anchorterm"/>
      <xsl:text> (</xsl:text>
      <xsl:value-of select="name(parent::*)"/>
      <xsl:text> ) in </xsl:text>
      <xsl:value-of select="parent::*"/>
    </xsl:message>
  </xsl:if>

  <xsl:choose>
    <xsl:when test="empty($termdef)">
      <xsl:variable name="termdef"
                    select="key('id',concat('dt-', $anchor),f:ospec(.))"/>
      <em class="glossterm">
        <xsl:choose>
          <xsl:when test="$termdef">
	    <a href="{$otherhref}#{$termdef/@xml:id}">
	      <xsl:apply-templates/>
	    </a>
            <sup class="xrefspec"><a href="{$otherhref}"><xsl:value-of select="$otherlabel"/></a></sup>
          </xsl:when>
          <xsl:otherwise>
	    <xsl:message>
	      <xsl:text>No definition for glossterm: "</xsl:text>
	      <xsl:value-of select="$anchor"/>
	      <xsl:text>"</xsl:text>
	    </xsl:message>
	    <xsl:apply-templates/>
          </xsl:otherwise>
        </xsl:choose>
      </em>
    </xsl:when>
    <xsl:otherwise>
      <em class="glossterm">
	<a href="#{$termdef/@xml:id}">
	  <xsl:apply-templates/>
	</a>
      </em>
    </xsl:otherwise>
  </xsl:choose>

  <xsl:if test="ancestor::db:error
		and ($anchorterm = 'static error'
                     or $anchorterm = 'dynamic error')">
    <xsl:variable name="code" select="ancestor::db:error[1]/@code"/>
    <xsl:text>&#160;(</xsl:text>

    <xsl:variable name="step-spec" select="not(contains($otherspec, '-steps'))"/>
    <xsl:variable name="step-err" select="starts-with($code, 'C')"/>

    <xsl:choose>
      <!-- MAJOR HACKING -->
      <xsl:when test="($step-spec and $step-err)
                      or (not($step-spec) and not($step-err))">
        <a href="#err.{$code}">
          <code class="errqname">
	    <xsl:text>err:X</xsl:text>
	    <xsl:value-of select="$code"/>
          </code>
        </a>
      </xsl:when>
      <xsl:when test="($step-spec and not($step-err))
                      or (not($step-spec) and $step-err)">
	<a href="{$otherhref}#err.{$code}">
          <code class="errqname">
	    <xsl:text>err:X</xsl:text>
	    <xsl:value-of select="$code"/>
          </code>
	</a>
        <sup class="xrefspec">
          <a href="{$otherhref}">
            <xsl:value-of select="$otherlabel"/>
          </a>
        </sup>
      </xsl:when>
      <xsl:otherwise>
	<xsl:message>
	  <xsl:text>No anchor for err: "</xsl:text>
	  <xsl:value-of select="$code"/>
	  <xsl:text>"</xsl:text>
	</xsl:message>
	<xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>)</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="db:olink">
  <!-- Hack: Ignore targetdoc because it's always just to the otherspec -->
  <xsl:variable name="ptr" select="@targetptr"/>
  <xsl:variable name="node" select="(f:ospec(.)//*[@xml:id=$ptr])[1]"/>

  <xsl:variable name="linktext">
    <xsl:choose>
      <xsl:when test="empty(node())">
        <xsl:apply-templates select="$node" mode="m:xref-to-prefix"/>
	<xsl:apply-templates select="$node" mode="m:xref-to"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <span class="xspecref">
    <a href="{$otherhref}#{$ptr}">
      <xsl:sequence select="$linktext"/>
    </a>
    <sup class="xrefspec"><a href="{$otherhref}"><xsl:value-of select="$otherlabel"/></a></sup>
  </span>
</xsl:template>

<xsl:template match="db:bibliolist">
  <xsl:variable name="list">
    <xsl:next-match/>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$list//h:div[@class='bibliomixed']">
      <xsl:sequence select="$list"/>
    </xsl:when>
    <xsl:otherwise>
      <p>None.</p>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="db:bibliomixed">
  <xsl:param name="label" select="f:biblioentry-label(.)"/>

  <xsl:variable name="id" select="@xml:id"/>
  <xsl:if test="//db:biblioref[@linkend=$id]">
    <div>
      <xsl:sequence select="f:html-attributes(.)"/>

      <p>
        <xsl:text>[</xsl:text>
        <xsl:copy-of select="$label"/>
        <xsl:text>] </xsl:text>
        <xsl:choose>
	  <xsl:when test="self::db:biblioentry">
	    <xsl:apply-templates mode="m:biblioentry"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:apply-templates mode="m:bibliomixed"/>
	  </xsl:otherwise>
        </xsl:choose>
      </p>
    </div>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
