<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster    
    
    Level:      Library
    
    Part:       FastCust
    Module:     funcs.xsl
    
    Scope:      Generic
    
    Func:       Inner, API, an wrapper functions for query templates                 
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Misc. useful functions ;) -->
    <xsl:import href="../../common/xsl-2.0/misc.xsl"/>


    <!-- 
        Please, skip this borrowing comment if you want 
        the debugging to take all your invaluable live. 
        
        The following four levels of control are involved
        into source document processing:
        
        - API functions
        
        - Custom templates
        
        - Wrapper functions
        
        - Default templates 
        
        An API function is a function your customization
        should use in order to detect element property
        values. Bypassing API functions is strongly
        not recommended. API functions has names like
        cpm:is_tocmamber.
        
        Basically you pass a document element to an API
        function. An API function applies a custom template 
        to an element it received in the $element parameter.
        
        Custom templates are usually defined in submodules of 
        the query.xsl module. An application programmer 
        (e.g. you, my valued unknown reader) can redefine 
        a custom template in their customization. Do this 
        for implementing your own rules of assigning levels
        to document elements, excluding elements from 
        an output document or from a TOC, etc. Custom templates
        usually have modes like "is_tocmamber". 
        
        One more place where a custom template can be redefined 
        is a source language level module, e.g. FastCust dita.xsl.
        A source language level module implements specific rules
        for detecting document element types, detecting topics,
        titles, and other language-independent parts of a documnet
        structure. 
        
        A custom template calls a wrapper function by default. 
        A wrapper function is usually just a wrapper for a default 
        template. A default template performs the job in a generic 
        manner whenever it is possible. Otherwise a default template 
        returns an empty string, or 0, or false(). Wrapper functions
        usually have names like cpm:fastcust.is_tocmamber. 
        Default templates usually have modes like "cpm.fastcust.is_tocmamber".
        
        No wrapper function and no default template is provided for
        properties that totally depend on a source language or on
        a customization.
        
        IMPORTANT: API functions as well as their wrapper sisters expect 
                   to find a "native" element in the $element parameter.
                   A variable containing a copy of an element will
                   result in incorrect output.
                   
                   Right:                    
                        <xsl:value-of select="cpm:is_tocmamber(.)"/>
                   
                   Wrong:
                        <xsl:variable name="foo">
                            <xsl:copy-of select="."/>
                        </xsl:variable>                        
                        <xsl:value-of select="cpm:is_tocmamber($foo)"/>
    -->



    <!-- ================== -->
    <!--  Working with IDs  -->
    <!-- ================== -->

    <!-- 
        Retrieving or generating a document element ID
    -->

    <!-- An wrapperfunction -->
    <xsl:function name="cpm:fastcust.id">

        <!-- 
            This function is a part of legacy code. Please, 
            use cpm:misc.is whenever an ID of an elemen 
            is required. 
        -->

        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="cpm.fastcust.id"/>

    </xsl:function>



    <!-- ======================== -->
    <!--  Working with languages  -->
    <!-- ======================== -->

    <!-- 
        Detectimg an element language
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.lang">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.lang"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:lang">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="lang"/>
    </xsl:function>



    <!-- ======================================================== -->
    <!--  Detecting element types basing on the FO content model  -->
    <!-- ======================================================== -->

    <!-- 
        Detecting elements giving FO containers
    -->

    <!-- An API function -->
    <xsl:function name="cpm:is_block_container" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_block_container"/>
    </xsl:function>


    <!-- 
        Detecting elements giving FO blocks 
    -->

    <!-- An API function -->
    <xsl:function name="cpm:is_block" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_block"/>
    </xsl:function>


    <!-- 
        Detecting elements giving FO inlines
    -->

    <!-- An API function -->
    <xsl:function name="cpm:is_inline" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_inline"/>
    </xsl:function>

    <!-- 
        Detecting elements giving FO list blocks
    -->

    <!-- An API function -->
    <xsl:function name="cpm:is_list_block" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_list_block"/>
    </xsl:function>


    <!-- 
        Detecting elements giving FO list item body elements
    -->

    <!-- An API function -->
    <xsl:function name="cpm:is_list_item_body" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_list_item_body"/>
    </xsl:function>


    <!--
        Detecting elements giving FO tables
    -->

    <!-- An API function -->
    <xsl:function name="cpm:is_table" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_table"/>
    </xsl:function>


    <!-- 
        Detecting elements giving FO table headers
    -->

    <!-- An API function -->
    <xsl:function name="cpm:is_table_header" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_table_header"/>
    </xsl:function>


    <!-- 
        Detecting elements giving FO table bodies 
    -->

    <!-- An API function -->
    <xsl:function name="cpm:is_table_body" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_table_body"/>
    </xsl:function>


    <!-- 
        Detecting elements giving FO table footers
    -->

    <!-- An API function -->
    <xsl:function name="cpm:is_table_footer" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_table_footer"/>
    </xsl:function>


    <!-- 
        Detecting elements giving FO table rows
    -->

    <!-- An API function -->
    <xsl:function name="cpm:is_table_row" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_table_row"/>
    </xsl:function>


    <!-- 
        Detecting elements giving FO table cells
    -->

    <!-- An API function -->
    <xsl:function name="cpm:is_table_cell" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_table_cell"/>
    </xsl:function>


    <!-- 
        Detecting elements giving FO external graphic elements
    -->

    <!-- An API function -->
    <xsl:function name="cpm:is_external_graphic" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_external_graphic"/>
    </xsl:function>



    <!-- ================================================= -->
    <!--  Detecting core elements of a document structure  -->
    <!-- ================================================= -->

    <!-- 
        Detecting a document root element    
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_docroot" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.is_docroot"/>

    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:is_docroot" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_docroot"/>
    </xsl:function>



    <!-- 
        Detecting topics
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_topic" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.is_topic"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:is_topic" as="xs:boolean">
        <xsl:param name="element"/>       
        <xsl:apply-templates select="$element" mode="is_topic"/>
    </xsl:function>


    <!-- 
        Detecting topics inside an element
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.has_subtopics" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.has_subtopics"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:has_subtopics" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="has_subtopics"/>
    </xsl:function>


    <!-- 
        Detecting topics having no topics inside
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_simple_topic" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.is_simple_topic"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:is_simple_topic" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_simple_topic"/>
    </xsl:function>


    <!-- 
        Detecting topics having other topics inside
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_complex_topic" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.is_complex_topic"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:is_complex_topic" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_complex_topic"/>
    </xsl:function>


    <!-- 
        Detecting titles
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_title" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.is_title"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:is_title" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_title"/>
    </xsl:function>


    <!-- 
        Detecting topics titles
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_topic_title" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.is_topic_title"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:is_topic_title" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_topic_title"/>
    </xsl:function>


    <!-- 
        Detecting topic metadata element
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_topic_meta" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.is_topic_meta"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:is_topic_meta" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_topic_meta"/>
    </xsl:function>


    <!-- 
        Detecting untitled ("slacking") content
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_untitled" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.is_untitled"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:is_untitled" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_untitled"/>
    </xsl:function>



    <!-- =================================== -->
    <!--  Navigating over section hierarchy  -->
    <!-- =================================== -->

    <!-- 
        Detecting an ID of a parent structural element in a source/improved document
    -->

    <!-- A wrapper function-->
    <xsl:function name="cpm:fastcust.parent_id">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="parent_id"/>
    </xsl:function>


    <!-- 
        Detecting an ID of a grandparent structural element in a source/improved document
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.grandpa_id">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="grandpa_id"/>
    </xsl:function>



    <!-- ====================================================== -->
    <!--  Detecting how elements are represented in a document  -->
    <!-- ====================================================== -->

    <!-- 
        Detecting anelement that should appear in a document
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_docmamber" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.is_docmamber"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:is_docmamber" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_docmamber"/>
    </xsl:function>


    <!-- 
        Detecting anelement that should appear in a TOC
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_tocmamber" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.is_tocmamber"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:is_tocmamber" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_tocmamber"/>
    </xsl:function>



    <!-- ====================== -->
    <!--  Classifying elements  -->
    <!-- ====================== -->

    <!-- 
        Detecting appendix topics
    -->

    <!-- An API function -->
    <xsl:function name="cpm:is_appendix" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_appendix"/>
    </xsl:function>


    <!-- 
        Detecting auxiliary topics
    -->

    <!-- An API function -->
    <xsl:function name="cpm:is_auxiliary" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_auxiliary"/>
    </xsl:function>


    <!-- 
        Detecting cover topics
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_cover" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.is_cover"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:is_cover" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_cover"/>
    </xsl:function>


    <!-- 
        Detecting main part topics
    -->
    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_main" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.is_main"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:is_main" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_main"/>
    </xsl:function>


    <!-- 
        Detecting preface/conclusion topics
    -->

    <!-- An API function -->
    <xsl:function name="cpm:is_prefconcl" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_prefconcl"/>
    </xsl:function>


    <!-- 
        Detecting resource topics
    -->

    <!-- An API function -->
    <xsl:function name="cpm:is_resource" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_resource"/>
    </xsl:function>


    <!-- 
        Detecting TOC topics
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_toctopic" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.is_toctopic"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:is_toctopic" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_toctopic"/>
    </xsl:function>


    <!-- 
        Detecting a TON topics
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_tontopic" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.is_tontopic"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:is_tontopic" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_tontopic"/>
    </xsl:function>


    <!-- 
        Detecting a type of a topic
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.sectype">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.sectype"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:sectype">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="sectype"/>
    </xsl:function>



    <!-- ========================================================= -->
    <!--  Detecting positions of elements in a document structure  -->
    <!-- ========================================================= -->

    <!-- 
        Calculating an element level
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.level">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.level"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:level">

        <!-- An element of a document (native! not a variable!) -->
        <xsl:param name="element"/>

        <!-- Trying to calculate a level -->
        <xsl:variable name="level">
            <xsl:apply-templates select="$element" mode="level"/>
        </xsl:variable>

        <!-- Escaping non-numeric values -->
        <xsl:value-of select="cpm:misc.defnum0($level)"/>

    </xsl:function>



    <!-- ============================================ -->
    <!--  Detecting numbering properties of elements  -->
    <!-- ============================================ -->

    <!-- 
        Calculating a numbering level of an element
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.numlevel">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.numlevel"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:numlevel">

        <xsl:param name="element"/>

        <xsl:variable name="numlevel">
            <xsl:apply-templates select="$element" mode="numlevel"/>
        </xsl:variable>

        <xsl:value-of select="cpm:misc.defnum0($numlevel)"/>

    </xsl:function>


    <!-- 
        Comparing numbering lavels of two elements
    -->
    <xsl:function name="cpm:fastcust.eqnumlevel" as="xs:boolean">

        <!-- An element -->
        <xsl:param name="element1"/>

        <!-- Another one -->
        <xsl:param name="element2"/>

        <xsl:variable name="numlevel1">
            <xsl:value-of select="cpm:fastcust.numlevel($element1)"/>
        </xsl:variable>

        <xsl:variable name="numlevel2">
            <xsl:value-of select="cpm:fastcust.numlevel($element2)"/>
        </xsl:variable>

        <xsl:value-of select="boolean($numlevel1 = $numlevel2)"/>

    </xsl:function>


    <!-- 
        Retrieving a numbering sequence name of an element
    -->
    
    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.numseqname">        
        <xsl:param name="element"/>                               
        <xsl:apply-templates select="$element" mode="cpm.fastcust.numseqname"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:numseqname">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="numseqname"/>
    </xsl:function>
    
    
    <!-- 
        Retrieving a base numbering sequence name
    -->
    
    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.numbase">        
        <xsl:param name="element"/>                       
        <xsl:apply-templates select="$element" mode="cpm.fastcust.numbase"/>
    </xsl:function>
    
    <!-- An API function -->
    <xsl:function name="cpm:numbase">
        <xsl:param name="element"/>                        
        <xsl:apply-templates select="$element" mode="numbase"/>                
    </xsl:function>


    <!-- 
        Calculating a local number of an element
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.locnumber">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.locnumber"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:locnumber">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="locnumber"/>
    </xsl:function>


    <!-- 
        Retrieving a higher element number
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.hinumber">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.hinumber"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:hinumber">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="hinumber"/>
    </xsl:function>


    <!-- 
        Calculating an element number (regular mode)
    -->

    <!-- A wrapper function for a fast mode -->
    <xsl:function name="cpm:fastcust.number">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <!-- A higher number -->
        <xsl:param name="hinumber"/>

        <!-- A higher numbering sequence -->
        <xsl:param name="hinumseq"/>

        <xsl:apply-templates select="$element" mode="cpm.fastcust.number">
            <xsl:with-param name="hinumber" select="$hinumber"/>
            <xsl:with-param name="hinumseq" select="$hinumseq"/>
        </xsl:apply-templates>

    </xsl:function>

    <!-- A wrapper function for a regular mode -->
    <xsl:function name="cpm:fastcust.number">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.number"/>
    </xsl:function>

    <!-- An API function for a fast mode -->
    <xsl:function name="cpm:number">
        <xsl:param name="element"/>
        <xsl:param name="hinumber"/>
        <xsl:param name="hinumseq"/>
        <xsl:apply-templates select="$element" mode="number">
            <xsl:with-param name="hinumber" select="$hinumber"/>
            <xsl:with-param name="hinumseq" select="$hinumseq"/>
        </xsl:apply-templates>
    </xsl:function>

    <!-- An API function for a regular mode -->
    <xsl:function name="cpm:number">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="number"/>
    </xsl:function>


    <!-- 
        Retrieving an element caption 
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.caption">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.caption"/>
    </xsl:function>

    <!-- An API function -->
    <xsl:function name="cpm:caption">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="caption"/>
    </xsl:function>


    <!-- 
        Retrieving a number navigation caption, e.g. Table, Figure, etc. 
    -->

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.navcaption">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.navcaption"/>
    </xsl:function>
    
    <!-- An API function -->
    <xsl:function name="cpm:navcaption">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="navcaption"/>
    </xsl:function>


    <!-- 
        Assembling a full number for an element
    -->
    
    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.full_number">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.full_number"/>
    </xsl:function>
    
    <!-- An API function -->
    <xsl:function name="cpm:full_number">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="full_number"/>
    </xsl:function>
    
    
    <!-- 
        Assembling a full navigation number for an element
    -->
    
    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.nav_full_number">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.fastcust.nav_full_number"/>
    </xsl:function>
    
    <!-- An API function -->
    <xsl:function name="cpm:nav_full_number">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="nav_full_number"/>
    </xsl:function>
    
    
    <!-- 
        Extracting a separator between a full number and a title
    -->
    <xsl:function name="cpm:fastcust.numsep">

        <xsl:param name="element"/>

        <xsl:variable name="ft">
            <xsl:value-of select="cpm:fastcust.full_title($element)"/>
        </xsl:variable>

        <xsl:variable name="fn">
            <xsl:value-of select="cpm:fastcust.full_number($element)"/>
        </xsl:variable>

        <xsl:variable name="ti">
            <xsl:value-of select="cpm:fastcust.title($element)"/>
        </xsl:variable>

        <xsl:value-of select="substring-before(substring-after($ft, $fn), $ti)"/>

    </xsl:function>



    <!-- ================== -->
    <!--  Cross references  -->
    <!-- ================== -->

    <!-- 
        Retrieving an ID of a cross reference target elemet 
    -->
    <xsl:function name="cpm:fastcust.refid">

        <!-- A target element, e.g. concept, table, title, etc. -->
        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="refid"/>

    </xsl:function>



    <!-- ================ -->
    <!--  TOC properties  -->
    <!-- ================ -->

    <!-- 
        Retrieving an element title
    -->
    <xsl:function name="cpm:fastcust.title">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="title"/>

    </xsl:function>


    <!-- 
        Assembling a full title for an element
    -->
    <xsl:function name="cpm:fastcust.full_title">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <!-- Improved document & flat document-->

        <xsl:value-of select="cpm:fastcust.full_number($element)"/>
        <xsl:value-of select="cpm:fastcust.title($element)"/>

    </xsl:function>


    <!-- 
        Assembling a full title TOC/TON for an element
    -->
    <xsl:function name="cpm:fastcust.nav_full_title">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <!-- Improved document & flat document-->

        <xsl:value-of select="cpm:fastcust.nav_full_number($element)"/>
        <xsl:value-of select="cpm:fastcust.title($element)"/>

    </xsl:function>



    <!-- ======================= -->
    <!--  Formatting properties  -->
    <!-- ======================= -->

    <!-- 
        Detecting an element class
    -->
    <xsl:function name="cpm:eclass" as="xs:boolean">

        <!-- 
            An element class is a value that allowes a customization
            to detect a "nature" of an element. The "nature" is 
            paragraph, list, list item, etc. 
            
            The function returns a string value that formatting rules
            can refer on, e.g.:            
            
            <element context="*[cpm:eclass()='topic/li']" style="List Item"/>
        -->

        <!-- Any element in a document -->
        <xsl:param name="element"/>

        <!-- A class we check an element -->
        <xsl:param name="class"/>

        <!-- 
            A customization should provide a template (templates) having
            mode="eclass". 
        -->

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:apply-templates select="$element" mode="eclass">
                <xsl:with-param name="class" select="$class"/>
            </xsl:apply-templates>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Detecting a strict element class
    -->
    <xsl:function name="cpm:sclass">

        <!-- 
            An element class is a value that allowes a customization
            to detect a "nature" of an element. The "nature" is 
            paragraph, list, list item, etc. 
            
            The function returns a string value that formatting rules
            can refer on, e.g.:        
            
            Unlike cpm:eclass() the cpm:sclass() function returns the 
            most specific element class. E.g. cpm:sclass(.)='topic/li'
            is true for a list item but it's false for a task step. 
            At the same time  cpm:sclass(.)='task/step' is true for 
            a task step. 
            
            <element context="*[cpm:eclass()='topic/li']" style="List Item"/>
        -->

        <!-- Any element in a document -->
        <xsl:param name="element"/>

        <!-- 
            A customization should provide a template (templates) having
            mode="sclass". 
        -->
        <xsl:apply-templates select="$element" mode="sclass"/>

    </xsl:function>


    <!-- 
        Output class
    -->

    <!-- Detecting an output class value -->
    <xsl:function name="cpm:oclass">

        <!-- 
            The function returns a string value that formatting rules
            can refer on, e.g.:            
            
            <element context="p[cpm:oclass()='foo']" style="Foo Top Heading"/>
        -->

        <!-- Any element in a document -->
        <xsl:param name="element"/>

        <!-- 
            A customization should provide a template (templates) having
            mode="oclass". 
        -->
        <xsl:apply-templates select="$element" mode="oclass"/>

    </xsl:function>

    <!-- Detecting elements having empty output class -->
    <xsl:function name="cpm:noclass" as="xs:boolean">

        <xsl:param name="element"/>

        <xsl:value-of select="cpm:oclass($element) = ''"/>

    </xsl:function>


    <!-- 
        FO element name for a source element
    -->
    <xsl:function name="cpm:fastcust.foname">

        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="foname"/>

    </xsl:function>


    <!-- 
        Detecting elements that are nested into an appendix
    -->
    <xsl:function name="cpm:in_appendix" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="in_appendix"/>
    </xsl:function>


    <!--
        Detecting elements nested into listitems
    -->
    <xsl:function name="cpm:in_list" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="in_list"/>
    </xsl:function>


    <!-- 
        Detecting elements that are nested into a table
    -->
    <xsl:function name="cpm:in_table" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="in_table"/>
    </xsl:function>


    <!--
        Detecting an element that has no any specific nesting
    -->
    <xsl:function name="cpm:is_normal" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_normal"/>
    </xsl:function>

    <xsl:template match="*" mode="colclass"/>

    <xsl:function name="cpm:colclass">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="colclass"/>
    </xsl:function>

    <xsl:function name="cpm:colpos">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="colpos"/>
    </xsl:function>

    <xsl:function name="cpm:rowclass">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="rowclass"/>
    </xsl:function>




</xsl:stylesheet>
