<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster    
    
    Level:      Library
    
    Part:       FastCust
    Module:     numbers.xsl
    
    Scope:      Generic
    
    Func:       Provides temptates and functions for assigning
                numbers to sections, figures, tables, etc.                 
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  

<!DOCTYPE stylesheet [
    <!ENTITY NUMBERING_LATIN_FULL "ABCDEFGHIJKLMNOPQRSTUVWXYZ">
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!--
        Modules    
    -->

    <!-- Wrapper functions -->
    <xsl:import href="funcs.xsl"/>

    <!-- Useful template functions -->
    <xsl:import href="../../common/xsl-2.0/misc.xsl"/>



    <!-- ========================================== -->
    <!--  Retrieving numbering sequence properties  -->
    <!-- ========================================== -->

    <!-- 
        Detecting a numbering sequence name
    -->

    <!-- A default template for a numbering sequence -->
    <xsl:template match="numseq" mode="cpm.fastcust.numseqname">
        <xsl:value-of select="@name"/>
    </xsl:template>

    <!-- A default template (should be overloaded in a generated layout.xsl) -->
    <xsl:template match="*" mode="cpm.fastcust.numseqname"/>

    <!-- A titled element has the same numbering with its title -->
    <xsl:template match="*[*[cpm:is_title(.)]]" mode="cpm.fastcust.numseqname">
        <xsl:value-of select="cpm:numseqname(*[cpm:is_title(.)])"/>
    </xsl:template>

    <!-- A default template for a flat documnet (always wins) -->
    <xsl:template match="*[@cpm:numseqname]" mode="cpm.fastcust.numseqname" priority="2">
        <xsl:value-of select="@cpm:numseqname"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="numseqname">
        <xsl:value-of select="cpm:fastcust.numseqname(.)"/>
    </xsl:template>


    <!-- 
        Detecting a numbering type 
    -->

    <!-- A type for a generic numbering sequence -->
    <xsl:template match="numseq" mode="cpm.fastcust.numtype">
        <xsl:value-of select="cpm:misc.defval(lower-case(@type), 'arabic')"/>
    </xsl:template>

    <!-- A type for a charset numbering sequence -->
    <xsl:template match="numseq[@chars]" mode="cpm.fastcust.numtype">
        <xsl:text>charset</xsl:text>
    </xsl:template>

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.numtype">

        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <xsl:if test="cpm:misc.is_element($numseq, 'numseq')">
            <xsl:apply-templates select="$numseq//numseq" mode="#current"/>
        </xsl:if>

    </xsl:template>

    <!-- ... a titled element -->
    <xsl:template match="*[*[cpm:is_title(.)]]" mode="cpm.fastcust.numtype">
        <xsl:value-of select="cpm:numtype(*[cpm:is_title(.)])"/>
    </xsl:template>

    <!-- A default template for a flat documnet (always wins) -->
    <xsl:template match="*[@cpm:numtype]" mode="cpm.fastcust.numtype" priority="2">
        <xsl:value-of select="@cpm:numtype"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="numtype">
        <xsl:value-of select="cpm:fastcust.numtype(.)"/>
    </xsl:template>


    <!-- 
        Detecting a numbering mode 
    -->

    <!-- ... numbering sequence -->
    <xsl:template match="numseq" mode="cpm.fastcust.nummode">
        <xsl:if test="@type != 'dummy'">
            <xsl:value-of select="cpm:misc.defval(@mode, 'decimal')"/>
        </xsl:if>
    </xsl:template>

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.nummode">

        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <xsl:if test="cpm:misc.is_element($numseq, 'numseq')">
            <xsl:apply-templates select="$numseq//numseq" mode="#current"/>
        </xsl:if>

    </xsl:template>

    <!-- ... a titled element -->
    <xsl:template match="*[*[cpm:is_title(.)]]" mode="cpm.fastcust.nummode">
        <xsl:value-of select="cpm:nummode(*[cpm:is_title(.)])"/>
    </xsl:template>

    <!-- A default template for a flat documnet (always wins) -->
    <xsl:template match="*[@cpm:nummode]" mode="cpm.fastcust.nummode" priority="2">
        <xsl:value-of select="@cpm:nummode"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="nummode">
        <xsl:value-of select="cpm:fastcust.nummode(.)"/>
    </xsl:template>


    <!-- 
        Detecting an initial number 
    -->

    <!-- ... numbering sequence -->
    <xsl:template match="numseq" mode="cpm.fastcust.start_from">
        <xsl:value-of select="cpm:misc.defnum1(@start-from)"/>
    </xsl:template>

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.start_from">

        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <xsl:if test="cpm:misc.is_element($numseq, 'numseq')">
            <xsl:apply-templates select="$numseq//numseq" mode="#current"/>
        </xsl:if>

    </xsl:template>

    <!-- ... a titled element -->
    <xsl:template match="*[*[cpm:is_title(.)]]" mode="cpm.fastcust.start_from">
        <xsl:value-of select="cpm:start_from(*[cpm:is_title(.)])"/>
    </xsl:template>

    <!-- A default template for a flat documnet (always wins) -->
    <xsl:template match="*[@cpm:start-from]" mode="cpm.fastcust.start_from" priority="2">
        <xsl:value-of select="@cpm:start_from"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="start_from">
        <xsl:value-of select="cpm:fastcust.start_from(.)"/>
    </xsl:template>


    <!-- 
        Retrieving an alphabet 
    -->

    <!-- ... for an explicit alphabet -->
    <xsl:template match="numseq" mode="cpm.fastcust.numchars">
        <xsl:value-of select="@chars"/>
    </xsl:template>

    <!-- ... for Latin alphabet, the upper case -->
    <xsl:template match="numseq[cpm:numtype(.) = 'latin-upper']" mode="cpm.fastcust.numchars">
        <xsl:value-of select="'&NUMBERING_LATIN_FULL;'"/>
    </xsl:template>

    <!-- for Latin alphabet, the lower case -->
    <xsl:template match="numseq[cpm:numtype(.) = 'latin-lower']" mode="cpm.fastcust.numchars">
        <xsl:value-of select="lower-case('&NUMBERING_LATIN_FULL;')"/>
    </xsl:template>

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.numchars">

        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <xsl:if test="cpm:misc.is_element($numseq, 'numseq')">
            <xsl:apply-templates select="$numseq//numseq" mode="#current"/>
        </xsl:if>

    </xsl:template>

    <!-- ... a titled element -->
    <xsl:template match="*[*[cpm:is_title(.)]]" mode="cpm.fastcust.numchars">
        <xsl:value-of select="cpm:numchars(*[cpm:is_title(.)])"/>
    </xsl:template>

    <!-- A default template for a flat documnet (always wins) -->
    <xsl:template match="*[@cpm:numchars]" mode="cpm.fastcust.numchars" priority="2">
        <xsl:value-of select="@numchars"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="numchars">
        <xsl:value-of select="cpm:fastcust.numchars(.)"/>
    </xsl:template>


    <!-- 
        Detecting base numbering sequence name
    -->

    <!-- ... numbering sequence -->
    <xsl:template match="numseq" mode="cpm.fastcust.numbase">
        <xsl:value-of select="@base"/>
    </xsl:template>

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.numbase">

        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <xsl:if test="cpm:misc.is_element($numseq, 'numseq')">
            <xsl:apply-templates select="$numseq//numseq" mode="#current"/>
        </xsl:if>

    </xsl:template>

    <!-- ... a titled element -->
    <xsl:template match="*[*[cpm:is_title(.)]]" mode="cpm.fastcust.numbase">
        <xsl:value-of select="cpm:numbase(*[cpm:is_title(.)])"/>
    </xsl:template>

    <!-- A default template for a flat documnet (always wins) -->
    <xsl:template match="*[@cpm:numbase]" mode="cpm.fastcust.numbase" priority="2">
        <xsl:value-of select="@cpm:numbase"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="numbase">
        <xsl:value-of select="cpm:fastcust.numbase(.)"/>
    </xsl:template>


    <!-- 
        Retrieving a caption for an element
    -->

    <!-- ... default -->
    <xsl:template match="numseq" mode="cpm.fastcust.caption">
        <xsl:if test="@type != 'dummy'">
            <xsl:value-of select="cpm:misc.defval(@caption, '%n. ')"/>
        </xsl:if>
    </xsl:template>

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.caption">
        <xsl:apply-templates select="cpm:numseq(.)" mode="#current"/>
    </xsl:template>

    <!-- ... a titled element -->
    <xsl:template match="*[*[cpm:is_title(.)]]" mode="cpm.fastcust.caption">
        <xsl:value-of select="cpm:caption(*[cpm:is_title(.)])"/>
    </xsl:template>

    <!-- A default template for a flat document (always wins!) -->
    <xsl:template match="*[@cpm:caption]" mode="cpm.fastcust.caption" priority="2">
        <xsl:value-of select="@cpm:caption"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="caption">
        <xsl:value-of select="cpm:fastcust.caption(.)"/>
    </xsl:template>


    <!-- 
        Retrieving a navigation caption for an element 
    -->

    <!-- ... default -->
    <xsl:template match="numseq" mode="cpm.fastcust.navcaption">
        <xsl:if test="@type != 'dummy'">
            <xsl:value-of select="cpm:misc.defval(@navcaption, cpm:caption(.))"/>
        </xsl:if>
    </xsl:template>

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.navcaption">
        <xsl:apply-templates select="cpm:numseq(.)" mode="#current"/>
    </xsl:template>

    <!-- ... a titled element -->
    <xsl:template match="*[*[cpm:is_title(.)]]" mode="cpm.fastcust.navcaption">
        <xsl:value-of select="cpm:navcaption(*[cpm:is_title(.)])"/>
    </xsl:template>

    <!-- A default template for a flat document (always wins!) -->
    <xsl:template match="*[@cpm:navcaption]" mode="cpm.fastcust.navcaption" priority="2">
        <xsl:value-of select="@cpm:navcaption"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="navcaption">
        <xsl:value-of select="cpm:fastcust.navcaption(.)"/>
    </xsl:template>


    <!-- 
        Retrieving a separator for decimal numbers 
    -->

    <!-- Doing this for a numbering sequence -->
    <xsl:template match="numseq" mode="cpm.fastcust.numsep">
        <xsl:value-of select="cpm:misc.defval(@sep, '.')"/>
    </xsl:template>

    <!-- Doing this for an element having a numbering sequence -->
    <xsl:template match="*" mode="cpm.fastcust.numsep">
        <xsl:apply-templates select="cpm:numseq(.)" mode="#current"/>
    </xsl:template>

    <!-- ... a titled element -->
    <xsl:template match="*[*[cpm:is_title(.)]]" mode="cpm.fastcust.numsep">
        <xsl:value-of select="cpm:numsep(*[cpm:is_title(.)])"/>
    </xsl:template>

    <!-- A default template for a flat document (always wins!) -->
    <xsl:template match="*[@cpm:numsep]" mode="cpm.fastcust.numsep" priority="2">
        <xsl:value-of select="@cpm:numsep"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="numsep">
        <xsl:value-of select="cpm:fastcust.numsep(.)"/>
    </xsl:template>


    <!-- 
        Retrieving a separator for linking a number to a base number  
    -->

    <!-- Doing this for a numbering sequence -->
    <xsl:template match="numseq" mode="cpm.fastcust.numbasesep">
        <xsl:value-of select="cpm:misc.defval(@basesep, '.')"/>
    </xsl:template>

    <!-- Doing this for an element having a numbering sequence -->
    <xsl:template match="*" mode="cpm.fastcust.numbasesep">
        <xsl:apply-templates select="cpm:numseq(.)" mode="#current"/>
    </xsl:template>

    <!-- ... a titled element -->
    <xsl:template match="*[*[cpm:is_title(.)]]" mode="cpm.fastcust.numbasesep">
        <xsl:value-of select="cpm:numbasesep(*[cpm:is_title(.)])"/>
    </xsl:template>

    <!-- A default template for a flat document (always wins!) -->
    <xsl:template match="*[@cpm:numbasesep]" mode="cpm.fastcust.numbasesep" priority="2">
        <xsl:value-of select="@cpm:numbasesep"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="numbasesep">
        <xsl:value-of select="cpm:fastcust.numbasesep(.)"/>
    </xsl:template>



    <!-- ===================================================== -->
    <!--  Converting an natural index to a local number value  -->
    <!-- ===================================================== -->

    <!-- 
        Converting a natural index to a number
    -->

    <!-- A default template (arabic or unknown) -->
    <xsl:template match="numseq" mode="cpm.fastcust.numval">
        <xsl:param name="index"/>
        <xsl:value-of select="$index"/>
    </xsl:template>

    <!-- A default template (Roman, upper case) -->
    <xsl:template match="numseq[cpm:numtype(.) = 'roman-upper']" mode="cpm.fastcust.numval">
        <xsl:param name="index"/>
        <xsl:value-of select="cpm:misc.roman_upper($index)"/>
    </xsl:template>

    <!-- A default template (Roman, lower case) -->
    <xsl:template match="numseq[cpm:numtype(.) = 'roman-lower']" mode="cpm.fastcust.numval">
        <xsl:param name="index"/>
        <xsl:value-of select="cpm:misc.roman_lower($index)"/>
    </xsl:template>

    <!-- A default template (alphabet) -->
    <xsl:template match="numseq[cpm:numtype(.) = ('latin-upper', 'latin-lower', 'charset')]"
        mode="cpm.fastcust.numval">
        <xsl:param name="index"/>
        <xsl:value-of select="substring(cpm:numchars(.), $index, 1)"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="numval">
        <xsl:param name="index"/>
        <xsl:value-of select="cpm:fastcust.numval(., $index)"/>
    </xsl:template>



    <!-- ==================== -->
    <!--  Assembling numbers  -->
    <!-- ==================== -->

    <!-- 
        Formatting a number
    -->

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.numformat">

        <xsl:param name="number" select="cpm:number(.)"/>

        <xsl:param name="caption" select="cpm:caption(.)"/>

        <xsl:analyze-string select="$caption" regex="%b|%n|%s">
            <xsl:matching-substring>
                <xsl:choose>
                    <xsl:when test=". = '%b'">
                        <xsl:value-of select="substring-before($number, cpm:numbasesep(.))"/>
                    </xsl:when>
                    <xsl:when test=". = '%n'">
                        <xsl:value-of select="$number"/>
                    </xsl:when>
                    <xsl:when test=". = '%s'">
                        <xsl:value-of select="cpm:numbasesep(.)"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>

    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="numformat">
        <xsl:param name="number" select="cpm:number(.)"/>
        <xsl:param name="caption" select="cpm:caption(.)"/>
        <xsl:value-of select="cpm:fastcust.numformat(., $number, $caption)"/>
    </xsl:template>



    <!-- ====================================== -->
    <!--  Detecting relations between elements  -->
    <!-- ====================================== -->

    <!-- 
        Calculating an element level for numerating purpose
    -->

    <!-- A default template for a common case -->
    <xsl:template match="*" mode="cpm.fastcust.numlevel"/>

    <!-- A default template for topics -->
    <xsl:template match="*[cpm:is_topic(.)]" mode="cpm.fastcust.numlevel">
        <xsl:if test="cpm:is_docmamber(.)">
            <xsl:value-of select="count(ancestor::*[cpm:is_topic(.)]) + 1"/>
        </xsl:if>
    </xsl:template>

    <!-- A default template for topic titles -->
    <xsl:template match="*[cpm:is_topic_title(.)]" mode="cpm.fastcust.numlevel">
        <xsl:value-of select="count(ancestor::*[cpm:is_topic(.)])"/>
    </xsl:template>

    <!-- A default template for a flat document -->
    <xsl:template match="*[@cpm:numlevel]" mode="cpm.fastcust.numlevel" priority="2">
        <xsl:value-of select="@cpm:numlevel"/>
    </xsl:template>

    <!-- A custom template  -->
    <xsl:template match="*" mode="numlevel">
        <xsl:value-of select="cpm:fastcust.numlevel(.)"/>
    </xsl:template>


    <!-- 
        Testing two elements for standing on the same numbering level
    -->

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.eqnumlevel" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:value-of select="cpm:numlevel(.) = cpm:numlevel($element)"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="eqnumlevel" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:value-of select="cpm:fastcust.eqnumlevel(., $element)"/>
    </xsl:template>


    <!-- 
        Testing two elements for being included to the same numbering sequence
    -->

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.eqnumseq" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:value-of select="cpm:numseqname(.) = cpm:numseqname($element)"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="eqnumseq" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:value-of select="cpm:fastcust.eqnumseq(., $element)"/>
    </xsl:template>


    <!-- 
        Detecting an ID of a "numbering parent" of an element
    -->

    <!-- A default template for corner cases -->
    <xsl:template match="*" mode="cpm.fastcust.numparent"/>

    <!-- A default template (for decimals) -->
    <xsl:template match="*[cpm:nummode(.) = 'decimal']" mode="cpm.fastcust.numparent">
        <xsl:variable name="ns" select="cpm:numseqname(.)"/>
        <xsl:variable name="nb" select="cpm:numbase(.)"/>
        <xsl:value-of select="cpm:misc.id(ancestor::*[cpm:numseqname(.) = ($ns, $nb)][1])"/>
    </xsl:template>

    <!-- A default template (for flats) -->
    <xsl:template match="*[cpm:nummode(.) = 'flat']" mode="cpm.fastcust.numparent">
        <xsl:variable name="nb" select="cpm:numbase(.)"/>
        <xsl:value-of select="cpm:misc.id(ancestor::*[cpm:numseqname(.) = $nb][1])"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="numparent">
        <xsl:value-of select="cpm:fastcust.numparent(.)"/>
    </xsl:template>


    <!-- 
        Do element local numbers belong to the same local sequence?
    -->

    <!-- A default template (unknown numbering mode) -->
    <xsl:template match="*" mode="cpm.fastcust.is_numsibling" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:value-of select="false()"/>
    </xsl:template>

    <!-- A default template (decimal numbering mode) -->
    <xsl:template match="*[cpm:nummode(.) = 'decimal']" mode="cpm.fastcust.is_numsibling"
        as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:value-of select="cpm:eqnumlevel(., $element) and cpm:eqnumseq(., $element)"/>
    </xsl:template>

    <!-- A default template (flat numbering mode) -->
    <xsl:template match="*[cpm:nummode(.) = 'flat']" mode="cpm.fastcust.is_numsibling"
        as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:value-of select="cpm:numparent(.) = cpm:numparent($element)"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="is_numsibling" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:value-of select="cpm:fastcust.is_numsibling(., $element)"/>
    </xsl:template>



    <!-- ============================================ -->
    <!--  Assembling a number for a document element  -->
    <!-- ============================================ -->

    <!-- 
        Retrieving a numbering sequence for an element
    -->

    <!-- A default template (should be overloaded in a generated layout.xsl) -->
    <xsl:template match="*" mode="cpm.fastcust.numseq"/>

    <!-- A default template for titled elements -->
    <xsl:template match="*[*[cpm:is_title(.)]]" mode="cpm.fastcust.numseq">
        <xsl:apply-templates select="*[cpm:is_title(.)]" mode="numseq"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="numseq">
        <xsl:apply-templates select="." mode="cpm.fastcust.numseq"/>
    </xsl:template>


    <!-- 
        Calculating a local number of an element
    -->

    <!-- Supressing corner cases -->
    <xsl:template match="*" mode="cpm.fastcust.locnumber"/>

    <!-- A default template (for decimals) -->
    <xsl:template match="*[cpm:nummode(.) = 'decimal']" mode="cpm.fastcust.locnumber">

        <!-- Calculating an index of the element in a local sequence, e.g. 4 -->
        <xsl:value-of select="count(preceding-sibling::*[cpm:is_numsibling(current(), .)]) + 1"/>



    </xsl:template>

    <!-- A default template (for flats) -->
    <xsl:template match="*[cpm:nummode(.) = 'flat']" mode="cpm.fastcust.locnumber">

        <!-- Calculating an index of the element in a local sequence, e.g. 4 -->
        <xsl:variable name="index"
            select="count(preceding::*[name(current()) = name(.) and cpm:is_numsibling(current(), .)]) + 1"/>

        <!-- Retrieving a numbering sequence for an element -->
        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <!-- Assembling a local number value, e.g. IV -->
        <xsl:value-of select="cpm:fastcust.numval($index, $numseq)"/>

    </xsl:template>


    <!-- A custom template -->
    <xsl:template match="*" mode="locnumber">
        <xsl:value-of select="cpm:fastcust.locnumber(.)"/>
    </xsl:template>


    <!-- 
        Taking a number of a higher element
    -->

    <!-- A working template -->
    <xsl:template match="*" mode="cpm.fastcust.hinumber">
        <xsl:variable name="numparent" select="cpm:numparent(.)"/>
        <xsl:value-of select="cpm:number(ancestor::*[cpm:misc.id(.) = $numparent])"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="hinumber">
        <xsl:value-of select="cpm:fastcust.hinumber(.)"/>
    </xsl:template>


    <!-- 
        Assembling a 'decimal' number for an element
    -->
    <xsl:template match="*[cpm:nummode(.) = 'decimal']" mode="cpm.fastcust.number">

        <!-- 
            OVERLOAD: Strongly not recommended.
        -->

        <!-- A higher number -->
        <xsl:param name="hinumber" select="cpm:hinumber(.)"/>

        <!-- A higher numbering sequence -->
        <xsl:param name="hinumseq"/>

        <!-- Detecting a numbering sequence name of a higher element -->
        <xsl:variable name="hinumseqname" select="cpm:numseqname($hinumseq)"/>

        <xsl:if test="$hinumseqname != ''">

            <xsl:choose>
                <xsl:when test="$hinumseqname = cpm:numseqname(.)">
                    <!--
                    <xsl:value-of select="cpm:misc.defval($hinumber, cpm:hinumber(.))"/>
                    -->
                    <xsl:value-of select="$hinumber"/>
                    <xsl:value-of select="cpm:numsep(.)"/>
                </xsl:when>
                <xsl:when test="$hinumseqname = cpm:numbase(.)">
                    <!--
                    <xsl:value-of select="cpm:misc.defval($hinumber, cpm:hinumber(.))"/>
                    -->
                    <xsl:value-of select="$hinumber"/>
                    <xsl:value-of select="cpm:numbasesep(.)"/>
                </xsl:when>
            </xsl:choose>

        </xsl:if>

        <xsl:value-of select="cpm:numval(cpm:numseq(.), cpm:locnumber(.))"/>

    </xsl:template>


    <!-- 
        Assembling a 'flat' number for an element
    -->
    <xsl:template match="*[cpm:nummode(.) = 'flat']" mode="cpm.fastcust.number">

        <!-- 
            OVERLOAD: Strongly not recommended.
        -->

        <!-- A higher number -->
        <xsl:param name="hinumber" select="''"/>

        <!-- A higher numbering sequence -->
        <xsl:param name="hinumseq"/>

        <xsl:variable name="basenumber" select="cpm:hinumber(.)"/>

        <xsl:if test="$basenumber != ''">
            <xsl:value-of select="$basenumber"/>
            <xsl:value-of select="cpm:numbasesep(.)"/>
        </xsl:if>

        <xsl:value-of select="cpm:locnumber(.)"/>

    </xsl:template>

    <!-- A default working template for titles -->
    <xsl:template match="*[cpm:is_title(.)]" mode="cpm.fastcust.number">

        <!-- * is an element of a document -->

        <!-- A higher number -->
        <xsl:param name="hinumber" select="''"/>

        <!-- A higher numbering sequence -->
        <xsl:param name="hinumseq"/>

        <!-- Inheriting a parent's number -->
        <xsl:choose>

            <!-- Using an explicit higher number  -->
            <xsl:when test="$hinumber != ''">
                <xsl:value-of select="$hinumber"/>
            </xsl:when>

            <!-- Calculating an higher number -->
            <xsl:otherwise>
                <xsl:value-of select="cpm:number(..)"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>

    <!-- A default template for a flat document (always wins!) -->
    <xsl:template match="*[@cpm:number]" mode="cpm.fastcust.number" priority="2">
        <xsl:param name="hinumber" select="''"/>
        <xsl:param name="hinumseq"/>
        <xsl:value-of select="@cpm:number"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="number">

        <!-- A higher number -->
        <xsl:param name="hinumber" select="''"/>

        <!-- A higher numbering sequence -->
        <xsl:param name="hinumseq"/>

        <!-- Using a wrapper function -->
        <xsl:choose>
            <xsl:when test="cpm:misc.is_element($hinumseq)">
                <xsl:value-of select="cpm:fastcust.number(., $hinumber, $hinumseq)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="cpm:fastcust.number(.)"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>




    <!-- 
        Assembling a full number for an element
    -->

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.full_number">

        <xsl:variable name="caption" select="cpm:caption(.)"/>

        <xsl:value-of select="substring-before($caption, '%n')"/>
        <xsl:value-of select="cpm:number(.)"/>
        <xsl:value-of select="substring-after($caption, '%n')"/>

    </xsl:template>

    <!-- A default template for a flat document (always wins!) -->
    <xsl:template match="*[@cpm:full-number]" mode="cpm.fastcust.full_number" priority="2">
        <xsl:value-of select="@cpm:full-number"/>
    </xsl:template>

    <!-- That's a corner case; I can't recall what's going on here -->
    <xsl:template match="*[not(@cpm:full-number) and @cpm:level]" mode="cpm.fastcust.full_number"
        priority="2"/>

    <!-- A custom template -->
    <xsl:template match="*" mode="full_number">
        <xsl:value-of select="cpm:fastcust.full_number(.)"/>
    </xsl:template>


    <!-- 
        Assembling a full navigation (TOC, TON) number for an element
    -->

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.nav_full_number">

        <xsl:variable name="navcaption" select="cpm:navcaption(.)"/>

        <xsl:value-of select="substring-before($navcaption, '%n')"/>
        <xsl:value-of select="cpm:number(.)"/>
        <xsl:value-of select="substring-after($navcaption, '%n')"/>

    </xsl:template>

    <!-- A default template for a flat document (always wins!) -->
    <xsl:template match="*[@cpm:nav-full-number]" mode="cpm.fastcust.nav_full_number" priority="2">
        <xsl:value-of select="@cpm:nav-full-number"/>
    </xsl:template>

    <!-- That's a corner case; I can't recall what's going on here -->
    <xsl:template match="*[not(@cpm:nav-full-number) and @cpm:level]"
        mode="cpm.fastcust.nav_full_number" priority="2"/>

    <!-- A custom template -->
    <xsl:template match="*" mode="nav_full_number">
        <xsl:value-of select="cpm:fastcust.nav_full_number(.)"/>
    </xsl:template>

</xsl:stylesheet>
