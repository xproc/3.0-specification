<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:idml2xml="http://transpect.io/idml2xml" 
  xmlns:tr="http://transpect.io" 
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:css="http://www.w3.org/1996/css"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs idml2xml tr css math css"
  version="3.0">
  
  <xsl:variable name="idml2xml:rad2deg" as="xs:double" select="180 div math:pi()"/>
  
  <xsl:function name="idml2xml:ItemTransform2css" as="element(css:transform)">
    <xsl:param name="it" as="attribute(ItemTransform)"/>
    <xsl:param name="ppt" as="element(PathPointType)"/><!-- 1st in PathPointArray, that is, top left -->
    <xsl:variable name="it-tokens" as="xs:double+" select="tokenize($it) ! number(.)"/>
    <xsl:variable name="acos" as="xs:double" select="math:acos($it-tokens[1])"/>
    <xsl:variable name="beyond-180" as="xs:boolean" select="$it-tokens[2] gt 0"/>
    <xsl:variable name="angle-deg" as="xs:double" select="if ($beyond-180) 
                                                          then 360 - $acos *$idml2xml:rad2deg 
                                                          else $acos * $idml2xml:rad2deg"/>
    <xsl:variable name="ppt-tokens" as="xs:double+" select="tokenize($ppt/@Anchor) ! number(.)"/>
    <xsl:variable name="xoffset" as="xs:double" select="$ppt-tokens[1]"/>
    <xsl:variable name="yoffset" as="xs:double" select="- $ppt-tokens[2]"/>
    <css:transform>
      <xsl:attribute name="rotate" select="$angle-deg || 'deg'"/>
      <xsl:attribute name="top" select="$it-tokens[6] - $yoffset"/>
      <xsl:attribute name="left" select="$it-tokens[5] - $xoffset"/>
      <xsl:attribute name="translateX" select="$it-tokens[5]"/>
      <xsl:attribute name="translateY" select="- $it-tokens[6]"/>
    </css:transform>
  </xsl:function>
  
  <xsl:variable name="rotation-input" as="element(input)">
    <input ItemTransform="{math:sqrt(2) div 2} .1 0 1 4 5">
      <PathPointType Anchor="-158.7401574802557 -235.2755905510906"
        LeftDirection="-158.7401574802557 -235.2755905510906" RightDirection="-158.7401574802557 -235.2755905510906"/>
    </input>
  </xsl:variable>
  
  <xsl:template name="rotation-test">
    <xsl:message select="idml2xml:ItemTransform2css($rotation-input/@ItemTransform, $rotation-input/PathPointType)"/>
  </xsl:template>
</xsl:stylesheet>