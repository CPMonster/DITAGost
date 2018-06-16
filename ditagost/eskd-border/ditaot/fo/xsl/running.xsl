<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA Gost 
    
    Level:      Library
    
    Part:       Borders
    Module:     borders.xsl
    
    Scope:      ESKD
    
    Func:       Borders
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="cpm" version="2.0">

    <!-- 
        Модули
    -->

    <!-- Paths & URIs -->
    <xsl:import href="../../../../common/cpm/lib/common/xsl-2.0/pathuri.xsl"/>

    <!-- Default layout settings -->
    <xsl:import href="../../../../common/shared/xsl/settings.xsl"/>

    <!-- Retrieving document parameters -->
    <xsl:import href="../../../../common/shared/xsl/docparams.xsl"/>



    <!-- ======================================= -->
    <!--  Конфигурация компонентов кастомизации  -->
    <!-- ======================================= -->

    <!-- ================================ -->
    <!--  Working with the configuration  -->
    <!-- ================================ -->

    <!-- An URI of common images folder -->
    <xsl:function name="cpm:image_uri">
        <xsl:value-of select="cpm:pathuri.folder(base-uri(document('running.xsl')))"/>
        <xsl:text>/../../../common/images/</xsl:text>
    </xsl:function>

    <!-- Расположение папки с рамками -->
    <xsl:function name="cpm:ditagost.borders_uri">
        <xsl:value-of select="cpm:pathuri.folder(base-uri(document('running.xsl')))"/>
        <xsl:text>/../../../../eskd/borders/</xsl:text>
    </xsl:function>

    <!-- Logo -->
    <xsl:template name="logo">
        <!--
        <xsl:variable name="logo_uri">
            <xsl:value-of select="cpm:image_uri()"/>
            <xsl:text>logo.png</xsl:text>
        </xsl:variable>

        <fo:block>
            <fo:external-graphic src="{$logo_uri}"/>
        </fo:block>
        -->
    </xsl:template>



    <!-- ========================================= -->
    <!--  Заготовки для рамок и основных надписей  -->
    <!-- ========================================= -->

    <!-- 
        Параметры частей рамок и основных надписей
    -->

    <!-- Параметры малого блока основной надписи -->
    <xsl:attribute-set name="cpm.ditagost.small_block">
        <xsl:attribute name="font-size">8pt</xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
        <xsl:attribute name="display-align">center</xsl:attribute>
    </xsl:attribute-set>

    <!-- Свойства крупного блока основной надписи -->
    <xsl:attribute-set name="cpm.ditagost.large_block">
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="display-align">center</xsl:attribute>
    </xsl:attribute-set>

    <!-- Свойства ячейки основной надписи -->
    <xsl:attribute-set name="cpm.ditagost.legend_cell">
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="display-align">center</xsl:attribute>
    </xsl:attribute-set>

    <!-- Свойства строки основной надписи -->
    <xsl:attribute-set name="cpm.ditagost.legend_row">
        <xsl:attribute name="border-style">none</xsl:attribute>
        <xsl:attribute name="border-width">0pt</xsl:attribute>
        <xsl:attribute name="height">5mm</xsl:attribute>
    </xsl:attribute-set>

    <!-- Формат A4, портретный -->
    <xsl:attribute-set name="cpm.ditagost.espd.A4p">
        <xsl:attribute name="width">auto</xsl:attribute>
        <xsl:attribute name="height">auto</xsl:attribute>
        <xsl:attribute name="content-width">210mm</xsl:attribute>
        <xsl:attribute name="content-height">297mm</xsl:attribute>
    </xsl:attribute-set>

    <!-- Ajhvfn A4, портрет, свойства контейнера для рамок -->
    <xsl:attribute-set name="cpm.ditagost.espd.A4p_bc">
        <xsl:attribute name="width">210mm</xsl:attribute>
        <xsl:attribute name="left">0mm</xsl:attribute>
        <xsl:attribute name="height">297mm</xsl:attribute>
        <xsl:attribute name="position">absolute</xsl:attribute>
    </xsl:attribute-set>


    <!-- 
        Пустые ячейки в нужном количестве
    -->
    <xsl:function name="cpm:ditagost.empty_cells">

        <xsl:param name="count"/>

        <xsl:if test="$count &gt; 0">

            <fo:table-cell>
                <fo:block/>
            </fo:table-cell>

            <xsl:copy-of select="cpm:ditagost.empty_cells($count - 1)"/>

        </xsl:if>

    </xsl:function>


    <!-- 
        Ячейка основной надписи с нужным текстом и нужным выравниванием
    -->
    <xsl:function name="cpm:ditagost.small_cell">

        <xsl:param name="text"/>

        <xsl:param name="text_align"/>

        <fo:table-cell xsl:use-attribute-sets="cpm.ditagost.legend_cell">

            <fo:block xsl:use-attribute-sets="cpm.ditagost.small_block" text-align="{$text_align}">

                <xsl:if test="$text_align = 'left'">
                    <xsl:attribute name="margin-left">
                        <xsl:text>1mm</xsl:text>
                    </xsl:attribute>
                </xsl:if>

                <xsl:value-of select="$text"/>

            </fo:block>

        </fo:table-cell>

    </xsl:function>


    <!-- 
        Объединенная ячейка с нужным текстом и нужным выравниванием 
    -->
    <xsl:function name="cpm:ditagost.spanned_cell">

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

            <fo:block xsl:use-attribute-sets="cpm.ditagost.small_block" text-align="{$text_align}">

                <xsl:if test="$text_align = 'left'">
                    <xsl:attribute name="margin-left">
                        <xsl:text>1mm</xsl:text>
                    </xsl:attribute>
                </xsl:if>

                <xsl:value-of select="$text"/>

            </fo:block>

        </fo:table-cell>

    </xsl:function>


    <!-- 
        Объединенная ячейка с нужным текстом
    -->

    <xsl:template name="cpm.ditagost.large_cell">

        <xsl:param name="content"/>

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

                <xsl:copy-of select="$content"/>

            </fo:block>

        </fo:table-cell>

    </xsl:template>

    <xsl:function name="cpm:ditagost.large_cell">

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

                <xsl:value-of select="$text"/>

            </fo:block>

        </fo:table-cell>

    </xsl:function>


    <!-- 
        Типичная строка основной надписи
    -->
    <xsl:template name="cpm.ditagost.legend_row">

        <xsl:param name="content"/>

        <fo:table-row xsl:use-attribute-sets="cpm.ditagost.legend_row">
            <xsl:copy-of select="$content"/>
        </fo:table-row>

    </xsl:template>



    <!-- ========================== -->
    <!--  Рамки и основные надписи  -->
    <!-- ========================== -->

    <!-- 
        Sidebar vertical fields
    -->
    <xsl:template name="cpm.ditagost.eskd.sidebar">

        <fo:block-container reference-orientation="90" absolute-position="absolute" left="8.5mm"
            overflow="visible">
            <fo:table font-family="GOST type B" font-size="9pt">
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell width="5mm" text-align="center" overflow="visible">
                            <fo:block/>
                        </fo:table-cell>
                        <fo:table-cell width="25mm" text-align="center" overflow="visible">
                            <fo:block>Инв № подл.</fo:block>
                        </fo:table-cell>
                        <fo:table-cell width="35mm" text-align="center" overflow="visible">
                            <fo:block>Подп. и дата</fo:block>
                        </fo:table-cell>
                        <fo:table-cell width="25mm" text-align="center" overflow="visible">
                            <fo:block>Взамен инв. №</fo:block>
                        </fo:table-cell>
                        <fo:table-cell width="25mm" text-align="center" overflow="visible">
                            <fo:block>Инв № дубл.</fo:block>
                        </fo:table-cell>
                        <fo:table-cell width="35mm" text-align="center" overflow="visible">
                            <fo:block>Подп. и дата</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>

        </fo:block-container>

    </xsl:template>


    <!-- 
        Титульный лист (всегда A4 портрет)
    -->

    <!-- Рамка -->
    <xsl:template name="cpm.ditagost.eskd.cover_borders">

        <xsl:variable name="frame_relative_uri">
            <xsl:value-of select="cpm:ditagost.borders_uri()"/>
            <xsl:text>ESKD-A4P-Title.svg</xsl:text>
        </xsl:variable>

        <xsl:variable name="frame_uri">
            <xsl:value-of select="document-uri(document($frame_relative_uri))"/>
        </xsl:variable>

        <fo:block-container xsl:use-attribute-sets="cpm.ditagost.espd.A4p_bc">

            <fo:block>
                <fo:external-graphic xsl:use-attribute-sets="cpm.ditagost.espd.A4p">

                    <xsl:attribute name="src">
                        <xsl:value-of select="$frame_uri"/>
                    </xsl:attribute>

                </fo:external-graphic>
            </fo:block>

        </fo:block-container>

    </xsl:template>

    <!-- Интегратор -->
    <xsl:template name="cpm.ditagost.eskd.cover_static">
        <xsl:call-template name="cpm.ditagost.eskd.cover_borders"/>
        <xsl:call-template name="cpm.ditagost.eskd.sidebar"/>
    </xsl:template>


    <!-- 
        Assembling a cover page footer
    -->
    <xsl:template name="cover_footer">

        <!-- Year -->

        <xsl:variable name="footer">
            <fo:block>
                <xsl:value-of select="cpm:ditagost.year()"/>
            </fo:block>
        </xsl:variable>
        
        <xsl:apply-templates select="$footer/*" mode="foxml"/>

    </xsl:template>


    <!-- 
        Первый лист оглавления (всегда A4 портрет)
    -->

    <!-- Основные надписи -->
    <xsl:template name="cpm.ditagost.eskd.toc_first_legend">

        <xsl:param name="frontmatter"/>

        <xsl:variable name="subject">
            <xsl:value-of select="cpm:ditagost.subject()"/>
        </xsl:variable>

        <xsl:variable name="originator">
            <xsl:value-of select="cpm:ditagost.originator()"/>
        </xsl:variable>

        <xsl:variable name="docnumber">
            <xsl:value-of select="cpm:ditagost.docnumber()"/>
        </xsl:variable>

        <!-- Контейнер для подписей -->
        <fo:block-container font-family="GOST type B" position="absolute" width="185mm"
            height="40mm" top="252.5mm" left="20mm">

            <fo:block>

                <fo:table border-style="none" border-width="0pt" width="185mm">

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

                                <fo:table-cell display-align="center" text-align="center">
                                    <fo:block margin-left="1mm" display-align="center"
                                        text-align="center" font-size="8pt">
                                        <fo:page-number/>
                                    </fo:block>
                                </fo:table-cell>

                                <fo:table-cell display-align="center" text-align="center">

                                    <fo:block margin-left="1mm" display-align="center"
                                        text-align="center" font-size="8pt">

                                        <fo:page-number-citation ref-id="cpm.fastcust.last_page"/>

                                    </fo:block>

                                </fo:table-cell>

                            </xsl:with-param>

                        </xsl:call-template>

                        <!-- row 6 -->
                        <xsl:call-template name="cpm.ditagost.legend_row">
                            <xsl:with-param name="content">
                                <xsl:copy-of select="cpm:ditagost.empty_cells(5)"/>
                                <xsl:call-template name="cpm.ditagost.large_cell">
                                    <xsl:with-param name="content">
                                        <xsl:call-template name="logo"/>
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

    <!-- Рамка -->
    <xsl:template name="cpm.ditagost.eskd.toc_first_borders">

        <xsl:variable name="frame_relative_uri">
            <xsl:value-of select="cpm:ditagost.borders_uri()"/>
            <xsl:text>ESKD-A4P-1stPage-F2.svg</xsl:text>
        </xsl:variable>

        <xsl:variable name="frame_uri">
            <xsl:value-of select="document-uri(document($frame_relative_uri))"/>
        </xsl:variable>

        <fo:block-container width="210mm" left="0mm" top="0mm" height="297mm" position="absolute">

            <fo:block>
                <fo:external-graphic width="auto" height="auto" content-width="210mm"
                    content-height="297mm">

                    <xsl:attribute name="src">
                        <xsl:value-of select="$frame_uri"/>
                    </xsl:attribute>

                </fo:external-graphic>
            </fo:block>

        </fo:block-container>

    </xsl:template>

    <!-- Интегратор -->
    <xsl:template name="cpm.ditagost.eskd.toc_first_static">

        <xsl:param name="frontmatter"/>

        <xsl:call-template name="cpm.ditagost.eskd.toc_first_legend">
            <xsl:with-param name="frontmatter" select="$frontmatter"/>
        </xsl:call-template>

        <xsl:call-template name="cpm.ditagost.eskd.toc_first_borders"/>
        <xsl:call-template name="cpm.ditagost.eskd.sidebar"/>

    </xsl:template>


    <!-- 
        Обычный портретный A4
    -->

    <!-- Основные надписи -->
    <xsl:template name="cpm.ditagost.eskd.regular_A4p_legend">

        <xsl:param name="frontmatter"/>

        <fo:block-container font-family="GOST type B" position="absolute" width="185mm"
            height="40mm" top="277.5mm" left="20mm">
            <fo:block>
                <fo:table border-style="none" border-width="0pt" width="185mm">
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


                            <fo:table-cell number-columns-spanned="5" number-rows-spanned="3"
                                display-align="center" text-align="center">
                                <fo:block display-align="center" text-align="center">
                                    <fo:table height="100%">
                                        <fo:table-body>
                                            <fo:table-row diaplay-align="center">
                                                <fo:table-cell>
                                                  <fo:block>
                                                  <xsl:copy-of select="cpm:ditagost.subject()"/>
                                                  </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell>
                                                  <xsl:call-template name="logo"/>
                                                </fo:table-cell>
                                            </fo:table-row>
                                        </fo:table-body>
                                    </fo:table>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell number-rows-spanned="3">
                                <fo:table height="15mm">
                                    <fo:table-body>
                                        <fo:table-row>
                                            <fo:table-cell height="7mm" text-align="center">
                                                <fo:block margin-top="1mm">Лист</fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                        <fo:table-row>
                                            <fo:table-cell height="8mm" text-align="center">
                                                <fo:block margin-top="2mm">
                                                  <fo:page-number/>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </fo:table-body>
                                </fo:table>
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

    <!-- Рамки -->
    <xsl:template name="cpm.ditagost.eskd.regular_A4p_borders">

        <xsl:variable name="frame_relative_uri">
            <xsl:value-of select="cpm:ditagost.borders_uri()"/>
            <xsl:text>ESKD-A4P-Main-F2a.svg</xsl:text>
        </xsl:variable>

        <xsl:variable name="frame_uri">
            <xsl:value-of select="document-uri(document($frame_relative_uri))"/>
        </xsl:variable>

        <fo:block-container width="210mm" left="0mm" top="0mm" height="297mm" position="absolute">
            <fo:block>
                <fo:external-graphic width="auto" height="auto" content-width="210mm"
                    content-height="297mm">

                    <xsl:attribute name="src">
                        <xsl:value-of select="$frame_uri"/>
                    </xsl:attribute>

                </fo:external-graphic>
            </fo:block>
        </fo:block-container>

    </xsl:template>

    <!-- Интегратор -->
    <xsl:template name="cpm.ditagost.eskd.regular_A4p_static">

        <xsl:call-template name="cpm.ditagost.eskd.regular_A4p_legend"/>
        <xsl:call-template name="cpm.ditagost.eskd.regular_A4p_borders"/>
        <xsl:call-template name="cpm.ditagost.eskd.sidebar"/>

    </xsl:template>


    <!-- 
        Обычный альбомный A4
    -->

    <!-- Основные надписи -->
    <xsl:template name="cpm.ditagost.eskd.regular_A4l_legend">

        <xsl:param name="frontmatter"/>

    </xsl:template>

    <!-- Рамки -->
    <xsl:template name="cpm.ditagost.eskd.regular_A4l_borders">

        <xsl:variable name="frame_relative_uri">
            <xsl:value-of select="cpm:ditagost.borders_uri()"/>
            <xsl:text>ESKD-A4L-Main-F2a.svg</xsl:text>
        </xsl:variable>

        <xsl:variable name="frame_uri">
            <xsl:value-of select="document-uri(document($frame_relative_uri))"/>
        </xsl:variable>

        <fo:block-container width="297mm" left="0mm" top="0mm" height="210mm" position="absolute">
            <fo:block>
                <fo:external-graphic width="auto" height="auto" content-width="297mm"
                    content-height="210mm">

                    <xsl:attribute name="src">
                        <xsl:value-of select="$frame_uri"/>
                    </xsl:attribute>

                </fo:external-graphic>
            </fo:block>
        </fo:block-container>

    </xsl:template>

    <!-- Интегратор -->
    <xsl:template name="cpm.ditagost.eskd.regular_A4l_static">

        <xsl:param name="frontmatter"/>

        <xsl:call-template name="cpm.ditagost.eskd.regular_A4l_legend">
            <xsl:with-param name="frontmatter" select="$frontmatter"/>
        </xsl:call-template>

        <xsl:call-template name="cpm.ditagost.eskd.regular_A4l_borders"/>

    </xsl:template>

</xsl:stylesheet>
