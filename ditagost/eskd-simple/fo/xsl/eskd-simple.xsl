<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      DITA OT customization
        
    Part:       ESKD documents without borders     
    Module:     eskd-simple.xsl
    
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
    <xsl:include href="../../../eskd/fo/xsl/eskd.xsl"/>
        
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

            <!-- Cover page header & footer -->
            <xsl:when test="@master-alias = 'ESKD.Cover'">

                <xsl:choose>
                    
                    <!-- A cover page header -->
                    <xsl:when test="@page-side = 'before'">
                        <xsl:call-template name="cover_header"/>
                    </xsl:when>
                    
                    <!-- A cover page footer -->
                    <xsl:when test="@page-side = 'after'">
                        <xsl:call-template name="cover_footer"/>
                    </xsl:when>

                </xsl:choose>

            </xsl:when>

            <!-- Landscape A4 header & footer -->
            <xsl:when test="@master-alias = 'ESKD.Content.PortraitRotated'">

                <xsl:choose>

                    <!-- A header -->
                    <xsl:when test="@page-side = 'start'">
                        <xsl:call-template name="A4_landscape_header"/>
                    </xsl:when>

                    <!-- A footer -->
                    <xsl:when test="@page-side = 'end'">
                        <xsl:call-template name="A4_landscape_footer"/>
                    </xsl:when>

                </xsl:choose>

            </xsl:when>

            <!-- Portrait A4 header & footer -->
            <xsl:otherwise>

                <xsl:choose>

                    <!-- A header -->
                    <xsl:when test="@page-side = 'before'">
                        <xsl:call-template name="A4_portrait_header"/>
                    </xsl:when>

                    <!-- A footer -->
                    <xsl:when test="@page-side = 'after'">
                        <xsl:call-template name="A4_portrait_footer"/>
                    </xsl:when>

                </xsl:choose>

            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>            

</xsl:stylesheet>
