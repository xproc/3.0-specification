<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="xs"
                version="2.0">
<!-- N.B. This stylesheet completely ignores its input document. -->

<xsl:param name="libraries" required="yes" as="xs:string"/>

<xsl:variable name="steps" as="document-node()+">
  <xsl:for-each select="tokenize(normalize-space($libraries), '\s+')">
    <xsl:sequence select="doc(.)"/>
  </xsl:for-each>
</xsl:variable>

<xsl:template match="/">
  <p:library xmlns:p="http://www.w3.org/ns/xproc"
             xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax"
             version="3.0">
    <xsl:for-each select="$steps/*/*">
      <xsl:sort select="@type"/>
      <xsl:sequence select="."/>
    </xsl:for-each>
  </p:library>
</xsl:template>

</xsl:stylesheet>
