<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster   
    
    Level:      Library
    
    Part:       DITA
    Module:     queries.xsl
    
    Scope:      DITA
    
    Func:       Retrieving data from source DITA content                  
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->    
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->
    
    <xsl:import href="queries-basics.xsl"/>
    <xsl:import href="queries-topics.xsl"/>
    <xsl:import href="queries-maps.xsl"/>
    <xsl:import href="queries-tables.xsl"/>

</xsl:stylesheet>
