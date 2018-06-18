<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster    
    
    Level:      Library        
    
    Part:       FastCust
    Module:     dita.xsl
    
    Scope:      FO
    
    Func:       Provides the support for DITA OT customization or 
                any other set of XSLT stylesheets that transforms
                a DITA source document to FO
             
    Usage:      Import the XSLT stylesheet into your cust.xsl.  
-->   
<!-- * * ** *** ***** ******** ************* ********************* --> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:ot-placeholder="http://www.idiominc.com/ot-placeholder"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Paths and URIs (CPM common)-->
    <xsl:import href="../../common/xsl-2.0/pathuri.xsl"/>

    <!-- Accessing document parameters -->
    <xsl:import href="fastcust.xsl"/>

    <!-- 
        TOC - a table of content
        TON - a table of numerated objects, e.g. tables
    -->

    <!-- TOCs and TONs -->
    <xsl:import href="tocton.xsl"/>



    <!-- =========== -->
    <!--  Constants  -->
    <!-- =========== -->

    <!-- 
        Class signatures
    -->

    <!-- Topics -->
    <xsl:variable name="CS_TOPIC" select="'topic/topic'"/>

    <!-- Bodies -->
    <xsl:variable name="CS_BODY" select="'topic/body'"/>

    <!-- Titles -->
    <xsl:variable name="CS_TITLE" select="'topic/title'"/>

    <!-- Sections -->
    <xsl:variable name="CS_SECTION" select="'topic/section'"/>

    <!-- Paragraps -->
    <xsl:variable name="CS_P" select="'topic/p '"/>

    <!-- Phrases -->
    <xsl:variable name="CS_PH" select="'topic/ph '"/>

    <!-- Unordered lists -->
    <xsl:variable name="CS_UL" select="'topic/ul '"/>

    <!-- Ordered lists -->
    <xsl:variable name="CS_OL" select="'topic/ol '"/>

    <!-- List items -->
    <xsl:variable name="CS_LI" select="'topic/li '"/>

    <!-- Steps -->
    <xsl:variable name="CS_STEPS" select="'task/steps '"/>

    <!-- A step -->
    <xsl:variable name="CS_STEP" select="'task/step '"/>

    <!-- Info, etc. -->
    <xsl:variable name="CS_ITEMGROUP" select="'topic/itemgroup'"/>

    <!-- Note -->
    <xsl:variable name="CS_NOTE" select="'topic/note'"/>

    <!-- Tables -->
    <xsl:variable name="CS_TABLE" select="'topic/table'"/>
    <xsl:variable name="CS_TGROUP" select="'topic/tgroup'"/>
    <xsl:variable name="CS_COLSPEC" select="'topic/colspec'"/>
    <xsl:variable name="CS_THEAD" select="'topic/thead'"/>
    <xsl:variable name="CS_TBODY" select="'topic/tbody'"/>
    <xsl:variable name="CS_TFOOT" select="'topic/tfoot'"/>
    <xsl:variable name="CS_ROW" select="'topic/row'"/>
    <xsl:variable name="CS_ENTRY" select="'topic/entry'"/>

    <!-- Figures, Images -->
    <xsl:variable name="CS_IMAGE" select="'topic/image'"/>
    <xsl:variable name="CS_FIG" select="'topic/fig'"/>



    <!-- ========= -->
    <!--  Queries  -->
    <!-- ========= -->

    <!-- 
        Detecting if an element is a topic 
    -->
    <xsl:template match="*" mode="is_section">

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="contains(@class, $CS_TOPIC)">
                    <xsl:value-of select="true()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:template>


    <!-- 
        Detecting if an element is appendix
    -->
    <xsl:template match="*" mode="is_appendix">

        <xsl:variable name="id">
            <xsl:value-of select="@id"/>
        </xsl:variable>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="//appendix[@id = $id]">
                    <xsl:value-of select="true()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:template>


    <!-- 
        Detecting if an element belongs to frontmatter
    -->
    <xsl:template match="*" mode="is_frontmatter">

        <xsl:variable name="id">
            <xsl:value-of select="@id"/>
        </xsl:variable>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="//frontmatter//*[@data-topic-id = $id]">
                    <xsl:value-of select="true()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:template>


    <!-- 
        Detecting if an element belongs to backmatter
    -->
    <xsl:template match="*" mode="is_backmatter">

        <xsl:variable name="id">
            <xsl:value-of select="@id"/>
        </xsl:variable>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="//backmatter//*[@id = $id]">
                    <xsl:value-of select="true()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:template>


    <!-- 
        Detecting if an element is a title
    -->
    <xsl:template match="*" mode="is_title">
        <xsl:value-of select="contains(@class, $CS_TITLE)"/>
    </xsl:template>


    <!-- 
        Detecting a languae
    -->
    <xsl:template match="*" mode="lang">

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
                <xsl:apply-templates select="parent::*" mode="lang"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 
        Checking an element class 
    -->
    <xsl:template match="*" mode="eclass" as="xs:boolean">

        <xsl:param name="class"/>

        <xsl:value-of select="contains(@class, $class)"/>

    </xsl:template>


    <!-- 
        Checking the most specific element class
    -->
    <xsl:template match="*" mode="sclass" as="xs:boolean">

        <xsl:param name="class"/>

        <xsl:variable name="remain">
            <xsl:value-of select="normalize-space(substring-after(@class, $class))"/>
        </xsl:variable>

        <xsl:value-of select="$remain = ''"/>

    </xsl:template>


    <!-- 
        Output class 
    -->
    <xsl:template match="*" mode="oclass">

        <!-- 
            A customization can overload this template for particular
            elements. Overloading this template can be requred for
            autodetecting output class in some cases.
        -->

        <xsl:choose>
            <xsl:when test="@outputclass">
                <xsl:value-of select="@outputclass"/>        
            </xsl:when>
            <xsl:when test="namespace-uri() = 'http://www.w3.org/1999/XSL/Format'">
                <xsl:value-of select="@role"/>        
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>        

    </xsl:template>



    <!-- ======================================= -->
    <!--  Assigning levels to document elements  -->
    <!-- ======================================= -->

    <!-- 
        Assigning a level to a title of a non-terminal topic 
    -->
    <!--
    <xsl:template match="*[cpm:fastcust.is_section(.)]/title" mode="level">
        <xsl:value-of select="count(../ancestor::*[title]) + 1"/>
    </xsl:template>
    -->

    <!-- 
        Assigning a level to a terminal topic
    -->
    <!--
    <xsl:template match="*[cpm:fastcust.is_terminal_topic(.)]" mode="level">
        <xsl:value-of select="count(ancestor::*[title]) + 1"/>
    </xsl:template>
    -->

    <!-- 
        Excluding redundant elements a stage1a file mignt contain
    -->
    <xsl:template match="opentopic:map | ot-placeholder:toc" mode="level">
        <xsl:value-of select="-1"/>
    </xsl:template>


    <!-- 
        Detecting if a topic appears in a document 
    -->

    <!-- A template for topics -->
    <!--
    <xsl:template match="*[contains(@class, $CS_TOPIC)]" mode="is_published">
        <xsl:value-of select="cpm:fastcust.level(.) &gt; 0"/>
    </xsl:template>
    -->



    <!-- =================== -->
    <!--  Assigning numbers  -->
    <!-- =================== -->

    <!-- A main sequence -->

    <!-- 
        Assembling a numbering sequence descriptor for a topic
    -->

    <!-- A template for topics -->
    <!--
    <xsl:template match="*[cpm:fastcust.is_topic(.) and not(cpm:fastcust.is_appendix(.))]"
        mode="numseq">
        <xsl:call-template name="cpm.fastcust.numbers.standard">
            <xsl:with-param name="name" select="'main'"/>
            <xsl:with-param name="type" select="'arabic'"/>
        </xsl:call-template>
    </xsl:template>
    -->

    <!-- A template for a title -->
    <!--
    <xsl:template match="*[cpm:fastcust.is_supsect(.)]/title" mode="numseq">
        <xsl:call-template name="cpm.fastcust.numbers.standard">
            <xsl:with-param name="name" select="'main'"/>
            <xsl:with-param name="type" select="'arabic'"/>
        </xsl:call-template>
    </xsl:template>
    -->


    <!--
        Assembling a number
    -->

    <!-- Retrieving a number for a chapter, subsection, etc. (non-terminal) -->
    <xsl:template match="title[@cpm:number]" mode="fonumber">
        <xsl:value-of select="@cpm:number"/>
    </xsl:template>


    <!-- 
        Calculating a table number
    -->
    <xsl:template match="table/title" mode="fonumber">
        <xsl:value-of select="count(preceding::table/title) + 1"/>
    </xsl:template>



    <!-- ======================================================== -->
    <!--  Creating FO elements corresponding to source elements   -->
    <!-- ======================================================== -->

    <!-- 
        Topic elements 
    -->
    <xsl:template match="*[contains(@class, $CS_TOPIC)]" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>


    <!-- 
        Body elements 
    -->
    <xsl:template match="*[contains(@class, $CS_BODY)]" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>


    <!-- 
        Titles 
    -->
    <xsl:template match="*[contains(@class, $CS_TITLE)]" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>



    <!-- ===== -->
    <!--  TOC  -->
    <!-- ===== -->

    <!-- 
        TOC
    -->
    <xsl:template match="cpm:tocentry" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>



    <!-- ========== -->
    <!--  Sections  -->
    <!-- ========== -->

    <!-- 
        A section 
    -->
    <xsl:template match="*[contains(@class, $CS_SECTION)]" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>



    <!-- ============ -->
    <!--  Paragraphs  -->
    <!-- ============ -->

    <!-- 
        A paragraph 
    -->
    <xsl:template match="*[contains(@class, $CS_P)]" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>



    <!-- ======== -->
    <!--  Tables  -->
    <!-- ======== -->

    <!-- 
        A table 
    -->
    <xsl:template match="*[contains(@class, $CS_TABLE)]" mode="foname">
        <xsl:text>cpm:none</xsl:text>
    </xsl:template>


    <!-- 
        A tgroup element
    -->
    <xsl:template match="*[contains(@class, $CS_TGROUP)]" mode="foname">
        <xsl:text>fo:table</xsl:text>
    </xsl:template>


    <!-- 
        A colspec element
    -->

    <!-- Choosing a FO element -->
    <xsl:template match="*[contains(@class, $CS_COLSPEC)]" mode="foname">
        <xsl:text>fo:table-column</xsl:text>
    </xsl:template>

    <!-- Extracting a numeric part from a size value -->
    <xsl:function name="cpm:fastcust.dita.getnum">
        <xsl:param name="size"/>
        <xsl:value-of select="replace($size, '[A-z]|\*', '')"/>
    </xsl:function>

    <!-- Creating attributes -->
    <xsl:template match="*[contains(@class, $CS_COLSPEC)]" mode="foattrs">
        <xsl:if test="@colwidth">
            <xsl:variable name="total">
                <xsl:value-of select="sum(../colspec/number(cpm:fastcust.dita.getnum(@colwidth)))"/>
            </xsl:variable>
            <xsl:variable name="width">
                <xsl:value-of select="number(cpm:fastcust.dita.getnum(@colwidth))"/>
            </xsl:variable>
            <xsl:attribute name="column-width">
                <xsl:value-of select="100 * $width div $total"/>
                <xsl:text>%</xsl:text>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>


    <!-- 
        A table header
    -->
    <xsl:template match="*[contains(@class, $CS_THEAD)]" mode="foname">
        <xsl:text>fo:table-header</xsl:text>
    </xsl:template>


    <!-- 
        A table body
    -->
    <xsl:template match="*[contains(@class, $CS_TBODY)]" mode="foname">
        <xsl:text>fo:table-body</xsl:text>
    </xsl:template>


    <!-- 
        A table footer
    -->
    <xsl:template match="*[contains(@class, $CS_TFOOT)]" mode="foname">
        <xsl:text>fo:table-footer</xsl:text>
    </xsl:template>


    <!-- 
        A table row
    -->
    <xsl:template match="*[contains(@class, $CS_ROW)]" mode="foname">
        <xsl:text>fo:table-row</xsl:text>
    </xsl:template>


    <!-- 
        A table entry
    -->

    <!-- Detect a position of a column by its name -->
    <xsl:function name="cpm:fastcust.dita.colpos">

        <!-- A tgroup element -->
        <xsl:param name="tgroup"/>

        <!-- A column name -->
        <xsl:param name="colname"/>

        <xsl:value-of
            select="$tgroup/colspec[@colname = $colname]/count(preceding-sibling::colspec) + 1"/>

    </xsl:function>

    <!-- Choosing a FO element -->
    <xsl:template match="*[contains(@class, $CS_ENTRY)]" mode="foname">
        <xsl:text>fo:table-cell</xsl:text>
    </xsl:template>

    <!-- Creating attributes -->
    <xsl:template match="*[contains(@class, $CS_ENTRY)]" mode="foattrs">

        <xsl:if test="@morerows">
            <xsl:attribute name="number-rows-spanned">
                <xsl:value-of select="@morerows + 1"/>
            </xsl:attribute>
        </xsl:if>

        <xsl:if test="@morecols">
            <xsl:attribute name="number-columns-spanned">
                <xsl:value-of select="@morecols + 1"/>
            </xsl:attribute>
        </xsl:if>

        <xsl:if test="@namest and @nameend">

            <xsl:variable name="pos1">
                <xsl:value-of select="cpm:fastcust.dita.colpos(ancestor::tgroup, @namest)"/>
            </xsl:variable>

            <xsl:variable name="pos2">
                <xsl:value-of select="cpm:fastcust.dita.colpos(ancestor::tgroup, @nameend)"/>
            </xsl:variable>

            <xsl:attribute name="number-columns-spanned">
                <xsl:value-of select="$pos2 - $pos1 + 1"/>
            </xsl:attribute>

        </xsl:if>

    </xsl:template>

    <!-- Wrapping cell content into a block -->
    <xsl:template match="*[contains(@class, $CS_ENTRY)]" mode="foinner">
        <fo:block>
            <xsl:if test="normalize-space(.) = ''">
                <xsl:text>&#160;</xsl:text>
            </xsl:if>
            <xsl:apply-templates select="node()" mode="foxml"/>
        </fo:block>
    </xsl:template>



    <!-- ======= -->
    <!--  Notes  -->
    <!-- ======= -->

    <!-- 
        Choosing a FO element 
    -->
    <xsl:template match="*[contains(@class, $CS_NOTE)]" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>


    <!-- 
        Assembling captionn (default) 
    -->
    <!--
    <xsl:template match="note" mode="cpm.fastcust.explicit_caption">
        <xsl:text>NOTE</xsl:text>
    </xsl:template>
    -->

    <!-- 
        Assembling note inner FO 
    -->
    <!--
    <xsl:template match="note" mode="foinner">
        <xsl:element name="fo:block">
            <xsl:apply-templates select="." mode="focaption"/>
        </xsl:element>
        <fo:block>
            <xsl:apply-templates select="node()" mode="foxml"/>
        </fo:block>
    </xsl:template>
    -->



    <!-- ====================== -->
    <!--  List items (generic)  -->
    <!-- ====================== -->

    <!--
        Choosing a FO element name for a list item
    -->
    <xsl:template match="*[contains(@class, $CS_LI)]" mode="foname">
        <xsl:text>fo:list-item</xsl:text>
    </xsl:template>


    <!-- 
        Assigning a numbering level to a list item
    -->
    <xsl:template match="*[contains(@class, $CS_LI)]" mode="numlevel">
        <xsl:value-of select="count(ancestor::*[contains(@class, $CS_LI)]) + 1"/>
    </xsl:template>


    <!-- 
        Assembling inner FO for a list item
    -->
    <xsl:template match="*[not(ancestor::entry) and contains(@class, $CS_LI)]" mode="foinner">

        <!-- Assembling a label for an list item -->
        <xsl:variable name="label">
            <fo:list-item-label>
                <fo:block>
                    <xsl:apply-templates select="." mode="fomarker"/>
                </fo:block>
            </fo:list-item-label>
        </xsl:variable>

        <!-- Formatting a label -->
        <xsl:apply-templates select="$label/*" mode="foxml"/>

        <!-- Assembling content for a list item -->
        <xsl:variable name="body">
            <fo:list-item-body cpm:numlevel="{cpm:numlevel(.)}">
                <fo:block>
                    <xsl:apply-templates select="node()" mode="foxml"/>
                </fo:block>
            </fo:list-item-body>
        </xsl:variable>

        <!-- Formatting content -->
        <xsl:apply-templates select="$body/*" mode="foxml"/>

    </xsl:template>


    <!-- 
        Assembling inner FO for a list item
    -->
    <xsl:template match="*[ancestor::entry and contains(@class, $CS_LI)]" mode="foinner">

        <!-- Assembling a label for an list item -->
        <xsl:variable name="label">
            <fo:list-item-label>
                <fo:block role="table">
                    <xsl:apply-templates select="." mode="fomarker"/>
                </fo:block>
            </fo:list-item-label>
        </xsl:variable>

        <!-- Formatting a label -->
        <xsl:apply-templates select="$label/*" mode="foxml"/>

        <!-- Assembling content for a list item -->
        <xsl:variable name="body">
            <fo:list-item-body cpm:numlevel="{cpm:numlevel(.)}" role="table">
                <fo:block>
                    <xsl:apply-templates select="node()" mode="foxml"/>
                </fo:block>
            </fo:list-item-body>
        </xsl:variable>

        <!-- Formatting content -->
        <xsl:apply-templates select="$body/*" mode="foxml"/>

    </xsl:template>



    <!-- ================ -->
    <!--  Unsorted lists  -->
    <!-- ================ -->

    <!-- 
        Choosing a FO element name for an unsorted list
    -->
    <xsl:template match="*[contains(@class, $CS_UL)]" mode="foname">
        <xsl:text>fo:list-block</xsl:text>
    </xsl:template>


    <!-- 
        Assembling a default marker for an item of an unsorted list 
    -->
    <xsl:template match="*[contains(@class, $CS_UL)]/*[contains(@class, $CS_LI)]" mode="fomarker">
        <xsl:text>–</xsl:text>
    </xsl:template>



    <!-- =============== -->
    <!--  Ordered lists  -->
    <!-- =============== -->

    <!-- 
        Choosing a FO element name for an ordered list 
    -->
    <xsl:template match="*[contains(@class, $CS_OL)]" mode="foname">
        <xsl:text>fo:list-block</xsl:text>
    </xsl:template>


    <!-- 
        Assembling a number for a list item 
    -->
    <xsl:template match="*[contains(@class, $CS_OL)]/*[contains(@class, $CS_LI)]" mode="fomarker">
        <xsl:value-of select="cpm:fastcust.full_number(.)"/>
    </xsl:template>



    <!-- ======== -->
    <!--  Tasks  -->
    <!-- ======= -->

    <!-- 
        Choosing a FO element name for a block of steps 
    -->
    <!--
    <xsl:template match="*[contains(@class, $CS_STEPS)]" mode="foname">
        <xsl:text>fo:list-block</xsl:text>
    </xsl:template>
    -->

    <!-- 
        Assembling a number for a step
    -->
    <!--
    <xsl:template match="*[contains(@class, $CS_STEP)]" mode="fomarker">
        <xsl:value-of select="cpm:fastcust.full_number(.)"/>
    </xsl:template>
    -->


    <!-- ========= -->
    <!--  Figures  -->
    <!-- ========= -->

    <!-- 
        Assembling inner FO for a figure
    -->
    <xsl:template match="*[contains(@class, $CS_FIG)]" mode="foinner">

        <!-- Assembling a block wrapper for an image -->
        <xsl:variable name="body">
            <fo:block outputclass="image">
                <xsl:attribute name="xtrf">
                    <xsl:value-of select="ancestor::*[not(parent::*)]/@xtrf"/>
                </xsl:attribute>
                <xsl:apply-templates select="*[contains(@class, $CS_IMAGE)]" mode="foxml"/>
            </fo:block>
        </xsl:variable>

        <!-- Formatting a wrapper -->
        <xsl:apply-templates select="$body/fo:block" mode="foxml"/>

        <!-- Formatting a title -->
        <xsl:apply-templates select="title" mode="foxml"/>

        <!-- Formatting additional text -->
        <xsl:apply-templates select="p" mode="foxml"/>

    </xsl:template>


    <!-- Assembling attributes -->
    <xsl:template match="*[contains(@class, $CS_IMAGE)]" mode="foattrs">

        <xsl:if test="@width">
            <xsl:attribute name="content-width">
                <xsl:value-of select="@width"/>
            </xsl:attribute>
        </xsl:if>

        <xsl:if test="@height">
            <xsl:attribute name="content-height">
                <xsl:value-of select="@height"/>
            </xsl:attribute>
        </xsl:if>

        <xsl:attribute name="src">
            <xsl:call-template name="cpm.pathuri.get_referred_uri">
                <xsl:with-param name="base_uri" select="cpm:fastcust.ditamap_uri()"/>
                <xsl:with-param name="href" select="@href"/>
            </xsl:call-template>
        </xsl:attribute>

    </xsl:template>


    <!-- 
        Phrases: apiname, b, i, etc. 
    -->
    <xsl:template match="*[contains(@class, $CS_PH)]" mode="foname">
        <xsl:text>fo:inline</xsl:text>
    </xsl:template>


    <!-- 
        Assigning a class attribute to an element
    -->
    <xsl:template match="*" mode="cpm.fastcust.dita.assign_class">

        <!-- A value we are going to assign to a @class attribute -->
        <xsl:param name="ditaclass"/>

        <xsl:copy>

            <xsl:copy-of select="@* except @class"/>

            <xsl:attribute name="class">
                <xsl:value-of select="$ditaclass"/>
            </xsl:attribute>

            <xsl:copy-of select="node()"/>

        </xsl:copy>

    </xsl:template>


    <!-- 
        Assigning a class attribute topic/topic to an element
    -->
    <xsl:template match="*" mode="cpm.fastcust.dita.assign_class_topic">

        <xsl:apply-templates select="." mode="cpm.fastcust.dita.assign_class">
            <xsl:with-param name="ditaclass" select="$CS_TOPIC"/>
        </xsl:apply-templates>

    </xsl:template>


    <!-- 
        Assigning a class attribute topic/title to an element
    -->
    <xsl:template match="*" mode="cpm.fastcust.dita.assign_class_title">

        <xsl:apply-templates select="." mode="cpm.fastcust.dita.assign_class">
            <xsl:with-param name="ditaclass" select="$CS_TITLE"/>
        </xsl:apply-templates>

    </xsl:template>


    <!-- 
        Assigning a class attribute topic/fig to an element
    -->
    <xsl:template match="*" mode="cpm.fastcust.dita.assign_class_fig">

        <xsl:apply-templates select="." mode="cpm.fastcust.dita.assign_class">
            <xsl:with-param name="ditaclass" select="$CS_FIG"/>
        </xsl:apply-templates>

    </xsl:template>


    <!-- 
        Assigning a class attribute topic/image to an element
    -->
    <xsl:template match="*" mode="cpm.fastcust.dita.assign_class_image">

        <xsl:apply-templates select="." mode="cpm.fastcust.dita.assign_class">
            <xsl:with-param name="ditaclass" select="$CS_IMAGE"/>
        </xsl:apply-templates>

    </xsl:template>



    <!-- ================== -->
    <!--  Cross references  -->
    <!-- ================== -->

    <!-- 
        Selecting a wrapper FO element name for a cross reference
    -->
    <xsl:template match="xref" mode="foname">
        <xsl:text>cpm:none</xsl:text>
    </xsl:template>



    <!-- 
        Assembling a FO representation for a cross reference
    -->
    <xsl:template match="xref" mode="foinner">

        <xsl:variable name="refid">
            <xsl:choose>
                <xsl:when test="contains(@href, '/')">
                    <xsl:value-of select="substring-after(@href, '/')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="substring-after(@href, '#')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="actual_refid" select="cpm:fastcust.refid(root(.)//*[@id = $refid])"/>

        <!--<fo:basic-link internal-destination="{$actual_refid}">-->

        <xsl:if test=". != ''">
            <xsl:value-of select="."/>
            <xsl:text>&#160;</xsl:text>
        </xsl:if>

        <xsl:value-of select="cpm:fastcust.number(root(.)//*[@id = $refid])"/>

        <!--</fo:basic-link>-->

    </xsl:template>


    <!-- ============== -->
    <!--  Corner cases  -->
    <!-- ============== -->

    <!-- We have no corner cases so far -->


</xsl:stylesheet>
