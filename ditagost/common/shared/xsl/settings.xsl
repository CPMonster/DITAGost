<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Products:   DITA OT Customization for Azimut    
    
    Level:      DITA OT customization shared files
    
    Part:       Common shared files
    Module:     settings.xsl
    
    Scope:      DITA, DITA OT
    
    Func:       Defining default layout settings
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs"
    version="2.0">
    
    <!-- 
        A default font family
    -->
    <xsl:function name="cpm:ditagost.default_font_family">
        <xsl:text>Times New Roman</xsl:text>
    </xsl:function>
    
</xsl:stylesheet>