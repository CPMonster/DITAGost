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
             
    Usage:      Import the XSLT stylesheet into your custom.xsl.  
-->   
<!-- * * ** *** ***** ******** ************* ********************* --> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:ot-placeholder="http://www.idiominc.com/ot-placeholder"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Paths and URIs (CPM common)-->
    <xsl:import href="../../common/xsl-2.0/pathuri.xsl"/>

    <!-- Typography -->
    <xsl:import href="../../common/xsl-2.0/typo.xsl"/>

    <!-- Working with DITA -->
    <xsl:import href="../../dita/xsl-2.0/queries.xsl"/>

    <!-- Working with FO -->
    <xsl:import href="../../fo/xsl-2.0/queries.xsl"/>

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
    <xsl:template match="*" mode="is_section" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_topic(.)"/>
    </xsl:template>


    <!-- 
        Detecting if an element is appendix
    -->
    <xsl:template match="*" mode="is_appendix" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_appendix(.)"/>
    </xsl:template>


    <!-- 
        Detecting if an element belongs to frontmatter
    -->
    <xsl:template match="*" mode="is_frontmatter" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_frontmatter(.)"/>
    </xsl:template>


    <!-- 
        Detecting if an element belongs to backmatter
    -->
    <xsl:template match="*" mode="is_backmatter">
        <xsl:value-of select="cpm:dita.is_backmatter(.)"/>
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
        <xsl:value-of select="cpm:dita.lang(.)"/>
    </xsl:template>


    <!-- 
        Testing an element class
    -->
    <xsl:template match="*" mode="eclass">

        <xsl:param name="class"/>

        <!-- 
            * represents a DITA element or a FO element.
        -->

        <xsl:value-of select="cpm:dita.eclass(., $class)"/>

    </xsl:template>


    <!-- 
        Detecting an element output class 
    -->
    <xsl:template match="*" mode="oclass">

        <!-- 
            * represents a DITA element or a FO element.
        -->

        <xsl:choose>
            <xsl:when test="@outputclass">
                <xsl:value-of select="@outputclass"/>
            </xsl:when>                        
            <xsl:when test="cpm:fo.is_fo(.)">
                <xsl:value-of select="cpm:fo.oclass(.)"/>
            </xsl:when>           
            <xsl:otherwise/>
        </xsl:choose>

    </xsl:template>


    <!-- 
        Detecting the most specific element class
    -->
    <xsl:template match="*" mode="sclass">
        <xsl:value-of select="cpm:dita.sclass(.)"/>
    </xsl:template>



    <!-- ======================================= -->
    <!--  Assigning levels to document elements  -->
    <!-- ======================================= -->

    <!-- 
        Excluding redundant elements a stage1a file mignt contain
    -->
    <xsl:template match="opentopic:map | ot-placeholder:toc" mode="level">
        <xsl:value-of select="-1"/>
    </xsl:template>



    <!-- =================== -->
    <!--  Assigning numbers  -->
    <!-- =================== -->

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
    <xsl:template match="*[cpm:dita.is_topic(.)]" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>


    <!-- 
        Body elements 
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/body')]" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>


    <!-- 
        Titles 
    -->
    <xsl:template match="*[cpm:dita.is_title(.)]" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>


    <!-- 
        Local sections 
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/section')]" mode="foname">
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



    <!-- ============ -->
    <!--  Paragraphs  -->
    <!-- ============ -->

    <!-- 
        A paragraph 
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/p')]" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>



    <!-- ======== -->
    <!--  Tables  -->
    <!-- ======== -->

    <!-- 
        An entire table 
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/table')]" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>


    <!-- 
        A tgroup element
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/tgroup')]" mode="foname">
        <xsl:text>fo:table</xsl:text>
    </xsl:template>


    <!-- 
        A colspec element
    -->

    <!-- Choosing a FO element -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/colspec')]" mode="foname">
        <xsl:text>fo:table-column</xsl:text>
    </xsl:template>

    <!-- Creating attributes -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/colspec')]" mode="foattrs">
        <xsl:if test="@colwidth">
            <xsl:variable name="total">
                <xsl:value-of select="sum(../colspec/cpm:typo.get_value(@colwidth))"/>
            </xsl:variable>
            <xsl:variable name="width">
                <xsl:value-of select="cpm:typo.get_value(@colwidth)"/>
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
    <xsl:template match="*[cpm:dita.eclass(., 'topic/thead')]" mode="foname">
        <xsl:text>fo:table-header</xsl:text>
    </xsl:template>


    <!-- 
        A table body
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/tbody')]" mode="foname">
        <xsl:text>fo:table-body</xsl:text>
    </xsl:template>


    <!-- 
        A table footer
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/tfooter')]" mode="foname">
        <xsl:text>fo:table-footer</xsl:text>
    </xsl:template>


    <!-- 
        A table row
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/row')]" mode="foname">
        <xsl:text>fo:table-row</xsl:text>
    </xsl:template>


    <!-- 
        A table entry
    -->

    <!-- Choosing a FO element -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/entry')]" mode="foname">
        <xsl:text>fo:table-cell</xsl:text>
    </xsl:template>

    <!-- Creating attributes -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/entry')]" mode="foattrs">

        <!-- Number of rows a call spans over -->
        <xsl:if test="@morerows">
            <xsl:attribute name="number-rows-spanned">
                <xsl:value-of select="@morerows + 1"/>
            </xsl:attribute>
        </xsl:if>

        <!-- Number of columns a call spans over -->
        <xsl:variable name="number-columns-spans">
            <xsl:value-of select="cpm:dita.colspans(.)"/>
        </xsl:variable>

        <xsl:if test="$number-columns-spans &gt; 1">
            <xsl:attribute name="number-columns-spanned">
                <xsl:value-of select="$number-columns-spans"/>
            </xsl:attribute>
        </xsl:if>

    </xsl:template>

    <!-- Wrapping cell content into a block -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/entry')]" mode="foinner">
        <fo:block>
            <xsl:if test="normalize-space(.) = ''">
                <xsl:text>&#160;</xsl:text>
            </xsl:if>
            <xsl:apply-templates select="node()" mode="foxml"/>
        </fo:block>
    </xsl:template>

    <!-- Detecting elements that are nested into a table -->
    <xsl:template match="*" mode="in_table" as="xs:boolean">

        <!-- 
            * represents DITA element that is probably nested 
            into a table. 
        -->

        <xsl:choose>
            <xsl:when test="cpm:fo.is_fo(.)">
                <xsl:value-of select="@role = 'table'"/>
            </xsl:when>           
            <xsl:otherwise>
                <xsl:value-of select="cpm:dita.in_table(.)"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>



    <!-- ======= -->
    <!--  Notes  -->
    <!-- ======= -->

    <!-- 
        Choosing a FO element 
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/note')]" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>



    <!-- ====================== -->
    <!--  List items (generic)  -->
    <!-- ====================== -->

    <!--
        Choosing a FO element name for a list item
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/li')]" mode="foname">
        <xsl:text>fo:list-item</xsl:text>
    </xsl:template>


    <!-- 
        Assigning a numbering level to a list item
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/li')]" mode="numlevel">
        <xsl:value-of select="count(ancestor::*[cpm:dita.eclass(., 'topic/li')]) + 1"/>
    </xsl:template>


    <!-- 
        Assembling inner FO for a list item
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/li')]" mode="foinner">

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

        <!-- Assembling a list item body -->
        <xsl:variable name="body">

            <fo:list-item-body cpm:numlevel="{cpm:numlevel(.)}">

                <xsl:if test="cpm:in_table(.)">
                    <xsl:attribute name="role">table</xsl:attribute>
                </xsl:if>

                <fo:block>
                    <xsl:copy-of select="node()"/>
                </fo:block>

            </fo:list-item-body>

        </xsl:variable>

        <!-- Formatting list item content -->
        <xsl:variable name="formatted_body">
            <xsl:apply-templates select="$body/*" mode="foxml"/>
        </xsl:variable>

        <!-- Nesting foratted content into a formatted list item body -->
        <fo:list-item-body>
            <xsl:copy-of select="$formatted_body/*/@*"/>
            <fo:block>
                <xsl:copy-of select="$formatted_body/*/*/@*"/>
                <xsl:apply-templates select="node()" mode="foxml"/>
            </fo:block>
        </fo:list-item-body>

    </xsl:template>



    <!-- ================ -->
    <!--  Unsorted lists  -->
    <!-- ================ -->

    <!-- 
        Choosing a FO element name for an unsorted list
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/ul')]" mode="foname">
        <xsl:text>fo:list-block</xsl:text>
    </xsl:template>


    <!-- 
        Assembling a default marker for an item of an unsorted list 
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/ul')]/*[cpm:dita.eclass(., 'topic/li')]"
        mode="fomarker">
        <xsl:text>–</xsl:text>
    </xsl:template>



    <!-- =============== -->
    <!--  Ordered lists  -->
    <!-- =============== -->

    <!-- 
        Choosing a FO element name for an ordered list 
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/ol')]" mode="foname">
        <xsl:text>fo:list-block</xsl:text>
    </xsl:template>


    <!-- 
        Assembling a number for a list item 
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/ol')]/*[cpm:dita.eclass(., 'topic/li')]"
        mode="fomarker">
        <xsl:value-of select="cpm:fastcust.full_number(.)"/>
    </xsl:template>



    <!-- ========= -->
    <!--  Figures  -->
    <!-- ========= -->

    <!-- 
        Assembling inner FO for a figure
    -->
    <xsl:template match="*[cpm:dita.eclass(., 'topic/fig')]" mode="foinner">

        <!-- Assembling a block wrapper for an image -->
        <xsl:variable name="body">
            <fo:block outputclass="image">
                <xsl:attribute name="xtrf">
                    <xsl:value-of select="ancestor::*[not(parent::*)]/@xtrf"/>
                </xsl:attribute>
                <xsl:apply-templates select="*[cpm:dita.eclass(., 'topic/image')]" mode="foxml"/>
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
    <xsl:template match="*[cpm:dita.eclass(., 'topic/image')]" mode="foattrs">

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
    <xsl:template match="*[cpm:dita.eclass(., 'topic/ph')]" mode="foname">
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
