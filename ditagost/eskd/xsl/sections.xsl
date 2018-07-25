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
    <xsl:import href="../../common/cpm/lib/fastcust/xsl-2.0/funcs.xsl"/>

    <!-- A ESKD cover page -->
    <xsl:import href="cover.xsl"/>

    <!-- Detecting resource topics -->
    <xsl:import href="../../common/shared/xsl/resource.xsl"/>

    <!-- Working with slacking text -->
    <xsl:import href="../../common/shared/xsl/slacking.xsl"/>

    <!-- A ESKD TOC -->
    <xsl:import href="../../common/shared/xsl/toc.xsl"/>

    <!-- Auxiliary topics -->
    <xsl:import href="../../common/shared/xsl/auxiliary.xsl"/>

    <!-- ESKD tables of figures, tables, etc. -->
    <xsl:import href="../../common/shared/xsl/ton.xsl"/>

    <!-- Working with signatures -->
    <xsl:import href="../../common/shared/xsl/signatures.xsl"/>

    <!-- Working with introduction topics -->
    <xsl:import href="../../common/shared/xsl/intro.xsl"/>

    <!-- Working with tables of named objects -->
    <xsl:import href="../../common/shared/xsl/ton.xsl"/>

    <!-- Working with appendices -->
    <xsl:import href="appendix.xsl"/>

    <!-- A final useless page -->
    <xsl:import href="../../common/shared/xsl/listregizm.xsl"/>


    <!-- 
        Detecting a section type specific for GOST
    -->
    <xsl:template match="*" mode="sectype">

        <!-- Detecting a standard FastCust section type -->
        <xsl:variable name="sectype">
            <xsl:value-of select="cpm:fastcust.sectype(.)"/>
        </xsl:variable>

        <xsl:choose>

            <!-- Returning a sepcific section type -->
            <xsl:when test="$sectype != 'main'">
                <xsl:value-of select="$sectype"/>
            </xsl:when>

            <!-- Qualifying the main section type -->
            <xsl:otherwise>

                <xsl:choose>

                    <!-- A list of signatures -->
                    <xsl:when test="cpm:is_signatures(.)">
                        <xsl:text>signatures</xsl:text>
                    </xsl:when>

                    <!-- Introduction topics -->
                    <xsl:when test="cpm:is_intro(.)">
                        <xsl:text>intro</xsl:text>
                    </xsl:when>

                    <!-- A fimal useless page -->
                    <xsl:when test="cpm:is_listregizm(.)">
                        <xsl:text>listregizm</xsl:text>
                    </xsl:when>

                    <!-- Main topics -->
                    <xsl:otherwise>
                        <xsl:text>main</xsl:text>
                    </xsl:otherwise>

                </xsl:choose>

            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>



    <!-- 
        A cover page 
    -->

    <!-- Including a cover page into a document -->
    <xsl:template match="*[cpm:sectype(.) = 'cover']" mode="level">
        <xsl:value-of select="1"/>
    </xsl:template>

    <!-- Selecting a page sequence for a cover page -->
    <xsl:template match="*[cpm:sectype(.) = 'cover']" mode="sequence">
        <xsl:text>ESKD.Cover</xsl:text>
    </xsl:template>


    <!-- 
        Regular (main and some other) topics
    -->

    <!-- Detecting regular topics (a template) -->
    <xsl:template match="*" mode="is_regular" as="xs:boolean">
       
        <xsl:choose>
            
            <!-- A cover page is not regular -->
            <xsl:when test="cpm:is_cover(.)">
                <xsl:value-of select="false()"/>
            </xsl:when>                        
            
            <!-- Other topics are regular -->
            <xsl:otherwise>
                <xsl:value-of select="true()"/>
            </xsl:otherwise>
            
        </xsl:choose>        

    </xsl:template>
    
    <!-- A wrapper function -->
    <xsl:function name="cpm:is_regular" as="xs:boolean">
        
        <xsl:param name="element"/>
        
        <xsl:apply-templates select="$element" mode="is_regular"/>
        
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
