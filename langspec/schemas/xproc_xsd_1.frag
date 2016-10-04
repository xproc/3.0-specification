<?xml version='1.0'?>
<schema xmlns="http://www.w3.org/2001/XMLSchema"
        targetNamespace="http://www.w3.org/ns/xproc"
        elementFormDefault="qualified"
        xmlns:p="http://www.w3.org/ns/xproc">

  <!-- This is schema version $Id: xproc_xsd_1.frag,v 1.15 2013-03-20 15:58:20 ht Exp $ -->
 
 <import namespace="http://www.w3.org/XML/1998/namespace"/>
 
 <element name="annotation" abstract="true" type="p:anyProc"/>

 <complexType name="anyProc">
  <sequence>
   <any namespace="##any" processContents="lax" minOccurs="0" maxOccurs="unbounded"/>
  </sequence>
  <attribute ref="xml:id"/>
  <attribute ref="xml:base"/>
  <attribute name="use-when" type="p:XPathExpression"/>
  <anyAttribute processContents="lax"/>
 </complexType>

 <element name="component" type="p:componentType" abstract="true"/>

 <complexType name="componentType">
  <complexContent>
   <extension base="p:anyProc">
    <attribute name="name" type="NCName"/>     
   </extension>
  </complexContent>
 </complexType>

 <group name="subPipe">
  <sequence>
   <sequence minOccurs="0" maxOccurs="unbounded">
    <element ref="p:variable"/>
    <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
   </sequence>
   <sequence maxOccurs="unbounded">
    <element ref="p:component"/>
    <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
   </sequence>
  </sequence>
 </group>

 <group name="seqConnection">
  <sequence>
   <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
   <choice>
    <sequence>
     <element ref="p:empty"/>
     <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
    </sequence>
    <sequence minOccurs="0" maxOccurs="unbounded">
     <element ref="p:oneConnection"/>
     <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
    </sequence>
   </choice>
  </sequence>
 </group>

 <element name="connection" abstract="true"/> 
 <element name="oneConnection" abstract="true" substitutionGroup="p:connection"/>

 <group name="optConnection">
  <sequence>
   <choice minOccurs="0" maxOccurs="unbounded">
    <element ref="p:namespaces"/>
    <element ref="p:annotation"/>
   </choice>
   <sequence minOccurs="0">
     <element ref="p:connection"/>
     <choice minOccurs="0" maxOccurs="unbounded">
      <element ref="p:namespaces"/>
      <element ref="p:annotation"/>
     </choice>
    </sequence>
  </sequence>
 </group>

 <element name="step" type="p:stepType" abstract="true" substitutionGroup="p:component"/>

 <complexType name="stepType">
  <complexContent>
   <restriction base="p:componentType">
    <sequence>      
      <choice minOccurs="0" maxOccurs="unbounded">        
       <element ref="p:input"/>
       <element ref="p:output"/>
       <element ref="p:log"/>
       <element ref="p:with-option"/>
       <element ref="p:with-param"/>
       <element ref="p:annotation"/>
      </choice>     
     <group ref="p:subPipe" minOccurs="0"/>
    </sequence>
    <anyAttribute processContents="lax"/>
   </restriction>
  </complexContent>
 </complexType>

 <complexType name="atomicStepType">
  <complexContent>
   <restriction base="p:stepType">
    <group ref="p:atomicStepModel"/>
    <anyAttribute processContents="lax"/>
   </restriction>
  </complexContent>
 </complexType>
 
 <group name="atomicStepModel">  
  <sequence>
   <annotation>
    <documentation>
     Include an empty sequence (&lt;sequence/>)
     at the end of _this_ sequence if you need to
     work around a problem Xerces has with this
     (reported as a restriction failure wrt atomicStepType)
     if you turn on strict schema checking
    </documentation>
   </annotation>
   <choice minOccurs="0" maxOccurs="unbounded">
    <element ref="p:input"/>
    <element ref="p:log"/>
    <element ref="p:with-option"/>
    <element ref="p:with-param"/>
    <element ref="p:annotation"/>
   </choice>
  </sequence>
 </group>

 <element name="atomicStep" abstract="true" substitutionGroup="p:step" type="p:atomicStepType"/>
 
  <element name="compoundStep" abstract="true" substitutionGroup="p:step">
   <complexType>
    <complexContent>
     <restriction base="p:stepType">
      <sequence>
       <choice minOccurs="0" maxOccurs="unbounded">        
        <element ref="p:input"/>
        <element ref="p:output"/>
        <element ref="p:log"/>
        <element ref="p:annotation"/>
       </choice>     
       <group ref="p:subPipe" minOccurs="0"/>
      </sequence>
      <anyAttribute namespace="##other" processContents="lax"/>
     </restriction>
    </complexContent>
   </complexType>
  </element>

 <simpleType name="ipType">
  <union>
   <simpleType>
    <restriction base="token">
     <enumeration value="#all"/>
    </restriction>
   </simpleType>
   <simpleType>
    <list itemType="p:ipItem"/>
   </simpleType>
  </union>
 </simpleType>
 
 <simpleType name="ipItem">
  <union memberTypes="NCName">
   <simpleType>
    <restriction base="token">
     <enumeration value="#default"/>
    </restriction>
   </simpleType>
  </union>
 </simpleType>

 <attributeGroup name="pipeTopAttrs">
  <attribute name="exclude-inline-prefixes" type="p:ipType"/>
  <attribute name="version" type="token"/>
  <attribute name="xpath-version" type="token"/>
  <attribute name="psvi-required" type="boolean"/>
 </attributeGroup>

 <group name="declProlog">
  <sequence>
   <choice minOccurs="0" maxOccurs="unbounded">        
    <element ref="p:input"/>
    <element ref="p:output"/>
    <element ref="p:option"/>
    <element ref="p:log"/>
    <element ref="p:serialization"/>
    <element ref="p:annotation"/>
   </choice>
   <sequence minOccurs="0" maxOccurs="unbounded">
    <choice>
     <element ref="p:import"/>
     <element ref="p:declare-step"/>
     <element ref="p:pipeline"/>
    </choice>
    <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
   </sequence>
  </sequence>
 </group>

 <element name="pipeline">
  <complexType>
   <complexContent>
    <restriction base="p:componentType">
     <sequence>
      <group ref="p:declProlog"/>
      <group ref="p:subPipe"/>
     </sequence>
     <attribute name="name" type="NCName"/>
     <attribute name="type" type="QName"/>
     <attributeGroup ref="p:pipeTopAttrs"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <element name="for-each" substitutionGroup="p:component">
  <complexType>
   <complexContent>
    <restriction base="p:componentType">
     <sequence>
      <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      <sequence minOccurs="0">
       <element ref="p:iteration-source"/>
       <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      </sequence>
      <sequence minOccurs="0" maxOccurs="unbounded">
       <choice>
	<element ref="p:output"/>
	<element ref="p:log"/>
       </choice>
       <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      </sequence>
      <group ref="p:subPipe"/>
     </sequence>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <element name="viewport" substitutionGroup="p:component">
  <complexType>
   <complexContent>
    <restriction base="p:componentType">
     <sequence>
      <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      <sequence minOccurs="0">       
       <element ref="p:viewport-source"/>
       <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      </sequence>
      <sequence minOccurs="0">       
       <element ref="p:output"/>
       <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      </sequence>
      <sequence minOccurs="0">       
       <element ref="p:log"/>
       <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      </sequence>
      <group ref="p:subPipe"/>
     </sequence>
     <attribute name="match" type="p:XSLTMatchPattern" use="required"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <element name="choose" substitutionGroup="p:component">
  <complexType>
   <complexContent>
    <restriction base="p:componentType">
     <sequence>
      <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      <sequence minOccurs="0">
       <element ref="p:xpath-context"/>
       <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      </sequence>
      <sequence minOccurs="0" maxOccurs="unbounded">
       <element ref="p:variable"/>
       <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      </sequence>
      <sequence minOccurs="0" maxOccurs="unbounded">
       <element ref="p:when"/>
       <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      </sequence>
      <sequence minOccurs="0">
       <element ref="p:otherwise"/>
       <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      </sequence>
     </sequence>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <element name="xpath-context">
  <complexType>
   <complexContent>
    <restriction base="p:anyProc">
     <sequence>
      <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      <element ref="p:connection"/>
      <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
     </sequence>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>   
  </complexType>
 </element>

 <element name="when">
  <complexType>
   <complexContent>
    <restriction base="p:componentType">
     <sequence>
      <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      <sequence minOccurs="0">
       <element ref="p:xpath-context"/>
       <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      </sequence>
      <sequence minOccurs="0" maxOccurs="unbounded">
       <choice>
        <element ref="p:output"/>
        <element ref="p:log"/>
       </choice>
       <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      </sequence>
      <group ref="p:subPipe"/>
     </sequence>
     <attribute name="name" use="prohibited"/>
     <attribute name="test" type="p:XPathExpression" use="required"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <group name="groupModel">
  <sequence>
   <choice minOccurs="0" maxOccurs="unbounded">
    <element ref="p:output"/>
    <element ref="p:log"/>
    <element ref="p:annotation"/>
   </choice>
   <group ref="p:subPipe"/>
  </sequence>
 </group>

 <element name="otherwise">
  <complexType>
   <complexContent>
    <restriction base="p:componentType">
     <group ref="p:groupModel"/>
     <attribute name="name" use="prohibited"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>
 
 <element name="group" substitutionGroup="p:component">
  <complexType>
   <complexContent>
    <restriction base="p:componentType">
     <group ref="p:groupModel"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <element name="try" substitutionGroup="p:component">
  <complexType>
   <complexContent>
    <restriction base="p:componentType">
     <sequence>
      <choice minOccurs="0" maxOccurs="unbounded">
       <element ref="p:annotation"/>
       <element ref="p:variable"/>
      </choice>
      <element ref="p:group"/>
      <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      <element ref="p:catch"/>
      <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
     </sequence>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <element name="catch">
  <complexType>
   <complexContent>
    <restriction base="p:componentType">
     <group ref="p:groupModel"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>
 
 <element name="input">
  <complexType>
   <complexContent>
    <restriction base="p:anyProc">
     <group ref="p:seqConnection"/>
     <attribute name="port" type="NCName" use="required"/>
     <attribute name="sequence" type="boolean"/>
     <attribute name="primary" type="boolean"/>
     <attribute name="kind">
      <simpleType>
       <restriction base="NMTOKEN">
        <enumeration value="document"/>
        <enumeration value="parameter"/>
       </restriction>
      </simpleType>
     </attribute>
     <attribute name="select" type="p:XPathExpression"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <element name="iteration-source">
  <complexType>
   <complexContent>
    <restriction base="p:anyProc">
     <group ref="p:seqConnection"/>
     <attribute name="select" type="p:XPathExpression"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <element name="viewport-source">
  <complexType>
   <complexContent>
    <restriction base="p:anyProc">
     <sequence>
      <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      <sequence minOccurs="0">
       <element ref="p:oneConnection"/>
       <element ref="p:annotation" minOccurs="0" maxOccurs="unbounded"/>
      </sequence>
     </sequence>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <element name="output">
  <complexType>
   <complexContent>
    <restriction base="p:anyProc">
     <group ref="p:seqConnection"/>
     <attribute name="port" type="NCName" use="required"/>
     <attribute name="sequence" type="boolean"/>
     <attribute name="primary" type="boolean"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element> 

 <element name="log">
  <complexType>
   <complexContent>
    <restriction base="p:anyProc">
     <sequence>
      <element ref="p:annotation" minOccurs="0"/>
     </sequence>
     <attribute name="port" type="NCName" use="required"/>
     <attribute name="href" type="anyURI"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>
 
