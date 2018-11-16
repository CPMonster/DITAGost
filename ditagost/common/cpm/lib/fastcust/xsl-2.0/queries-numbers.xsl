<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster    
    
    Level:      Library
    
    Part:       FastCust
    Module:     queries-numbers.xsl
    
    Scope:      Generic
    
    Func:       Provides temptates and functions for assigning
                numbers to sections, figures, tables, etc.                 
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  

<!DOCTYPE stylesheet [
    <!ENTITY NUMBERING_LATIN_FULL "ABCDEFGHIJKLMNOPQRSTUVWXYZ">
    <!ENTITY NUMBERING_DEFSEP ".">           
    <!ENTITY NUMBERING_DEFBASESEP ".">
    <!ENTITY NUMBERING_DEFCAPTION "&#37;n. ">
    <!ENTITY NUMBERING_DEFPATTERN "1.2.3.4.5.6.7.8.9">  
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
    <xsl:template match="*" mode="cpm.fastcust.numseqname">
        <xsl:value-of select="cpm:numseqname(cpm:numseq(.))"/>
    </xsl:template>

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
        <xsl:apply-templates select="cpm:numseq(.)" mode="#current"/>
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
        <xsl:apply-templates select="cpm:numseq(.)" mode="#current"/>
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
        <xsl:apply-templates select="cpm:numseq(.)" mode="#current"/>
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
        <xsl:apply-templates select="cpm:numseq(.)" mode="#current"/>
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
        <xsl:apply-templates select="cpm:numseq(.)" mode="#current"/>
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
        Detecting a base level for a numbering sequence
    -->

    <!-- A default template for a numbering sequence -->
    <xsl:template match="numseq" mode="cpm.fastcust.numbaselevel" as="xs:integer">
        <xsl:value-of select="0"/>
    </xsl:template>

    <!-- A default template for a numbering sequence having a numbering base level -->
    <xsl:template match="numseq[@baselevel]" mode="cpm.fastcust.numbaselevel" as="xs:integer">
        <xsl:value-of select="cpm:misc.defnum0(@baselevel)"/>
    </xsl:template>

    <!-- A default template for an element of a document -->
    <xsl:template match="*" mode="cpm.fastcust.numbaselevel" as="xs:integer">
        <xsl:apply-templates select="cpm:numseq(.)" mode="#current"/>
    </xsl:template>

    <!-- ... a titled element -->
    <xsl:template match="*[*[cpm:is_title(.)]]" mode="cpm.fastcust.numbaselevel" as="xs:integer">
        <xsl:value-of select="cpm:numbaselevel(*[cpm:is_title(.)])"/>
    </xsl:template>

    <!-- A default template for a flat documnet (always wins) -->
    <xsl:template match="*[@cpm:numbaselevel]" mode="cpm.fastcust.numbaselevel" as="xs:integer"
        priority="2">
        <xsl:value-of select="cpm:misc.defnum0(@cpm:numbaselevel)"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="numbaselevel" as="xs:integer">
        <xsl:value-of select="cpm:fastcust.numbaselevel(.)"/>
    </xsl:template>


    <!-- 
        Retrieving a caption for an element
    -->

    <!-- ... default -->
    <xsl:template match="numseq" mode="cpm.fastcust.caption">
        <xsl:if test="@type != 'dummy'">
            <xsl:value-of select="cpm:misc.defval(@caption, '&NUMBERING_DEFCAPTION;')"/>
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
        Detecting an element number pattern
    -->

    <!-- A default template for numbering sequences -->
    <xsl:template match="numseq" mode="cpm.fastcust.numpattern">
        <xsl:if test="@type != 'dummy'">
            <xsl:value-of select="cpm:misc.defval(@pattern, '&NUMBERING_DEFPATTERN;')"/>
        </xsl:if>
    </xsl:template>

    <!-- A default template for elements -->
    <xsl:template match="*" mode="cpm.fastcust.numpattern">
        <xsl:apply-templates select="cpm:numseq(.)" mode="#current"/>
    </xsl:template>

    <!-- ... a titled element -->
    <xsl:template match="*[cpm:has_title(.)]" mode="cpm.fastcust.numpattern">
        <xsl:value-of select="cpm:numpattern(*[cpm:is_title(.)])"/>
    </xsl:template>

    <!-- A default template for a flat document (always wins!) -->
    <xsl:template match="*[@cpm:numpattern]" mode="cpm.fastcust.numpattern" priority="2">
        <xsl:value-of select="@cpm:numpattern"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="numpattern">
        <xsl:value-of select="cpm:fastcust.numpattern(.)"/>
    </xsl:template>


    <!-- 
        Detecting an element number format for navigation purposes  
    -->

    <!-- A default template for numbering sequences -->
    <xsl:template match="numseq" mode="cpm.fastcust.numnavpattern">
        <xsl:if test="@type != 'dummy'">
            <xsl:value-of select="cpm:misc.defval(@numnavpattern, cpm:numpattern(.))"/>
        </xsl:if>
    </xsl:template>

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.numnavpattern">
        <xsl:apply-templates select="cpm:numseq(.)" mode="#current"/>
    </xsl:template>

    <!-- ... a titled element -->
    <xsl:template match="*[cpm:has_title(.)]" mode="cpm.fastcust.numnavpattern">
        <xsl:value-of select="cpm:numnavpattern(*[cpm:is_title(.)])"/>
    </xsl:template>

    <!-- A default template for a flat document (always wins!) -->
    <xsl:template match="*[@cpm:numnavpattern]" mode="cpm.fastcust.numnavpattern" priority="2">
        <xsl:value-of select="@cpm:numnavpattern"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="numnavpattern">
        <xsl:value-of select="cpm:fastcust.numnavpattern(.)"/>
    </xsl:template>


    <!-- 
        Retrieving a separator for decimal numbers 
    -->

    <!-- Doing this for a numbering sequence -->
    <xsl:template match="numseq" mode="cpm.fastcust.numsep">
        <xsl:value-of select="cpm:misc.defval(@sep, '&NUMBERING_DEFSEP;')"/>
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
        <xsl:value-of select="cpm:misc.defval(@basesep, '&NUMBERING_DEFBASESEP;')"/>
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
    <xsl:template name="cpm.fastcust.numassemble">
        
        <xsl:param name="number"/>
        
        <xsl:param name=""></xsl:param>

        <xsl:variable name="regexp">
            <xsl:text>[^{^}]+$</xsl:text>
        </xsl:variable>

        <xsl:analyze-string select="$number" regex="{$regexp}">
            <xsl:matching-substring>
                <main>
                    <xsl:value-of select="."/>
                </main>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:
            </xsl:non-matching-substring>
        </xsl:analyze-string>

    </xsl:template>
    -->


    <!-- 
        Formatting a number
    -->

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.numformat">

        <xsl:param name="basenumber" select="''"/>
        
        <xsl:param name="number" select="cpm:number(.)"/>                

        <xsl:param name="caption" select="cpm:caption(.)"/>

        <xsl:param name="numbasesep" select="cpm:numbasesep(.)"/>

        <xsl:analyze-string select="$caption" regex="%b|%n|%s">
            <xsl:matching-substring>
                <xsl:choose>
                    <xsl:when test=". = '%b'">
                        <xsl:value-of select="$basenumber"/>
                    </xsl:when>
                    <xsl:when test=". = '%n'">
                        <xsl:value-of select="$number"/>
                    </xsl:when>
                    <xsl:when test=". = '%s'">
                        <xsl:value-of select="$numbasesep"/>
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
        <xsl:param name="basenumber" select="''"/>
        <xsl:param name="number" select="cpm:number(.)"/>
        <xsl:param name="caption" select="cpm:caption(.)"/>
        <xsl:value-of select="cpm:fastcust.numformat(., $basenumber, $number, $caption)"/>
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
        Detecting an ID of a "numbering parent" for an element
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

        <xsl:variable name="nbn" select="cpm:numbase(.)"/>

        <xsl:variable name="nbl" select="cpm:numbaselevel(.)"/>

        <xsl:choose>

            <!-- Base numbering level is provided -->
            <xsl:when test="$nbl != 0">

                <xsl:choose>

                    <!-- Base numbering name is irrelevant -->
                    <xsl:when test="$nbn = ''">
                        <xsl:value-of select="cpm:misc.id(ancestor::*[cpm:numlevel(.) = $nbl])"/>
                    </xsl:when>

                    <!-- Base numbering level is relevant for topics -->
                    <xsl:when test="$nbn = '#topic'">
                        <xsl:value-of
                            select="cpm:misc.id(ancestor::*[cpm:is_topic(.) and cpm:numlevel(.) = $nbl])"
                        />
                    </xsl:when>

                    <!-- Base numbering level is relevant for a particular numbering sequence -->
                    <xsl:otherwise>
                        <xsl:value-of
                            select="cpm:misc.id(ancestor::*[cpm:numseqname(.) = $nbn and cpm:numlevel(.) = $nbl])"
                        />
                    </xsl:otherwise>

                </xsl:choose>
            </xsl:when>

            <!-- Base numbering level is irrelevant -->
            <xsl:otherwise>
                <xsl:value-of select="cpm:misc.id(ancestor::*[cpm:numseqname(.) = $nbn][1])"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="numparent">
        <xsl:value-of select="cpm:fastcust.numparent(.)"/>
    </xsl:template>


    <!-- 
        Detecting a local flat indexing group of an element
    -->

    <!-- A default template for a common element -->
    <xsl:template match="*" mode="cpm.fastcust.numidxmode"/>

    <!-- A default template for a decimal numbering mode -->
    <xsl:template match="*[cpm:nummode(.) = 'decimal']" mode="cpm.fastcust.numidxmode">
        <xsl:text>decimals</xsl:text>
    </xsl:template>

    <!-- A default template for a flat numbering mode -->
    <xsl:template match="*[cpm:nummode(.) = 'flat']" mode="cpm.fastcust.numidxmode">

        <xsl:choose>
            <xsl:when test="cpm:is_topic(.)">
                <xsl:text>topics</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:is_list_item_body(.)">
                <xsl:text>items</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="cpm:numbase(.) = ''">
                        <xsl:text>globals</xsl:text>
                    </xsl:when>
                    <xsl:when test="cpm:numbase(.) != ''">
                        <xsl:text>locals</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>other</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- Custom template -->
    <xsl:template match="*" mode="numidxmode">
        <xsl:value-of select="cpm:fastcust.numidxmode(.)"/>
    </xsl:template>


    <!-- 
        Detecting elements that have a chance to belong to the same local sequence
    -->

    <!-- Always false by default -->
    <xsl:template match="*" mode="cpm.fastcust.is_locmate" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:value-of select="false()"/>
    </xsl:template>

    <!-- A default template (decimal numbering mode) -->
    <xsl:template match="*[cpm:numidxmode(.) = 'decimals']" mode="cpm.fastcust.is_locmate"
        as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:value-of select="cpm:eqnumlevel(., $element) and cpm:eqnumseq(., $element)"/>
    </xsl:template>

    <!-- Numbering topics in a flat mode -->
    <xsl:template match="*[cpm:numidxmode(.) = 'topics']" mode="cpm.fastcust.is_locmate"
        as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:value-of select="cpm:is_topic($element) and cpm:eqnumseq(., $element)"/>
    </xsl:template>

    <!-- Numbering list items in a flat mode -->
    <xsl:template match="*[cpm:numidxmode(.) = 'items']" mode="cpm.fastcust.is_locmate"
        as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:value-of select="cpm:is_list_item_body($element) and cpm:eqnumseq(., $element)"/>
    </xsl:template>

    <!-- Numbering titled elements in a flat mode -->
    <xsl:template match="*[cpm:numidxmode(.) = ('globals', 'locals')]"
        mode="cpm.fastcust.is_locmate" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:value-of select="cpm:eqnumseq(., $element)"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="is_locmate" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:value-of select="cpm:fastcust.is_locmate(., $element)"/>
    </xsl:template>



    <!-- ============================================ -->
    <!--  Assembling a number for a document element  -->
    <!-- ============================================ -->

    <!-- 
        Retrieving a numbering sequence for an element
    -->

    <!-- A default template (should be overloaded in a generated layout.xsl) -->
    <xsl:template match="*" mode="cpm.fastcust.numseq">
        <numseq type="dummy"/>
    </xsl:template>

    <!-- A default template for titled elements -->
    <xsl:template match="*[cpm:has_title(.)]" mode="cpm.fastcust.numseq">
        <xsl:copy-of select="cpm:numseq(*[cpm:is_title(.)])"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="numseq">
        <xsl:copy-of select="cpm:fastcust.numseq(.)"/>
    </xsl:template>


    <!-- 
        Calculating a local number of an element
    -->

    <!-- Supressing corner cases -->
    <xsl:template match="*" mode="cpm.fastcust.locindex">
        <xsl:value-of select="0"/>
    </xsl:template>

    <!-- Numbering topics and listitems in the both modes -->
    <xsl:template match="*[cpm:numidxmode(.) = ('decimals', 'items', 'topics')]"
        mode="cpm.fastcust.locindex">
        <xsl:value-of select="count(preceding-sibling::*[cpm:is_locmate(current(), .)]) + 1"/>
    </xsl:template>

    <!-- Numbering elements in a flat mode over a document -->
    <xsl:template match="*[cpm:numidxmode(.) = 'globals']" mode="cpm.fastcust.locindex">
        <xsl:variable name="elname" select="name()"/>
        <xsl:value-of
            select="count(preceding::*[name() = $elname and cpm:is_locmate(current(), .)]) + 1"/>
    </xsl:template>

    <!-- Numbering elements in a flat mode over a base element -->
    <xsl:template match="*[cpm:numidxmode(.) = 'locals']" mode="cpm.fastcust.locindex">
        <xsl:variable name="elname" select="name()"/>
        <xsl:variable name="nbn" select="cpm:numbase(.)"/>
        <xsl:variable name="bid" select="cpm:numparent(.)"/>

        <xsl:variable name="count_prec">
            <xsl:choose>
                <xsl:when test="ancestor::*[$bid = cpm:misc.id(.)]/@id">
                    <xsl:value-of
                        select="count(preceding::*[cpm:is_locmate(current(), .) and name() = $elname and ancestor::*[$bid = @id]])"
                    />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of
                        select="count(preceding::*[cpm:is_locmate(current(), .) and name() = $elname and ancestor::*[$bid = generate-id()]])"
                    />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="$count_prec + 1"/>

    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="locindex">
        <xsl:value-of select="cpm:fastcust.locindex(.)"/>
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
        Assembling a number for an element
    -->

    <!-- A default template for dummy numbering -->
    <xsl:template match="*" mode="cpm.fastcust.number"/>

    <!-- ... for a decimal numbering -->
    <xsl:template match="*[not(cpm:is_title(.)) and cpm:nummode(.) = 'decimal']"
        mode="cpm.fastcust.number">

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
                <xsl:when test="$hinumseqname = cpm:numbase(.)">
                    <!--
                    <xsl:text>{</xsl:text>
                    <xsl:value-of select="$hinumber"/>
                    <xsl:text>}</xsl:text>
                    -->
                </xsl:when>
                <xsl:when test="$hinumseqname = cpm:numseqname(.)">
                    <xsl:value-of select="$hinumber"/>
                    <xsl:value-of select="cpm:numsep(.)"/>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>

        </xsl:if>

        <!-- Converting an index to a local number -->
        <xsl:value-of select="cpm:numval(cpm:numseq(.), cpm:locindex(.))"/>

    </xsl:template>

    <!-- ... for a flat numbering -->
    <xsl:template match="*[not(cpm:is_title(.)) and cpm:nummode(.) = 'flat']"
        mode="cpm.fastcust.number">

        <!-- 
            OVERLOAD: Strongly not recommended.
        -->

        <!-- A higher number -->
        <xsl:param name="hinumber" select="''"/>

        <!-- A higher numbering sequence -->
        <xsl:param name="hinumseq"/>

        <xsl:variable name="basenumber" select="cpm:hinumber(.)"/>

        <!--
        <xsl:if test="$basenumber != ''">
            <xsl:text>{</xsl:text>
            <xsl:value-of select="$basenumber"/>
            <xsl:text>}</xsl:text>
        </xsl:if>
        -->

        <!-- Converting an index to a local number -->
        <xsl:value-of select="cpm:numval(cpm:numseq(.), number(cpm:locindex(.)))"/>

    </xsl:template>

    <!-- A default template for titles -->
    <xsl:template match="*[cpm:is_title(.)]" mode="cpm.fastcust.number">

        <!-- * represents an element of a document -->

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

    <!-- A common default template -->
    <xsl:template match="*" mode="cpm.fastcust.full_number">
        <xsl:value-of select="cpm:numformat(.)"/>
    </xsl:template>

    <!-- A default template for a flat document -->
    <xsl:template match="*[@cpm:full-number]" mode="cpm.fastcust.full_number">
        <xsl:value-of select="@cpm:full-number"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="full_number">
        <xsl:value-of select="cpm:fastcust.full_number(.)"/>
    </xsl:template>


    <!-- 
        Assembling a navigation full number for an element
    -->

    <!-- A common default template -->
    <xsl:template match="*" mode="cpm.fastcust.nav_full_number">
        <xsl:value-of select="cpm:numformat(., @cpm:basenumber, cpm:number(.), cpm:navcaption(.))"/>
    </xsl:template>

    <!-- A default template for a flat document -->
    <xsl:template match="*[@cpm:nav_full-number]" mode="cpm.fastcust.nav_full_number">
        <xsl:value-of select="@cpm:nav_full-number"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="nav_full_number">
        <xsl:value-of select="cpm:fastcust.nav_full_number(.)"/>
    </xsl:template>

</xsl:stylesheet>
