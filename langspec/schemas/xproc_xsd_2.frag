         xmlns="http://www.w3.org/2001/XMLSchema">
   <element name="add-attribute" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="match" type="p:XSLTMatchPattern"/>
               <attribute name="attribute-name" type="QName"/>
               <attribute name="attribute-prefix" type="NCName"/>
               <attribute name="attribute-namespace" type="anyURI"/>
               <attribute name="attribute-value" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="add-xml-base" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="all" type="boolean"/>
               <attribute name="relative" type="boolean"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="cast-content-type" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="content-type" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="compare" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="fail-if-not-equal" type="boolean"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="count" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="limit" type="integer"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="delete" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="match" type="p:XSLTMatchPattern"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="directory-list" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="path" type="anyURI"/>
               <attribute name="include-filter" type="p:regExp"/>
               <attribute name="exclude-filter" type="p:regExp"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="error" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="code" type="QName"/>
               <attribute name="code-prefix" type="NCName"/>
               <attribute name="code-namespace" type="anyURI"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="escape-markup" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="cdata-section-elements">
                  <simpleType>
                     <list itemType="QName"/>
                  </simpleType>
               </attribute>
               <attribute name="doctype-public" type="string"/>
               <attribute name="doctype-system" type="anyURI"/>
               <attribute name="escape-uri-attributes" type="boolean"/>
               <attribute name="include-content-type" type="boolean"/>
               <attribute name="indent" type="boolean"/>
               <attribute name="media-type" type="string"/>
               <attribute name="method" type="QName"/>
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
               <attribute name="version" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="filter" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="select" type="p:XPathExpression"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="http-request" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="byte-order-mark" type="boolean"/>
               <attribute name="cdata-section-elements">
                  <simpleType>
                     <list itemType="QName"/>
                  </simpleType>
               </attribute>
               <attribute name="doctype-public" type="string"/>
               <attribute name="doctype-system" type="anyURI"/>
               <attribute name="encoding" type="string"/>
               <attribute name="escape-uri-attributes" type="boolean"/>
               <attribute name="include-content-type" type="boolean"/>
               <attribute name="indent" type="boolean"/>
               <attribute name="media-type" type="string"/>
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
               <attribute name="version" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="identity" substitutionGroup="p:vanillaStep"/>
   <element name="insert" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="match" type="p:XSLTMatchPattern"/>
               <attribute name="position">
                  <simpleType>
                     <restriction base="NMTOKEN">
                        <enumeration value="first-child"/>
                        <enumeration value="last-child"/>
                        <enumeration value="before"/>
                        <enumeration value="after"/>
                     </restriction>
                  </simpleType>
               </attribute>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="label-elements" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="attribute" type="QName"/>
               <attribute name="attribute-prefix" type="NCName"/>
               <attribute name="attribute-namespace" type="anyURI"/>
               <attribute name="label" type="p:XPathExpression"/>
               <attribute name="match" type="p:XSLTMatchPattern"/>
               <attribute name="replace" type="boolean"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="load" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="href" type="anyURI"/>
               <attribute name="dtd-validate" type="boolean"/>
               <attribute name="override-content-type" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="make-absolute-uris" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="match" type="p:XSLTMatchPattern"/>
               <attribute name="base-uri" type="anyURI"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="namespace-rename" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="from" type="anyURI"/>
               <attribute name="to" type="anyURI"/>
               <attribute name="apply-to">
                  <simpleType>
                     <restriction base="NMTOKEN">
                        <enumeration value="all"/>
                        <enumeration value="elements"/>
                        <enumeration value="attributes"/>
                     </restriction>
                  </simpleType>
               </attribute>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="pack" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="wrapper" type="QName"/>
               <attribute name="wrapper-prefix" type="NCName"/>
               <attribute name="wrapper-namespace" type="anyURI"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="parameters" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="parameters" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="rename" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="match" type="p:XSLTMatchPattern"/>
               <attribute name="new-name" type="QName"/>
               <attribute name="new-prefix" type="NCName"/>
               <attribute name="new-namespace" type="anyURI"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="replace" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="match" type="p:XSLTMatchPattern"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="set-attributes" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="match" type="p:XSLTMatchPattern"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="set-properties" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="properties" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="sink" substitutionGroup="p:vanillaStep"/>
   <element name="split-sequence" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="initial-only" type="boolean"/>
               <attribute name="test" type="p:XPathExpression"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="store" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="href" type="anyURI"/>
               <attribute name="byte-order-mark" type="boolean"/>
               <attribute name="cdata-section-elements">
                  <simpleType>
                     <list itemType="QName"/>
                  </simpleType>
               </attribute>
               <attribute name="doctype-public" type="string"/>
               <attribute name="doctype-system" type="anyURI"/>
               <attribute name="encoding" type="string"/>
               <attribute name="escape-uri-attributes" type="boolean"/>
               <attribute name="include-content-type" type="boolean"/>
               <attribute name="indent" type="boolean"/>
               <attribute name="media-type" type="string"/>
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
               <attribute name="version" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="string-replace" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="match" type="p:XSLTMatchPattern"/>
               <attribute name="replace" type="p:XPathExpression"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="unescape-markup" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="namespace" type="anyURI"/>
               <attribute name="content-type" type="string"/>
               <attribute name="encoding" type="string"/>
               <attribute name="charset" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="unwrap" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="match" type="p:XSLTMatchPattern"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="wrap" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="wrapper" type="QName"/>
               <attribute name="wrapper-prefix" type="NCName"/>
               <attribute name="wrapper-namespace" type="anyURI"/>
               <attribute name="match" type="p:XSLTMatchPattern"/>
               <attribute name="group-adjacent" type="p:XPathExpression"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="wrap-sequence" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="wrapper" type="QName"/>
               <attribute name="wrapper-prefix" type="NCName"/>
               <attribute name="wrapper-namespace" type="anyURI"/>
               <attribute name="group-adjacent" type="p:XPathExpression"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="xinclude" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="fixup-xml-base" type="boolean"/>
               <attribute name="fixup-xml-lang" type="boolean"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="xslt" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="parameters" type="string"/>
               <attribute name="initial-mode" type="QName"/>
               <attribute name="template-name" type="QName"/>
               <attribute name="output-base-uri" type="anyURI"/>
               <attribute name="version" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="exec" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="command" type="string"/>
               <attribute name="args" type="string"/>
               <attribute name="cwd" type="string"/>
               <attribute name="source-is-xml" type="boolean"/>
               <attribute name="result-is-xml" type="boolean"/>
               <attribute name="wrap-result-lines" type="boolean"/>
               <attribute name="errors-is-xml" type="boolean"/>
               <attribute name="wrap-error-lines" type="boolean"/>
               <attribute name="path-separator" type="string"/>
               <attribute name="failure-threshold" type="integer"/>
               <attribute name="arg-separator" type="string"/>
               <attribute name="byte-order-mark" type="boolean"/>
               <attribute name="cdata-section-elements">
                  <simpleType>
                     <list itemType="QName"/>
                  </simpleType>
               </attribute>
               <attribute name="doctype-public" type="string"/>
               <attribute name="doctype-system" type="anyURI"/>
               <attribute name="encoding" type="string"/>
               <attribute name="escape-uri-attributes" type="boolean"/>
               <attribute name="include-content-type" type="boolean"/>
               <attribute name="indent" type="boolean"/>
               <attribute name="media-type" type="string"/>
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
               <attribute name="version" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="hash" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="parameters" type="string"/>
               <attribute name="value" type="string"/>
               <attribute name="algorithm" type="QName"/>
               <attribute name="match" type="p:XSLTMatchPattern"/>
               <attribute name="version" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="in-scope-names" substitutionGroup="p:vanillaStep"/>
   <element name="template" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="parameters" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="uuid" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="match" type="p:XSLTMatchPattern"/>
               <attribute name="version" type="integer"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="validate-with-relax-ng" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="dtd-attribute-values" type="boolean"/>
               <attribute name="dtd-id-idref-warnings" type="boolean"/>
               <attribute name="assert-valid" type="boolean"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="validate-with-schematron" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="parameters" type="string"/>
               <attribute name="phase" type="string"/>
               <attribute name="assert-valid" type="boolean"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="validate-with-xml-schema" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="use-location-hints" type="boolean"/>
               <attribute name="try-namespaces" type="boolean"/>
               <attribute name="assert-valid" type="boolean"/>
               <attribute name="mode">
                  <simpleType>
                     <restriction base="NMTOKEN">
                        <enumeration value="strict"/>
                        <enumeration value="lax"/>
                     </restriction>
                  </simpleType>
               </attribute>
               <attribute name="version" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="www-form-urldecode" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="value" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="www-form-urlencode" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="parameters" type="string"/>
               <attribute name="match" type="p:XSLTMatchPattern"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="xquery" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="parameters" type="string"/>
               <attribute name="version" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
   <element name="xsl-formatter" substitutionGroup="p:atomicStep">
      <complexType>
         <complexContent>
            <restriction base="p:atomicStepType">
               <group ref="p:atomicStepModel"/>
               <attribute name="parameters" type="string"/>
               <attribute name="href" type="anyURI"/>
               <attribute name="content-type" type="string"/>
               <anyAttribute namespace="##other" processContents="lax"/>
            </restriction>
         </complexContent>
      </complexType>
   </element>
