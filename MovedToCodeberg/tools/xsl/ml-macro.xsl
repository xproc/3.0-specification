<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:ml="http://nwalsh.com/ns/ml-macro#"
		xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="ml xdt xs"
                version="2.0">

<rdf:Description rdf:about=''
		 xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'
		 xmlns:cc="http://web.resource.org/cc/"
		 xmlns:dc='http://purl.org/dc/elements/1.1/'
		 xmlns:cvs="http://nwalsh.com/rdf/cvs#">
  <rdf:type rdf:resource="http://web.resource.org/cc/Work"/>
  <rdf:type rdf:resource="http://norman.walsh.name/knows/taxonomy#XSL"/>
  <dc:type rdf:resource='http://purl.org/dc/dcmitype/Text'/>
  <dc:format>application/xsl+xml</dc:format>
  <dc:title>Macro expansion stylesheet</dc:title>
  <dc:date>2006-01-06</dc:date>
  <cvs:date>$Date: 2006/04/10 18:47:49 $</cvs:date>
  <dc:creator rdf:resource='http://norman.walsh.name/knows/who#norman-walsh'/>
  <dc:rights>Copyright &#169; 2006 Norman Walsh. This work is licensed under the Creative Commons Attribution-NonCommercial License.</dc:rights>
  <cc:license rdf:resource="http://creativecommons.org/licenses/by-nc/2.0/"/>
  <dc:description>Expands macros in text content and attribute values. See http://norman.walsh.name/2006/01/06/doctype</dc:description>
</rdf:Description>

<xsl:output method="xml" encoding="utf-8" indent="no"/>
<xsl:preserve-space elements="*"/>

<!-- URI of a resource that contains default macros -->
<xsl:variable name="defaultMacros" select="'#macros'"/>

<!-- Load the default macros -->
<xsl:variable name="ml:defaultMacros" select="document($defaultMacros)"/>

<!-- Default macros -->
<ml:collection xml:id="macros">
  <!-- Defaults here, or override $defaultMacros to point elsewhere -->
  <!--
  <ml:macro name="ndw">Norman Walsh</ml:macro>
  -->
</ml:collection>

<!-- Dynamic macros -->
<xsl:template name="ml:dynamicMacros" as="element(ml:macro)*">
  <!-- Define any dynamic macros here. -->
  <!--
  <ml:macro name="time">
    <xsl:value-of select="format-time(current-time(), '[h01]:[m01][Pn,*-1]')"/>
  </ml:macro>
  <ml:macro name="timeZ">
    <xsl:value-of 
	select="format-dateTime(adjust-dateTime-to-timezone(current-dateTime(),
		                     xdt:dayTimeDuration('PT0H')),
			        '[h01]:[m01][Pn,*-1]')"/>
  </ml:macro>
  <ml:macro name="date">
    <xsl:value-of select="format-date(current-date(), '[D] [MNn,*-3] [Y]')"/>
  </ml:macro>
  <ml:macro name="dateZ">
    <xsl:value-of 
	select="format-dateTime(adjust-dateTime-to-timezone(current-dateTime(),
		                     xdt:dayTimeDuration('PT0H')),
			        '[D] [MNn,*-3] [Y]')"/>
  </ml:macro>
  -->
</xsl:template>

<!-- Select the relevant processing instructions: ones before the
     document element or before the first child element inside the
     document element. -->
<xsl:variable
    name="ml:pis" 
    select="/*/preceding-sibling::processing-instruction('ml-macro')
	    |/*/processing-instruction('ml-macro')[not(preceding-sibling::*)]"
    as="processing-instruction()*"/>

<!-- Select the open delimiter -->
<xsl:variable
    name="ml:odre"
    select="(/*/preceding-sibling::processing-instruction('ml-macro-odre')[1],
            '\[\[')[1]"/>

<!-- Select the close delimiter -->
<xsl:variable
    name="ml:cdre"
    select="(/*/preceding-sibling::processing-instruction('ml-macro-cdre')[1],
            '\]\]')[1]"/>

<!-- Parse all the relevant PIs once and build an element list that will
     be easier to search. -->
<xsl:variable name="ml:macros" as="element(ml:macro)*">
  <!-- All ml-macro PIs before or within the root element -->
  <xsl:for-each select="$ml:pis">
    <xsl:variable name="data" select="concat(' ',normalize-space(.))"/>
    <xsl:variable name="macro" select="ml:find-pseudo($data, 'name')"/>
    <xsl:variable name="text" select="ml:find-pseudo($data, 'text')"/>
    <xsl:if test="$macro != ''">
      <ml:macro name="{$macro}">
	<xsl:value-of select="$text"/>
      </ml:macro>
    </xsl:if>
  </xsl:for-each>

  <!-- Then all the ones in externally referenced files -->
  <xsl:for-each select="$ml:pis">
    <xsl:variable name="data" select="concat(' ',normalize-space(.))"/>
    <xsl:variable name="href" select="ml:find-pseudo($data, 'href')"/>
    <xsl:if test="$href != ''">
      <xsl:variable name="macs" select="document($href,/)"/>
      <xsl:copy-of select="$macs/ml:collection/ml:macro"/>
    </xsl:if>
  </xsl:for-each>

  <!-- Then all the default ones -->
  <xsl:choose>
    <xsl:when test="$ml:defaultMacros instance of element()">
      <xsl:copy-of select="$ml:defaultMacros/ml:macro"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:copy-of select="$ml:defaultMacros/ml:collection/ml:macro"/>
    </xsl:otherwise>
  </xsl:choose>

  <!-- Then the dynamic ones -->
  <xsl:call-template name="ml:dynamicMacros"/>
