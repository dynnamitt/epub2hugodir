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
    xmlns:z3998="http://www.daisy.org/z3998/2012/vocab/structure/#">   
        
    <xsl:output method="text" encoding="utf-8" 
        omit-xml-declaration="yes" indent="yes" />
    
    <!-- IF opf is input. NCX, NAV, XHTMLS -->
    <xsl:param name="Q"/>
    
    
    <xsl:variable name="MT_OPF">application/oebps-package+xml</xsl:variable>
    <xsl:variable name="MT_NCX">application/x-dtbncx+xml</xsl:variable>
    <xsl:variable name="MT_XH">application/xhtml+xml</xsl:variable>
    
    <xsl:template match="/cont:container">
        <xsl:value-of select="//cont:rootfile[@media-type=$MT_OPF]/@full-path"/>
    </xsl:template>
    
    <xsl:template match="/opf:package">
        
        <xsl:choose>
            <xsl:when test="$Q = 'NCX'">
                <xsl:value-of select="//opf:item[@media-type=$MT_NCX]/@href"/>
            </xsl:when>
            <xsl:when test="$Q = 'NAV'">
                <xsl:if test="@version != '3.0'">
                    <xsl:message>XSL: ONLY 3.x supports NAV</xsl:message>
                </xsl:if>
                <xsl:value-of select="//opf:item[@properties='nav']/@href"/>
            </xsl:when>
            <xsl:when test="$Q = 'XHTMLS'">
                <xsl:apply-templates select="//opf:item[@media-type=$MT_XH]" mode="xhtml-list"/>
            </xsl:when>
            <!-- more to come -->
            <xsl:otherwise>
                <xsl:message terminate="yes">XSL: No Q param given. Must be either NCX,NAV or XHTMLS</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
       
    </xsl:template>  
    
    <!--
        xh list (hrefs)
    -->
    <xsl:template match="opf:item[@media-type='application/xhtml+xml']" mode="xhtml-list">
        <xsl:value-of select="@href"/>
        <xsl:if test="following-sibling::opf:item[@media-type=$MT_XH]/@href"></xsl:if><xsl:text>&#xA;</xsl:text>
        <!-- maybe id -->
    </xsl:template>

</xsl:stylesheet>