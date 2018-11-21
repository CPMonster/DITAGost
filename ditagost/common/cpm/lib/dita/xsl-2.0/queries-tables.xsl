<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster   
    
    Level:      Library
    
    Part:       DITA
    Module:     queries-tables.xsl
    
    Scope:      DITA
    
    Func:       Retrieving data from source DITA tables                  
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->   

<!DOCTYPE stylesheet [
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



    <!-- ========================== -->
    <!--  Detecting table elements  -->
    <!-- ========================== -->

    <xsl:template match="*" mode="cpm.dita.is_table" as="xs:boolean">
        <xsl:value-of select="cpm:dita.eclass(., '&DITA_CLASS_TABLE;')"/>
    </xsl:template>

    <xsl:template match="*" mode="cpm.dita.is_tgroup" as="xs:boolean">
        <xsl:value-of select="cpm:dita.eclass(., '&DITA_CLASS_TGROUP;')"/>
    </xsl:template>

    <xsl:template match="*" mode="cpm.dita.is_colspec" as="xs:boolean">
        <xsl:value-of select="cpm:dita.eclass(., '&DITA_CLASS_COLSPEC;')"/>
    </xsl:template>

    <xsl:template match="*" mode="cpm.dita.is_thead" as="xs:boolean">
        <xsl:value-of select="cpm:dita.eclass(., '&DITA_CLASS_THEAD;')"/>
    </xsl:template>

    <xsl:template match="*" mode="cpm.dita.is_tbody" as="xs:boolean">
        <xsl:value-of select="cpm:dita.eclass(., '&DITA_CLASS_TBODY;')"/>
    </xsl:template>

    <xsl:template match="*" mode="cpm.dita.is_tfoot" as="xs:boolean">
        <xsl:value-of select="cpm:dita.eclass(., '&DITA_CLASS_TFOOT;')"/>
    </xsl:template>

    <xsl:template match="*" mode="cpm.dita.is_row" as="xs:boolean">
        <xsl:value-of select="cpm:dita.eclass(., '&DITA_CLASS_ROW;')"/>
    </xsl:template>

    <xsl:template match="*" mode="cpm.dita.is_entry" as="xs:boolean">
        <xsl:value-of select="cpm:dita.eclass(., '&DITA_CLASS_ENTRY;')"/>
    </xsl:template>



    <!-- ============================== -->
    <!--  Detecting an element context  -->
    <!-- ============================== -->

    <!-- 
        Detecting elements that are nested into tables
    -->
    <xsl:template match="*" mode="cpm.dita.in_table" as="xs:boolean">

        <!-- 
            * represents a DITA element (e.g. ul ro ol) that is probably 
              nested into a table.
        -->

        <xsl:choose>
            <xsl:when test="&DITA_MY_ENTRY;">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 
        Detecting a position of a column by its name 
    -->
    <xsl:template match="&DITA_TGROUP;" mode="cpm.dita.colpos" as="xs:integer">

        <!-- A column name (colspec/@colname) -->
        <xsl:param name="colname"/>

        <xsl:choose>

            <xsl:when test="colspec[@colname = $colname]">
                <xsl:value-of
                    select="colspec[@colname = $colname][1]/count(preceding-sibling::colspec) + 1"/>
            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="0"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>


    <!-- 
        Calculating column positions for entries
    -->

    <!-- A working template -->
    <xsl:template match="&DITA_ENTRY;" mode="cpm.dita.colpos" as="xs:integer">

        <!-- 
            * represents an entry element.
        -->

        <xsl:choose>

            <xsl:when test="preceding-sibling::*">

                <xsl:variable name="pos">
                    <xsl:value-of select="cpm:dita.colpos(preceding-sibling::*[1])"/>
                </xsl:variable>

                <xsl:variable name="spans">
                    <xsl:value-of select="cpm:dita.colspans(preceding-sibling::*[1])"/>
                </xsl:variable>

                <xsl:value-of select="$pos + $spans"/>

            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="1"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>

    <!-- A wrapper template for an element nested into a cell -->
    <xsl:template match="*[not(cpm:dita.is_entry(.) or cpm:dita.is_tgroup(.))]"
        mode="cpm.dita.colpos" as="xs:integer">

        <!-- 
            * represents an element nested into an entry
        -->

        <xsl:choose>

            <xsl:when test="&DITA_MY_ENTRY;">
                <xsl:apply-templates select="&DITA_MY_ENTRY;" mode="#current"/>
            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="0"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>


    <!-- 
        Calculating a number of columns a entry spans over
    -->

    <!-- A working template -->
    <xsl:template match="*" mode="cpm.dita.colspans" as="xs:integer">

        <!-- 
            * represents a table entry element
        -->

        <xsl:choose>

            <xsl:when test="@morecols">
                <xsl:value-of select="number(@morecols) + 1"/>
            </xsl:when>

            <xsl:when test="@namest and @nameend">

                <xsl:variable name="pos1">
                    <xsl:value-of select="cpm:dita.colpos(&DITA_MY_TGROUP;, @namest)"/>
                </xsl:variable>

                <xsl:variable name="pos2">
                    <xsl:value-of select="cpm:dita.colpos(&DITA_MY_TGROUP;, @nameend)"/>
                </xsl:variable>

                <xsl:value-of select="$pos2 - $pos1 + 1"/>

            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="1"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>



    <!-- ============================= -->
    <!--  Extracting data from tables  -->
    <!-- ============================= -->

    <!-- 
        Detecting and retrieving headings row
    -->

    <!-- Detecting a heading row ID for a tgroup -->
    <xsl:template match="&DITA_TGROUP;" mode="cpm.dita.headings_id">

        <xsl:variable name="rows" as="xs:integer">
            <xsl:value-of select="count(&DITA_THEAD;/*)"/>
        </xsl:variable>

        <xsl:value-of select="generate-id(&DITA_THEAD;/*[$rows])"/>

    </xsl:template>

    <!-- Detecting a heading row ID for inner table elements -->
    <xsl:template match="*[&DITA_MY_TGROUP; and not(cpm:dita.is_tgroup(.))]"
        mode="cpm.dita.headings_id">
        <xsl:apply-templates select="&DITA_MY_TGROUP;" mode="#current"/>
    </xsl:template>

    <!-- Detecting a heading rows ID for a table -->
    <xsl:template match="&DITA_TABLE;" mode="cpm.dita.headings_id">
        <xsl:apply-templates select="&DITA_TGROUP;[1]" mode="#current"/>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:template match="*" name="cpm.dita.headings_id">
        <xsl:apply-templates select="." mode="cpm.dita.headings_id"/>
    </xsl:template>

    <!-- Detecting and retrieving a headings row moving from inner table elements -->
    <xsl:template match="*" mode="cpm.dita.headings">

        <xsl:variable name="headings_id">
            <xsl:apply-templates select="." mode="cpm.dita.headings_id"/>
        </xsl:variable>

        <xsl:copy-of select="root(.)//*[generate-id() = $headings_id]"/>

    </xsl:template>


    <!-- 
        Retrieving a row by its heading
    -->

    <!-- ... more explicit parameters -->
    <xsl:function name="cpm:dita.row_id_by_heading">

        <!-- A row alias list, e.g. "Cats;Dogs;Rabbits" -->
        <xsl:param name="aliases"/>

        <!-- A row of headings (a native one! not a copy stored in a variable!) -->
        <xsl:param name="headings"/>

        <!-- An alias list for a leading column, e.g. "Animal;Item" -->
        <xsl:param name="leading_col_aliases"/>

        <xsl:variable name="index" as="xs:integer">
            <xsl:value-of select="cpm:dita.index($headings, $leading_col_aliases)"/>
        </xsl:variable>

        <xsl:value-of
            select="generate-id(($headings/&DITA_MY_TBODY;/*[cpm:props.match(*[$index], $aliases)])[1])"/>

    </xsl:function>


    <!-- 
        Retrieving cell content by a row and a column heading
    -->

    <!-- ... more explicit paremeters -->
    <xsl:function name="cpm:dita.entry">

        <!-- A row element (a copy stored in a variable is allowed) -->
        <xsl:param name="row"/>

        <!-- A column alias list -->
        <xsl:param name="aliases"/>

        <!-- A row containing column headings (a copy stored in a variable is allowed) -->
        <xsl:param name="headings"/>

        <!-- Calculating an index of a cell in a row -->
        <xsl:variable name="index" as="xs:integer">

            <xsl:choose>

                <!-- 
                     We try to calculate a cell index if an element
                     is provided in the $row.
                -->
                <xsl:when test="cpm:props.is_element($headings)">
                    <xsl:value-of select="cpm:dita.index($headings, $aliases)"/>
                </xsl:when>

                <!-- 
                    We treat the $aliases value as an explicit column index 
                    if no element is provided in the $row. 
                -->
                <xsl:otherwise>
                    <xsl:value-of select="number($aliases)"/>
                </xsl:otherwise>

            </xsl:choose>

        </xsl:variable>

        <!-- Retrieving a value if the index is valid -->
        <xsl:if test="$index != -1">
            <xsl:value-of select="normalize-space($row/*[$index])"/>
        </xsl:if>

    </xsl:function>

    <!-- ... more automation -->
    <xsl:function name="cpm:dita.entry">

        <!-- A row element (a native one! not a copy stored in a variable) -->
        <xsl:param name="row"/>

        <!-- A column aliases list -->
        <xsl:param name="aliases"/>

        <!-- Retrieving a column headings row -->
        <xsl:variable name="headings">
            <xsl:apply-templates select="$row" mode="cpm.dita.headings"/>
        </xsl:variable>

        <!-- Calling a function with an explicit column headings row -->
        <xsl:value-of select="cpm:dita.entry($row, $aliases, $headings/*)"/>

    </xsl:function>


    <!-- 
        Retrieving cell content by row alias and column alias
    -->
    <xsl:template match="*" mode="cpm.dita.rowcol_inner">
        <xsl:param name="row_id"/>
        <xsl:param name="col_aliases"/>
        <xsl:param name="headings"/>

        <xsl:value-of
            select="cpm:dita.entry(root(.)//*[generate-id() = $row_id], $col_aliases, $headings)"/>

    </xsl:template>

    <xsl:template match="*" mode="cpm.dita.rowcol">

        <!-- 
            * represents a table element or any child of a table. 
        -->

        <!-- A row alias list -->
        <xsl:param name="row_aliases"/>

        <!-- A column alias list -->
        <xsl:param name="col_aliases"/>

        <!-- A column headings row (a copy is allowed) -->
        <xsl:param name="headings"/>

        <!-- A leading column alias list -->
        <xsl:param name="leading_col_aliases"/>

        <!-- Retrieving an ID of a target row -->
        <xsl:variable name="row_id">
            <xsl:value-of
                select="cpm:dita.row_id_by_heading($row_aliases, $headings, $leading_col_aliases)"/>
        </xsl:variable>

        <!-- Retrieving a value -->
        <xsl:apply-templates select="." mode="cpm.dita.rowcol_inner">
            <xsl:with-param name="row_id" select="$row_id"/>
            <xsl:with-param name="col_aliases" select="$col_aliases"/>
            <xsl:with-param name="headings" select="$headings"/>
        </xsl:apply-templates>

    </xsl:template>


    <!-- 
        Retrieving a column caption
    -->
    <xsl:template match="*" name="cpm.dita.colcap">

        <!-- 
            * represents a table entry or an element nested into 
              a table entry. 
        -->

        <xsl:variable name="headings">
            <xsl:apply-templates select="." mode="cpm.dita.headings"/>
        </xsl:variable>

        <xsl:variable name="colpos" as="xs:integer">
            <xsl:value-of select="cpm:dita.colpos(.)"/>
        </xsl:variable>

        <xsl:value-of select="$headings/*/*[$colpos]"/>

    </xsl:template>


    <!-- 
        Checking a column caption against an alias list
    -->
    <xsl:template match="*" mode="cpm.dita.match_colcap" as="xs:boolean">

        <!-- 
            * represents a table entry or an element 
              nested into a table entry. 
        -->

        <!-- An alias list -->
        <xsl:param name="aliases"/>

        <xsl:variable name="colcap">
            <xsl:value-of select="cpm:dita.colcap(.)"/>
        </xsl:variable>

        <xsl:value-of select="cpm:props.match($colcap, $aliases)"/>

    </xsl:template>


    <!--
        Detecting text align for a entry
    -->
    <xsl:template match="*" mode="cpm.dita.colalign"/>

    <xsl:template match="&DITA_ENTRY;" mode="cpm.dita.colalign">
        
        <xsl:choose>
            <xsl:when test="@align">
                <xsl:value-of select="@align"/>
            </xsl:when>
            <xsl:when test="not(@align)">
                <xsl:variable name="cp" select="cpm:dita.colpos(.)"/>
                <xsl:value-of
                    select="ancestor::&DITA_TGROUP;[1]/colspec[position()=$cp]/@align"/>                    
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>

        <!--
        <xsl:variable name="tmp">
            <xsl:choose>
                <xsl:when test="@align">
                    <xsl:value-of select="@align"/>
                </xsl:when>
                <xsl:when test="not(@align)">
                    <xsl:variable name="cp" select="cpm:dita.colpos(.)"/>
                    <xsl:value-of
                        select="ancestor::&DITA_TGROUP;[1]/colspec[position()=$cp]/@align"/>                    
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        -->
       
        <!--
        <xsl:choose>
            <xsl:when test="$tmp != ''">
                <xsl:value-of select="$tmp"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>left</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        -->

    </xsl:template>

</xsl:stylesheet>