</xsl:variable>

<!-- Copy elements; expanding macros as we go -->
<xsl:template match="*" mode="ml:expand-macros">
  <xsl:param name="seen" select="()"/>

  <xsl:copy>
    <xsl:apply-templates select="@*|node()" mode="ml:expand-macros">
      <xsl:with-param name="seen" select="$seen"/>
    </xsl:apply-templates>
  </xsl:copy>
</xsl:template>

<!-- Expand macros in attribute values -->
<xsl:template match="@*" mode="ml:expand-macros">
  <xsl:param name="seen" select="()"/>

  <xsl:choose>
    <xsl:when test="not(empty($ml:macros))">
      <xsl:attribute name="{name(.)}" namespace="{namespace-uri(.)}"
		     select="ml:expand-macros(.,$seen)"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:copy/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- Expand macros in text nodes -->
<xsl:template match="text()" mode="ml:expand-macros">
  <xsl:param name="seen" select="()"/>
  <xsl:choose>
    <xsl:when test="not(empty($ml:macros))">
      <xsl:sequence select="ml:expand-macros(.,$seen)"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:copy/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- Drop ?ml-macro PIs; there's not much point in holding onto them now -->
<xsl:template match="processing-instruction('ml-macro')
		     |processing-instruction('ml-macro-odre')
		     |processing-instruction('ml-macro-cdre')"
	      mode="ml:expand-macros">
</xsl:template>

<!-- Expand macros in comments -->
<xsl:template match="comment()" mode="ml:expand-macros">
  <xsl:param name="seen" select="()"/>
  <xsl:comment>
    <xsl:value-of select="ml:expand-macros(.,$seen)"/>
  </xsl:comment>
</xsl:template>

<!-- Expand macros in PIs -->
<xsl:template match="processing-instruction()" mode="ml:expand-macros">
  <xsl:param name="seen" select="()"/>
  <xsl:processing-instruction name="{name(.)}">
    <xsl:value-of select="ml:expand-macros(.,$seen)"/>
  </xsl:processing-instruction>
</xsl:template>

<!-- Function to expand [[macro-name]] macros -->
<xsl:function name="ml:expand-macros">
  <xsl:param name="text" as="xs:string"/>
  <xsl:param name="seen" as="xs:string*"/>

  <xsl:analyze-string select="$text" regex="{concat($ml:odre,'.*?',$ml:cdre)}">
    <xsl:matching-substring>
      <xsl:variable name="repl"
		    select="replace(., concat($ml:odre,'(.*?)',$ml:cdre), '$1')"/>
      <xsl:choose>
	<xsl:when test="$repl = $seen">
	  <xsl:message>
	    <xsl:text>Expansion of "</xsl:text>
	    <xsl:value-of select="$repl"/>
	    <xsl:text>" is recursive. Giving up.</xsl:text>
	  </xsl:message>
	  <xsl:value-of select="."/>
	</xsl:when>
	<xsl:when test="$ml:macros[@name = $repl]">
	  <xsl:apply-templates select="$ml:macros[@name = $repl][1]/node()"
			       mode="ml:expand-macros">
	    <xsl:with-param name="seen" select="($seen,$repl)"/>
	  </xsl:apply-templates>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:message>
	    <xsl:text>Undefined macro encountered: </xsl:text>
	    <xsl:value-of select="$repl"/>
	  </xsl:message>
	  <xsl:value-of select="."/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:matching-substring>
    <xsl:non-matching-substring>
      <xsl:value-of select="."/>
    </xsl:non-matching-substring>
  </xsl:analyze-string>
</xsl:function>

<!-- Attempt to parse pseudo-attribute values from PIs. This isn't likely
     to handle badly formed PIs very well. So don't do that. -->
<xsl:function name="ml:find-pseudo" as="xs:string?">
  <xsl:param name="text" as="xs:string"/>
  <xsl:param name="find" as="xs:string"/>

  <xsl:if test="matches($text, '^\s*\c+=[&apos;&apos;&quot;].*$')">
    <xsl:variable
	name="pseudo"
	select="replace($text, '^\s*(\c+)=[&apos;&apos;&quot;].*$', '$1')"/>
    <xsl:variable
	name="quote"
	select="replace($text, '^\s*\c+=([&apos;&apos;&quot;]).*$', '$1')"/>
    <xsl:variable
	name="value"
	select="substring-before(substring-after($text, $quote),$quote)"/>
    <xsl:variable
	name="rest"
	select="substring-after(substring-after($text, $quote),$quote)"/>

    <!--
    <xsl:message>
      <xsl:value-of select="$pseudo"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="$quote"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="$value"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="$rest"/>
    </xsl:message>
    -->

    <xsl:choose>
      <xsl:when test="$pseudo = $find">
	<xsl:value-of select="$value"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="ml:find-pseudo($rest, $find)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:if>
</xsl:function>      

</xsl:stylesheet>
