<?xml version="1.0" encoding="utf-8"?>
<!-- 
  Probabl/y taken from some ONLINE url, but cannot remember where....
  TODO maybe find true OFFICIAL version
-->
<xsl:stylesheet version="1.0"
  exclude-result-prefixes="ncx xsl" xmlns="http://www.w3.org/1999/xhtml"
  xmlns:ncx="http://www.daisy.org/z3986/2005/ncx/" 
  xmlns:epub="http://www.idpf.org/2007/ops"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  >

  <xsl:output omit-xml-declaration="no" method="xml" encoding="UTF-8" indent="yes"/>

  <!-- Text for the top-level `h1` inside the primary `nav` element -->
  <xsl:param name="contents-str">Contents</xsl:param>

  <!-- @id value for primary toc `nav` element -->
  <xsl:param name="toc-id">toc</xsl:param>
  <xsl:param name="xh_sub-dir"></xsl:param>

  <xsl:template match="ncx:ncx">
    <html>
      <head>
        <title>
          <xsl:apply-templates select="/ncx:ncx/ncx:docTitle/ncx:text/text()"/>
        </title>
        <xsl:for-each select="ncx:head/ncx:meta">
          <meta  name="{@name}" content="{@content}" />
        </xsl:for-each>
        <xsl:apply-templates select="ncx:docAuthor/ncx:text"/>        
      </head>
      <body>
        <xsl:apply-templates select="ncx:navMap"/>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="ncx:docAuthor/ncx:text">
    <meta name="docAuthor" content="text()"/>
  </xsl:template>

  <xsl:template match="ncx:navMap|ncx:pageList">
    <nav>
      <xsl:copy-of select="@class"/>
      
      <xsl:if test="self::ncx:navMap">
        <xsl:attribute name="id">
          <xsl:value-of select="$toc-id"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:attribute name="epub:type">
        <xsl:choose>
          <xsl:when test="self::ncx:navMap">toc</xsl:when>
          <xsl:when test="self::ncx:pageList">page-list</xsl:when>
        </xsl:choose>
      </xsl:attribute>

      <xsl:choose>
        <xsl:when test="ncx:navInfo">
          <xsl:apply-templates select="ncx:navInfo"/>
        </xsl:when>
        <xsl:when test="ncx:navLabel">
          <xsl:apply-templates select="ncx:navLabel" mode="heading"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="self::ncx:navMap">
            <h1>
              <xsl:value-of select="$contents-str"/>
            </h1>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
      <ol>
        <xsl:apply-templates select="ncx:navPoint|ncx:pageTarget"/>
      </ol>
    </nav>
  </xsl:template>


  <xsl:template match="ncx:navInfo">
    <h1>
      <xsl:copy-of select="@class"/>
      <xsl:apply-templates/>
    </h1>
  </xsl:template>


  <xsl:template match="ncx:navLabel" mode="heading">
    <h2>
      <xsl:copy-of select="@class"/>
      <xsl:apply-templates/>
    </h2>
  </xsl:template>


  <xsl:template match="ncx:navPoint|ncx:pageTarget">
    <li>
      <xsl:copy-of select="@id|@class"/>

      <!-- every navPoint and pageTarget has to have a navLabel and content -->
      <a rel="subsection" href="{ncx:content/@src}">
        <span>
          <xsl:value-of select="ncx:navLabel/ncx:text"/>
        </span>
      </a>

      <!-- some navPoints have more navPoints inside them for deep NCXes. 
        pageTargets cannot nest. -->
      <xsl:if test="child::ncx:navPoint">
        <ol>
          <xsl:apply-templates select="child::ncx:navPoint"/>
        </ol>
      </xsl:if>
    </li>
  </xsl:template>


  <!-- Default rule to catch omissions -->
  <xsl:template match="*">
    <xsl:message terminate="yes">ERROR: <xsl:value-of select="name(.)"/> not matched! </xsl:message>
  </xsl:template>

</xsl:stylesheet>
