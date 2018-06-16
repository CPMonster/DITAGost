<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster   
    
    Level:      Library
    
    Part:       DITA library
    Module:     queries-basic.xsl
    
    Scope:      DITA
    
    Func:       Retrieving common data from DITA source                  
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



    <!-- ================================================ -->
    <!--  Retrieving DITA element core data and metadata  -->
    <!-- ================================================ -->

    <!-- 
        Retrieving an othermeta value
    -->
    <xsl:function name="cpm:dita.othermeta">

        <!-- A DITA element, e.g. bookmap -->
        <xsl:param name="element"/>

        <!-- An othermeta name, e.g. "Document type" -->
        <xsl:param name="name"/>

        <!-- Retrieving an othermeta value by a strict name -->
        <xsl:apply-templates select="$element" mode="cpm.dita.othermeta">
            <xsl:with-param name="name" select="$name"/>
        </xsl:apply-templates>

    </xsl:function>


    <!-- 
        Retrieving an othermeta value by an alias hashtag
    -->
    <xsl:function name="cpm:dita.othermeta_by_alias">

        <!-- A DITA element, e.g. bookmap -->
        <xsl:param name="element"/>

        <!-- A list of othermeta aliases, e.g. "Document;Document type" -->
        <xsl:param name="alias_list"/>

        <!-- Transforming an alias list to an alias sequence -->
        <xsl:variable name="alias_sequence" as="xs:string*">
            <xsl:sequence select="cpm:props.alias_sequence($alias_list)"/>
        </xsl:variable>

        <!-- Retrieving an othermeta matching with the alias sequence -->
        <xsl:for-each select="$alias_sequence">
            <xsl:apply-templates select="$element" mode="cpm.dita.othermeta_by_hashtag">
                <xsl:with-param name="name" select="."/>
            </xsl:apply-templates>
        </xsl:for-each>

    </xsl:function>


    <!-- 
        Retrieving an element title
    -->
    <xsl:function name="cpm:dita.title">

        <!-- A DITA element -->
        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="cpm.dita.title"/>

    </xsl:function>

</xsl:stylesheet>
