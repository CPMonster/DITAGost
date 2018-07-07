<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster   
    
    Level:      Library
    
    Part:       CPM
    Module:     queries.xsl
    
    Scope:      CPM
    
    Func:       Queries related to CPM                  
-->   
<!-- * * ** *** ***** ******** ************* ********************* --> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->
    
    <!-- Wrapper functions-->
    <xsl:import href="funcs.xsl"/>


    <!-- 
        Detecting CPM elements and attributes
    -->
    <xsl:template match="node() | @*" mode="cpm.cpm.is_cpm" as="xs:boolean">
        <xsl:value-of select="namespace-uri() != 'http://cpmonster.com/xmlns/cpm'"/>
    </xsl:template>

</xsl:stylesheet>
