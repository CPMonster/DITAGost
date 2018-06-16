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
    <xsl:template match="cpm:static-content" mode="static">
        
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
        
        <xsl:choose>
            
            <!-- A cover page border -->
            <xsl:when test="@master-alias = 'ESKD.Cover'">
                
                <xsl:choose>
                    
                    <!-- A cover  page header -->
                    <xsl:when test="@page-side = 'start'">
                        <xsl:call-template name="cpm.ditagost.eskd.cover_static"/>
                    </xsl:when>
                    
                    <!-- A cover page footer -->
                    <xsl:when test="@page-side = 'after'">                        
                        <xsl:call-template name="cover_footer"/>                        
                    </xsl:when>
                    
                </xsl:choose>
                
            </xsl:when>
            
            <!-- Borders for TOC pages -->
            <xsl:when test="@master-alias = 'ESKD.TOC'">
                
                <xsl:choose>
                    
                    <!-- A 1st page border -->
                    <xsl:when test="@page-side = 'start' and @page-position = 'first'">
                        <xsl:call-template name="cpm.ditagost.eskd.toc_first_static"/>
                    </xsl:when>
                    
                    <!-- A regular page border -->
                    <xsl:when test="@page-side = 'start' and @page-position != 'first'">
                        <xsl:call-template name="cpm.ditagost.eskd.regular_A4p_static"/>
                    </xsl:when>
                    
                </xsl:choose>
                
            </xsl:when>
            
            <!-- A border for a portrait A4 with rotated text -->
            <xsl:when test="@master-alias = 'ESKD.Content.PortraitRotated'">
                <xsl:call-template name="cpm.ditagost.eskd.regular_A4p_static"/>
            </xsl:when>
            
            <!-- Portrait A4 border -->
            <xsl:otherwise>
                
                <xsl:if test="@page-side = 'start'">
                    <xsl:call-template name="cpm.ditagost.eskd.regular_A4p_static"/>
                </xsl:if>
                
            </xsl:otherwise>
            
        </xsl:choose>
        
    </xsl:template>            
    
    
    <!-- 
        A TOC
    -->
    
    <!-- Including a TOC to a document -->
    <xsl:template match="*[cpm:is_toctopic(.)]" mode="sequence">
        <xsl:text>ESKD.TOC</xsl:text>
    </xsl:template>

</xsl:stylesheet>
