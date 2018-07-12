<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster    
    
    Level:      Library        
    
    Part:       FO
    Module:     queries.xsl
    
    Scope:      FO
    
    Func:       Parsing FO content                   
-->   
<!-- * * ** *** ***** ******** ************* ********************* --> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Wrapper functions -->
    <xsl:import href="funcs.xsl"/>


    <!-- 
        Detecting FO elements and attributes
    -->
    <xsl:template match="*" mode="cpm.fo.is_fo" as="xs:boolean">
        <xsl:value-of select="namespace-uri() = 'http://www.w3.org/1999/XSL/Format'"/>
    </xsl:template>

    <xsl:template match="@*" mode="cpm.fo.is_fo" as="xs:boolean">
        <xsl:value-of select="false()"/>
    </xsl:template>

    <xsl:template match="@*[namespace-uri() = 'http://www.w3.org/1999/XSL/Format']"
        mode="cpm.fo.is_fo" as="xs:boolean">
        <xsl:value-of select="true()"/>
    </xsl:template>

    
    <!-- 
        Detecting a FO element output class
    -->
    <xsl:template match="*" mode="cpm.fo.oclass">
        <xsl:value-of select="@role"/>
    </xsl:template>
    
    
    <!-- 
        Extracting a region side from an element
    -->
    <xsl:template match="fo:region-before | fo:region-after | fo:region-start | fo:region-end" mode="cpm.fo.regside">        
        <xsl:value-of select="substring-after(name(), 'fo:region-')"/>        
    </xsl:template>


</xsl:stylesheet>
