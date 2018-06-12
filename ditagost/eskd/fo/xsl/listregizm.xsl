<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      Standalone library
        
    Part:       ESKD  
    Module:     listregizm.xsl
    
    Scope:      DITA, DITA OT
    
    Func:       Assembling a final useless page
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Rebuilding DITA elements -->
    <xsl:import href="../../../lib/dita/xsl-2.0/rebuild.xsl"/>


    <!-- 
        Detecting a topic containing a final useless page
    -->
    <xsl:function name="cpm:is_listregizm" as="xs:boolean">

        <xsl:param name="element"/>

        <xsl:choose>
            <xsl:when test="$element/@id = 'listregizm'">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>


    <xsl:template match="*[cpm:is_listregizm(.)]" mode="level">
        <xsl:value-of select="1"/>
    </xsl:template>

    <xsl:template match="*[cpm:is_listregizm(.)]" mode="sequence">
        <xsl:text>ESKD.Content.Portrait</xsl:text>
    </xsl:template>

    <!-- 
        Excluding a final useless page from a TOC
    -->
    <xsl:template match="*[cpm:is_listregizm(.)]" mode="is_tocmamber" as="xs:boolean">
        <xsl:value-of select="false()"/>
    </xsl:template>


    <!-- 
        Assembling header rows
    -->
    <xsl:template name="listregizm_header_rows">
        <row>
            <entry morerows="1">Изм.</entry>
            <entry namest="col2" nameend="col5">Номера листов (страниц)</entry>
            <entry morerows="1">Всего листов (страниц) в докум.</entry>
            <entry morerows="1">N докум.</entry>
            <entry morerows="1" rotate="1">Входящий № сопроводительного докум. и дата</entry>
            <entry morerows="1">Подп.</entry>
            <entry morerows="1">Дата</entry>
        </row>
        <row>
            <entry>измененных</entry>
            <entry>замененных</entry>
            <entry>новых</entry>
            <entry>аннулированных</entry>
        </row>
    </xsl:template>


    <!-- 
        Assembling body rows
    -->
    <xsl:template name="listregizm_body_rows">

        <xsl:param name="rows" select="17" as="xs:integer"/>

        <xsl:param name="cols" select="10" as="xs:integer"/>

        <xsl:for-each select="1 to $rows">
            <row>
                <xsl:for-each select="1 to $cols">
                    <entry/>
                </xsl:for-each>
            </row>
        </xsl:for-each>

    </xsl:template>


    <!-- 
        Assembling a topic for a final useless page
    -->
    <xsl:template name="listregizm">

        <xsl:param name="rows" select="17" as="xs:integer"/>

        <xsl:variable name="cols" select="10" as="xs:integer"/>

        <xsl:variable name="topic">
            <concept xml:lang="ru" id="listregizm">
                <title>Лист регистрации изменений</title>
                <conbody>
                    <table frame="all" closep="1" rowsep="1">
                        <tgroup cols="{$cols}">
                            <xsl:for-each select="1 to $cols">
                                <colspec colname="{concat('col', .)}"/>
                            </xsl:for-each>
                            <thead>
                                <xsl:call-template name="listregizm_header_rows"/>
                            </thead>
                            <tbody>
                                <xsl:call-template name="listregizm_body_rows">
                                    <xsl:with-param name="rows" select="$rows"/>
                                    <xsl:with-param name="cols" select="$cols"/>
                                </xsl:call-template>
                            </tbody>
                        </tgroup>
                    </table>
                </conbody>
            </concept>
        </xsl:variable>        
        
        <xsl:message>
            <xsl:apply-templates select="$topic/concept" mode="cpm.dita.class"/>
        </xsl:message>
        
        <xsl:apply-templates select="$topic/concept" mode="cpm.dita.class"/>        
        
    </xsl:template>

</xsl:stylesheet>
