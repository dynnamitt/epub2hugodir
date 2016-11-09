<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:xh="http://www.w3.org/1999/xhtml">

    <xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes" indent="yes"/>

    <xsl:template match="/">
        <xsl:copy-of select="xh:html/xh:head" />
    </xsl:template>    

</xsl:stylesheet>