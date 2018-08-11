<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster    
    
    Level:      Library
    
    Part:       FastCust
    Module:     queries.xsl
    
    Scope:      Generic
    
    Func:       Detecting and testing document elements                 
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->
    
    <!-- Wrapper function -->
    <xsl:import href="funcs.xsl"/>
   
    <!-- Retrieving data related to FO elements -->
    <xsl:import href="../../fo/xsl-2.0/queries.xsl"/>

    <!-- Retrieving data related to FO elements -->
    <xsl:import href="../../cpm/xsl-2.0/queries.xsl"/>



    <!-- ======================== -->
    <!--  Working with languages  -->
    <!-- ======================== -->

    <!-- 
        Assigning a language code to an element in a source/improved document
    -->

    <!-- A default FastCust template -->
    <xsl:template match="*" mode="cpm.fastcust.lang">

        <!-- Scope: any stage, DITA -->

        <!-- * represents an element of a document -->

        <xsl:variable name="tmp">
            <xsl:choose>
                <xsl:when test="@xml:lang">
                    <xsl:value-of select="@xml:lang"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="ancestor::*[@xml:lang][1]/@xml:lang"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$tmp != ''">
                <xsl:value-of select="$tmp"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>en</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- A default custom template -->
    <xsl:template match="*" mode="lang">
        <xsl:value-of select="cpm:fastcust.lang(.)"/>
    </xsl:template>



    <!-- ============================================ -->
    <!--  Detecting core document structure elements  -->
    <!-- ============================================ -->

    <!-- 
        Detecting a document root element
    -->

    <!-- A FastCust default template -->
    <xsl:template match="*" mode="cpm.fastcust.is_docroot" as="xs:boolean">

        <!-- Scope: source, complete, improved -->

        <!-- * represents an element of a document -->

        <xsl:choose>
            <xsl:when test="parent::*">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="true()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- A default custom template -->
    <xsl:template match="*" mode="is_docroot" as="xs:boolean">
        <xsl:value-of select="cpm:fastcust.is_docroot(.)"/>
    </xsl:template>


    <!-- 
        Detecting topics
    -->

    <!-- A default FastCust template -->
    <xsl:template match="*" mode="cpm.fastcust.is_topic" as="xs:boolean">
        <xsl:value-of select="false()"/>
    </xsl:template>

    <!-- A default custom template -->
    <xsl:template match="*" mode="is_topic" as="xs:boolean">
        <xsl:value-of select="cpm:fastcust.is_topic(.)"/>
    </xsl:template>


    <!-- 
        Detecting topics having (not having) subtopics
    -->

    <!-- A default FastCust template -->
    <xsl:template match="*" mode="cpm.fastcust.has_subtopics" as="xs:boolean">

        <!-- Scope: complete, improved -->

        <!-- * represents an element of a document -->

        <xsl:choose>
            <xsl:when test="descendant::*[cpm:is_topic(.)]">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- A default custom template -->
    <xsl:template match="*" mode="has_subtopics" as="xs:boolean">
        <xsl:value-of select="cpm:fastcust.has_subtopics(.)"/>
    </xsl:template>


    <!-- 
        Detecting topics having no topics inside
    -->

    <!-- A default FastCust template -->
    <xsl:template match="*" mode="cpm.fastcust.is_simple_topic" as="xs:boolean">

        <!-- Scope: complete, improved -->

        <!-- * represents an element of a document -->

        <xsl:choose>
            <xsl:when test="cpm:is_topic(.)">
                <xsl:value-of select="not(cpm:has_subtopics(.))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- A default custom template -->
    <xsl:template match="*" mode="is_simple_topic" as="xs:boolean">
        <xsl:value-of select="cpm:fastcust.is_simple_topic(.)"/>
    </xsl:template>


    <!-- 
        Detecting topics having other topics inside
    -->

    <!-- A default FastCust template -->
    <xsl:template match="*" mode="cpm.fastcust.is_complex_topic" as="xs:boolean">

        <!-- Scope: complete, improved -->

        <!-- * represents an element of a document -->

        <xsl:choose>
            <xsl:when test="cpm:is_topic(.)">
                <xsl:value-of select="cpm:has_subtopics(.)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- A default custom template -->
    <xsl:template match="*" mode="is_complex_topic" as="xs:boolean">
        <xsl:value-of select="cpm:fastcust.is_complex_topic(.)"/>
    </xsl:template>


    <!-- 
        Detecting titles
    -->

    <!-- A default FastCust template -->
    <xsl:template match="*" mode="cpm.fastcust.is_title" as="xs:boolean">
        <xsl:value-of select="false()"/>
    </xsl:template>

    <!-- A default custom template -->
    <xsl:template match="*" mode="is_title" as="xs:boolean">
        <xsl:value-of select="cpm:fastcust.is_title(.)"/>
    </xsl:template>


    <!-- 
        Detecting topic titles
    -->

    <!-- A default template -->
    <xsl:template match="*[not(cpm:is_title(.))]" mode="cpm.fastcust.is_topic_title" as="xs:boolean">
        <xsl:value-of select="false()"/>
    </xsl:template>
    
    <!-- A default template -->
    <xsl:template match="*[cpm:is_title(.)]" mode="cpm.fastcust.is_topic_title" as="xs:boolean">

        <!-- Scope: complete, improved -->

        <!-- * represents an element of a document -->

        <xsl:value-of select="cpm:is_topic(..)"/>               

    </xsl:template>

    <!-- A default custom template -->
    <xsl:template match="*" mode="is_topic_title" as="xs:boolean">
        <xsl:value-of select="cpm:fastcust.is_topic_title(.)"/>
    </xsl:template>


    <!-- 
        Detecting topic metadata
    -->

    <!-- A default FastCust template -->
    <xsl:template match="*" mode="cpm.fastcust.is_topic_meta" as="xs:boolean">
        <xsl:value-of select="false()"/>
    </xsl:template>

    <!-- A default custom template -->
    <xsl:template match="*" mode="is_topic_meta" as="xs:boolean">
        <xsl:value-of select="cpm:fastcust.is_topic_meta(.)"/>
    </xsl:template>


    <!-- 
        Detecting untitled content
    -->

    <!-- A default FastCust template -->
    <xsl:template match="*" mode="cpm.fastcust.is_untitled" as="xs:boolean">

        <xsl:choose>
            <xsl:when test="cpm:is_topic(.)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:when test="cpm:is_topic_title(.)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:when test="cpm:is_topic_meta(.)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="following-sibling::*[cpm:is_topic(.)]">
                        <xsl:value-of select="true()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="false()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- A default custom template -->
    <xsl:template match="*" mode="is_untitled" as="xs:boolean">
        <xsl:value-of select="cpm:fastcust.is_untitled(.)"/>
    </xsl:template>



    <!-- =================================== -->
    <!--  Navigating over section hierarchy  -->
    <!-- =================================== -->

    <!-- 
        Detecting/generating an ID for an element (legacy!)
    -->
    <xsl:template match="*" mode="cpm.fastcust.id">
        <xsl:value-of select="cpm:misc.id(.)"/>
    </xsl:template>


    <!-- 
        Detecting an ID of a parent structural element in a source/improved document
    -->
    <xsl:template match="*" name="cpm.fastcust.parent_id">
        <xsl:value-of select="cpm:misc.id(ancestor::*[cpm:is_topic(.)][1])"/>
    </xsl:template>


    <!-- 
        Detecting an ID of a grandparent structural element in a source/improved document
    -->
    <xsl:template match="*" name="cpm:fastcust.grandpa_id">

        <xsl:variable name="parent_id">
            <xsl:value-of select="cpm:fastcust.parent_id(.)"/>
        </xsl:variable>

        <xsl:value-of select="cpm:fastcust.parent_id(ancestor::*[cpm:misc.id(.) = $parent_id])"/>

    </xsl:template>



    <!-- ======================= -->
    <!--  Detecting topic types  -->
    <!-- ======================= -->

    <!-- 
        Detecting appendices
    -->
    <xsl:template match="*" mode="is_appendix" as="xs:boolean">

        <!-- Scope: complete, improved -->

        <!-- * represents an element of a document -->

        <xsl:value-of select="false()"/>

    </xsl:template>


    <!-- 
        Detecting auxiliary topics
    -->
    <xsl:template match="*" mode="is_auxiliary" as="xs:boolean">

        <!-- Scope: complete, improved -->

        <!-- * represents an element of a document -->

        <xsl:value-of select="false()"/>

    </xsl:template>


    <!-- 
        Detecting cover page topics
    -->

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.is_cover" as="xs:boolean">

        <!-- Scope: complete, improved -->

        <!-- * represents an element of a document -->

        <xsl:value-of select="name() = 'cpm:cover'"/>

    </xsl:template>

    <!-- A custom working template -->
    <xsl:template match="*" mode="is_cover" as="xs:boolean">
        <xsl:value-of select="cpm:fastcust.is_cover(.)"/>
    </xsl:template>


    <!-- 
        Detecting topics of a main part
    -->

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.is_main" as="xs:boolean">

        <!-- Scope: complete, improved, flat -->

        <!-- * represents an element of a document -->

        <xsl:value-of select="cpm:sectype(.) = 'main'"/>

    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="is_main" as="xs:boolean">
        <xsl:value-of select="cpm:fastcust.is_main(.)"/>
    </xsl:template>


    <!-- 
        Detecting preface/conclusion topics
    -->
    <xsl:template match="*" mode="is_prefconcl" as="xs:boolean">

        <!-- Scope: complete, improved, flat -->

        <!-- * represents an element of a document -->

        <xsl:value-of select="false()"/>

    </xsl:template>


    <!-- 
        Detecting resource topics
    -->

    <!-- A custom template -->
    <xsl:template match="*" mode="is_resource" as="xs:boolean">

        <!-- Scope: source -->

        <!-- * represents an element of a document -->

        <xsl:value-of select="false()"/>

    </xsl:template>


    <!-- 
        Detecting TOC topics
    -->

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.is_toctopic" as="xs:boolean">

        <!-- Scope: complete, improved, flat -->

        <!-- * represents an element of a document -->

        <xsl:choose>
            <xsl:when test="cpm:is_simple_topic(.)">
                <xsl:choose>
                    <xsl:when test="descendant::cpm:toc">
                        <xsl:value-of select="true()"/>
                    </xsl:when>
                    <xsl:when test="descendant::*[cpm:oclass(.) = 'toc']">
                        <xsl:value-of select="true()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="false()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="is_toctopic" as="xs:boolean">
        <xsl:value-of select="cpm:fastcust.is_toctopic(.)"/>
    </xsl:template>


    <!-- 
        Detecting TON topics
    -->

    <!-- A default working template -->
    <xsl:template match="*" mode="cpm.fastcust.is_tontopic" as="xs:boolean">

        <!-- * is an element of a document -->                

        <xsl:choose>
            <xsl:when test="cpm:is_simple_topic(.)">
                <xsl:choose>
                    <xsl:when test="descendant::cpm:ton">
                        <xsl:value-of select="true()"/>
                    </xsl:when>
                    <xsl:when test="descendant::*[@role = 'ton']">
                        <xsl:value-of select="true()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="false()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- A custom working template -->
    <xsl:template match="*" mode="is_tontopic" as="xs:boolean">        
        <xsl:value-of select="cpm:fastcust.is_tontopic(.)"/>
    </xsl:template>


    <!-- 
        Detecting topic types
    -->
    
    <!-- A default template for a common case -->
    <xsl:template match="*" mode="cpm.fastcust.sectype"/>
    
    <!-- A default template for a cover page -->
    <xsl:template match="*[cpm:is_cover(.)]" mode="cpm.fastcust.sectype">
        <xsl:text>cover</xsl:text>
    </xsl:template>
        
    <!-- A default template for complete and improved document elements -->
    <xsl:template match="*[cpm:is_topic(.)]" mode="cpm.fastcust.sectype">

        <!-- * represents an element of a complete document -->

        <xsl:choose>
            <xsl:when test="cpm:is_appendix(.)">
                <xsl:text>appendix</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_auxiliary(.)">
                <xsl:text>auxiliary</xsl:text>
            </xsl:when>            
            <xsl:when test="cpm:is_prefconcl(.)">
                <xsl:text>prefconcl</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_resource(.)">
                <xsl:text>resource</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_toctopic(.)">
                <xsl:text>toctopic</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_tontopic(.)">
                <xsl:text>tontopic</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>main</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>
       
    <!-- A title inherits a parent's section type -->
    <xsl:template match="*[cpm:is_topic_title(.)]" mode="cpm.fastcust.sectype">          
        <xsl:value-of select="cpm:sectype(..)"/>
    </xsl:template>
    
    <!-- A default template for flat document elements (always wins!) -->
    <xsl:template match="*[@cpm:sectype]" mode="cpm.fastcust.sectype" priority="2">
        <xsl:value-of select="@cpm:sectype"/>
    </xsl:template>

    <!-- A default custom template -->
    <xsl:template match="*" mode="sectype">                
        <xsl:value-of select="cpm:fastcust.sectype(.)"/>
    </xsl:template>



    <!-- ====================================================== -->
    <!--  Detecting how elements are represented in a document  -->
    <!-- ====================================================== -->

    <!-- 
        Should an element appear in a document?
    -->

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.is_docmamber" as="xs:boolean">
        <xsl:value-of select="not(cpm:is_resource(.))"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="is_docmamber" as="xs:boolean">
        <xsl:value-of select="cpm:fastcust.is_docmamber(.)"/>
    </xsl:template>


    <!-- 
        Should an element appear in a TOC?
    -->

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.is_tocmamber" as="xs:boolean">

        <xsl:choose>
            <xsl:when test="cpm:is_auxiliary(.)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:when test="cpm:is_cover(.)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:when test="cpm:is_resource(.)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:when test="cpm:is_toctopic(.)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:when test="cpm:is_untitled(.)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="cpm:is_topic(.)"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="is_tocmamber" as="xs:boolean">
        <xsl:value-of select="cpm:fastcust.is_tocmamber(.)"/>
    </xsl:template>



    <!-- ========================================================= -->
    <!--  Detecting positions of elements in a document structure  -->
    <!-- ========================================================= -->

    <!-- 
        Calculating or retrieving a level of an element
    -->

    <!-- A default template for a common case -->
    <xsl:template match="*" mode="cpm.fastcust.level">
        <xsl:value-of select="0"/>
    </xsl:template>    

    <!-- Excluding redundant elements -->
    <xsl:template match="*[not(cpm:is_docmamber(.))]" mode="cpm.fastcust.level" priority="2">
        <xsl:value-of select="-1"/>
    </xsl:template>

    <!-- A default template for complex topics -->
    <xsl:template match="*[cpm:is_complex_topic(.)]" mode="cpm.fastcust.level">
        <xsl:value-of select="0"/>
    </xsl:template>

    <!-- A default template for simple topics -->
    <xsl:template match="*[cpm:is_simple_topic(.)]" mode="cpm.fastcust.level">
        <xsl:value-of select="count(ancestor::*[cpm:is_topic(.)]) + 1"/>
    </xsl:template>

    <!-- A default template for topic titles -->
    <xsl:template match="*[cpm:is_topic_title(.)]" mode="cpm.fastcust.level">

        <xsl:choose>
            <xsl:when test="cpm:is_complex_topic(..)">
                <xsl:value-of select="count(ancestor::*[cpm:is_topic(.)])"/>
            </xsl:when>
            <xsl:when test="cpm:is_simple_topic(..)">
                <xsl:value-of select="cpm:level(..)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="0"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>
    
    <!-- A default template for flat document elements (always wins!) -->
    <xsl:template match="*[@cpm:level]" mode="cpm.fastcust.level" priority="2">
        <xsl:value-of select="@cpm:level"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="level">
        <xsl:value-of select="cpm:fastcust.level(.)"/>
    </xsl:template>

</xsl:stylesheet>
