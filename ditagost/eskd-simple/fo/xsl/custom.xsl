<?xml version='1.0'?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      DITA OT customization
    
    Part:       A common document with no ESKD border
    Module:     custom.xsl
    
    Scope:      DITA, DITA OT, ESKD
    
    Func:       Providing a program interface with DITA OT    
-->   
<!-- * * ** *** ***** ******** ************* ********************* --> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Layout-specific templates  -->
    <xsl:include href="eskd-simple.xsl"/>
    
    <!-- Pages and styles -->
    <xsl:include href="../../../eskd/fo/xsl/layout.xsl"/>


    <!-- 
        Output options
    -->
    <xsl:output method="xml" indent="yes"/>
        
</xsl:stylesheet>
