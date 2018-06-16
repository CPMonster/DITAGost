<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      Standalone library
        
    Part:       Common
    Module:     auxilliary.xsl
    
    Scope:      DITA, DITA OT
    
    Func:       Working with auxilliary topics
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
    
    <xsl:import href="../../cpm/lib/fastcust/xsl-2.0/funcs.xsl"/>
    
    
    <!-- 
        Detecting an auxilliary topic (a wrapper function)
    -->
    <xsl:function name="cpm:is_auxiliary" as="xs:boolean">
        
        <!-- DITA (stage1.xml) element -->
        <xsl:param name="element"/>
        
        <xsl:value-of select="cpm:fastcust.is_auxiliary($element)"/>
        
    </xsl:function>
    
    
</xsl:stylesheet>