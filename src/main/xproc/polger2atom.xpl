<p:declare-step name="polger2atom" version="1.0"
                xmlns:p="http://www.w3.org/ns/xproc">

  <p:input  port="source"/>
  <p:output port="result"/>

  <p:xslt name="html2atom">
    <p:input port="stylesheet">
      <p:document href="../xslt/html2atom.xsl"/>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>
  </p:xslt>

  <p:validate-with-relax-ng name="validate" assert-valid="true">
    <p:input port="schema">
      <p:data href="../schema/atom.rnc"/>
    </p:input>
  </p:validate-with-relax-ng>

</p:declare-step>
