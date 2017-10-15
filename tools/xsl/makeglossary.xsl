<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:db="http://docbook.org/ns/docbook"
		xmlns="http://docbook.org/ns/docbook"
		exclude-result-prefixes="xs"
                version="2.0">

<xsl:key name="glossterm" match="db:glossterm"
	 use="if (@baseform) then @baseform else normalize-space(.)"/>

<xsl:template match="/">
  <appendix xml:id='glossary'>
    <title>Glossary</title>
    <glosslist>
      <xsl:apply-templates select="//db:termdef">
	<xsl:sort select="(db:firstterm[1]/@baseform,db:firstterm[1])[1]"/>
      </xsl:apply-templates>
    </glosslist>
  </appendix>
</xsl:template>

<xsl:template match="db:termdef">
  <xsl:variable name="defs" select="db:glossterm"/>
  <xsl:variable name="uses" select="key('glossterm',
                                    normalize-space((db:firstterm[1]/@baseform,db:firstterm[1])[1]))"/>
  <xsl:variable name="refs" select="$uses except $defs"/>

  <glossentry>
    <glossterm>
      <xsl:value-of select="(db:firstterm[1]/@baseform,db:firstterm[1])[1]"/>
    </glossterm>
    <glossdef>
      <para>
	<xsl:apply-templates/>
      </para>

      <xsl:if test="count($refs) = 0">
	<xsl:message>
	  <xsl:text>Note: glossterm "</xsl:text>
	  <xsl:value-of select="normalize-space((db:firstterm[1]/@baseform,db:firstterm[1])[1])"/>
	  <xsl:text>" defined but never referenced</xsl:text>
	</xsl:message>
      </xsl:if>
    </glossdef>
  </glossentry>
</xsl:template>

<xsl:template match="db:*">
  <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
    <xsl:copy-of select="@* except @xml:id"/>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

</xsl:stylesheet>
