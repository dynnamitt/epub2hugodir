<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:xh="http://www.w3.org/1999/xhtml">

    <xsl:output method="text" encoding="utf-8"/>
    
    <xsl:param name="fmt">toml</xsl:param>

    <xsl:template match="/*">
        <xsl:apply-templates select="*" />
    </xsl:template>
    
    <xsl:template match="xh:title">
        <xsl:call-template name="toml" >
            <xsl:with-param name="k">title</xsl:with-param>
            <xsl:with-param name="v" select="text()"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="xh:meta">
        <xsl:call-template name="toml" >
            <xsl:with-param name="k" select="(@name|@http-equiv)[1]"/>
            <xsl:with-param name="v" select="@content" />
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="toml">
        <xsl:param name="k"/>
        <xsl:param name="v"/>
        <xsl:value-of select="$k"/>
        <xsl:text> = "</xsl:text>
        <xsl:value-of select="$v"/>
        <xsl:text>"&#xA;</xsl:text> 
    </xsl:template>


</xsl:stylesheet>