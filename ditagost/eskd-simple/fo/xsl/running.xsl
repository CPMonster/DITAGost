<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      DITA OT Customization
        
    Part:       A common document with no ESKD border     
    Module:     running.xsl
    
    Scope:      DITA, DITA OT, Russian, ESKD
    
    Func:       Assembling headers and footers
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->    
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="cpm" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Paths & URIs -->
    <xsl:import href="../../../lib/common/xsl-2.0/pathuri.xsl"/>

    <!-- Default layout settings -->
    <xsl:import href="../../../common/xsl/settings.xsl"/>

    <!-- Retrieving document parameters -->
    <xsl:import href="../../../common/xsl/docparams.xsl"/>



    <!-- ===================================== -->
    <!--  Working with a layout configuration  -->
    <!-- ===================================== -->

    <!-- 
        Assembling a base URI for layout images
    -->

    <!-- A default template -->
    <xsl:template name="layout_image_uri">

        <xsl:variable name="base">
            <xsl:value-of select="cpm:pathuri.folder(base-uri(document('running.xsl')))"/>
        </xsl:variable>

        <xsl:value-of select="cpm:pathuri.join_uri($base, 'images')"/>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:layout_image_uri">
        <xsl:call-template name="layout_image_uri"/>
    </xsl:function>



    <!-- ======================================== -->
    <!--  A header and a footer for a cover page  -->
    <!-- ======================================== -->

    <!-- 
        Assembling a cover page header
    -->
    <xsl:template name="cover_header">
        <fo:block/>        
    </xsl:template>


    <!-- 
        Assembling a cover page footer
    -->
    <xsl:template name="cover_footer">

        <!-- Assembling footer content for a cover page -->
        <xsl:variable name="footer_content">
            <p outputclass="cover.year">
                <xsl:value-of select="cpm:ditagost.year()"/>
            </p>
        </xsl:variable>

        <!-- Assembling FO for cover page static content -->
        <xsl:apply-templates select="$footer_content/*" mode="foxml"/>

    </xsl:template>



    <!-- ============================ -->
    <!--  A regular portrait A4 page  -->
    <!-- ============================ -->

    <!-- 
        Assembling a regulsr header
    -->

    <xsl:template name="A4_portrait_header">

        <xsl:variable name="subject">
            <xsl:value-of select="cpm:ditagost.subject()"/>
        </xsl:variable>

        <xsl:variable name="originator">
            <xsl:value-of select="cpm:ditagost.originator()"/>
        </xsl:variable>

        <xsl:variable name="docnumber">
            <xsl:value-of select="cpm:ditagost.docnumber()"/>
        </xsl:variable>

        <xsl:variable name="header">
            <fo:block>
                <fo:table>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block text-align="right" width="20%"/>
                            </fo:table-cell>
                            <fo:table-cell text-align="right">
                                <fo:block role="header_pagenumber">
                                    <fo:block text-align="center" margin-top="0.8cm">
                                        <fo:inline>
                                            <fo:page-number/>
                                        </fo:inline>
                                    </fo:block>
                                    <fo:block text-align="center">
                                        <xsl:value-of select="$docnumber"/>
                                    </fo:block>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block text-align="right" width="20%"/>                                    
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </xsl:variable>
        
        <xsl:apply-templates select="$header/*" mode="foxml"/>

    </xsl:template>


    <!-- 
        Assembling a regular footer
    -->
    <xsl:template name="A4_portrait_footer">

        <!--
        <xsl:param name="cfg"/>

        <xsl:param name="docparams"/>
        -->

        <fo:block/>

        <!-- There is no footer in this layout -->

    </xsl:template>



    <!-- ============================= -->
    <!--  A regular landscape A4 page  -->
    <!-- ============================= -->

    <!-- 
        Assembling a header
    -->
    <xsl:template name="A4_landscape_header">
        <!--
        <xsl:param name="cfg"/>

        <xsl:param name="docparams"/>
        -->
    </xsl:template>


    <!-- 
        Assembling a footer
    -->
    <xsl:template name="A4_landscape_footer">

        <!--
        <xsl:param name="cfg"/>

        <xsl:param name="docparams"/>
        -->

        <xsl:variable name="subject">
            <xsl:value-of select="cpm:ditagost.subject()"/>
        </xsl:variable>

        <xsl:value-of select="$subject"/>

    </xsl:template>

</xsl:stylesheet>
