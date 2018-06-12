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

    <!-- A ESKD TOC -->
    <xsl:import href="../../../common/xsl/toc.xsl"/>

    <!-- ESKD tables of figures, tables, etc. -->
    <xsl:import href="../../../common/xsl/ton.xsl"/>

    <!-- Working with signatures -->
    <xsl:import href="../../../common/xsl/signatures.xsl"/>

    <!-- Working with introduction topics -->
    <xsl:import href="../../../common/xsl/intro.xsl"/>

    <!-- Working with topics that belong to a main part of a document -->
    <xsl:import href="../../../common/xsl/regular.xsl"/>

    <!-- Working with appendices -->
    <xsl:import href="appendix.xsl"/>

    <!-- Working with tables of named objects -->
    <xsl:import href="../../../common/xsl/ton.xsl"/>

    <!-- A final useless page -->
    <xsl:import href="../../../common/xsl/listregizm.xsl"/>


    <!-- 
        Detecting a section type
    -->
    <xsl:template match="*" mode="sectype">

        <xsl:choose>
            <xsl:when test="cpm:is_signatures(.)">
                <xsl:text>signatures</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:fastcust.is_toctopic(.)">
                <xsl:text>toctopic</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:fastcust.is_auxiliary(.)">
                <xsl:text>auxiliary</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_slacking(.)">
                <xsl:text>slacking</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_intro(.)">
                <xsl:text>intro</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_main(.)">
                <xsl:text>main</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:fastcust.is_tontopic(.)">
                <xsl:text>tontopic</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_appendix(.)">
                <xsl:text>appendix</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_listregizm(.)">
                <xsl:text>listregizm</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>other</xsl:text>
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

    <!-- Excluding signatures from a TOC -->
    <xsl:template match="*[cpm:is_signatures(.)]" mode="is_tocmamber" as="xs:boolean">
        <xsl:value-of select="false()"/>
    </xsl:template>


    <!-- 
        A TOC
    -->

    <!-- Including a TOC to a document -->
    <xsl:template match="*[cpm:fastcust.is_toctopic(.)]" mode="level">
        <xsl:value-of select="1"/>
    </xsl:template>

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

    <!-- Selecting a page sequence for a regular topic -->
    <xsl:template match="*[cpm:is_main(.)]" mode="sequence">

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

    <!-- Including a final useless page into a document -->
    <xsl:template match="*[cpm:is_listregizm(.)]" mode="level">
        <xsl:value-of select="1"/>
    </xsl:template>

    <!-- Selecting a page sequence for a final useless page -->
    <xsl:template match="*[cpm:is_listregizm(.)]" mode="sequence">
        <xsl:text>ESKD.Content.Portrait</xsl:text>
    </xsl:template>

    <!-- Excluding a final useless page from a TOC -->
    <xsl:template match="*[cpm:is_listregizm(.)]" mode="is_tocmamber" as="xs:boolean">
        <xsl:value-of select="false()"/>
    </xsl:template>


</xsl:stylesheet>
