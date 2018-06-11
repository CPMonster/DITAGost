<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA OT Customization for Azimut
    
    Level:      DITA OT customization shared files
        
    Part:       Common files for DITA OT customizations    
    Module:     sections.xsl
    
    Scope:      DITA, DITA OT
    
    Func:       Detecting section types, etc.
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->    
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- FustCust wrapper functions -->
    <xsl:import href="../../lib/fastcust/xsl-2.0/funcs.xsl"/>

    <xsl:import href="../../eskd/fo/xsl/listregizm.xsl"/>

    <!-- Detecting resource topics -->
    <xsl:import href="resource.xsl"/>

    <!-- Working with introduction topics -->
    <xsl:import href="intro.xsl"/>

    <!-- Working with signatures -->
    <xsl:import href="signatures.xsl"/>

    <!-- Working with topics that belong to a main part of a document -->
    <xsl:import href="regular.xsl"/>

    <!-- Working with appendices -->
    <xsl:import href="appendix.xsl"/>

    <!-- Working with tables of named objects -->
    <xsl:import href="ton.xsl"/>


    


    <!-- 
        Detecting a section type
    -->
    <xsl:template match="*" mode="sectype">

        <xsl:choose>
            
            <xsl:when test="cpm:is_listregizm(.)">
                <xsl:text>listregizm</xsl:text>
            </xsl:when>
           
            
            <xsl:when test="cpm:is_slacking(.)">
                <xsl:text>slacking</xsl:text>
            </xsl:when>
            
            <xsl:when test="cpm:is_intro(.)">
                <xsl:text>intro</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_appendix(.)">
                <xsl:text>appendix</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:fastcust.is_auxiliary(.)">
                <xsl:text>auxiliary</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_signatures(.)">
                <xsl:text>signatures</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_main(.)">
                <xsl:text>main</xsl:text>
            </xsl:when>            
            <!--
            <xsl:when test="cpm:is_listopic(.)">
                <xsl:text>listopic</xsl:text>
            </xsl:when>
            -->
            <xsl:when test="cpm:fastcust.is_toctopic(.)">
                <xsl:text>toctopic</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:fastcust.is_tontopic(.)">
                <xsl:text>tontopic</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>other</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


</xsl:stylesheet>
