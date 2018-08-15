<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      DITA OT customization
        
    Part:       ESKD documents with borders     
    Module:     eskd-border.xsl
    
    Scope:      DITA, DITA OT, Russian, ESKD
    
    Func:       Performing core FastCust activities
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->    
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->    

    <!-- Styles and formatting rules -->
    <xsl:include href="../../../../eskd/xsl/eskd.xsl"/>

    <!-- Headers & footers -->
    <xsl:include href="running.xsl"/>


    <!-- 
        Headers & footers
    -->
    
    <!--
        parent::cpm:sequence/@master-alias
            "Человеческое" название раздела.
        
        parent::cpm:sequence/@master-name
            Имя раздела, которое прописано в FO.                            
        
        @region-name 
            A FO name of a region (fo:region-before/@region-name)
        
        @page-side
            Одно из четырех: before, after, start, end.
        
        @page-position
            Значение fo:conditional-page-master-reference/@page-position.
            Для fo:single-page-master-reference вернется пустая строка. 
    -->
    
    <xsl:template match="cpm:static-content[cpm:page_side(., 'ESKD.Cover', '*', 'start')]"
        mode="static">
        <xsl:call-template name="cpm.ditagost.eskd.cover_static"/>
    </xsl:template>

    <xsl:template match="cpm:static-content[cpm:page_side(., 'ESKD.Cover', '*', 'after')]"
        mode="static">
        <xsl:call-template name="cover_footer"/>
    </xsl:template>

    <xsl:template match="cpm:static-content[cpm:page_side(., 'ESKD.TOC', 'first', 'start')]"
        mode="static">
        <xsl:call-template name="cpm.ditagost.eskd.toc_first_static"/>
    </xsl:template>

    <xsl:template match="cpm:static-content[cpm:page_side(., 'ESKD.TOC', 'regular', 'start')]"
        mode="static">
        <xsl:call-template name="cpm.ditagost.eskd.regular_A4p_static"/>
    </xsl:template>

    <xsl:template
        match="cpm:static-content[cpm:page_side(., 'ESKD.Content.Portrait', '*', 'start')]"
        mode="static">
        <xsl:call-template name="cpm.ditagost.eskd.regular_A4p_static"/>
    </xsl:template>

    <xsl:template
        match="cpm:static-content[cpm:page_side(., 'ESKD.Content.PortraitRotated', '*', 'start')]"
        mode="static">
        <xsl:call-template name="cpm.ditagost.eskd.regular_A4p_static"/>
    </xsl:template>
    

    <!-- 
        A TOC
    -->

    <!-- Including a TOC to a document -->
    <xsl:template match="*[cpm:is_toctopic(.)]" mode="sequence">
        <xsl:text>ESKD.TOC</xsl:text>
    </xsl:template>

</xsl:stylesheet>
