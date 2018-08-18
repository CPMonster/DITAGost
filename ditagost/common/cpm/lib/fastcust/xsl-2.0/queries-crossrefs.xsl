<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster    
    
    Level:      Library
    
    Part:       FastCust
    Module:     queries-crossrefs.xsl 
    
    Scope:      Generic, FO
    
    Func:       Providing queries for creating cross references.
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Useful templates and functions -->
    <xsl:import href="../../common/xsl-2.0/misc.xsl"/>

    <!-- FastCust wrapper functions -->
    <xsl:import href="funcs.xsl"/>


    <!-- 
        Detecting an ID of a target element
    -->

    <!-- A default template for a common element -->
    <xsl:template match="*" mode="cpm.fastcust.refid">
        <xsl:value-of select="cpm:misc.id(.)"/>
    </xsl:template>

    <!-- A default template for a titled element -->
    <xsl:template match="*[*[cpm:is_title(.)]]" mode="cpm.fastcust.refid">
        <xsl:value-of select="cpm:refid(*[cpm:is_title(.)])"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="refid">
        <xsl:value-of select="cpm:fastcust.refid(.)"/>
    </xsl:template>


    <!-- 
        Assembling a number placeholder for an element
    -->
    <xsl:template match="*" mode="cpm.fastcust.number_placeholder">
        <xsl:param name="src" select="''"/>
        <cpm:number refid="{cpm:refid(.)}">
            <xsl:copy-of select="cpm:misc.attr('src', $src)"/>
        </cpm:number>
    </xsl:template>

</xsl:stylesheet>
