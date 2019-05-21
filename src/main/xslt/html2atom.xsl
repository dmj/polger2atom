<xsl:transform version="2.0"
               xpath-default-namespace="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all"
               xmlns="http://www.w3.org/2005/Atom"
               xmlns:atom="http://www.w3.org/2005/Atom"
               xmlns:fn="tag:maus@hab.de,2019:PolonskyGerman"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="baseUri">https://hab.bodleian.ox.ac.uk</xsl:variable>
  <xsl:variable name="monthNames" as="xs:string+" select="('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')"/>

  <xsl:template match="html">
    <xsl:variable name="entries" as="element()*">
      <xsl:apply-templates/>
    </xsl:variable>

    <feed>
      <id><xsl:value-of select="$baseUri"/></id>
      <title><xsl:value-of select="head/title[1]"/></title>
      <updated><xsl:value-of select="$entries[1]/atom:updated"/></updated>
      <xsl:sequence select="$entries"/>
    </feed>
  </xsl:template>

  <xsl:template match="section[tokenize(@class, ' ') = 'blog-article']">
    <xsl:variable name="contentSection" select="div[tokenize(@class, ' ') = 'blog-article__text']" as="element(div)"/>
    <xsl:variable name="entryTitle" select="$contentSection/a[tokenize(@class, ' ') = 'title']" as="element(a)"/>
    <xsl:variable name="entryUri" select="concat($baseUri, $entryTitle/@href)" as="xs:string"/>

    <entry>
      <id><xsl:value-of select="$entryUri"/></id>
      <link rel="alternate" type="text/html" href="{$entryUri}"/>
      <updated><xsl:value-of select="fn:parse-date($contentSection/p/span[i[tokenize(@class, ' ') = 'fa-calendar-alt']])"/>T00:00:00</updated>
      <title><xsl:value-of select="$entryTitle"/></title>
      <author>
        <name><xsl:value-of select="normalize-space($contentSection/p/span[i[tokenize(@class, ' ') = 'fa-user']])"/></name>
      </author>
    </entry>

  </xsl:template>

  <xsl:template match="text()"/>

  <xsl:function name="fn:parse-date" as="xs:string">
    <xsl:param name="date" as="xs:string"/>

    <xsl:variable name="particles" select="tokenize(normalize-space($date), ' ')"/>

    <xsl:variable name="month" select="index-of($monthNames, $particles[2])"/>

    <xsl:value-of select="string-join(($particles[3], format-number($month, '00'), format-number(number($particles[1]), '00')), '-')"/>

  </xsl:function>

</xsl:transform>
