<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:db="http://docbook.org/ns/docbook"
		exclude-result-prefixes="db"
		version="2.0">

<xsl:output method="xml" indent="yes"/>
<xsl:strip-space elements="*"/>

<xsl:key name="id" match="*" use="@xml:id"/>

<xsl:template match="/">
  <xsl:comment> $Id: error-list.xsl,v 1.2 2009/09/10 17:17:57 NormanWalsh Exp $ </xsl:comment>
  <xsl:text>&#10;</xsl:text>
  <error-list xmlns="http://www.w3.org/ns/xproc-error">
    <xsl:for-each-group select="//db:error" group-by="@code">
      <xsl:sort select="@code"/>
      <error xmlns="http://www.w3.org/ns/xproc-error"
	     code="X{current-grouping-key()}">
	<xsl:value-of select="normalize-space(current-group()[1])"/>
      </error>
    </xsl:for-each-group>
  </error-list>
</xsl:template>

</xsl:stylesheet>
