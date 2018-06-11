<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      Standalone library
        
    Part:       ESKD
    Module:     toc.xsl
    
    Scope:      DITA, DITA OT
    
    Func:       Assembling a ESKD TOC
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules    
    -->

    <!-- A common TOC -->
    <xsl:import href="../../../common/xsl/toc.xsl"/>


    <!-- 
        Providing a master page sequence alias for TOC pages
    -->
    <xsl:template match="*[cpm:fastcust.is_toctopic(.)]" mode="sequence">
        <xsl:text>ESKD.Content.Portrait</xsl:text>
    </xsl:template>

</xsl:stylesheet>
