<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:exf="http://exproc.org/standard/functions"
                xmlns:h="http://www.w3.org/1999/xhtml"
                exclude-inline-prefixes="c cx exf"
                name="main">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>
<p:output port="result"/>
<p:serialization port="result" indent="false"/>

<p:add-attribute match="h:pre"
                 attribute-name="xml:space"
                 attribute-value="preserve">
</p:add-attribute>

<p:xslt>
  <p:input port="stylesheet">
    <p:inline><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="xs h"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:h="http://www.w3.org/1999/xhtml"
                version="2.0">

<xsl:template match="element()">
  <xsl:copy>
    <xsl:apply-templates select="@*,node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="attribute()|text()|comment()|processing-instruction()">
  <xsl:copy/>
</xsl:template>

<xsl:template match="h:p[contains(@class, 'element-syntax')]">
  <div class="{@class}">
    <xsl:call-template name="breakup">
      <xsl:with-param name="nodes" select="h:code/node()"/>
    </xsl:call-template>
  </div>
</xsl:template>

<xsl:template name="breakup">
  <xsl:param name="nodes" as="node()*"/>
  <xsl:param name="acc" as="node()*"/>

  <xsl:choose>
    <xsl:when test="empty($nodes)">
      <xsl:if test="not(empty($acc))">
        <div class="line"><code><xsl:sequence select="$acc"/></code></div>
      </xsl:if>
    </xsl:when>
    <xsl:when test="$nodes[1]/self::h:br">
      <div class="line"><code><xsl:sequence select="$acc"/></code></div>
      <xsl:call-template name="breakup">
        <xsl:with-param name="nodes" select="subsequence($nodes,2)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="breakup">
        <xsl:with-param name="nodes" select="subsequence($nodes,2)"/>
        <xsl:with-param name="acc" select="($acc,$nodes[1])"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet></p:inline>
  </p:input>
</p:xslt>

</p:declare-step>
