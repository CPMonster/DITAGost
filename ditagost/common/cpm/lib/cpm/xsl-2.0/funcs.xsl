<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster   
    
    Level:      Library
    
    Part:       CPM
    Module:     funcs.xsl
    
    Scope:      CPM
    
    Func:       Wrapper functions for CPM queries                  
-->   
<!-- * * ** *** ***** ******** ************* ********************* --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <xsl:function name="cpm:cpm.is_cpm" as="xs:boolean">
        <xsl:param name="node"/>
        <xsl:apply-templates select="$node" mode="cpm.cpm.is_cpm"/>
    </xsl:function>

</xsl:stylesheet>
