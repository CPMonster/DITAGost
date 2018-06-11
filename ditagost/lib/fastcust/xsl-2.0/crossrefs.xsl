<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster    
    
    Level:      Library
    
    Part:       FastCust
    Module:     crossrefs.xsl 
    
    Scope:      Generic, FO
    
    Func:       Providing queries for creating cross references.
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- 
        Modules
    -->
    
    <!-- Wrapper functions -->
    <xsl:import href="funcs.xsl"/>
    
    
    <!-- 
        Detecting an ID of a target element
    -->
    
    <!-- A default working template -->
    <xsl:template match="*" mode="cpm.fastcust.refid">
        
        <!-- 
            * represents a target element.
        -->
        
        <xsl:choose>
            
            <!-- The case when a target element has a title -->
            <xsl:when test="*[cpm:fastcust.is_title(.)]">
                <!-- ... referring to the title -->
                <xsl:value-of select="cpm:fastcust.id(*[cpm:fastcust.is_title(.)])"/>
            </xsl:when>
            
            <!-- The case when a target element has no title -->
            <xsl:otherwise>
                <!-- ... referring to the element itself -->
                <xsl:value-of select="cpm:fastcust.id(.)"/>
            </xsl:otherwise>
            
        </xsl:choose>        
        
    </xsl:template>
    
    <!-- A default custom template -->
    <xsl:template match="*" mode="refid">                
        <xsl:apply-templates select="." mode="cpm.fastcust.refid"/>       
    </xsl:template>
    
</xsl:stylesheet>