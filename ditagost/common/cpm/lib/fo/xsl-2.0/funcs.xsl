<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster    
    
    Level:      Library        
    
    Part:       FO
    Module:     funcs.xsl
    
    Scope:      FO
    
    Func:       Wrapper functions for queries                   
-->   
<!-- * * ** *** ***** ******** ************* ********************* --> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="cpm xs" version="2.0">


    <xsl:function name="cpm:fo.is_fo" as="xs:boolean">        
        <xsl:param name="node"/>
        <!--
        <xsl:variable name="tmp">
            <xsl:apply-templates select="$node" mode="cpm.fo.is_fo"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$tmp castable as xs:boolean">
                <xsl:value-of select="$tmp"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
        -->
        <xsl:apply-templates select="$node" mode="cpm.fo.is_fo"/>
        
    </xsl:function>


    <xsl:function name="cpm:fo.oclass">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fo.oclass"/>
    </xsl:function>


</xsl:stylesheet>
