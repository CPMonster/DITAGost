<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      Standalone library
        
    Part:       ESKD    
    Module:     sections.xsl
    
    Scope:      DITA, DITA OT
    
    Func:       Assigning levels, page sequences, etc. to sections
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->    
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- FustCust wrapper functions -->
    <xsl:import href="../../../lib/fastcust/xsl-2.0/funcs.xsl"/>

    <!-- A ESKD cover page -->
    <xsl:import href="cover.xsl"/>

    <!-- Detecting resource topics -->
    <xsl:import href="../../../common/xsl/resource.xsl"/>

    <!-- Working with slacking text -->
    <xsl:import href="../../../common/xsl/slacking.xsl"/>

    <!-- A ESKD TOC -->
    <xsl:import href="../../../common/xsl/toc.xsl"/>

    <!-- Auxiliary topics -->
    <xsl:import href="../../../common/xsl/auxiliary.xsl"/>

    <!-- ESKD tables of figures, tables, etc. -->
    <xsl:import href="../../../common/xsl/ton.xsl"/>

    <!-- Working with signatures -->
    <xsl:import href="../../../common/xsl/signatures.xsl"/>

    <!-- Working with introduction topics -->
    <xsl:import href="../../../common/xsl/intro.xsl"/>

    <!-- Working with tables of named objects -->
    <xsl:import href="../../../common/xsl/ton.xsl"/>

    <!-- Working with appendices -->
    <xsl:import href="appendix.xsl"/>

    <!-- A final useless page -->
    <xsl:import href="../../../common/xsl/listregizm.xsl"/>


    <!-- 
        Detecting a section type
    -->
    <xsl:template match="*" mode="sectype">

        <xsl:choose>
            <xsl:when test="cpm:is_cover(.)">
                <xsl:text>cover</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_signatures(.)">
                <xsl:text>signatures</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_toctopic(.)">
                <xsl:text>toctopic</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_auxiliary(.)">
                <xsl:text>auxiliary</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_slacking(.)">
                <xsl:text>slacking</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_intro(.)">
                <xsl:text>intro</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_tontopic(.)">
                <xsl:text>tontopic</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_appendix(.)">
                <xsl:text>appendix</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_listregizm(.)">
                <xsl:text>listregizm</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>main</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 
        A cover page 
    -->

    <!-- Including a cover page into a document -->
    <xsl:template match="cpm:cover" mode="level">
        <xsl:value-of select="1"/>
    </xsl:template>

    <!-- Selecting a page sequence for a cover page -->
    <xsl:template match="cpm:cover" mode="sequence">
        <xsl:text>ESKD.Cover</xsl:text>
    </xsl:template>

    <!-- Excluding a cover page form a TOC -->
    <xsl:template match="cpm:cover" mode="is_tocmamber" as="xs:boolean">
        <xsl:value-of select="false()"/>
    </xsl:template>


    <!-- 
        A list of signatures 
    -->

    <!-- Excluding signatures from a document -->
    <xsl:template match="*[cpm:is_signatures(.)]" mode="level">
        <xsl:value-of select="-1"/>
    </xsl:template>
    

    <!-- 
        A TOC
    -->

    <!-- Including a TOC to a document -->
    <xsl:template match="*[cpm:fastcust.is_toctopic(.)]" mode="sequence">
        <xsl:text>ESKD.Content.Portrait</xsl:text>
    </xsl:template>

    <!-- Excluding a TOC from a TOC -->
    <xsl:template match="*[cpm:fastcust.is_toctopic(.)]" mode="is_tocmamber" as="xs:boolean">
        <xsl:value-of select="false()"/>
    </xsl:template>


    <!-- 
        Slacking text
    -->

    <!-- Excluding slacking text from a TOC -->
    <xsl:template match="*[cpm:is_slacking(.)]" mode="is_tocmamber" as="xs:boolean">
        <xsl:value-of select="false()"/>
    </xsl:template>


    <!-- 
        Regular topics
    -->

    <!-- Detecting regular topics -->
    <xsl:function name="cpm:is_regular" as="xs:boolean">
        
        <xsl:param name="element"/>
        
        <xsl:choose>
            <xsl:when test="cpm:is_cover($element)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:when test="cpm:is_toctopic($element)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="true()"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:function>

    <!-- Detecting a main part topics -->
    <xsl:function name="cpm:is_main" as="xs:boolean">

        <!-- An element representing a section -->
        <xsl:param name="element"/>

        <xsl:value-of select="cpm:sectype($element) = 'main'"/>

    </xsl:function>

    <!-- Selecting a page sequence for a regular topic -->
    <xsl:template match="*[cpm:is_regular(.)]" mode="sequence">

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
        A final useless page    
    -->    

    <!-- Excluding a final useless page from a TOC -->
    <xsl:template match="*[cpm:is_listregizm(.)]" mode="is_tocmamber" as="xs:boolean">
        <xsl:value-of select="false()"/>
    </xsl:template>


</xsl:stylesheet>
