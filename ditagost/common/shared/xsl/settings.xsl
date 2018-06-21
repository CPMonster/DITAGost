<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Products:   DITA GOST    
    
    Level:      Standalone library
    
    Part:       Common shared files
    Module:     settings.xsl
    
    Scope:      DITA, DITA OT
    
    Func:       Retrieving default layout settings
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Working with properties -->
    <xsl:import href="../../cpm/lib/common/xsl-2.0/props.xsl"/>


    <!-- 
        Defining a global variables 
    -->
    
    <!-- Default global DITA GOST settings -->
    <xsl:variable name="cpm.ditagost.GLOBAL_DEFAULT_SETTINGS">
        <record name="settings">
            <property name="name" value="Docset Captions"/>
            <property name="originator" value="Company;Originator;Организация;Производитель"/>
            <property name="subject" value="Product;Изделие;Продукт;Предмет"/>
            <property name="genre" value="Genre;Жанр;Документ;Тип документа"/>
            <property name="refcode" value="Reference code;Шифр;Шифр темы"/>
            <property name="docnumber" value="Document number;Part number;Обозначение"/>
            <property name="year" value="Year;Год;Год выпуска"/>
        </record>
    </xsl:variable>
        
    <!-- Actual global DITA GOST settings -->
    <xsl:variable name="cpm.ditagost.GLOBAL_SETTINGS">
        <xsl:call-template name="cpm.ditagost.load_global_settings"/>
    </xsl:variable>
    
    
    <!-- 
        A default font family
    -->
    <xsl:function name="cpm:ditagost.default_font_family">
        <xsl:text>Times New Roman</xsl:text>
    </xsl:function>


    <!-- 
        Assembling an URI for a settings file (dummy)
    -->
    <xsl:template match="node()" mode="global_settings_uri"/>


    <!-- 
        Retrieving settings from a file when URI is provided      
    -->
    <xsl:template match="node()" mode="global_settings">

        <xsl:variable name="settings_uri">
            <xsl:apply-templates select="." mode="global_settings_uri"/>
        </xsl:variable>

        <xsl:if test="$settings_uri != ''">
            <xsl:copy-of select="document($settings_uri)"/>
        </xsl:if>

    </xsl:template>


    <!-- 
        Retrieving general settings without fail
    -->
    <xsl:template name="cpm.ditagost.load_global_settings">

        <xsl:variable name="settings">
            <xsl:apply-templates select="/" mode="global_settings"/>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$settings != ''">
                <xsl:copy-of select="$settings"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="$cpm.ditagost.GLOBAL_DEFAULT_SETTINGS"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 
        Retrieving a list of docparam aliases
    -->
    <xsl:function name="cpm:ditagost.docparam_aliases">

        <xsl:param name="docparam_name"/>

        <xsl:value-of
            select="
                cpm:props.get($cpm.ditagost.GLOBAL_SETTINGS,
                'settings', 'name', 'Docset Captions', $docparam_name)"/>

    </xsl:function>

</xsl:stylesheet>
