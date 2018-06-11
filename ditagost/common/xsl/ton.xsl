<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA OT Customization for Azimut 
    
    Level:      DITA OT customozation shared files
    
    Part:       Tables of named objects (tables, figures, etc.)
    Module:     ton.xsl
    
    Scope:      ESKD
    
    Func:       Working with tables of named objects 
-->   
<!-- * * ** *** ***** ******** ************* ********************* --> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">
    
    <!-- 
        Modules
    -->
    
    <!-- TOCs and TONs -->
    <xsl:import href="../../lib/fastcust/xsl-2.0/tocton.xsl"/>


    <!-- 
        Assembling a TON topic
    -->
    <xsl:template name="tontopic">
        
        <!-- A TON scope -->
        <xsl:param name="scope" select="'global'"/>
        
        <!-- An explicit TOC scope element ID -->
        <xsl:param name="scopeid" select="''"/>

        <!-- A numbering sequence name for titles we include to a table -->
        <xsl:param name="numseq"/>

        <!-- A list topic title -->
        <xsl:param name="title" select="''"/>

        <!-- Assembling a topic title -->
        <xsl:variable name="title">
            <title>
                <xsl:value-of select="$title"/>
            </title>
        </xsl:variable>

        <!-- Assembling an entire topic -->
        <xsl:variable name="concept">
            
            <concept class="- topic/topic">
                
                <!-- Assigning an appropriate dita class to a title element -->
                <xsl:apply-templates select="$title/title"
                    mode="cpm.fastcust.dita.assign_class_title"/>
                
                <conbody>
                    
                    <!-- Defining a list placeholder -->
                    <xsl:call-template name="cpm.fastcust.ton_placeholder">                       
                        <xsl:with-param name="scopeid" select="$scopeid"/>
                        <xsl:with-param name="scope" select="$scope"/>
                        <xsl:with-param name="numseqname" select="$numseq"/>
                        <xsl:with-param name="outputclass" select="'ton'"/>
                    </xsl:call-template>
                    
                </conbody>
                
            </concept>
            
        </xsl:variable>

        <!-- Assigning an appropriate class to a concept element -->
        <xsl:apply-templates select="$concept/concept" mode="cpm.fastcust.dita.assign_class_topic"/>

    </xsl:template>
    
    
    <!-- 
        Assembling a subordinate TON topic for an element 
    -->
    <xsl:template match="*" mode="tontopic">
        
        <!-- 
            * represents a parent element for a TOC topic.
        -->                
        
        <!-- A numbering sequence name for titles we include to a table -->
        <xsl:param name="numseq"/>
        
        <!-- A topic title -->
        <xsl:param name="title" select="''"/>
        
        <!-- Assembling a TOC topic -->        
        <xsl:call-template name="tontopic">
            <xsl:with-param name="scopeid" select="cpm:fastcust.id(.)"/>                  
            <xsl:with-param name="numseq" select="$numseq"/>
            <xsl:with-param name="title" select="$title"/>
        </xsl:call-template>
       
    </xsl:template>

</xsl:stylesheet>
