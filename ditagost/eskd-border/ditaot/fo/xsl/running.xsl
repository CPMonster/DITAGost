<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST 
    
    Level:      DITA OT customization
    
    Part:       ESKD documents with borders
    Module:     borders.xsl
    
    Scope:      ESKD, Russian
    
    Func:       Assembling borders
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="cpm" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Paths & URIs -->
    <xsl:import href="../../../../common/cpm/lib/common/xsl-2.0/pathuri.xsl"/>   

    <!-- Retrieving document parameters -->
    <xsl:import href="../../../../common/shared/xsl/docparams.xsl"/>



    <!-- ================================ -->
    <!--  Working with the configuration  -->
    <!-- ================================ -->

    <!-- 
        Assembling an URI for a border image file 
    -->
    <xsl:function name="cpm:ditagost.borders_uri">

        <xsl:param name="border_filename"/>

        <xsl:variable name="relative_uri">
            <xsl:value-of select="cpm:pathuri.folder(base-uri(document('running.xsl')))"/>
            <xsl:text>/../../../../eskd/borders/</xsl:text>
            <xsl:value-of select="$border_filename"/>
        </xsl:variable>

        <xsl:value-of select="document-uri(document($relative_uri))"/>

    </xsl:function>


    <!-- 
        Assembling an originator's logo 
    -->
    <xsl:template name="cpm.ditagost.logo">

        <xsl:variable name="logo">
            <xsl:apply-templates select="." mode="logo"/>
        </xsl:variable>

        <fo:block xsl:use-attribute-sets="cpm.ditagost.large_block">
            <xsl:choose>
                <xsl:when test="$logo != ''">
                    <xsl:copy-of select="$logo"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="cpm:ditagost.originator()"/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:block>

    </xsl:template>


    <!--  
        Assembling a logo table
    -->
    <xsl:template name="cpm.ditagost.product_and_logo">
        <fo:table height="100%">
            <fo:table-body>
                <fo:table-row diaplay-align="center">

                    <fo:table-cell>
                        <fo:block xsl:use-attribute-sets="cpm.ditagost.large_block">
                            <xsl:copy-of select="cpm:ditagost.subject()"/>
                        </fo:block>
                    </fo:table-cell>

                    <xsl:variable name="logo">
                        <xsl:apply-templates select="." mode="logo"/>
                    </xsl:variable>

                    <xsl:if test="$logo != ''">
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="cpm.ditagost.large_block">
                                <xsl:copy-of select="$logo"/>
                            </fo:block>
                        </fo:table-cell>
                    </xsl:if>

                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>



    <!-- ============================== -->
    <!--  Assembling border containers  -->
    <!-- ============================== -->

    <!-- 
        Assembling a border for portrait A4 pages
    -->

    <!-- Container attributes -->
    <xsl:attribute-set name="cpm.ditagost.A4p_border_bc">
        <xsl:attribute name="width">210mm</xsl:attribute>
        <xsl:attribute name="left">0mm</xsl:attribute>
        <xsl:attribute name="top">0mm</xsl:attribute>
        <xsl:attribute name="height">297mm</xsl:attribute>
        <xsl:attribute name="position">absolute</xsl:attribute>
    </xsl:attribute-set>

    <!-- External graphic attributes -->
    <xsl:attribute-set name="cpm.ditagost.A4p_border">
        <xsl:attribute name="width">auto</xsl:attribute>
        <xsl:attribute name="height">auto</xsl:attribute>
        <xsl:attribute name="content-width">210mm</xsl:attribute>
        <xsl:attribute name="content-height">297mm</xsl:attribute>
    </xsl:attribute-set>

    <!-- A template -->
    <xsl:template name="cpm.ditagost.eskd.A4p_border">

        <xsl:param name="border_filename"/>

        <xsl:variable name="border_uri">
            <xsl:value-of select="cpm:ditagost.borders_uri($border_filename)"/>
        </xsl:variable>

        <fo:block-container xsl:use-attribute-sets="cpm.ditagost.A4p_border_bc">
            <fo:block>
                <fo:external-graphic xsl:use-attribute-sets="cpm.ditagost.A4p_border">
                    <xsl:attribute name="src">
                        <xsl:value-of select="$border_uri"/>
                    </xsl:attribute>
                </fo:external-graphic>
            </fo:block>
        </fo:block-container>

    </xsl:template>


    <!-- 
        Assembling a border for landscape A4 pages
    -->

    <!-- Container attributes -->
    <xsl:attribute-set name="cpm.ditagost.A4l_border_bc">
        <xsl:attribute name="width">297mm</xsl:attribute>
        <xsl:attribute name="left">0mm</xsl:attribute>
        <xsl:attribute name="top">0mm</xsl:attribute>
        <xsl:attribute name="height">210mm</xsl:attribute>
        <xsl:attribute name="position">absolute</xsl:attribute>
    </xsl:attribute-set>

    <!-- External graphic attributes -->
    <xsl:attribute-set name="cpm.ditagost.A4l_border">
        <xsl:attribute name="width">auto</xsl:attribute>
        <xsl:attribute name="height">auto</xsl:attribute>
        <xsl:attribute name="content-width">297mm</xsl:attribute>
        <xsl:attribute name="content-height">210mm</xsl:attribute>
    </xsl:attribute-set>

    <!-- A template -->
    <xsl:template name="cpm.ditagost.eskd.A4l_border">

        <xsl:param name="border_filename"/>

        <xsl:variable name="border_uri">
            <xsl:value-of select="cpm:ditagost.borders_uri($border_filename)"/>
        </xsl:variable>

        <fo:block-container xsl:use-attribute-sets="cpm.ditagost.A4l_border_bc">
            <fo:block>
                <fo:external-graphic xsl:use-attribute-sets="cpm.ditagost.A4l_border">
                    <xsl:attribute name="src">
                        <xsl:value-of select="$border_uri"/>
                    </xsl:attribute>
                </fo:external-graphic>
            </fo:block>
        </fo:block-container>

    </xsl:template>


    <!-- 
        Assembling a vertical sidebar
    -->

    <!-- Small cell attributes -->
    <xsl:attribute-set name="cpm.ditagost.eskd.sidebar_5_attrs">
        <xsl:attribute name="width">5mm</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="overflow">visible</xsl:attribute>
    </xsl:attribute-set>

    <!-- Middle size cell attributes -->
    <xsl:attribute-set name="cpm.ditagost.eskd.sidebar_25_attrs">
        <xsl:attribute name="width">25mm</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="overflow">visible</xsl:attribute>
    </xsl:attribute-set>

    <!-- Large cell attributes -->
    <xsl:attribute-set name="cpm.ditagost.eskd.sidebar_35_attrs">
        <xsl:attribute name="width">35mm</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="overflow">visible</xsl:attribute>
    </xsl:attribute-set>

    <!-- Entire sidebar attributes -->
    <xsl:attribute-set name="cpm.ditagost.eskd.sidebar_attrs">
        <xsl:attribute name="reference-orientation">90</xsl:attribute>
        <xsl:attribute name="absolute-position">absolute</xsl:attribute>
        <xsl:attribute name="left">8.5mm</xsl:attribute>
        <xsl:attribute name="overflow">visible</xsl:attribute>
    </xsl:attribute-set>

    <!-- Assemblin a sidebar -->
    <xsl:template name="cpm.ditagost.eskd.sidebar">

        <fo:block-container xsl:use-attribute-sets="cpm.ditagost.eskd.sidebar_attrs">
            <fo:table role="border.sidebar" font-size="9pt">
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell xsl:use-attribute-sets="cpm.ditagost.eskd.sidebar_5_attrs">
                            <fo:block/>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="cpm.ditagost.eskd.sidebar_25_attrs">
                            <fo:block>Инв № подл.</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="cpm.ditagost.eskd.sidebar_35_attrs">
                            <fo:block>Подп. и дата</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="cpm.ditagost.eskd.sidebar_25_attrs">
                            <fo:block>Взамен инв. №</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="cpm.ditagost.eskd.sidebar_25_attrs">
                            <fo:block>Инв № дубл.</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="cpm.ditagost.eskd.sidebar_35_attrs">
                            <fo:block>Подп. и дата</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>

        </fo:block-container>

    </xsl:template>



    <!-- ===================================== -->
    <!--  Assembling cells for a bottom table  -->
    <!-- ===================================== -->

    <!-- 
        Attributes of bottom table cells
    -->

    <!-- A block nested into a small cell -->
    <xsl:attribute-set name="cpm.ditagost.small_block">
        <xsl:attribute name="font-size">8pt</xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
        <xsl:attribute name="display-align">center</xsl:attribute>
    </xsl:attribute-set>

    <!-- A block nested into a large cell  -->
    <xsl:attribute-set name="cpm.ditagost.large_block">
        <xsl:attribute name="font-size">14pt</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="display-align">center</xsl:attribute>
    </xsl:attribute-set>

    <!-- A cells of a bottom table -->
    <xsl:attribute-set name="cpm.ditagost.legend_cell">
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="display-align">center</xsl:attribute>
    </xsl:attribute-set>

    <!-- A row of a bottom table -->
    <xsl:attribute-set name="cpm.ditagost.legend_row">
        <xsl:attribute name="border-style">none</xsl:attribute>
        <xsl:attribute name="border-width">0pt</xsl:attribute>
        <xsl:attribute name="height">5mm</xsl:attribute>
    </xsl:attribute-set>


    <!-- 
        Assembling a sequence of empty cells
    -->
    <xsl:function name="cpm:ditagost.empty_cells">

        <xsl:param name="count"/>

        <xsl:for-each select="1 to $count">
            <fo:table-cell>
                <fo:block/>
            </fo:table-cell>
        </xsl:for-each>

    </xsl:function>


    <!-- 
        Assembling a singular cell
    -->
    <xsl:function name="cpm:ditagost.small_cell">

        <xsl:param name="text"/>

        <xsl:param name="text_align"/>

        <fo:table-cell xsl:use-attribute-sets="cpm.ditagost.legend_cell">
            <fo:block xsl:use-attribute-sets="cpm.ditagost.small_block">
                <xsl:attribute name="text-align">
                    <xsl:value-of select="$text_align"/>
                </xsl:attribute>
                <xsl:if test="$text_align = 'left'">
                    <xsl:attribute name="margin-left">
                        <xsl:text>1mm</xsl:text>
                    </xsl:attribute>
                </xsl:if>
                <xsl:copy-of select="$text"/>
            </fo:block>
        </fo:table-cell>

    </xsl:function>


    <!-- 
        Assembling a merged cell 
    -->

    <!-- A working template -->
    <xsl:template name="cpm.ditagost.spanned_cell">

        <xsl:param name="text"/>

        <xsl:param name="colspan"/>

        <xsl:param name="rowspan"/>

        <xsl:param name="text_align"/>

        <fo:table-cell xsl:use-attribute-sets="cpm.ditagost.legend_cell">

            <xsl:if test="$colspan != 0">
                <xsl:attribute name="number-columns-spanned">
                    <xsl:value-of select="$colspan"/>
                </xsl:attribute>
            </xsl:if>

            <xsl:if test="$rowspan != 0">
                <xsl:attribute name="number-rows-spanned">
                    <xsl:value-of select="$rowspan"/>
                </xsl:attribute>
            </xsl:if>

            <fo:block xsl:use-attribute-sets="cpm.ditagost.small_block">

                <xsl:attribute name="text-align">
                    <xsl:value-of select="$text_align"/>
                </xsl:attribute>

                <xsl:if test="$text_align = 'left'">
                    <xsl:attribute name="margin-left">
                        <xsl:text>1mm</xsl:text>
                    </xsl:attribute>
                </xsl:if>

                <xsl:copy-of select="$text"/>

            </fo:block>

        </fo:table-cell>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:ditagost.spanned_cell">

        <xsl:param name="text"/>

        <xsl:param name="colspan"/>

        <xsl:param name="rowspan"/>

        <xsl:param name="text_align"/>

        <xsl:call-template name="cpm.ditagost.spanned_cell">
            <xsl:with-param name="text" select="$text"/>
            <xsl:with-param name="colspan" select="$colspan"/>
            <xsl:with-param name="rowspan" select="$rowspan"/>
            <xsl:with-param name="text_align" select="$text_align"/>
        </xsl:call-template>

    </xsl:function>


    <!-- 
        Assembling a merged cell containing centered text
    -->

    <!-- A working template -->
    <xsl:template name="cpm.ditagost.large_cell">

        <xsl:param name="text"/>

        <xsl:param name="colspan"/>

        <xsl:param name="rowspan"/>

        <fo:table-cell xsl:use-attribute-sets="cpm.ditagost.legend_cell">

            <xsl:if test="$colspan != 0">
                <xsl:attribute name="number-columns-spanned">
                    <xsl:value-of select="$colspan"/>
                </xsl:attribute>
            </xsl:if>

            <xsl:if test="$rowspan != 0">
                <xsl:attribute name="number-rows-spanned">
                    <xsl:value-of select="$rowspan"/>
                </xsl:attribute>
            </xsl:if>

            <fo:block xsl:use-attribute-sets="cpm.ditagost.large_block">
                <xsl:copy-of select="$text"/>
            </fo:block>

        </fo:table-cell>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:ditagost.large_cell">

        <xsl:param name="text"/>

        <xsl:param name="colspan"/>

        <xsl:param name="rowspan"/>

        <xsl:call-template name="cpm.ditagost.large_cell">
            <xsl:with-param name="text" select="$text"/>
            <xsl:with-param name="colspan" select="$colspan"/>
            <xsl:with-param name="rowspan" select="$rowspan"/>
        </xsl:call-template>

    </xsl:function>


    <!-- 
        Assembling a page number cell
    -->
    <xsl:template name="cpm.ditagost.page_number_cell">
        <xsl:param name="font_size" select="'8pt'"/>
        <fo:table-cell xsl:use-attribute-sets="cpm.ditagost.legend_cell">
            <fo:block margin-left="1mm">
                <xsl:attribute name="font-size">
                    <xsl:value-of select="$font_size"/>
                </xsl:attribute>
                <fo:page-number/>
            </fo:block>
        </fo:table-cell>
    </xsl:template>


    <!-- 
        Assembling a cell containing a number of pages
    -->
    <xsl:template name="cpm.ditagost.pages_cell">
        <fo:table-cell display-align="center" text-align="center">
            <fo:block margin-left="1mm" display-align="center" text-align="center" font-size="8pt">
                <fo:page-number-citation ref-id="cpm.fastcust.last_page"/>
            </fo:block>
        </fo:table-cell>
    </xsl:template>


    <!-- 
        Assembling a page number table
    -->
    <xsl:template name="cpm.ditagost.page_number">

        <fo:table>
            <fo:table-body>
                <fo:table-row height="7.5mm">
                    <fo:table-cell text-align="center">
                        <fo:block margin-top="1mm">Лист</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="7.5mm">
                    <xsl:call-template name="cpm.ditagost.page_number_cell">
                        <xsl:with-param name="font_size" select="'12pt'"/>
                    </xsl:call-template>
                </fo:table-row>
            </fo:table-body>
        </fo:table>

    </xsl:template>


    <!-- 
        Assembling a bottom table row
    -->
    <xsl:template name="cpm.ditagost.legend_row">

        <xsl:param name="content"/>

        <fo:table-row xsl:use-attribute-sets="cpm.ditagost.legend_row">
            <xsl:copy-of select="$content"/>
        </fo:table-row>

    </xsl:template>



    <!-- =========================== -->
    <!--  Assembling entire borders  -->
    <!-- =========================== -->

    <xsl:attribute-set name="cpm.ditagost.A4p_cover_legend_bc_attrs">
        <xsl:attribute name="width">185mm</xsl:attribute>
        <xsl:attribute name="height">40mm</xsl:attribute>
        <xsl:attribute name="left">20mm</xsl:attribute>
        <xsl:attribute name="top">252.5mm</xsl:attribute>
        <xsl:attribute name="position">absolute</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="cpm.ditagost.A4p_regular_legend_bc_attrs">
        <xsl:attribute name="width">185mm</xsl:attribute>
        <xsl:attribute name="height">40mm</xsl:attribute>
        <xsl:attribute name="left">20mm</xsl:attribute>
        <xsl:attribute name="top">277.5mm</xsl:attribute>
        <xsl:attribute name="position">absolute</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="cpm.ditagost.A4p_legend_table_attrs">
        <xsl:attribute name="border-style">none</xsl:attribute>
        <xsl:attribute name="border-width">0pt</xsl:attribute>
        <xsl:attribute name="width">185mm</xsl:attribute>
    </xsl:attribute-set>


    <!-- 
        A cover page (portrait A4)
    -->

    <!-- A footer -->
    <xsl:template name="cover_footer">

        <xsl:variable name="footer">
            <p outputclass="cover.year">
                <xsl:value-of select="cpm:ditagost.year()"/>
            </p>
        </xsl:variable>

        <xsl:apply-templates select="$footer/*" mode="foxml"/>

    </xsl:template>

    <!-- An entire border -->
    <xsl:template name="cpm.ditagost.eskd.cover_static">

        <xsl:variable name="border">
            <xsl:call-template name="cpm.ditagost.eskd.A4p_border">
                <xsl:with-param name="border_filename" select="'ESKD-A4P-Cover.svg'"/>
            </xsl:call-template>
            <xsl:call-template name="cpm.ditagost.eskd.sidebar"/>
        </xsl:variable>

        <xsl:apply-templates select="$border/*" mode="foxml"/>

    </xsl:template>


    <!-- 
        A first page of a TOC (portrait A4)
    -->

    <!-- A legend -->
    <xsl:template name="cpm.ditagost.eskd.toc_first_legend">

        <xsl:variable name="subject">
            <xsl:value-of select="cpm:ditagost.subject()"/>
        </xsl:variable>

        <xsl:variable name="originator">
            <xsl:value-of select="cpm:ditagost.originator()"/>
        </xsl:variable>

        <xsl:variable name="docnumber">
            <xsl:value-of select="cpm:ditagost.docnumber()"/>
        </xsl:variable>

        <fo:block-container xsl:use-attribute-sets="cpm.ditagost.A4p_cover_legend_bc_attrs">
            <fo:block role="border.details">
                <fo:table xsl:use-attribute-sets="cpm.ditagost.A4p_legend_table_attrs">
                    <fo:table-column column-width="7mm"/>
                    <fo:table-column column-width="10mm"/>
                    <fo:table-column column-width="23mm"/>
                    <fo:table-column column-width="15mm"/>
                    <fo:table-column column-width="10mm"/>
                    <fo:table-column column-width="70mm"/>
                    <fo:table-column column-width="5mm"/>
                    <fo:table-column column-width="5mm"/>
                    <fo:table-column column-width="5mm"/>
                    <fo:table-column column-width="15mm"/>
                    <fo:table-column column-width="20mm"/>
                    <fo:table-body>
                        <!-- row 1 -->
                        <xsl:call-template name="cpm.ditagost.legend_row">
                            <xsl:with-param name="content">
                                <xsl:copy-of select="cpm:ditagost.empty_cells(5)"/>
                                <xsl:copy-of select="cpm:ditagost.large_cell($subject, 6, 3)"/>
                            </xsl:with-param>
                        </xsl:call-template>
                        <!-- row 2 -->
                        <xsl:call-template name="cpm.ditagost.legend_row">
                            <xsl:with-param name="content">
                                <xsl:copy-of select="cpm:ditagost.empty_cells(5)"/>
                            </xsl:with-param>
                        </xsl:call-template>
                        <!-- row 3 -->
                        <xsl:call-template name="cpm.ditagost.legend_row">
                            <xsl:with-param name="content">
                                <xsl:copy-of select="cpm:ditagost.small_cell('Изм.', 'center')"/>
                                <xsl:copy-of select="cpm:ditagost.small_cell('Лист', 'center')"/>
                                <xsl:copy-of select="cpm:ditagost.small_cell('№ докум.', 'center')"/>
                                <xsl:copy-of select="cpm:ditagost.small_cell('Подп.', 'center')"/>
                                <xsl:copy-of select="cpm:ditagost.small_cell('Дата', 'center')"/>
                            </xsl:with-param>
                        </xsl:call-template>
                        <!-- row 4 -->
                        <xsl:call-template name="cpm.ditagost.legend_row">
                            <xsl:with-param name="content">
                                <xsl:copy-of
                                    select="cpm:ditagost.spanned_cell('Разраб.', 2, 0, 'left')"/>
                                <xsl:copy-of select="cpm:ditagost.empty_cells(3)"/>
                                <xsl:copy-of select="cpm:ditagost.large_cell($docnumber, 0, 5)"/>
                                <xsl:copy-of
                                    select="cpm:ditagost.spanned_cell('Лит.', 3, 0, 'center')"/>
                                <xsl:copy-of select="cpm:ditagost.small_cell('Лист', 'center')"/>
                                <xsl:copy-of select="cpm:ditagost.small_cell('Листов', 'center')"/>
                            </xsl:with-param>
                        </xsl:call-template>
                        <!-- row 5 -->
                        <xsl:call-template name="cpm.ditagost.legend_row">
                            <xsl:with-param name="content">
                                <xsl:copy-of
                                    select="cpm:ditagost.spanned_cell('Пров.', 2, 0, 'left')"/>
                                <xsl:copy-of select="cpm:ditagost.empty_cells(6)"/>
                                <xsl:call-template name="cpm.ditagost.page_number_cell"/>
                                <xsl:call-template name="cpm.ditagost.pages_cell"/>
                            </xsl:with-param>
                        </xsl:call-template>
                        <!-- row 6 -->
                        <xsl:call-template name="cpm.ditagost.legend_row">
                            <xsl:with-param name="content">
                                <xsl:copy-of select="cpm:ditagost.empty_cells(5)"/>
                                <xsl:call-template name="cpm.ditagost.large_cell">
                                    <xsl:with-param name="text">
                                        <xsl:call-template name="cpm.ditagost.logo"/>
                                    </xsl:with-param>
                                    <xsl:with-param name="colspan" select="5"/>
                                    <xsl:with-param name="rowspan" select="3"/>
                                </xsl:call-template>
                            </xsl:with-param>
                        </xsl:call-template>
                        <!-- row 7 -->
                        <xsl:call-template name="cpm.ditagost.legend_row">
                            <xsl:with-param name="content">
                                <xsl:copy-of
                                    select="cpm:ditagost.spanned_cell('Н. контр.', 2, 0, 'left')"/>
                                <xsl:copy-of select="cpm:ditagost.empty_cells(3)"/>
                            </xsl:with-param>
                        </xsl:call-template>
                        <!-- row 8 -->
                        <xsl:call-template name="cpm.ditagost.legend_row">
                            <xsl:with-param name="content">
                                <xsl:copy-of
                                    select="cpm:ditagost.spanned_cell('Утв.', 2, 0, 'left')"/>
                                <xsl:copy-of select="cpm:ditagost.empty_cells(3)"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </fo:block-container>

    </xsl:template>

    <!-- An entire border -->
    <xsl:template name="cpm.ditagost.eskd.toc_first_static">

        <xsl:variable name="border">
            <xsl:call-template name="cpm.ditagost.eskd.A4p_border">
                <xsl:with-param name="border_filename" select="'ESKD-A4P-1stPage-F2.svg'"/>
            </xsl:call-template>
            <xsl:call-template name="cpm.ditagost.eskd.toc_first_legend"/>
            <xsl:call-template name="cpm.ditagost.eskd.sidebar"/>
        </xsl:variable>

        <xsl:apply-templates select="$border/*" mode="foxml"/>

    </xsl:template>


    <!-- 
        Regular portrait A4 pages
    -->

    <!-- A legend -->
    <xsl:template name="cpm.ditagost.eskd.regular_A4p_legend">

        <fo:block-container xsl:use-attribute-sets="cpm.ditagost.A4p_regular_legend_bc_attrs">
            <fo:block role="border.details">
                <fo:table xsl:use-attribute-sets="cpm.ditagost.A4p_legend_table_attrs">
                    <fo:table-column column-width="7mm"/>
                    <fo:table-column column-width="10mm"/>
                    <fo:table-column column-width="23mm"/>
                    <fo:table-column column-width="15mm"/>
                    <fo:table-column column-width="10mm"/>
                    <fo:table-column column-width="70mm"/>
                    <fo:table-column column-width="5mm"/>
                    <fo:table-column column-width="5mm"/>
                    <fo:table-column column-width="5mm"/>
                    <fo:table-column column-width="25mm"/>
                    <fo:table-column column-width="10mm"/>
                    <fo:table-body>
                        <!-- row 1 -->
                        <fo:table-row border-style="none" border-width="0pt" height="5mm">
                            <xsl:copy-of select="cpm:ditagost.empty_cells(5)"/>
                            <xsl:call-template name="cpm.ditagost.spanned_cell">
                                <xsl:with-param name="text">
                                    <xsl:call-template name="cpm.ditagost.product_and_logo"/>
                                </xsl:with-param>
                                <xsl:with-param name="colspan" select="5"/>
                                <xsl:with-param name="rowspan" select="3"/>
                                <xsl:with-param name="text_align" select="'center'"/>
                            </xsl:call-template>
                            <fo:table-cell number-rows-spanned="3">
                                <xsl:call-template name="cpm.ditagost.page_number"/>
                            </fo:table-cell>
                        </fo:table-row>
                        <!-- row 2 -->
                        <fo:table-row border-style="none" border-width="0pt" height="5mm">
                            <xsl:copy-of select="cpm:ditagost.empty_cells(5)"/>
                        </fo:table-row>
                        <!-- row 3 -->
                        <fo:table-row border-style="none" border-width="0pt" height="5mm">
                            <xsl:copy-of select="cpm:ditagost.small_cell('Изм.', 'center')"/>
                            <xsl:copy-of select="cpm:ditagost.small_cell('Лист', 'center')"/>
                            <xsl:copy-of select="cpm:ditagost.small_cell('№ докум.', 'center')"/>
                            <xsl:copy-of select="cpm:ditagost.small_cell('Подп.', 'center')"/>
                            <xsl:copy-of select="cpm:ditagost.small_cell('Дата', 'center')"/>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </fo:block-container>

    </xsl:template>

    <!-- An entire border -->
    <xsl:template name="cpm.ditagost.eskd.regular_A4p_static">

        <xsl:variable name="border">
            <xsl:call-template name="cpm.ditagost.eskd.A4p_border">
                <xsl:with-param name="border_filename" select="'ESKD-A4P-Main-F2a.svg'"/>
            </xsl:call-template>
            <xsl:call-template name="cpm.ditagost.eskd.regular_A4p_legend"/>
            <xsl:call-template name="cpm.ditagost.eskd.sidebar"/>
        </xsl:variable>

        <xsl:apply-templates select="$border/*" mode="foxml"/>

    </xsl:template>


    <!-- 
        Regular landscape A4 pages
    -->

    <!-- A legend -->
    <xsl:template name="cpm.ditagost.eskd.regular_A4l_legend"/>

    <!-- An entire border -->
    <xsl:template name="cpm.ditagost.eskd.regular_A4l_static">

        <xsl:variable name="border">
            <xsl:call-template name="cpm.ditagost.eskd.A4l_border">
                <xsl:with-param name="border_filename" select="'ESKD-A4L-Main-F2a.svg'"/>
            </xsl:call-template>
            <xsl:call-template name="cpm.ditagost.eskd.regular_A4l_legend"/>
        </xsl:variable>

        <xsl:apply-templates select="$border/*" mode="foxml"/>

    </xsl:template>

</xsl:stylesheet>
