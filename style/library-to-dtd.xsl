<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:p="http://www.w3.org/ns/xproc" xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
 
 <!-- Based on library-to-rnc.xsl, r1.2 -->
 <!-- Produces two fragments
      (destinations specified by step-cm and step-decls params),
      not a whole DTD -->
 
 <xsl:param name="step-cm">cm.ent</xsl:param>
 <xsl:param name="step-decls">decls.ent</xsl:param>

<xsl:template match="/">
  <xsl:result-document href="{$step-cm}" method="text">
   <xsl:for-each select="/p:library/p:declare-step">
    <xsl:variable name="name" select="substring-after(@type, 'p:')"/>
    <xsl:text>&lt;!ENTITY % </xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text> "%p;</xsl:text>    
    <xsl:value-of select="$name"/>
    <xsl:text>">&#10;</xsl:text>
  </xsl:for-each>
   <xsl:text>&#10;</xsl:text>
   <xsl:text>&lt;!ENTITY % step "(</xsl:text>
   <xsl:for-each select="/p:library/p:declare-step">
    <xsl:if test="position() &gt; 1">|</xsl:if>
    <xsl:if test="(position() mod 4)=0">
     <xsl:text>&#10;                  </xsl:text>
    </xsl:if>
    <xsl:text>%</xsl:text>
    <xsl:value-of select="substring-after(@type, 'p:')"/>
    <xsl:text>;</xsl:text>
  </xsl:for-each>
   <xsl:text> %user-steps;)">&#10;</xsl:text>
  </xsl:result-document>

  <xsl:result-document href="{$step-decls}" method="text">
   <xsl:apply-templates select="/p:library/p:declare-step"/>
  </xsl:result-document>
</xsl:template>

<xsl:template match="p:declare-step">
 <xsl:variable name="name" select="substring-after(@type, 'p:')"/>
 <xsl:text>&lt;!ELEMENT %</xsl:text>
  <xsl:value-of select="$name"/>
  <xsl:text>; %step-model;>&#10;</xsl:text>
  <xsl:text>&lt;!ATTLIST %</xsl:text>
  <xsl:value-of select="$name"/>
  <xsl:text>; %step-attrs;</xsl:text>
  <xsl:apply-templates select="p:option"/>
  <xsl:text>>&#10;</xsl:text>
</xsl:template>

<xsl:template match="p:option">
  <xsl:variable name="stepType" select="parent::*/@type"/>
  <xsl:variable name="name" select="@name"/>
 <xsl:variable name="etype" select="replace((@e:type,@as)[1],'xs:','xsd:')"/>
  <xsl:variable name="type">
    <xsl:choose>
      <xsl:when test="not($etype)">
	<xsl:message>Warning: no @type for <xsl:value-of select="$stepType"/>:<xsl:value-of select="$name"/>!!!</xsl:message>
       <xsl:text>CDATA</xsl:text>
      </xsl:when>
      <xsl:when test="contains($etype,'|')">
       <xsl:text>(</xsl:text>
	<xsl:value-of select="$etype"/>
       <xsl:text>)</xsl:text>
      </xsl:when>
     <xsl:when test="$etype='xsd:string'">
      <xsl:text>CDATA</xsl:text>
     </xsl:when>
     <xsl:when test="$etype='xsd:anyURI'">
      <xsl:text>%URIref;</xsl:text>
     </xsl:when>
      <xsl:when test="contains($etype,'xsd:')">
       <xsl:text>%</xsl:text>
       <xsl:value-of select="substring-after($etype,'xsd:')"/>
       <xsl:text>;</xsl:text>
      </xsl:when>
     <xsl:when test="$etype='ListOfQNames'">
      <xsl:text>NMTOKENS</xsl:text>
     </xsl:when>
     <xsl:when test="$etype='XSLTMatchPattern'">
      <xsl:text>%XSLT_match_pattern;</xsl:text>
     </xsl:when>
     <xsl:when test="$etype='XPathExpression'">
      <xsl:text>%XPath_expression;</xsl:text>
     </xsl:when>
     <xsl:when test="$etype='XPathSequenceType'">
      <xsl:text>%XPath_sequence_type;</xsl:text>
     </xsl:when>
     <xsl:when test="$etype='NormalizationForm'">
      <xsl:text>NMTOKEN</xsl:text>
     </xsl:when>
     <xsl:when test="$etype='RegularExpression'">
      <xsl:text>%regexp;</xsl:text>
     </xsl:when>
     <xsl:otherwise>
      <xsl:message>Unrecognised option type <xsl:value-of select="@e:type"/></xsl:message>
      
     </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:text>&#10; </xsl:text>
  <xsl:value-of select="$name"/>
  <xsl:text> </xsl:text>
  <xsl:value-of select="$type"/>
  <xsl:text> #IMPLIED</xsl:text>
</xsl:template>

</xsl:stylesheet>
