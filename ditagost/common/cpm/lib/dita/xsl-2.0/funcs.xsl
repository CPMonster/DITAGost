<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster   
    
    Level:      Library
    
    Part:       DITA
    Module:     funcs.xsl
    
    Scope:      DITA
    
    Func:       Wrapper functions for DITA queries                  
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



    <!-- ====== -->
    <!--  i18n  -->
    <!-- ====== -->

    <xsl:function name="cpm:dita.lang">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.lang"/>
    </xsl:function>



    <!-- ===================== -->
    <!--  Calculating indexes  -->
    <!-- ===================== -->

    <!-- 
        Calculating an index of element among its siblings by its hashtag
    -->
    <xsl:function name="cpm:dita.index" as="xs:integer">

        <!-- An element containing a target element-->
        <xsl:param name="parent"/>

        <!-- A list of aliases -->
        <xsl:param name="aliases"/>

        <xsl:choose>

            <xsl:when test="$parent/*[cpm:props.match(., $aliases)]">
                <xsl:variable name="presiblings">
                    <xsl:copy-of
                        select="$parent/*[cpm:props.match(., $aliases)][1]/preceding-sibling::*"/>
                </xsl:variable>
                <xsl:value-of select="count($presiblings/*) + 1"/>
            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="-1"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:function>



    <!-- =========================== -->
    <!--  Detecting element classes  -->
    <!-- =========================== -->

    <xsl:function name="cpm:dita.eclass" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:param name="class"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.eclass">
            <xsl:with-param name="class" select="$class"/>
        </xsl:apply-templates>
    </xsl:function>

    <xsl:function name="cpm:dita.oclass">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.oclass"/>
    </xsl:function>

    <xsl:function name="cpm:dita.sclass">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.sclass"/>
    </xsl:function>



    <!-- ================== -->
    <!--  Detecting topics  -->
    <!-- ================== -->

    <xsl:function name="cpm:dita.is_topic" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_topic"/>
    </xsl:function>        

    <xsl:function name="cpm:dita.is_appendix" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_appendix"/>
    </xsl:function>

    <xsl:function name="cpm:dita.is_frontmatter" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_frontmatter"/>
    </xsl:function>

    <xsl:function name="cpm:dita.is_backmatter" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_backmatter"/>
    </xsl:function>



    <!-- =============================== -->
    <!--  Detecting core topic elements  -->
    <!-- =============================== -->
    
    <xsl:function name="cpm:dita.is_body" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_body"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.is_section" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_section"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.is_div" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_div"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.is_title" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_title"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.is_p" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_p"/>
    </xsl:function>
        
    <xsl:function name="cpm:dita.is_note" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_note"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.is_fig" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_fig"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.is_image" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_image"/>
    </xsl:function>



    <!-- ======= -->
    <!--  Lists  -->
    <!-- ======= -->  

    <xsl:function name="cpm:dita.is_ul" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_ul"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.is_ol" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_ol"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.is_li" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_li"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.in_list" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.in_list"/>
    </xsl:function>
    


    <!-- ======== -->
    <!--  Tables  -->
    <!-- ======== -->    

    <xsl:function name="cpm:dita.is_table" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_table"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.is_tgroup" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_tgroup"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.is_thead" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_thead"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.is_colspec" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_colspec"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.is_tbody" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_tbody"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.is_tfoot" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_tfoot"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.is_row" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_row"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.is_entry" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_entry"/>
    </xsl:function>

    <xsl:function name="cpm:dita.in_table" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.in_table"/>
    </xsl:function>
    
    <xsl:function name="cpm:dita.colpos" as="xs:integer">
        
        <!-- A tgroup element -->
        <xsl:param name="tgroup"/>
        
        <!-- A column name -->
        <xsl:param name="colname"/>
        
        <xsl:apply-templates select="$tgroup">
            <xsl:with-param name="colname" select="$colname"/>
        </xsl:apply-templates>
        
    </xsl:function>
    
    <xsl:function name="cpm:dita.colspans" as="xs:integer">
        
        <!-- An entry element -->
        <xsl:param name="entry"/>
        
        <xsl:apply-templates select="$entry" mode="cpm.dita.colspans"/>
        
    </xsl:function>
    
    <xsl:function name="cpm:dita.colpos" as="xs:integer">
        
        <!-- An entry element or an element nested into an entry -->
        <xsl:param name="element"/>
        
        <xsl:apply-templates select="$element" mode="cpm.dita.colpos"/>
        
    </xsl:function>
    
    <xsl:function name="cpm:dita.rowcol">
        
        <!-- A table element or any child of a table -->
        <xsl:param name="element"/>
        
        <!-- A row alias list -->
        <xsl:param name="row_aliases"/>
        
        <!-- A column alias list -->
        <xsl:param name="col_aliases"/>
        
        <!-- A column headings row (a copy is allowed) -->
        <xsl:param name="headings"/>
        
        <!-- A leading column alias list -->
        <xsl:param name="leading_col_aliases"/>
                        
        <!-- Retrieving a value -->
        <xsl:apply-templates select="$element" mode="cpm.dita.rowcol">
            <xsl:with-param name="row_aliases" select="$row_aliases"/>
            <xsl:with-param name="col_aliases" select="$col_aliases"/>
            <xsl:with-param name="headings" select="$headings"/>
            <xsl:with-param name="leading_col_aliases" select="$leading_col_aliases"/>
        </xsl:apply-templates>
        
    </xsl:function>
        
    <xsl:function name="cpm:dita.rowcol">
        
        <!-- A table element or any child of a table -->
        <xsl:param name="element"/>
        
        <!-- A row alias list, e.g. "Cats;Dogs;Rabbits" -->
        <xsl:param name="row_aliases"/>
        
        <!-- A column alias list, e.g. "Item;Price;Total" -->
        <xsl:param name="col_aliases"/>
        
        <!-- A leading column alias list, e.g. "Item;Animal" -->
        <xsl:param name="leading_col_aliases"/>
        
        <!-- Retrieving an ID of a column headings row -->
        <xsl:variable name="heading_row_id">
            <xsl:apply-templates select="$element" mode="cpm.dita.headings_id"/>            
        </xsl:variable>
        
        <!-- Calling a function that receives an explicit column headings row -->
        <xsl:value-of
            select="
            cpm:dita.rowcol(
            $element,
            $row_aliases,
            $col_aliases,
            root($element)//*[generate-id() = $heading_row_id],
            $leading_col_aliases)"/>
        
    </xsl:function>
    
    <xsl:function name="cpm:dita.colcap">
        
        <!-- A table entry or an element nested into a table entry -->
        <xsl:param name="element"/>
        
        <xsl:apply-templates select="$element" mode="cpm.dita.colcap"/>
        
    </xsl:function>
    
    <xsl:function name="cpm:dita.match_colcap" as="xs:boolean">
        
        <!-- A table entry or an element nested into a table entry -->
        <xsl:param name="element"/>
        
        <!-- An alias list -->
        <xsl:param name="aliases"/>
        
        <xsl:apply-templates select="$element" mode="cpm.dita.match_colcap">
            <xsl:with-param name="aliases" select="$aliases"/>
        </xsl:apply-templates>
        
    </xsl:function>
    
    <xsl:function name="cpm:dita.is_inline" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="cpm.dita.is_inline"/>
    </xsl:function>


</xsl:stylesheet>
