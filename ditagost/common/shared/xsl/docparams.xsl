<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST  
   
    Level:      Standalone library
    
    Part:       Common     
    Module:     docparams.xsl 
    
    Scope:      DITA
    
    Func:       Retrieving document parameters specific for GOST 
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- FastCust docparams module -->
    <xsl:import href="../../cpm/lib/fastcust/xsl-2.0/docparams.xsl"/>

    <!-- Loading global settings -->
    <xsl:import href="settings.xsl"/>


    <!-- 
        Retrieving a docparam value by a property name
    -->
    <xsl:function name="cpm:ditagost.docparam">

        <!-- Property name; see settings.xsl -->
        <xsl:param name="name"/>

        <xsl:variable name="docparam_aliases">
            <xsl:value-of select="cpm:ditagost.docparam_aliases($name)"/>
        </xsl:variable>

        <xsl:value-of select="cpm:fastcust.docparam($docparam_aliases)"/>

    </xsl:function>


    <!-- 
        A document originator
    -->
    <xsl:function name="cpm:ditagost.originator">
        <xsl:value-of select="cpm:ditagost.docparam('originator')"/>
    </xsl:function>


    <!-- 
        A product name
    -->
    <xsl:function name="cpm:ditagost.subject">
        <xsl:value-of select="cpm:ditagost.docparam('subject')"/>
    </xsl:function>


    <!-- 
        A product refcode
    -->
    <xsl:function name="cpm:ditagost.refcode">
        <xsl:value-of select="cpm:ditagost.docparam('refcode')"/>
    </xsl:function>


    <!-- 
        A document genre
    -->
    <xsl:function name="cpm:ditagost.genre">
        <xsl:value-of select="cpm:ditagost.docparam('genre')"/>
    </xsl:function>


    <!-- 
        A document partnumber
    -->
    <xsl:function name="cpm:ditagost.docnumber">
        <xsl:value-of select="cpm:ditagost.docparam('docnumber')"/>
    </xsl:function>


    <!-- 
        A document year
    -->
    <xsl:function name="cpm:ditagost.year">
        <xsl:value-of select="cpm:ditagost.docparam('year')"/>
        <xsl:message>
            <xsl:copy-of select="$cpm.ditagost.GLOBAL_SETTINGS"/>
        </xsl:message>
    </xsl:function>


    <!-- 
        A picture for a cover page
    -->
    <xsl:function name="cpm:ditagost.cover">

        <xsl:variable name="docparams">
            <xsl:copy-of select="$cpm.fastcust.GLOBAL_CFG//docparams/*"/>
        </xsl:variable>

        <xsl:variable name="image">
            <xsl:apply-templates select="$docparams" mode="cpm.fastcust.docparam">
                <xsl:with-param name="names" select="'Обложка'"/>
            </xsl:apply-templates>
        </xsl:variable>

        <xsl:value-of select="$image//image/@href"/>

    </xsl:function>


    <!-- 
        Detecting a topic containing a docparams table
    -->
    
    <!-- A working template -->
    <xsl:template match="*" mode="is_docparams" as="xs:boolean">

        <xsl:choose>
            <xsl:when test=".//table[cpm:fastcust.is_docparams($cpm.fastcust.GLOBAL_CFG, .)]">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
                
    </xsl:template>
    
    <!-- A wrapper function -->
    <xsl:function name="cpm:is_docparams" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_docparams"/>
    </xsl:function>
    
    
    <!-- 
        Excluding docparams topics from a TOC 
    -->
    <xsl:template match="*[cpm:is_docparams(.)]" mode="is_resource" as="xs:boolean">        
        <xsl:value-of select="true()"/>        
    </xsl:template>

</xsl:stylesheet>
