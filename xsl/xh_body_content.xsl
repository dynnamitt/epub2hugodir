<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:xh="http://www.w3.org/1999/xhtml">

    <xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes" indent="yes"/>

    <xsl:template match="/">
        <xsl:apply-templates select="xh:html/xh:body/*" />
    </xsl:template>
    
    <xsl:template match="node()|@*|processing-instruction()">
        <xsl:copy>
           <xsl:apply-templates select="@*|node()|processing-instruction()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>