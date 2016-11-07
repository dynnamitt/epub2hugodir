<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:xh="http://www.w3.org/1999/xhtml"
    xmlns:cont="urn:oasis:names:tc:opendocument:xmlns:container"
    xmlns:ncx="http://www.daisy.org/z3986/2005/ncx/" xmlns:opf="http://www.idpf.org/2007/opf"
    xmlns:strings="http://exslt.org/strings" xmlns:exslt="http://exslt.org/common"
    xmlns:epub="http://www.idpf.org/2007/ops" xmlns:epvoc="http://idpf.org/epub/vocab/structure/"
    xmlns:dsct="http://readin.no/epub/custom-type/#"
    xmlns:z3998="http://www.daisy.org/z3998/2012/vocab/structure/#"
    exclude-result-prefixes="ncx strings cont opf epub dsct z3998 epvoc">

    <xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes" indent="yes"/>

    <xsl:variable name="class_val_prefix">et+</xsl:variable>
    <xsl:variable name="colon_replacement">+</xsl:variable>

    <!-- doc -->
    <xsl:template match="/">
        <xsl:apply-templates mode="move_epub_type_attrs"/>
    </xsl:template>
    

    <!-- 
    
            epub:type -> class
            
            aka   mode [[ move_epub_type_attrs ]]
    
    -->


    <!-- remove -->
    <xsl:template match="@epub:prefix" mode="move_epub_type_attrs"/>

    <!-- 
        COPY
        IDIOM   x 3
        
        verbosity is OK since we cleanse out BAD ns's
    -->
    
    <!-- template to copy elements -->
    <xsl:template match="*"  mode="move_epub_type_attrs">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@* | node()" mode="move_epub_type_attrs"/>
        </xsl:element>
    </xsl:template>
    
    <!-- template to copy attributes -->
    <xsl:template match="@*" mode="move_epub_type_attrs">
        <xsl:attribute name="{local-name()}">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>
    
    <!-- template to copy the rest of the nodes -->
    <xsl:template match="comment() | text() | processing-instruction()" mode="move_epub_type_attrs" >
        <xsl:copy/>
    </xsl:template>



    <!-- 
        move (3.0) INFLECTED sematic into class attr 
    -->
    <xsl:template match="*[@epub:type]" mode="move_epub_type_attrs">

        <xsl:variable name="types-cnt" select="count(strings:split(@epub:type, ' '))"/>

        <xsl:element name="{local-name()}">
            <xsl:attribute name="class">
                <xsl:if test="@class">
                    <xsl:value-of select="@class"/>
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:for-each select="strings:split(@epub:type, ' ')">
                    <xsl:value-of
                        select="concat($class_val_prefix,strings:replace(., ':', $colon_replacement))"/>
                    <xsl:if test="not(position() = $types-cnt)">
                        <xsl:text> </xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </xsl:attribute>
            <xsl:apply-templates select="@*[local-name(.) != 'type' and local-name(.) != 'class']"/>
            <xsl:apply-templates select="node() | processing-instruction()" mode="move_epub_type_attrs"/>
        </xsl:element>

    </xsl:template>



</xsl:stylesheet>
