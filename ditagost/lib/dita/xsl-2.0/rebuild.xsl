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
    <xsl:template match="*" mode="cmp.dita.class_value"/>

    <!-- Explicit values -->

    <xsl:template match="concept" mode="cmp.dita.class_value">
        <xsl:text>- topic/topic concept/concept</xsl:text>
    </xsl:template>

    <xsl:template match="topic/title" mode="cmp.dita.class_value">
        <xsl:text>- topic/title</xsl:text>
    </xsl:template>

    <xsl:template match="concept/title" mode="cmp.dita.class_value">
        <xsl:text>- topic/title</xsl:text>
    </xsl:template>

    <xsl:template match="task/title" mode="cmp.dita.class_value">
        <xsl:text>- topic/title</xsl:text>
    </xsl:template>

    <xsl:template match="reference/title" mode="cmp.dita.class_value">
        <xsl:text>- topic/title</xsl:text>
    </xsl:template>

    <xsl:template match="conbody" mode="cmp.dita.class_value">
        <xsl:text>- topic/body concept/conbody</xsl:text>
    </xsl:template>

    <xsl:template match="entry" mode="cmp.dita.class_value">
        <xsl:text>- topic/entry</xsl:text>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:dita.class_value">

        <!-- A DITA element -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp">
            <xsl:apply-templates select="$element" mode="cmp.dita.class_value"/>
        </xsl:variable>

        <xsl:if test="$tmp != ''">
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
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:apply-templates select="." mode="cmp.dita.class_attr"/>            
            <xsl:apply-templates select="node()" mode="#current"/>
        </xsl:copy>

    </xsl:template>

</xsl:stylesheet>
