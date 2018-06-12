<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      Standalone library
        
    Part:       ESKD  
    Module:     eskd.xsl
    
    Scope:      DITA, DITA OT
    
    Func:       A particular customization (e.g. ESKD borders) 
                imports this file in order to get an the access 
                to appropriate templates and functions
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- FastCust publishing engine -->
    <xsl:import href="../../../lib/fastcust/xsl-2.0/dita.xsl"/>

    <!-- Detecting section types -->
    <xsl:import href="sections.xsl"/>


    <!-- 
        Reassembling a document
    -->
    <xsl:template match="bookmap | map" mode="complete">

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
    
    
    <!-- 
        Formatting a ESKD-style note 
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
