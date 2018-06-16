<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster   
    
    Level:      Library
    
    Part:       DITA library
    Module:     rebuild.xsl
    
    Scope:      DITA
    
    Func:       Rebuilding DITA content                  
-->   
<!-- * * ** *** ***** ******** ************* ********************* --> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Assembling class values
    -->

    <!-- A default @class value is empty -->
    <xsl:template match="*" mode="cpm.dita.class_value"/>

    <!-- Explicit values -->

    <xsl:template match="concept" mode="cpm.dita.class_value">
        <xsl:text>- topic/topic concept/concept</xsl:text>
    </xsl:template>

    <xsl:template match="topic/title" mode="cpm.dita.class_value">
        <xsl:text>- topic/title</xsl:text>
    </xsl:template>

    <xsl:template match="concept/title" mode="cpm.dita.class_value">
        <xsl:text>- topic/title</xsl:text>
    </xsl:template>

    <xsl:template match="task/title" mode="cpm.dita.class_value">
        <xsl:text>- topic/title</xsl:text>
    </xsl:template>

    <xsl:template match="reference/title" mode="cpm.dita.class_value">
        <xsl:text>- topic/title</xsl:text>
    </xsl:template>

    <xsl:template match="conbody" mode="cpm.dita.class_value">
        <xsl:text>- topic/body concept/conbody</xsl:text>
    </xsl:template>

    <xsl:template match="table" mode="cpm.dita.class_value">
        <xsl:text>- topic/table</xsl:text>
    </xsl:template>

    <xsl:template match="tgroup" mode="cpm.dita.class_value">
        <xsl:text>- topic/tgroup</xsl:text>
    </xsl:template>

    <xsl:template match="colspec" mode="cpm.dita.class_value">
        <xsl:text>- topic/colspec</xsl:text>
    </xsl:template>

    <xsl:template match="thead" mode="cpm.dita.class_value">
        <xsl:text>- topic/thead</xsl:text>
    </xsl:template>

    <xsl:template match="tbody" mode="cpm.dita.class_value">
        <xsl:text>- topic/tbody</xsl:text>
    </xsl:template>

    <xsl:template match="tfoot" mode="cpm.dita.class_value">
        <xsl:text>- topic/tfoot</xsl:text>
    </xsl:template>

    <xsl:template match="row" mode="cpm.dita.class_value">
        <xsl:text>- topic/row</xsl:text>
    </xsl:template>

    <xsl:template match="entry" mode="cpm.dita.class_value">
        <xsl:text>- topic/entry</xsl:text>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:dita.class_value">

        <!-- A DITA element -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp1">
            <xsl:apply-templates select="$element" mode="cpm.dita.class_value"/>
        </xsl:variable>

        <xsl:variable name="tmp2">
            <xsl:value-of select="normalize-space($tmp1)"/>
        </xsl:variable>

        <xsl:if test="$tmp2 != ''">
            <xsl:value-of select="$tmp2"/>
            <xsl:text>&#32;</xsl:text>
        </xsl:if>

    </xsl:function>


    <!-- 
        Skipping elements that have some @class already
    -->
    <xsl:template match="*[@class]" mode="cpm.dita.class_attr"/>


    <!-- 
        Assembling a @class attribute for an element 
    -->
    <xsl:template match="*[not(@class)]" mode="cpm.dita.class_attr">

        <xsl:variable name="tmp">
            <xsl:value-of select="cpm:dita.class_value(.)"/>
        </xsl:variable>

        <xsl:if test="$tmp != ''">
            <xsl:attribute name="class">
                <xsl:value-of select="$tmp"/>
            </xsl:attribute>
        </xsl:if>

    </xsl:template>


    <!-- 
        Assigning class attribute to an element
    -->
    <xsl:template match="node() | @*" mode="cpm.dita.class">

        <xsl:copy>            
            <xsl:apply-templates select="." mode="cpm.dita.class_attr"/>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>

    </xsl:template>

</xsl:stylesheet>
