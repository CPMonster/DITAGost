<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      DITA OT customization shared files
        
    Part:       Common shared files  
    Module:     regular.xsl
    
    Scope:      DITA, DITA OT, Russian
    
    Func:       Working with topics that belong to a main part
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Introduction topics -->
    <xsl:import href="intro.xsl"/>

    <!-- Appendices -->
    <xsl:import href="appendix.xsl"/>

    <xsl:template match="*" mode="is_slacking">
                
        <xsl:variable name="supreor_title">            
            <xsl:value-of select="normalize-space(ancestor::*[cpm:is_section(.)][1]/title)"/>                       
        </xsl:variable>
        
        <xsl:choose>            
            <xsl:when test="$supreor_title = normalize-space(title)">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>
    
    
    <xsl:function name="cpm:is_slacking" as="xs:boolean">
        
        <!-- An element representing a section -->
        <xsl:param name="element"/>
        
        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="exists($element)">
                    <xsl:apply-templates select="$element" mode="is_slacking"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:value-of select="boolean($tmp)"/>
        
    </xsl:function>
    
    
    
    
    <xsl:template match="*[contains(title, 'Перечень')]" mode="is_tontopic" as="xs:boolean">
                
        <xsl:choose>
            <xsl:when test="title = 'Перечень сокращений'">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:when test="title = 'Перечень терминов'">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:when test="title = 'Перечень таблиц'">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:when test="title = 'Перечень рисунков'">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:when test="title = 'Перечень приложений'">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>


    <!-- 
        Detecting a regular topic
    -->
    <xsl:function name="cpm:is_main" as="xs:boolean">

        <!-- An element representing a section -->
        <xsl:param name="element"/>

        <xsl:choose>
            <xsl:when test="cpm:is_intro($element)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:when test="cpm:is_appendix($element)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:when test="cpm:is_slacking($element)">
                <xsl:value-of select="false()"/>
            </xsl:when>            
            <xsl:when test="cpm:fastcust.is_toctopic($element)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:when test="cpm:fastcust.is_tontopic($element)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:when test="cpm:is_listregizm($element)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="true()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>

</xsl:stylesheet>
