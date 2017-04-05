<p:pipeline xmlns:p="http://www.w3.org/ns/xproc">
<p:sink/>

<p:identity name="readcsv">
  <p:input port="source">
    <p:data href="stateabbr.csv"/>
  </p:input>
</p:identity>

</p:pipeline>
