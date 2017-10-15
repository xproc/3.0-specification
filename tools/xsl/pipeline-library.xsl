<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
		exclude-result-prefixes="e"
		version="2.0">

<xsl:output method="xml" indent="yes"/>

<xsl:strip-space elements="*"/>

<xsl:key name="id" match="*" use="@xml:id"/>

<xsl:template match="/">
  <xsl:comment> $Id: pipeline-library.xsl,v 1.5 2009/11/06 17:09:59 NormanWalsh Exp $ </xsl:comment>
  <xsl:text>&#10;</xsl:text>
  <p:library version='1.0'>
    <xsl:for-each select="key('id','std-required')//p:declare-step">
      <xsl:apply-templates select="." mode="copystep"/>
    </xsl:for-each>
    <xsl:for-each select="key('id','std-optional')//p:declare-step">
      <xsl:apply-templates select="." mode="copystep"/>
    </xsl:for-each>
  </p:library>
</xsl:template>

<xsl:template match="p:declare-step" mode="copystep">
  <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
    <xsl:copy-of select="@name|@port"/>
    <xsl:copy-of select="@*[not(name(.) = 'e:type' or name(.) = 'name' or name(.) = 'port')]"/>
    <xsl:attribute name="xml:id" select="substring-after(@type,':')"/>
    <xsl:apply-templates mode="copystep"/>
  </xsl:element>
</xsl:template>

<xsl:template match="*" mode="copystep">
  <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
    <xsl:copy-of select="@name|@port"/>
    <xsl:copy-of select="@*[not(name(.) = 'e:type' or name(.) = 'name' or name(.) = 'port')]"/>
    <xsl:apply-templates mode="copystep"/>
  </xsl:element>
</xsl:template>

</xsl:stylesheet>
