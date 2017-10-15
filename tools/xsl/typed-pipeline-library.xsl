<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
		version="2.0">

<xsl:output method="xml" indent="yes"/>

<xsl:strip-space elements="*"/>

<xsl:key name="id" match="*" use="@xml:id"/>

<xsl:param name="merge" select="''"/>

<xsl:variable name="lib" as="element(p:declare-step)*">
  <xsl:if test="$merge != ''">
    <xsl:sequence select="doc(resolve-uri($merge, base-uri(/)))//p:declare-step"/>
  </xsl:if>
</xsl:variable>

<xsl:template match="/">
  <p:library version='1.0'>
    <xsl:sequence select="$lib"/>

    <xsl:for-each select="key('id','std-required')//p:declare-step">
      <xsl:apply-templates select="." mode="copystep"/>
    </xsl:for-each>
    <xsl:for-each select="key('id','std-optional')//p:declare-step">
      <xsl:apply-templates select="." mode="copystep"/>
    </xsl:for-each>

    <xsl:if test="empty(key('id','std-required')) and empty(key('id','std-optional'))">
      <xsl:for-each select="//p:declare-step">
        <xsl:apply-templates select="." mode="copystep"/>
      </xsl:for-each>
    </xsl:if>
  </p:library>
</xsl:template>

<xsl:template match="p:declare-step" mode="copystep">
  <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
    <xsl:apply-templates select="@*" mode="copystep"/>
    <xsl:attribute name="xml:id" select="substring-after(@type,':')"/>
    <xsl:apply-templates mode="copystep"/>
  </xsl:element>
</xsl:template>

<xsl:template match="*" mode="copystep">
  <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
    <xsl:apply-templates select="@*" mode="copystep"/>
    <xsl:apply-templates mode="copystep"/>
  </xsl:element>
</xsl:template>

<xsl:template match="@as" mode="copystep">
  <xsl:choose>
    <xsl:when test="contains(., '(')">
      <xsl:attribute name="as" select="'xs:string'"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:copy/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="attribute()" mode="copystep">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>
