<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA OT Customization for Azimut
    
    Level:      DITA OT customization shared files
        
    Part:       Common files for DITA OT customizations    
    Module:     signatures.xsl
    
    Scope:      DITA, DITA OT
    
    Func:       Working with lists of signatures
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->   
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">

    <!-- 
        Detecting sections that contain signatures 
    -->
    <xsl:function name="cpm:is_signatures" as="xs:boolean">

        <!-- An element representing a section -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="$element/@outputclass = 'signatures'">
                    <xsl:value-of select="true()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Excluding signatures from a TOC 
    -->
    <xsl:template match="*[cpm:is_signatures(.)]" mode="is_tocmamber">
        <xsl:value-of select="false()"/>
    </xsl:template>

</xsl:stylesheet>
