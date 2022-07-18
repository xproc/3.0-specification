<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:h="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="#all"
                version="3.0">

<xsl:output method="xml" encoding="utf-8" indent="no"
            omit-xml-declaration="yes"/>

<xsl:mode on-no-match="shallow-copy"/>

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="h:p[contains-token(@class, 'copyright')]">
  <xsl:next-match/>
  <xsl:sequence select="../h:section[@id='abstract']"/>
</xsl:template>

<xsl:template match="h:section[@id='abstract']"/>

<xsl:template match="h:img[@src='https://www.w3.org/StyleSheets/TR/2016/logos/W3C']">
  <img>
    <xsl:copy-of select="@* except @src"/>
    <xsl:attribute name="src" select="'logos/W3C.png'"/>
  </img>
</xsl:template>

<xsl:template match="h:link[@href='css/respec.css']">
  <!-- drop -->
</xsl:template>

</xsl:stylesheet>
