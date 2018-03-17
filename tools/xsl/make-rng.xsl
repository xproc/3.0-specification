<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
		exclude-result-prefixes="xs rng"
                version="2.0">

<xsl:param name="libraries" required="yes" as="xs:string"/>

<xsl:variable name="steps" as="document-node()+">
  <xsl:for-each select="tokenize(normalize-space($libraries), '\s+')">
    <xsl:sequence select="doc(.)"/>
  </xsl:for-each>
</xsl:variable>

<xsl:template match="rng:grammar">
  <xsl:copy>
    <xsl:apply-templates select="@*,node()"/>

    <define xmlns="http://relaxng.org/ns/structure/1.0"
            name="StandardStep">
      <choice>
        <xsl:for-each select="$steps">
          <xsl:copy-of select="rng:grammar/rng:define[@name='Step']//rng:ref"/>
        </xsl:for-each>
      </choice>
    </define>

    <xsl:for-each select="$steps">
      <xsl:copy-of select="rng:grammar/rng:define[@name != 'Step']"/>
    </xsl:for-each>
  </xsl:copy>
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