<attributeGroup name="coreSerializationAttrs">
  <attribute name="cdata-section-elements" type="NMTOKENS"/>
  <attribute name="doctype-public" type="string"/>
  <attribute name="doctype-system" type="anyURI"/>
  <attribute name="encoding" type="NMTOKEN"/>
  <attribute name="escape-uri-attributes" type="boolean"/>
  <attribute name="include-content-type" type="boolean"/>
  <attribute name="indent" type="boolean"/>
  <attribute name="media-type" type="token"/>
  <attribute name="method" type="QName"/>
  <attribute name="normalization-form" type="p:normFormType"/>
  <attribute name="omit-xml-declaration" type="boolean"/>
  <attribute name="standalone">
   <simpleType>
    <restriction base="NMTOKEN">
     <enumeration value="true"/>
     <enumeration value="false"/>
     <enumeration value="omit"/>
    </restriction>
   </simpleType>
  </attribute>
  <attribute name="undeclare-prefixes" type="boolean"/>
  <attribute name="version" type="token"/>
</attributeGroup>

 <attributeGroup name="serializationAttrs">
  <attributeGroup ref="p:coreSerializationAttrs"/>
  <attribute name="byte-order-mark" type="boolean"/>
 </attributeGroup>
 
 <element name="serialization">
  <complexType>
   <complexContent>
    <restriction base="p:anyProc">
     <sequence>
      <element ref="p:annotation" minOccurs="0"/>
     </sequence>
     <attributeGroup ref="p:serializationAttrs"/>
     <attribute name="port" type="NCName" use="required"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <complexType name="poType">
  <complexContent>
   <restriction base="p:anyProc">
    <group ref="p:optConnection"/>
    <attribute name="name" type="QName" use="required"/>
    <attribute name="required" type="boolean"/>
    <attribute name="select" type="p:XPathExpression"/>
    <anyAttribute namespace="##other" processContents="lax"/>
   </restriction>
  </complexContent>
  </complexType>

 <complexType name="bindingType">
  <complexContent>
   <restriction base="p:poType">
    <group ref="p:optConnection"/>
    <attribute name="required" use="prohibited"/>
    <attribute name="select" type="p:XPathExpression" use="required"/>
    <anyAttribute namespace="##other" processContents="lax"/>
   </restriction>
  </complexContent>
 </complexType>
 
 <element name="variable" type="p:bindingType"/>

 <element name="option">
  <complexType>
   <complexContent>
    <restriction base="p:poType">
     <sequence>
      <annotation>
       <documentation>
       Include an empty sequence (&lt;sequence/>)
       at the end of _this_ sequence if you need to
       work around a problem Xerces has with this
       (reported as a restriction failure wrt atomicStepType)
       if you turn on strict schema checking
       </documentation>
      </annotation> 
      <element ref="p:annotation" minOccurs="0"/>
     </sequence>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>
 
 <element name="with-option" type="p:bindingType"/>
 <element name="with-param">
  <complexType>
   <complexContent>
    <extension base="p:bindingType">
     <attribute name="port" type="NCName"/>
    </extension>
   </complexContent>
  </complexType>
 </element>

 <element name="namespaces">
  <complexType>
   <complexContent>
    <restriction base="p:anyProc">
     <sequence>
      <element ref="p:annotation" minOccurs="0"/>
     </sequence>
     <attribute name="binding" type="QName"/>
     <attribute name="element" type="p:XPathExpression"/>
     <attribute name="except-prefixes" type="NMTOKENS"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <element name="declare-step">
  <complexType>
   <complexContent>
    <restriction base="p:anyProc">
     <sequence>
      <group ref="p:declProlog"/>
      <group ref="p:subPipe" minOccurs="0"/>
     </sequence>
     <attribute name="name" type="NCName"/>
     <attribute name="type" type="QName"/>
     <attributeGroup ref="p:pipeTopAttrs"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <element name="library">
  <complexType>
   <complexContent>
    <restriction base="p:anyProc">
     <sequence>
      <choice minOccurs="0" maxOccurs="unbounded">        
       <element ref="p:import"/>
       <element ref="p:declare-step"/>
       <element ref="p:pipeline"/>
       <element ref="p:annotation"/>
      </choice>
     </sequence>
     <attributeGroup ref="p:pipeTopAttrs"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <element name="import">
  <complexType>
   <sequence>
    <element ref="p:annotation" minOccurs="0"/>
   </sequence>
   <attribute name="href" type="anyURI" use="required"/>
  </complexType>
 </element>

 <element name="pipe" substitutionGroup="p:oneConnection">
  <complexType>
   <complexContent>
    <restriction base="p:anyProc">
     <sequence>
      <element ref="p:annotation" minOccurs="0"/>
     </sequence>
     <attribute name="step" type="NCName" use="required"/>
     <attribute name="port" type="NCName" use="required"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <element name="document" substitutionGroup="p:oneConnection">
  <complexType>
   <complexContent>
    <restriction base="p:anyProc">
     <sequence>
      <element ref="p:annotation" minOccurs="0"/>
     </sequence>
     <attribute name="href" type="anyURI" use="required"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <element name="data" substitutionGroup="p:oneConnection">
  <complexType>
   <complexContent>
    <restriction base="p:anyProc">
     <sequence>
      <element ref="p:annotation" minOccurs="0"/>
     </sequence>
     <attribute name="href" type="anyURI" use="required"/>
     <attribute name="wrapper" type="QName"/>
     <attribute name="content-type" type="token"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>
 
 <element name="empty" substitutionGroup="p:connection">
  <complexType>
   <complexContent>
    <restriction base="p:anyProc">
     <sequence>
      <element ref="p:annotation" minOccurs="0"/>
     </sequence>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <element name="inline" substitutionGroup="p:oneConnection">
  <complexType>
   <complexContent>
    <restriction base="p:anyProc">
     <sequence>
      <any namespace="##any" processContents="lax"/>
     </sequence>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>

 <element name="documentation" substitutionGroup="p:annotation"/>

 <element name="pipeinfo" substitutionGroup="p:annotation"/>

 <element name="vanillaStep" abstract="true" substitutionGroup="p:atomicStep">
  <complexType>
   <complexContent>
    <restriction base="p:atomicStepType">
     <group ref="p:atomicStepModel"/>
     <anyAttribute namespace="##other" processContents="lax"/>
    </restriction>
   </complexContent>
  </complexType>
 </element>
 
