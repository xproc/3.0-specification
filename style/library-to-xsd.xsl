<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:p="http://www.w3.org/ns/xproc" xmlns:e="http://www.w3.org/1999/XSL/Spec/ElementSyntax" xmlns="http://www.w3.org/2001/XMLSchema" version="2.0">
 
 <!-- Based on library-to-dtd.xsl, r1.1 -->
 <!-- Content of root to be used, a series of elt decls -->
 
 <xsl:output indent="yes"/>

<xsl:template match="/">
 <wrapper>
  <xsl:apply-templates select="/p:library/p:declare-step"/>
 </wrapper>  
</xsl:template>

<xsl:template match="p:declare-step[p:option]">
 <xsl:variable name="name" select="substring-after(@type, 'p:')"/>
 <element name="{$name}" substitutionGroup="p:atomicStep">
  <complexType>
   <complexContent>
    <restriction base="p:atomicStepType">
     <group ref="p:atomicStepModel"/>
     <xsl:apply-templates select="p:option"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>
</xsl:template>
 
 <xsl:template match="p:declare-step">
  <xsl:variable name="name" select="substring-after(@type, 'p:')"/>
  <element name="{$name}" substitutionGroup="p:vanillaStep"/>
 </xsl:template>

<xsl:template match="p:option">
 <xsl:variable name="stepType" select="parent::*/@type"/>
 <xsl:variable name="name" select="@name"/>
 <xsl:variable name="etype" select="replace((@e:type,@as)[1],'xs:','xsd:')"/>
 <attribute name="{$name}">
  <xsl:choose>
   <xsl:when test="not($etype)">
    <xsl:message>Warning: no @type for
<xsl:value-of select="$stepType"/>:<xsl:value-of select="$name"/>!!!</xsl:message>
    <xsl:attribute name="type">string</xsl:attribute>
   </xsl:when>
   <xsl:when test="contains($etype,'xsd:')">
    <xsl:attribute name="type">
     <xsl:value-of select="substring-after($etype,'xsd:')"/>
    </xsl:attribute>
   </xsl:when>
   <xsl:when test="$etype='ListOfQNames'">
    <simpleType>
     <list itemType="QName"/>
    </simpleType>
   </xsl:when>
   <xsl:when test="$etype='XSLTMatchPattern'">
    <xsl:attribute name="type">p:XSLTMatchPattern</xsl:attribute>
   </xsl:when>
   <xsl:when test="$etype='XPathExpression'">
    <xsl:attribute name="type">p:XPathExpression</xsl:attribute>
   </xsl:when>
   <xsl:when test="$etype='XPathSequenceType'">
    <xsl:attribute name="type">p:XPathSequenceType</xsl:attribute>
   </xsl:when>
   <xsl:when test="$etype='NormalizationForm'">
    <xsl:attribute name="type">p:normFormType</xsl:attribute>
   </xsl:when>
   <xsl:when test="$etype='RegularExpression'">
    <xsl:attribute name="type">p:regExp</xsl:attribute>
   </xsl:when>
   <xsl:when test="contains($etype,'|')">
    <simpleType>
     <restriction base="NMTOKEN">
      <xsl:for-each select="tokenize($etype,'\|')">
       <enumeration value="{.}"/>
      </xsl:for-each>
     </restriction>
    </simpleType>
   </xsl:when>
   <xsl:otherwise>
    <xsl:message>Unrecognised option type
<xsl:value-of select="@e:type"/></xsl:message>
      
   </xsl:otherwise>
  </xsl:choose>
 </attribute>
</xsl:template>

</xsl:stylesheet>
