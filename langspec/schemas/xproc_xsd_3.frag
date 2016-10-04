
 <simpleType name="XPathExpression">
  <restriction base="string"/>
 </simpleType>

 <simpleType name="XSLTMatchPattern">
  <restriction base="string"/>
 </simpleType>

 <simpleType name="normFormType">
  <restriction base="NMTOKEN">
   <annotation>
    <documentation>
     NFC|NFD|NFKC|NFKD|fully-normalized|none|impl-def...
    </documentation>
   </annotation>
  </restriction>
 </simpleType>

 <simpleType name="regExp">
  <restriction base="string"/>
 </simpleType>

</schema>
