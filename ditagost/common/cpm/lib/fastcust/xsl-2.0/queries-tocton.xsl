<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster    
    
    Level:      Library
    
    Part:       FastCust
    Module:     queries-tocton.xsl
    
    Scope:      Generic
    
    Func:       Provides temptates and functions for assembling 
                titles and navigation titles 
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs cpm"
    version="2.0">
    
    <!-- 
        Modules
    -->
    
    <!-- FastCust wrapper functions -->
    <xsl:import href="funcs.xsl"/>
        
    
    <!-- 
        Retrieving a title of an element
    -->
    
    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.title" >
        
        <!-- * represents an element of a document -->
        
        <xsl:choose>
            <xsl:when test="cpm:is_title(.)">
                <xsl:value-of select="."/>
            </xsl:when>                                   
            <xsl:when test="*[cpm:is_title(.)]">
                <xsl:value-of select="*[cpm:is_title(.)]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="@title"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    <!-- A custom template -->
    <xsl:template match="*" mode="title">
        <xsl:value-of select="cpm:fastcust.title(.)"/>
    </xsl:template>
    
    
    <!--
        Assembling a full title of an element
    -->
    
    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.full_title">        
        <xsl:value-of select="cpm:full_number(.)"/>
        <xsl:value-of select="cpm:title(.)"/>        
    </xsl:template>
    
    <!-- A custom template -->
    <xsl:template match="*" mode="full_title">        
        <xsl:value-of select="cpm:fastcust.full_title(.)"/>               
    </xsl:template>
    
    
    <!--
        Assembling a full navigation title of an element
    -->
    
    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.nav_full_title">        
        <xsl:value-of select="cpm:nav_full_number(.)"/>
        <xsl:value-of select="cpm:title(.)"/>        
    </xsl:template>
    
    <!-- A custom template -->
    <xsl:template match="*" mode="nav_full_title">        
        <xsl:value-of select="cpm:nav_full_number(.)"/>      
        <xsl:value-of select="cpm:title(.)"/>  
    </xsl:template>
        
</xsl:stylesheet>