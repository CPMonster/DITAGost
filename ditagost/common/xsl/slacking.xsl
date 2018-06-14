<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      Standalone library
        
    Part:       Common  
    Module:     slacking.xsl
    
    Scope:      DITA, DITA OT
    
    Func:       Working with slacking text
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs"
    version="2.0">
    
    <!-- 
        Modules
    -->
    
    <xsl:import href="../../lib/fastcust/xsl-2.0/funcs.xsl"/>
    
    
    <!-- 
        Detecting slacking text
    -->
    
    <!-- A template -->
    <xsl:template match="*" mode="is_slacking" as="xs:boolean">
        
        <xsl:variable name="supreor_title">            
            <xsl:value-of select="normalize-space(ancestor::*[cpm:is_section(.)][1]/title)"/>                       
        </xsl:variable>
        
        <xsl:choose>            
            <xsl:when test="$supreor_title = normalize-space(title)">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    <!-- A wrapper function -->
    <xsl:function name="cpm:is_slacking" as="xs:boolean">
        
        <!-- An element representing a section -->
        <xsl:param name="element"/>
        
        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="exists($element)">
                    <xsl:apply-templates select="$element" mode="is_slacking"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:value-of select="boolean($tmp)"/>
        
    </xsl:function>    
    
</xsl:stylesheet>