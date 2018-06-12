<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      Standalone library
        
    Part:       ESKD  
    Module:     eskd.xsl
    
    Scope:      DITA, DITA OT
    
    Func:       A particular customization (e.g. ESKD borders) 
                imports this file in order to get an the access 
                to appropriate templates and functions
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- 
        Modules
    -->
    
    <!-- FastCust publishing engine -->
    <xsl:import href="../../../lib/fastcust/xsl-2.0/dita.xsl"/>        
    
    <!-- A ESKD cover page -->
    <xsl:import href="cover.xsl"/>
    
    <!-- A ESKD TOC -->
    <xsl:import href="toc.xsl"/>
    
    <!-- ESKD tables of figures, tables, etc. -->
    <xsl:import href="../../../common/xsl/ton.xsl"/>
    
    <!-- A final useless page -->
    <xsl:import href="listregizm.xsl"/>        
    
    <xsl:import href="../../../common/xsl/sections.xsl"/>
    
</xsl:stylesheet>