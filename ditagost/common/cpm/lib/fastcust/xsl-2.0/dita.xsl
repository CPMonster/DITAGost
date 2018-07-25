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



    <!-- ========= -->
    <!--  Queries  -->
    <!-- ========= -->

    <xsl:template match="*" mode="is_block_container" as="xs:boolean">
        <xsl:value-of select="false()"/>
    </xsl:template>

    <xsl:template match="*" mode="is_block" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_block(.)"/>
    </xsl:template>

    <xsl:template match="*" mode="is_inline" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_inline(.)"/>
    </xsl:template>

    <xsl:template match="*" mode="is_list_block" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_ul(.) or cpm:dita.is_ol(.)"/>
    </xsl:template>

    <xsl:template match="*" mode="is_list_item_body" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_li(.)"/>
    </xsl:template>

    <xsl:template match="*" mode="is_table" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_tgroup(.)"/>
    </xsl:template>

    <xsl:template match="*" mode="is_table_header" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_thead(.)"/>
    </xsl:template>

    <xsl:template match="*" mode="is_table_body" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_tbody(.)"/>
    </xsl:template>

    <xsl:template match="*" mode="is_table_footer" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_tfoot(.)"/>
    </xsl:template>

    <xsl:template match="*" mode="is_table_row" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_row(.)"/>
    </xsl:template>

    <xsl:template match="*" mode="is_table_cell" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_entry(.)"/>
    </xsl:template>
    
    <xsl:template match="*" mode="is_external_graphic" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_image(.)"/>
    </xsl:template>
        


    <!-- 
        Detecting if an element is appendix
    -->
    <xsl:template match="*" mode="is_appendix" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_appendix(.)"/>
    </xsl:template>


    <!-- 
        Detecting elements nested into an appendix
    -->
    <xsl:template match="*" mode="in_appendix" as="xs:boolean">

        <xsl:choose>
            <xsl:when test="ancestor::*[cpm:dita.is_appendix(.)]">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 
        Detecting if an element belongs to backmatter
    -->
    <xsl:template match="*" mode="is_backmatter" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_backmatter(.)"/>
    </xsl:template>


    <!-- 
        Detecting if an element belongs to frontmatter
    -->
    <xsl:template match="*" mode="is_frontmatter" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_frontmatter(.)"/>
    </xsl:template>


    <!-- 
        Detecting elements nested into lists
    -->
    <xsl:template match="*" mode="in_list" as="xs:boolean">
        <xsl:value-of select="cpm:dita.in_list(.)"/>
    </xsl:template>


    <!-- 
        Detecting elements having no specific nesting
    -->
    <xsl:template match="*" mode="is_normal" as="xs:boolean">

        <xsl:choose>
            <xsl:when test="cpm:in_table(.)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:when test="cpm:in_list(.)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="true()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 
        Detecting if an element is a topic 
    -->
    <xsl:template match="*" mode="is_topic" as="xs:boolean">
        <xsl:message>
            <xsl:text>::: </xsl:text>
        </xsl:message>
        <xsl:value-of select="cpm:dita.is_topic(.)"/>
    </xsl:template>


    <!-- 
        Detecting if an element is a title
    -->
    <xsl:template match="*" mode="is_title" as="xs:boolean">
        <xsl:value-of select="cpm:dita.is_title(.)"/>
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
    <xsl:template match="*" mode="eclass" as="xs:boolean">

        <xsl:param name="class"/>

        <!-- 
            * represents a DITA element or a FO element.
        -->

        <xsl:value-of select="cpm:dita.eclass(., $class)"/>

    </xsl:template>


    <!-- 
        Detecting an element output class 
    -->
    <xsl:template match="*" mode="oclass" as="xs:string">

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
            <xsl:otherwise>
                <xsl:text/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 
        Detecting the most specific element class
    -->
    <xsl:template match="*" mode="sclass" as="xs:string">
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



    <!-- ==================== -->
    <!--  Completing content  -->
    <!-- ==================== -->

    <!-- 
        Supressing redundant elements
    -->
    <xsl:template match="titlealts" mode="complete"/>



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
    <xsl:template match="*[cpm:dita.is_body(.)]" mode="foname">
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
    <xsl:template match="*[cpm:dita.is_section(.)]" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>


    <!-- 
        div elements 
    -->
    <xsl:template match="*[cpm:dita.is_div(.)]" mode="foname">
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
    <xsl:template match="*[cpm:dita.is_p(.)]" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>



    <!-- ======== -->
    <!--  Tables  -->
    <!-- ======== -->

    <!-- 
        An entire table 
    -->
    <xsl:template match="*[cpm:dita.is_table(.)]" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>


    <!-- 
        A tgroup element
    -->
    <xsl:template match="*[cpm:dita.is_tgroup(.)]" mode="foname">
        <xsl:text>fo:table</xsl:text>
    </xsl:template>


    <!-- 
        A colspec element
    -->

    <!-- Choosing a FO element -->
    <xsl:template match="*[cpm:dita.is_colspec(.)]" mode="foname">
        <xsl:text>fo:table-column</xsl:text>
    </xsl:template>

    <!-- Creating attributes -->
    <xsl:template match="*[cpm:dita.is_colspec(.)]" mode="foattrs">
        <xsl:if test="@colwidth">
            <xsl:variable name="total">
                <xsl:value-of
                    select="sum(../*[cpm:dita.is_colspec(.)]/cpm:typo.get_value(@colwidth))"/>
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
    <xsl:template match="*[cpm:dita.is_thead(.)]" mode="foname">
        <xsl:text>fo:table-header</xsl:text>
    </xsl:template>


    <!-- 
        A table body
    -->
    <xsl:template match="*[cpm:dita.is_tbody(.)]" mode="foname">
        <xsl:text>fo:table-body</xsl:text>
    </xsl:template>


    <!-- 
        A table footer
    -->
    <xsl:template match="*[cpm:dita.is_tfoot(.)]" mode="foname">
        <xsl:text>fo:table-footer</xsl:text>
    </xsl:template>


    <!-- 
        A table row
    -->
    <xsl:template match="*[cpm:dita.is_row(.)]" mode="foname">
        <xsl:text>fo:table-row</xsl:text>
    </xsl:template>


    <!-- 
        A table entry
    -->

    <!-- Choosing a FO element -->
    <xsl:template match="*[cpm:dita.is_entry(.)]" mode="foname">
        <xsl:text>fo:table-cell</xsl:text>
    </xsl:template>

    <!-- Creating attributes -->
    <xsl:template match="*[cpm:dita.is_entry(.)]" mode="foattrs">

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
    <xsl:template match="*[cpm:dita.is_entry(.)]" mode="foinner">
        <fo:block>
            <xsl:if test="normalize-space(.) = ''">
                <xsl:text>&#160;</xsl:text>
            </xsl:if>
            <xsl:apply-templates select="node()" mode="foxml"/>
        </fo:block>
    </xsl:template>

    <!-- Calculating a column number -->
    <xsl:template match="*" mode="colpos">
        <xsl:value-of select="cpm:dita.colpos(.)"/>
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


    <xsl:function name="cpm:colcap">

        <!-- A cell or an element nested into a cell -->
        <xsl:param name="element"/>

        <xsl:value-of select="cpm:dita.colcap($element)"/>

    </xsl:function>



    <xsl:function name="cpm:match_colcap" as="xs:boolean">

        <!-- A cell or an element nested into a cell -->
        <xsl:param name="element"/>

        <!-- A list of aliases -->
        <xsl:param name="aliases"/>

        <xsl:value-of select="cpm:dita.match_colcap($element, $aliases)"/>

    </xsl:function>



    <!-- ======= -->
    <!--  Notes  -->
    <!-- ======= -->

    <!-- 
        Choosing a FO element 
    -->
    <xsl:template match="*[cpm:dita.is_note(.)]" mode="foname">
        <xsl:text>fo:block</xsl:text>
    </xsl:template>



    <!-- ====================== -->
    <!--  List items (generic)  -->
    <!-- ====================== -->

    <!--
        Choosing a FO element name for a list item
    -->
    <xsl:template match="*[cpm:dita.is_li(.)]" mode="foname">
        <xsl:text>fo:list-item</xsl:text>
    </xsl:template>


    <!-- 
        Assigning a numbering level to a list item
    -->
    <xsl:template match="*[cpm:dita.is_li(.)]" mode="numlevel">
        <xsl:value-of select="count(ancestor::*[cpm:dita.is_li(.)]) + 1"/>
    </xsl:template>


    <!-- 
        Assembling inner FO for a list item
    -->
    <xsl:template match="*[cpm:dita.is_li(.)]" mode="foinner">

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
    <xsl:template match="*[cpm:dita.is_ul(.)]" mode="foname">
        <xsl:text>fo:list-block</xsl:text>
    </xsl:template>


    <!-- 
        Assembling a default marker for an item of an unsorted list 
    -->
    <xsl:template match="*[cpm:dita.is_ul(.)]/*[cpm:dita.is_li(.)]" mode="fomarker">
        <xsl:text>–</xsl:text>
    </xsl:template>



    <!-- =============== -->
    <!--  Ordered lists  -->
    <!-- =============== -->

    <!-- 
        Choosing a FO element name for an ordered list 
    -->
    <xsl:template match="*[cpm:dita.is_ol(.)]" mode="foname">
        <xsl:text>fo:list-block</xsl:text>
    </xsl:template>


    <!-- 
        Assembling a number for a list item 
    -->
    <xsl:template match="*[cpm:dita.is_ol(.)]/*[cpm:dita.is_li(.)]" mode="fomarker">
        <xsl:value-of select="cpm:fastcust.full_number(.)"/>
    </xsl:template>



    <!-- ========= -->
    <!--  Figures  -->
    <!-- ========= -->

    <!-- 
        Assembling inner FO for a figure
    -->
    <xsl:template match="*[cpm:dita.is_fig(.)]" mode="foinner">

        <!-- Assembling a block wrapper for an image -->
        <xsl:variable name="body">
            <fo:block outputclass="image">
                <xsl:attribute name="xtrf">
                    <xsl:value-of select="ancestor::*[not(parent::*)]/@xtrf"/>
                </xsl:attribute>
                <xsl:apply-templates select="*[cpm:dita.is_image(.)]" mode="foxml"/>
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
    <xsl:template match="*[cpm:dita.is_image(.)]" mode="foattrs">

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
    <xsl:template match="*[cpm:dita.is_inline(.)]" mode="foname">
        <xsl:text>fo:inline</xsl:text>
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
