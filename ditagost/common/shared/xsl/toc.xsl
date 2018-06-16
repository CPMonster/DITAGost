<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      Standalone library
        
    Part:       Common
    Module:     toc.xsl
    
    Scope:      DITA, DITA OT
    
    Func:       Assembling TOCs
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Rebuilding DITA elements -->
    <xsl:import href="../../cpm/lib/dita/xsl-2.0/rebuild.xsl"/>

    <!-- TOCs and TONs -->
    <xsl:import href="../../cpm/lib/fastcust/xsl-2.0/tocton.xsl"/>
    
    
    <!-- 
        A wrapper function
    -->
    <xsl:function name="cpm:is_toctopic" as="xs:boolean">        
        <xsl:param name="element"/>        
        <xsl:value-of select="cpm:fastcust.is_toctopic($element)"/>        
    </xsl:function>


    <!-- 
        Providing the level for a TOC topic 
    -->
    <xsl:template match="*[cpm:fastcust.is_toctopic(.)]" mode="level">
        <xsl:value-of select="1"/>
    </xsl:template>


    <!-- 
        Assembling a TOC topic
    -->
    <xsl:template name="toctopic">

        <!-- A TOC scope -->
        <xsl:param name="scope" select="'global'"/>

        <!-- An explicit TOC scope element ID -->
        <xsl:param name="scopeid" select="''"/>

        <!-- 
            Commonly either $scope or $scopeid is to be provided.
        -->

        <!-- A TOC depth -->
        <xsl:param name="maxlevel" select="cpm:fastcust.numinf('')"/>

        <!-- A maximal number of levels in a TOC -->
        <xsl:param name="maxdepth" select="cpm:fastcust.numinf('')"/>

        <!-- 
            Commonly either $maxlevel or $maxdepth is to be provided.
        -->

        <!-- An output class for a TOC topic (for applying styles) -->
        <xsl:param name="outputclass" select="''"/>

        <!-- A title for a TOC topic -->
        <xsl:param name="title" select="''"/>

        <xsl:variable name="topic">

            <concept>

                <title>
                    <xsl:value-of select="$title"/>
                </title>

                <conbody>

                    <xsl:call-template name="cpm.fastcust.toc_placeholder">
                        <xsl:with-param name="scope" select="$scope"/>
                        <xsl:with-param name="scopeid" select="$scopeid"/>
                        <xsl:with-param name="maxlevel" select="$maxlevel"/>
                        <xsl:with-param name="maxdepth" select="$maxdepth"/>
                        <xsl:with-param name="outputclass" select="'toc'"/>
                    </xsl:call-template>

                </conbody>

            </concept>

        </xsl:variable>
        
        <xsl:apply-templates select="$topic/concept" mode="cpm.dita.class"/>

    </xsl:template>


    <!-- 
        Assembling a subordinate TOC topic for an element 
    -->
    <xsl:template match="*" mode="toctopic">

        <!-- 
            * represents a parent element for a TOC topic.
        -->

        <!-- A TOC depth -->
        <xsl:param name="maxlevel" select="cpm:fastcust.numinf('')"/>

        <!-- A maximal number of levels in a TOC -->
        <xsl:param name="maxdepth" select="cpm:fastcust.numinf('')"/>

        <!-- 
            Commonly either $maxlevel or $maxdepth is to be provided.
        -->

        <!-- An output class for a TOC topic (for applying styles) -->
        <xsl:param name="outputclass" select="''"/>

        <!-- A TOC topic title -->
        <xsl:param name="title" select="''"/>

        <!-- Assembling a TOC topic -->
        <xsl:call-template name="toctopic">
            <xsl:with-param name="scopeid" select="cpm:fastcust.id(.)"/>
            <xsl:with-param name="maxlevel" select="$maxlevel"/>
            <xsl:with-param name="maxdepth" select="$maxdepth"/>
            <xsl:with-param name="outputclass" select="$outputclass"/>
            <xsl:with-param name="title" select="$title"/>
        </xsl:call-template>

    </xsl:template>

</xsl:stylesheet>
