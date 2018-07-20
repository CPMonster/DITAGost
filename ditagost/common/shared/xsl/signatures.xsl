<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA OT Customization for Azimut
    
    Level:      DITA OT customization shared files
        
    Part:       Common files for DITA OT customizations    
    Module:     signatures.xsl
    
    Scope:      DITA, DITA OT
    
    Func:       Working with lists of signatures
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->   
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Detecting a topic containing a list of signatures
    -->
    <xsl:function name="cpm:is_signatures" as="xs:boolean">

        <!-- An element representing a section -->
        <xsl:param name="element"/>

        <xsl:value-of select="$element/@outputclass = 'signatures'"/>

    </xsl:function>


    <!-- 
        Excluding a list of signatures from TOC
    -->
    <xsl:template match="*[cpm:is_signatures(.)]" mode="is_tocmamber" as="xs:boolean">
        <xsl:value-of select="false()"/>
    </xsl:template>


</xsl:stylesheet>
