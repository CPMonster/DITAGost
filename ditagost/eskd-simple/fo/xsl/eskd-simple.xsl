<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      DITA OT customization
        
    Part:       A common document with no ESKD border     
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

    

    <!-- ============================= -->
    <!--  Completing document content  -->
    <!-- ============================= -->

    <!-- 
        Rebuilding a topic for publishing it as an appendix
    -->

    <!-- Assembling appendix titles -->
    <xsl:template match="*" mode="appendix_titles">

        <p outputclass="appnumber">
            <!--
            <xsl:value-of select="substring-before(cpm:fastcust.full_number(.), '.')"/>
            -->
            <xsl:value-of select="cpm:fastcust.full_number(.)"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="title"/>
            <xsl:text> </xsl:text>
            <xsl:text>(Обязательное)</xsl:text>
        </p>

        <!--
        <p outputclass="appmanopt">
            <xsl:text>(Обязательное)</xsl:text>
        </p>

        <p outputclass="apptitle">
            <xsl:value-of select="title"/>
        </p>
        -->

    </xsl:template>

    <!-- Reassembling an appendix -->
    <xsl:template match="*[cpm:sectype(.) = 'appendix']" mode="complete">

        <xsl:copy>

            <xsl:copy-of select="@*"/>

            <title>
                <xsl:copy-of select="title/@*"/>
                <xsl:value-of select="title"/>
                <xsl:text> (Обязательное)</xsl:text>
            </title>

            <body class="- topic/body">
                <xsl:copy-of select="*[contains(@class, 'topic/body')]/@*"/>
                <!-- <xsl:apply-templates select="." mode="appendix_titles"/> -->
                <xsl:apply-templates select="*[contains(@class, 'topic/body')]/*" mode="complete"/>
            </body>

        </xsl:copy>

    </xsl:template>


    <!-- 
        Reassembling a document
    -->
    <xsl:template match="map | bookmap" mode="complete">

        <bookmap>

            <!-- Copying attributes -->
            <xsl:copy-of select="@*"/>

            <!-- Assembling cover page content -->
            <xsl:call-template name="cover"/>

            <!-- Assembling a TOC -->
            <xsl:call-template name="toctopic">
                <xsl:with-param name="title" select="'Содержание'"/>
                <xsl:with-param name="maxlevel" select="3"/>
            </xsl:call-template>

            <!-- Appending DITA OT preprocessor output -->
            <xsl:apply-templates select="*[cpm:sectype(.) != 'appendix']" mode="complete"/>

            <!-- Assembling a topic containing a list of figures -->
            <xsl:if test=".//fig">
                <xsl:call-template name="tontopic">
                    <xsl:with-param name="numseq" select="'Рисунки'"/>
                    <xsl:with-param name="title" select="'Перечень рисунков'"/>
                </xsl:call-template>
            </xsl:if>

            <!-- Assembling a topic containing a list of tables -->
            <xsl:if test=".//table[title]">
                <xsl:call-template name="tontopic">
                    <xsl:with-param name="numseq" select="'Таблицы'"/>
                    <xsl:with-param name="title" select="'Перечень таблиц'"/>
                </xsl:call-template>
            </xsl:if>

            <xsl:apply-templates select="*[cpm:sectype(.) = 'appendix']" mode="complete"/>

            <xsl:call-template name="listregizm"/>

        </bookmap>

    </xsl:template>



    <!-- ======================= -->
    <!--  Flattening a document  -->
    <!-- ======================= -->

    <!-- 
        Eliminating signatures
    -->
    <xsl:template match="*[cpm:sectype(.) = 'signatures']" mode="level">
        <xsl:value-of select="-1"/>
    </xsl:template>


    <!-- 
        Providing a page sequence alias
    -->
    <xsl:template match="*[cpm:fastcust.is_topic(.)]" mode="sequence">

        <xsl:choose>

            <xsl:when test="descendant::*[@outputclass = 'wide']">
                <xsl:text>ESKD.Content.PortraitRotated</xsl:text>
            </xsl:when>

            <xsl:otherwise>
                <xsl:text>ESKD.Content.Portrait</xsl:text>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>


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
    
    
    <!-- 
        Костыль омерзительный!!!!!!!!!
    -->
    <xsl:template match="note" mode="cpm.fastcust.improve">
        
        <p outputclass="notecaption">ВНИМАНИЕ!</p>
        
        <xsl:choose>
            <xsl:when test="p|li|table|fig">
                <xsl:apply-templates select="*" mode="cpm.fastcust.improve"/>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:apply-templates select="node()" mode="cpm.fastcust.improve"/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    

</xsl:stylesheet>
