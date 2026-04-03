<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:db="http://docbook.org/ns/docbook"
		exclude-result-prefixes="xs db"
                version="2.0">

<xsl:variable name="bib" select="doc('../../src/main/xml/bibliography.xml')"/>

<xsl:template match="db:bibliomixed">
  <xsl:variable name="id" select="@xml:id"/>
  <xsl:variable name="entry" select="$bib//db:bibliomixed[@xml:id=$id]"/>
  <xsl:choose>
    <xsl:when test="count($entry) = 1">
      <xsl:copy>
        <xsl:apply-templates select="$entry/@*,$entry/node()"/>
      </xsl:copy>
    </xsl:when>
    <xsl:otherwise>
      <bibliomixed xmlns="http://docbook.org/ns/docbook" role="error">
        <xsl:apply-templates select="@*"/>
        <xsl:text>@@FIXME:MISSING </xsl:text>
        <xsl:apply-templates select="node()"/>
      </bibliomixed>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="element()">
  <xsl:copy>
    <xsl:apply-templates select="@*,node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="attribute()|text()|comment()|processing-instruction()">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>
