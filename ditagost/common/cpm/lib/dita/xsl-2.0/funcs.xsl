<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster   
    
    Level:      Library
    
    Part:       DITA
    Module:     funcs.xsl
    
    Scope:      DITA
    
    Func:       Wrapper functions for DITA queries                  
-->   
<!-- * * ** *** ***** ******** ************* ********************* --> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Working with properties, translit -->
    <xsl:import href="../../common/xsl-2.0/props.xsl"/>


    <!-- ====== -->
    <!--  i18n  -->
    <!-- ====== -->

    <xsl:function name="cpm:dita.lang">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.lang"/>
    </xsl:function>



    <!-- ===================== -->
    <!--  Calculating indexes  -->
    <!-- ===================== -->

    <!-- 
        Calculating an index of element among its siblings by its hashtag
    -->
    <xsl:function name="cpm:dita.index">

        <!-- An element containing a target element-->
        <xsl:param name="parent"/>

        <!-- A list of aliases -->
        <xsl:param name="aliases"/>

        <xsl:choose>

            <xsl:when test="$parent/*[cpm:props.match(., $aliases)]">
                <xsl:variable name="presiblings">
                    <xsl:copy-of
                        select="$parent/*[cpm:props.match(., $aliases)][1]/preceding-sibling::*"/>
                </xsl:variable>
                <xsl:value-of select="count($presiblings/*) + 1"/>
            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="-1"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:function>



    <!-- =========================== -->
    <!--  Detecting element classes  -->
    <!-- =========================== -->

    <xsl:function name="cpm:dita.eclass" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:param name="class"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.eclass">
            <xsl:with-param name="class" select="$class"/>
        </xsl:apply-templates>
    </xsl:function>

    <xsl:function name="cpm:dita.oclass">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.oclass"/>
    </xsl:function>

    <xsl:function name="cpm:dita.sclass">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.sclass"/>
    </xsl:function>



    <!-- ================== -->
    <!--  Detecting topics  -->
    <!-- ================== -->

    <xsl:function name="cpm:dita.is_topic" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_topic"/>
    </xsl:function>

    <xsl:function name="cpm:dita.is_appendix" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_appendix"/>
    </xsl:function>

    <xsl:function name="cpm:dita.is_frontmatter" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_frontmatter"/>
    </xsl:function>

    <xsl:function name="cpm:dita.is_backmatter" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_backmatter"/>
    </xsl:function>

    <xsl:function name="cpm:dita.is_title" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_title"/>
    </xsl:function>



    <!-- ======== -->
    <!--  Tables  -->
    <!-- ======== -->

    <xsl:function name="cpm:dita.in_table" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:value-of select="false()"/>
        <!--
        <xsl:variable name="tmp">
            <xsl:apply-templates select="$element" mode="cpm.dita.in_table"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$tmp castable as xs:boolean">
                <xsl:value-of select="boolean($tmp)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
        -->
    </xsl:function>


</xsl:stylesheet>
