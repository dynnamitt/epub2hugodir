<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xh="http://www.w3.org/1999/xhtml"
    xmlns:cont="urn:oasis:names:tc:opendocument:xmlns:container"
    xmlns:ncx="http://www.daisy.org/z3986/2005/ncx/"
    xmlns:opf="http://www.idpf.org/2007/opf"
    xmlns:strings="http://exslt.org/strings"
    xmlns:epub="http://www.idpf.org/2007/ops"
    xmlns:epvoc="http://idpf.org/epub/vocab/structure/"
    xmlns:dsct="http://readin.no/epub/custom-type/#"
    xmlns:z3998="http://www.daisy.org/z3998/2012/vocab/structure/#"
    exclude-result-prefixes="ncx strings cont opf epub dsct z3998 epvoc">   
        
    <xsl:output method="text" encoding="utf-8" 
        omit-xml-declaration="yes" indent="yes" />
    
    <xsl:template match="/cont:container">
        <xsl:value-of select="//cont:rootfile[@media-type='application/oebps-package+xml']/@full-path"/>
    </xsl:template>
    
    <xsl:template match="/opf:package">
        <xsl:choose>
            <xsl:when test="@version = '2.0'">
                <xsl:value-of select="//opf:item[@media-type='application/x-dtbncx+xml']/@href"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="//opf:item[@properties='nav']/@href"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>  

</xsl:stylesheet>