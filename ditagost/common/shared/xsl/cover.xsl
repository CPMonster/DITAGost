<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      Standalone library
        
    Part:       Common  
    Module:     cover.xsl
    
    Scope:      DITA, DITA OT
    
    Func:       Assembling cover pages
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->   
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs"
    version="2.0">
                    
    <!-- 
        Transforming a cover page to FO
    -->
    <xsl:template match="cpm:cover" mode="foxml">
        
        <!-- Skipping a wrapper cpm:cover element, diving into content -->
        
        <xsl:apply-templates select="*" mode="foxml"/>
        
    </xsl:template>
    
</xsl:stylesheet>