<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA OT Customization for Azimut
    
    Level:      DITA OT customization shared files
        
    Part:       Common shared files  
    Module:     intro.xsl
    
    Scope:      DITA, DITA OT, Russian
    
    Func:       Working with introduction topics
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Fastcust queries -->
    <xsl:import href="../../lib/fastcust/xsl-2.0/funcs.xsl"/>


    <!-- 
        Detecting an intro section
    -->

    <!-- A common template -->
    <xsl:template match="node()" mode="is_intro">
        <xsl:value-of select="false()"/>
    </xsl:template>

    <!-- A template for chapters -->
    <xsl:template match="*[cpm:fastcust.numlevel(.) = 1]" mode="is_intro">
        
        <xsl:choose>
            <xsl:when test="normalize-space(title) = 'Введение'">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>
    
    <!-- A wrapper function -->
    <xsl:function name="cpm:is_intro" as="xs:boolean">
        
        <!-- An element representing a section -->
        <xsl:param name="element"/>
        
        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="exists($element)">
                    <xsl:apply-templates select="$element" mode="is_intro"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:value-of select="boolean($tmp)"/>
        
    </xsl:function>

    <!-- A template for inner sections -->
    <xsl:template match="*[cpm:fastcust.numlevel(.) &gt; 1]" mode="is_intro">        

        <xsl:choose>
            <xsl:when test="ancestor::*[cpm:is_intro(.)]">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

</xsl:stylesheet>
