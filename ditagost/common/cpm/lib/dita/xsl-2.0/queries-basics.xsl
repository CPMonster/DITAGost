<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster   
    
    Level:      Library
    
    Part:       DITA
    Module:     queries-basic.xsl
    
    Scope:      DITA
    
    Func:       Retrieving common data from DITA source                  
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  

<!DOCTYPE xsl:stylesheet [        
   <!ENTITY % defs SYSTEM "../dtd/classdefs.ent">    
   %defs;        
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Working with properties, translit -->
    <xsl:import href="../../common/xsl-2.0/props.xsl"/>

    <!-- Wrapper functions -->
    <xsl:import href="funcs.xsl"/>



    <!-- ====== -->
    <!--  i18n  -->
    <!-- ====== -->

    <!-- 
        Detecting a languae
    -->
    <xsl:template match="*" mode="cpm.dita.lang">

        <!-- 
            OVERRIDE this template in cust.xsl if you don't keep 
            language codes in xml:lang attributes in your XML.
            
            The template is probably already overloaded in a
            markcup-specific XSLT stylesheet, e.g. dita.xsl.
        -->

        <xsl:choose>
            <xsl:when test="@xml:lang">
                <xsl:value-of select="@xml:lang"/>
            </xsl:when>
            <xsl:when test="not(@xml:lang) and not(parent::*)">
                <xsl:text>en</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="cpm:dita.lang(parent::*)"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- ================== -->
    <!--  Block or inline?  -->
    <!-- ================== -->
    
    <xsl:template match="*" mode="cpm.dita.is_block">
        <xsl:value-of select="false()"/>
    </xsl:template>
    
    <xsl:template match="&DITA_BLOCK;" mode="cpm.dita.is_block">
        <xsl:value-of select="true()"/>
    </xsl:template>
    
    <xsl:template match="&DITA_INLINE;" mode="cpm.dita.is_inline">
        <xsl:value-of select="true()"/>
    </xsl:template>



    <!-- ============================ -->
    <!--  Detecting an element class  -->
    <!-- ============================ -->

    <!-- 
        Checking an element class 
    -->
    
    <!-- The case when an element has @class -->
    <xsl:template match="*" mode="cpm.dita.eclass" as="xs:boolean">

        <!-- 
            * represents a DITA element.
        -->

        <!-- A probable class, e.g. topic/li -->
        <xsl:param name="class"/>

        <!-- Making the template more reliable -->
        <xsl:variable name="actual_class">
            <xsl:value-of select="normalize-space($class)"/>
            <xsl:text>&#32;</xsl:text>
        </xsl:variable>

        <xsl:value-of select="contains(@class, $actual_class)"/>

    </xsl:template>

    <!-- The case when an element has no @class -->
    <xsl:template match="*[not(@class)]" mode="cpm.dita.eclass" as="xs:boolean">

        <!-- 
            * represents a DITA element.
        -->

        <!-- A probable class, e.g. topic/li -->
        <xsl:param name="class"/>

        <xsl:variable name="actual_class">
            <xsl:value-of select="normalize-space(substring-after($class, '/'))"/>
        </xsl:variable>        
        
        <xsl:value-of select="name() = $actual_class"/>
        
    </xsl:template>


    <!-- 
        Retrieving an output class
    -->
    <xsl:template match="*" mode="cpm.dita.oclass">
        
        <!-- 
            * represents a DITA element.
        -->
        
        <xsl:value-of select="@outputclass"/>
        
    </xsl:template>


    <!-- 
        Detecting the most specific element class
    -->
    <xsl:template match="*[@class]" mode="cpm.dita.sclass">

        <!-- 
            * represents a DITA element.
        -->          
        
        <xsl:variable name="classes" as="xs:string*">
            <xsl:copy-of select="tokenize(normalize-space(@class),' ')"/>
        </xsl:variable>
        
        <xsl:value-of select="$classes[count($classes)]"/>        

    </xsl:template>
    
    <xsl:template match="*[not(@class)]" mode="cpm.dita.sclass">
        <xsl:value-of select="name()"/>
    </xsl:template>

   

    <!-- ================================== -->
    <!--  Retrieving DITA element metadata  -->
    <!-- ================================== -->

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
