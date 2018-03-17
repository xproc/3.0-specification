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

<xsl:import href="dbspec.xsl"/>

<xsl:key name="linkend" match="*" use="@linkend"/>

<xsl:variable name="spec" as="xs:string">
  <xsl:choose>
    <xsl:when test="/*/@xml:id = 'overview'">
      <xsl:value-of select="''"/>
    </xsl:when>
    <xsl:when test="starts-with(/*/@xml:id, 'step-')">
      <xsl:value-of select="concat(substring-after(/*/@xml:id, 'step-'), '/')"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="concat(/*/@xml:id, '/')"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:key name="errcode" match="db:error" use="@code"/>

<xsl:template match="/">
  <xsl:if test="/*/@xml:id">
    <xsl:result-document href="{/*/@xml:id}/build/toc.xml" method="xml">
      <xsl:apply-templates mode="make-toc-xml"/>
    </xsl:result-document>
  </xsl:if>
  <xsl:next-match/>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="db:specification" mode="make-toc-xml">
  <toc xmlns="http://docbook.org/ns/docbook"
       xmlns:xlink="http://www.w3.org/1999/xlink"
       xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
       xmlns:xi="http://www.w3.org/2001/XInclude">
    <xsl:apply-templates mode="make-toc-xml"/>
  </toc>
</xsl:template>

<xsl:template match="db:section[db:section|db:appendix]
                     |db:appendix[db:section|db:appendix]"
              mode="make-toc-xml" priority="200">
  <tocdiv xmlns="http://docbook.org/ns/docbook"
          role="{local-name(.)}">
    <xsl:sequence select="@xml:id"/>
    <xsl:apply-templates mode="make-toc-xml"/>
  </tocdiv>
</xsl:template>

<xsl:template match="db:section|db:appendix" mode="make-toc-xml" priority="100">
  <tocentry xmlns="http://docbook.org/ns/docbook"
            role="{local-name(.)}">
    <xsl:sequence select="@xml:id"/>
    <xsl:sequence select="db:info/db:title/node()"/>
  </tocentry>
</xsl:template>

<xsl:template match="db:specification/db:info/db:title
                     |db:section/db:info/db:title
                     |db:appendix/db:info/db:title"
              mode="make-toc-xml" priority="100">
  <xsl:sequence select="."/>
</xsl:template>

<xsl:template match="db:figure[@xml:id]|db:example[@xml:id]|db:table[@xml:id]"
              mode="make-toc-xml" priority="100">
  <xsl:if test="db:info/db:title">
    <tocentry xmlns="http://docbook.org/ns/docbook"
              role="{local-name(.)}">
      <xsl:sequence select="@xml:id"/>
      <xsl:sequence select="db:info/db:title/node()"/>
    </tocentry>
  </xsl:if>
</xsl:template>

<xsl:template match="element()" mode="make-toc-xml">
  <xsl:apply-templates mode="make-toc-xml"/>
</xsl:template>

<xsl:template match="attribute()|text()|comment()|processing-instruction()"
              mode="make-toc-xml">
  <!-- nop -->
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="db:bibliomixed">
  <xsl:param name="label" select="f:biblioentry-label(.)"/>

  <div>
    <xsl:sequence select="f:html-attributes(.)"/>
    <p>
      <xsl:if test="empty(key('linkend', @xml:id))
                    and not('unreferenced' = tokenize(@role, '\s+'))">
        <xsl:attribute name="class" select="'error'"/>
        <xsl:text>@@FIXME:UNREFERENCED </xsl:text>
      </xsl:if>
      <xsl:text>[</xsl:text>
      <xsl:copy-of select="$label"/>
      <xsl:text>] </xsl:text>
      <xsl:apply-templates mode="m:bibliomixed"/>
    </p>
  </div>
</xsl:template>

</xsl:stylesheet>
