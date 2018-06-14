<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      Standalone library
        
    Part:       ESKD  
    Module:     cover.xsl
    
    Scope:      DITA, DITA OT, ESKD
    
    Func:       Assembling cover pages for ESKD documents
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->    
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Accessing document parameters -->
    <xsl:import href="../../../common/xsl/docparams.xsl"/>

    <!-- Common templates and functions for cover pages -->
    <xsl:import href="../../../common/xsl/cover.xsl"/>


    <!-- 
        Assembling content for a cover page
    -->
    <xsl:template name="cover">

        <cpm:cover>

            <!-- Approved -->
            <p outputclass="cover.approved">
                <xsl:text>УТВЕРЖДЕН</xsl:text>
            </p>

            <!-- LU -->
            <p outputclass="cover.LU">
                <xsl:value-of select="cpm:ditagost.docnumber()"/>
                <xsl:text>-ЛУ</xsl:text>
            </p>

            <!-- A document title -->
            <p outputclass="cover.title">
                <xsl:value-of select="cpm:ditagost.subject()"/>
            </p>

            <!-- A document subtitle -->
            <p outputclass="cover.subtitle">
                <xsl:value-of select="cpm:ditagost.genre()"/>
            </p>

            <!-- A document partnumber -->
            <p outputclass="cover.docnumber">
                <xsl:value-of select="cpm:ditagost.docnumber()"/>
            </p>

            <!-- A number of pages -->
            <p outputclass="cover.pages">
                <xsl:text>На </xsl:text>
                <fo:page-number-citation ref-id="cpm.fastcust.last_page"/>
                <xsl:text> листах</xsl:text>
            </p>

        </cpm:cover>

    </xsl:template>


    <!-- 
        Detecting a cover page
    -->
    <xsl:function name="cpm:is_cover" as="xs:boolean">

        <!-- An element of a document after the "complete" stage -->
        <xsl:param name="element"/>

        <xsl:choose>
            <xsl:when test="name($element) = 'cpm:cover'">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>


</xsl:stylesheet>
