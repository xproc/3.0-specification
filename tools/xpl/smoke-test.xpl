<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
                name="main" version="3.0">
  <!-- This pipeline does nothing, it's just a smoke test for
       the RELAX NG validator. -->
  <p:input port="source"/>
  <p:output port="result"/>
  <p:identity>
    <p:with-input port="source" pipe="source"/>
  </p:identity>
</p:declare-step>
