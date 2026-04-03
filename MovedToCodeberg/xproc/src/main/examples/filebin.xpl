<p:pipeline xmlns:p="http://www.w3.org/ns/xproc">
<p:sink/>

<p:identity name="readpng">
  <p:input port="source">
    <p:data href="icon.png" content-type="image/png"/>
  </p:input>
</p:identity>

<p:add-attribute name="makeimg" match="img" attribute-name="src">
  <p:input port="source"><p:inline><img/></p:inline></p:input>
  <p:with-option name="attribute-value"
		 select="concat('data:image/png;base64,',/*/node())">
    <p:pipe step="readpng" port="result"/>
  </p:with-option>
</p:add-attribute>

</p:pipeline>
