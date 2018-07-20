<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster    
    
    Level:      Library
    
    Part:       FastCust
    Module:     docparams.xsl 
    
    Scope:      DITA
    
    Func:       Retrieving content configuration settings, document 
                parameters, and other globals 
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Translit -->
    <xsl:import href="../../common/xsl-2.0/translit.xsl"/>
    
  

    <!-- =========================================== -->
    <!--  Retrieving content configuration settings  -->
    <!-- =========================================== -->
    
    <!-- 
        Retrieving document configuration settings
    -->
    <xsl:template name="cpm.fastcust.docparams.cfg">

        <!-- This template is dummy so far -->
        
        <record name="settings"/>

    </xsl:template>



    <!-- ============================= -->
    <!--  Detecting a docparams table  -->
    <!-- ============================= -->

    <!-- 
        Detecting a docparams table 
    -->

    <!-- A default template -->
    <xsl:template match="table" mode="cpm.fastcust.is_docparams">        

        <!-- Content configuration settings -->
        <xsl:param name="cfg"/>

        <!-- 
            OVERLOAD: In a particular customization
        -->

        <xsl:choose>
            <xsl:when test="@outputclass = 'docparams'">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_docparams" as="xs:boolean">

        <!-- Content configuration settings -->
        <xsl:param name="cfg"/>

        <!-- A table element -->
        <xsl:param name="table"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:apply-templates select="$table" mode="cpm.fastcust.is_docparams"/>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>

    
    
    <!-- ================================ -->
    <!--  Retrieving document parameters  -->
    <!-- ================================ -->

    <!-- 
        Detecting a list separator
    -->

    <!-- A working template -->
    <xsl:template name="cpm.fastcust.sep">

        <!-- Content configuration settings -->
        <xsl:param name="cfg"/>

        <!-- A list -->
        <xsl:param name="list"/>

        <xsl:text>;</xsl:text>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.sep">

        <!-- Content configuration settings -->
        <xsl:param name="cfg"/>

        <!-- A list -->
        <xsl:param name="list"/>

        <xsl:call-template name="cpm.fastcust.sep">
            <xsl:with-param name="cfg" select="$cfg"/>
            <xsl:with-param name="list" select="$list"/>
        </xsl:call-template>

    </xsl:function>


    <!-- 
        Retrieving a document parameter
    -->
        
    <!-- A working template -->   
    <xsl:template match="*" mode="cpm.fastcust.docparam">
        
        <!-- * is a table element or a variable containing one -->

        <!-- Content configuration settings -->
        <xsl:param name="cfg"/>

        <!-- A list of names (a string) -->
        <xsl:param name="names"/>

        <!-- Detect a list separator -->
        <xsl:variable name="sep">
            <xsl:value-of select="cpm:fastcust.sep($cfg, $names)"/>
        </xsl:variable>

        <!-- Extracting an entry containing a document parameter value -->
        <xsl:variable name="docparam">
            <xsl:copy-of select=".//tbody/row[cpm:translit.mlht(entry[1], $names, $sep)]/entry[2]"/>
        </xsl:variable>                                         
        
        <!-- Extracting a document parameter value -->
        <xsl:choose>
            
            <!-- The case when an entry has complex content -->
            <xsl:when test="$docparam/entry/*">                  
                <xsl:copy-of select="$docparam/entry/*"/>
            </xsl:when>
            
            <!-- The case when an entry has string content -->
            <xsl:otherwise>                
                <xsl:value-of select="$docparam/entry"/>
            </xsl:otherwise>
            
        </xsl:choose>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.docparams.docparam">

        <!-- Content configuration settings -->
        <xsl:param name="cfg"/>

        <!-- A table element -->
        <xsl:param name="table"/>

        <!-- A list of names (a string) -->
        <xsl:param name="names"/>

        <xsl:apply-templates select="$table" mode="cpm.fastcust.docparam">
            <xsl:with-param name="cfg" select="$cfg"/>
            <xsl:with-param name="names" select="$names"/>
        </xsl:apply-templates>

    </xsl:function>
    
    
    
    <!-- ========================================== -->
    <!--  Defining and retrieving document globals  -->
    <!-- ========================================== -->
    
    <!-- 
        Retrieving a global docparams table (version A)
    -->
    <xsl:template name="cpm.fastcust.docparams.global">
        
        <!-- Content configuration settings -->
        <xsl:param name="cfg"/>
        
        <xsl:copy-of select="//table[cpm:fastcust.is_docparams($cfg, .)]"/>
                
    </xsl:template>
    
    
    <!-- 
        Retrieving a global docparams table (version B)
    -->
    <xsl:template match="*" mode="cpm.fastcust.docparams.global">
        
        <!-- 
            Legacy version of the template 
        -->
        
        <!-- Content configuration settings -->
        <xsl:param name="cfg"/>
        
        <xsl:copy-of select="root()//table[cpm:fastcust.is_docparams($cfg, .)]"/>
        
    </xsl:template>
    
    
    <!-- 
        Building a block of global configuration settings  
    -->
    <xsl:variable name="cpm.fastcust.GLOBAL_CFG">
        
        <!-- 
            I'm defining a global variable here. Global variables 
            are evel. Everyone is aware of this, aren't they?
            I'm doing this nevertheless. That's because I failed
            to make the settings available everywhere I need them
            without defining globals. Sad but true().  
        -->
        
        <!-- Retrieving content configuration settings -->
        <xsl:variable name="cfg">
            <xsl:call-template name="cpm.fastcust.docparams.cfg"/>
        </xsl:variable>
        
        <xsl:variable name="docparams">
            <xsl:call-template name="cpm.fastcust.docparams.global">
                <xsl:with-param name="cfg" select="$cfg"/>                                    
            </xsl:call-template>
        </xsl:variable>
        
        <cfg>

            <!-- A URI of a ditamap file -->
            <ditamap uri="{/*/@xtrf}"/>
            
            <!-- A copy of content configuration settings -->
            <cfg>
                <xsl:copy-of select="$cfg"/>
            </cfg>
            
            <!-- A copy of a docparams table -->
            <docparams>
                <xsl:copy-of select="$docparams"/>
            </docparams>
            
        </cfg>                
        
    </xsl:variable>
    
    
    <!-- 
        Retrieving an URI of a ditamap file
    -->
    <xsl:function name="cpm:fastcust.ditamap_uri">        
        <xsl:value-of select="$cpm.fastcust.GLOBAL_CFG//ditamap/@uri"/>        
    </xsl:function>
    
    
    <!-- 
        Retrieving a document paremeter
    -->
    <xsl:function name="cpm:fastcust.docparam">
        
        <!-- A list of parameter names -->
        <xsl:param name="names"/>
        
        <!-- Retrieving content configuration settings -->
        <xsl:variable name="cfg">
            <xsl:copy-of select="$cpm.fastcust.GLOBAL_CFG//cfg/*"/>
        </xsl:variable>
        
        <!-- Retrieving document parameters -->
        <xsl:variable name="docparams">
            <xsl:copy-of select="$cpm.fastcust.GLOBAL_CFG//docparams/*"/>
        </xsl:variable>                
        
        <!-- Extracting a parameter value -->
        <xsl:value-of select="cpm:fastcust.docparams.docparam($cfg, $docparams, $names)"/>
                        
    </xsl:function>

</xsl:stylesheet>
