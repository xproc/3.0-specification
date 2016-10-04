<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns="http://docbook.org/ns/docbook"
		exclude-result-prefixes="xs db rng"
                version="2.0">

<xsl:param name="prefix" select="'p:'"/>

<xsl:output method="xml" indent="yes"/>

<xsl:template match="/">
  <xsl:choose>
    <xsl:when test="$prefix = 'c:'">
      <xsl:call-template name="extract-steps"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="extract-elements"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="extract-elements">
  <xsl:variable name="tags" select="//db:section/db:title[starts-with(., $prefix)]
                                    |//db:section/db:info/db:title[starts-with(., $prefix)]
                                    |//db:methodname[starts-with(., $prefix)]"/>
  <xsl:variable name="names" select="distinct-values($tags)"/>

  <itemizedlist spacing="compact">
    <xsl:for-each select="$names">
      <xsl:sort select="."/>

      <xsl:variable name="name" select="."/>
      <xsl:variable name="id" select="$tags[.=$name]/ancestor::db:section[1]/@xml:id"/>

      <listitem>
        <simpara>
          <xsl:choose>
            <xsl:when test="$id != ''">
              <link xlink:href="http://www.w3.org/TR/2010/REC-xproc-20100511/#{$id}">
                <xsl:value-of select="."/>
              </link>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="."/>
            </xsl:otherwise>
          </xsl:choose>
        </simpara>
      </listitem>
    </xsl:for-each>

  </itemizedlist>
</xsl:template>

<xsl:template name="extract-steps">
  <xsl:variable name="tags" select="//db:tag[starts-with(., $prefix)]"/>
  <xsl:variable name="names" select="distinct-values($tags)"/>

  <itemizedlist spacing="compact">
    <xsl:for-each select="$names">
      <xsl:sort select="."/>

      <xsl:variable name="name" select="."/>
      <xsl:variable name="id" select="$tags[.=$name][1]/ancestor::db:section[1]/@xml:id"/>

      <listitem>
        <simpara>
          <xsl:choose>
            <xsl:when test="$id != ''">
              <link xlink:href="http://www.w3.org/TR/2010/REC-xproc-20100511/#{$id}">
                <xsl:value-of select="."/>
              </link>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="."/>
            </xsl:otherwise>
          </xsl:choose>
        </simpara>
      </listitem>
    </xsl:for-each>

  </itemizedlist>
</xsl:template>

</xsl:stylesheet>
