<xsl:stylesheet version="1.0" 
  xmlns:cont="urn:oasis:names:tc:opendocument:xmlns:container"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output type="text" encoding="utf-8" omit-xml-declaration="yes"/>

    <xsl:template 
      match="//cont:rootfile[@media-type='application/oebps-package+xml']">
      <xsl:value-of select="@full-path"/>
    </xsl:template>

</xsl:stylesheet>
