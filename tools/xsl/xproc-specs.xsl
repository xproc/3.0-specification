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

<xsl:param name="spec" select="'???'"/>

<xsl:key name="errcode" match="db:error" use="@code"/>

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
