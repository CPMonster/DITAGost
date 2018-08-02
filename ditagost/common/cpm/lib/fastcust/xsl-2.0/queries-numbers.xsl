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



    <!-- ===================== -->
    <!--  Basics of numbering  -->
    <!-- ===================== -->

    <!-- 
        The properties of a numbering sequence are:
        
        - A name (string), mandatory
        
        - A type (one of possible standard types or a custom type), mandatory
        
        - An initial number value (@start-from), 1 is a default value for numerics 
        
        - A mode ('flat' or 'decimal'), 'decimal' is a default value
        
        - A list of characters (string), mandatory for the 'charset' type
        
        - A name of a basic numeration sequence, optional
        
        - A caption string, e. g. 'Appendix %n', optional
        
        The standard types of numbering are:
        
        - Arabic
        
        - Roman (is not supported so far)
        
        - Latin-caps
        
        - Latin-small    
        
        - Charset (an explicit sequence of characters is required)
        
        A custom numbering type is any string except one of standard types.
        
        A sequence of characters is a string like 'ABCD...Y' or 'АБВГ...Я'.
    -->



    <!-- ========================================= -->
    <!--  "Arithmetic": calculating number values  -->
    <!-- ========================================= -->

    <!--  
        Taking the next character for a given one
    -->
    <xsl:function name="cpm:fastcust.incchar">

        <!-- A current character -->
        <xsl:param name="char"/>

        <!-- A sequence of characters -->
        <xsl:param name="alphabet"/>

        <!-- 
            IMPORTANT: A character must be unique in a character list. 
        -->

        <xsl:choose>

            <!-- The first number -->
            <xsl:when test="$char = ''">
                <xsl:value-of select="substring($alphabet, 1, 1)"/>
            </xsl:when>

            <!-- The next number -->
            <xsl:otherwise>

                <!-- Deleting characters up to the current one -->
                <xsl:variable name="tail" select="substring-after($alphabet, $char)"/>

                <!-- Taking the next character -->
                <xsl:value-of select="substring($tail, 1, 1)"/>

            </xsl:otherwise>

        </xsl:choose>

    </xsl:function>


    <!-- 
        Retrieving a character by an index
    -->
    <xsl:function name="cpm:fastcust.char">

        <!-- A current character -->
        <xsl:param name="index"/>

        <!-- A sequence of characters -->
        <xsl:param name="alphabet"/>

        <xsl:value-of select="substring($alphabet, $index, 1)"/>

    </xsl:function>


    <!--  
        Taking the next number for a Roman number
    -->
    <xsl:function name="cpm:fastcust.incroman">

        <xsl:param name="roman"/>

        <xsl:variable name="romans">
            <romans>
                <roman n="I" next_n="II"/>
                <roman n="II" next_n="III"/>
                <roman n="III" next_n="IV"/>
                <roman n="IV" next_n="V"/>
                <roman n="V" next_n="VI"/>
                <roman n="VI" next_n="VII"/>
                <roman n="VII" next_n="IIX"/>
                <roman n="IIX" next_n="IX"/>
                <roman n="IX" next_n="X"/>
                <roman n="X" next_n="XI"/>
                <roman n="XI" next_n="XII"/>
                <roman n="XII" next_n="XIII"/>
                <roman n="XIII" next_n="XIV"/>
                <roman n="XIV" next_n="XV"/>
            </romans>
        </xsl:variable>

        <xsl:variable name="tmp">
            <xsl:value-of select="$romans//roman[@n = upper-case($roman)]/@next_n"/>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="contains($roman, 'i') or contains($roman, 'v') or contains($roman, 'x')">
                <xsl:value-of select="lower-case($tmp)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$tmp"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>



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

    <!-- ... numbering sequence -->
    <xsl:template match="numseq" mode="cpm.fastcust.numtype">
        <xsl:value-of select="cpm:misc.defval(@type, 'arabic')"/>
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

    <!-- ... numbering sequence -->
    <xsl:template match="numseq" mode="cpm.fastcust.numchars">
        <xsl:value-of select="@chars"/>
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

        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <xsl:apply-templates select="$numseq//numseq" mode="#current"/>

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

        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <xsl:apply-templates select="$numseq//numseq" mode="#current"/>

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

        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <xsl:apply-templates select="$numseq//numseq" mode="#current"/>

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

        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <xsl:apply-templates select="$numseq//numseq" mode="#current"/>

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



    <!-- ====================== -->
    <!--  Incrementing numbers  -->
    <!-- ====================== -->

    <!-- 
        A dummy template
    -->
    <xsl:template match="numseq" mode="cpm.fastcust.inc">

        <xsl:param name="number"/>

        <xsl:value-of select="0"/>

    </xsl:template>


    <xsl:template match="numseq[@type = 'dummy']" mode="cpm.fastcust.inc"/>


    <!-- 
        Calculating the next number for 1, 2, 3...
    -->
    <xsl:template match="numseq[@type = 'arabic']" mode="cpm.fastcust.inc">

        <xsl:param name="number"/>

        <xsl:variable name="start_from" select="cpm:start_from(.)"/>

        <xsl:variable name="actual_start_from" select="cpm:misc.defnum1($start_from)"/>

        <xsl:choose>
            <xsl:when test="$number = ''">
                <xsl:value-of select="number($actual_start_from)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="number($number) + 1"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 
        Calculating the next number for a Roman number
    -->
    <xsl:template match="numseq[@type = 'roman']" mode="cpm.fastcust.inc">

        <xsl:param name="number"/>

        <xsl:value-of select="cpm:fastcust.incroman($number)"/>

    </xsl:template>


    <!-- 
        Calculating the next number for A, B, C...
    -->
    <xsl:template match="numseq[@chars]" mode="cpm.fastcust.inc">

        <xsl:param name="number"/>

        <xsl:value-of select="cpm:fastcust.incchar($number, @chars)"/>

    </xsl:template>


    <!--  
        A wrapper function for "increment" templates
    -->
    <xsl:function name="cpm:fastcust.inc">

        <!-- A current number -->
        <xsl:param name="number"/>

        <!-- A numbering sequence-->
        <xsl:param name="numseq"/>

        <xsl:apply-templates select="$numseq//numseq" mode="cpm.fastcust.inc">
            <xsl:with-param name="number" select="$number"/>
        </xsl:apply-templates>

    </xsl:function>



    <!-- ===================================================== -->
    <!--  Converting an natural index to a local number value  -->
    <!-- ===================================================== -->

    <xsl:template match="numseq[@type = 'dummy']" mode="cpm.fastcust.numval"/>

    <!-- 
        Taking a natural number by an index (not so fast!)
    -->
    <xsl:template match="numseq[@type = 'arabic']" mode="cpm.fastcust.numval">

        <xsl:param name="index"/>

        <xsl:variable name="start_from" select="cpm:start_from(.)"/>

        <xsl:variable name="actual_start_from">
            <xsl:choose>
                <xsl:when test="string($start_from) != ''">
                    <xsl:value-of select="$start_from"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="1"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="string($index) = ''">
                <xsl:value-of select="number($actual_start_from)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$actual_start_from + number($index) - 1"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 
        Taking a roman number by an index
    -->
    <xsl:template match="numseq[@type = 'roman']" mode="cpm.fastcust.numval">

        <xsl:param name="index"/>

        <xsl:text>IV</xsl:text>

    </xsl:template>


    <!-- 
        Taking a character by an index
    -->
    <xsl:template match="numseq[@chars]" mode="cpm.fastcust.numval">

        <xsl:param name="index"/>

        <xsl:value-of select="cpm:fastcust.char($index, @chars)"/>

    </xsl:template>


    <!-- 
        Taking a local number by an index
    -->
    <xsl:function name="cpm:fastcust.numval">

        <!-- An index -->
        <xsl:param name="index"/>

        <!-- A numbering sequence-->
        <xsl:param name="numseq"/>

        <xsl:apply-templates select="$numseq//numseq" mode="cpm.fastcust.numval">
            <xsl:with-param name="index" select="$index"/>
        </xsl:apply-templates>

    </xsl:function>



    <!-- ==================== -->
    <!--  Assembling numbers  -->
    <!-- ==================== -->

    <!-- 
        Assembling a "decimal" number
    -->
    <xsl:function name="cpm:fastcust.nummerge">

        <!-- A number of a higher element -->
        <xsl:param name="hinumber"/>

        <!-- A local number of a current element -->
        <xsl:param name="locnumber"/>

        <!-- A numbering sequence of a current element -->
        <xsl:param name="locnumseq"/>

        <xsl:if test="$hinumber != ''">
            <xsl:value-of select="$hinumber"/>
            <xsl:value-of select="cpm:numsep($locnumseq//numseq)"/>
        </xsl:if>

        <xsl:value-of select="$locnumber"/>

    </xsl:function>


    <!-- 
        Formatting a number
    -->
    <xsl:function name="cpm:fastcust.numformat">

        <xsl:param name="number"/>

        <xsl:param name="numseq"/>

        <xsl:variable name="caption" select="cpm:caption($numseq//numseq)"/>

        <xsl:choose>

            <xsl:when test="$caption = ''"/>

            <xsl:otherwise>
                <xsl:analyze-string select="$caption" regex="%n">
                    <xsl:matching-substring>
                        <xsl:value-of select="$number"/>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:value-of select="."/>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:function>


    <!-- 
        Formatting a number
    -->
    <xsl:function name="cpm:fastcust.navformat">

        <xsl:param name="number"/>

        <xsl:param name="numseq"/>

        <xsl:variable name="navcaption" select="cpm:navcaption($numseq//numseq)"/>

        <xsl:choose>

            <xsl:when test="$navcaption = ''"/>

            <xsl:otherwise>
                <xsl:analyze-string select="$navcaption" regex="%n">
                    <xsl:matching-substring>
                        <xsl:value-of select="$number"/>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:value-of select="."/>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:function>



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
        Do elements belong to the same numbering sequence?
    -->

    <!-- A default function -->
    <xsl:function name="cpm:fastcust.eqnumseq" as="xs:boolean">
        <xsl:param name="element1"/>
        <xsl:param name="element2"/>
        <xsl:value-of select="cpm:numseqname($element1) = cpm:numseqname($element2)"/>
    </xsl:function>


    <!-- 
        Do element local numbers belong to the same local sequence?
    -->
    <xsl:function name="cpm:fastcust.is_numsibs" as="xs:boolean">
        <xsl:param name="element1"/>
        <xsl:param name="element2"/>
        <xsl:value-of
            select="cpm:fastcust.eqnumlevel($element1, $element2) and cpm:fastcust.eqnumseq($element1, $element2)"
        />
    </xsl:function>



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

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.locnumber">

        <!-- Retrieving a numbering sequence for an element -->
        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <!-- Calculating an index of the element in a local sequence -->
        <xsl:variable name="index">
            <xsl:value-of
                select="count(preceding-sibling::*[cpm:fastcust.is_numsibs(current(), .)]) + 1"/>
        </xsl:variable>

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

        <xsl:variable name="my_nsn" select="cpm:numseqname(.)"/>

        <xsl:choose>

            <!-- Retrieving a higher number in the same numbering sequence -->
            <xsl:when test="ancestor::*[cpm:numseqname(.) = $my_nsn]">
                <xsl:value-of select="cpm:number(ancestor::*[cpm:numseqname(.) = $my_nsn][1])"/>
            </xsl:when>

            <!-- Trying with a base numbering sequence (when available) -->
            <xsl:otherwise>

                <xsl:variable name="base" select="cpm:numbase(.)"/>

                <xsl:if test="$base != '' and ancestor::*[cpm:numseqname(.) = $base]">
                    <xsl:value-of select="cpm:number(ancestor::*[cpm:numseqname(.) = $base][1])"/>
                </xsl:if>

            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="hinumber">
        <xsl:value-of select="cpm:fastcust.hinumber(.)"/>
    </xsl:template>


    <!-- 
        Assembling a 'decimal' number for an element
    -->
    <xsl:template match="*" mode="cpm.fastcust.decimal">

        <!-- 
            OVERLOAD: Strongly not recommended.
        -->

        <!-- A higher number -->
        <xsl:param name="hinumber" select="''"/>

        <!-- A higher numbering sequence -->
        <xsl:param name="hinumseq"/>
       
        <!-- Detecting a numbering sequence name of a higher element -->
        <xsl:variable name="hinumseqname" select="cpm:numseqname($hinumseq)"/>
             
        <xsl:if test="$hinumseqname != ''">
                                    
            <xsl:choose>
                <xsl:when test="$hinumseqname = cpm:numseqname(.)">                    
                    <xsl:value-of select="cpm:misc.defval($hinumber, cpm:hinumber(.))"/>
                    <xsl:value-of select="cpm:numsep(.)"/>
                </xsl:when>
                <xsl:when test="$hinumseqname = cpm:numbase(.)">                    
                    <xsl:value-of select="cpm:misc.defval($hinumber, cpm:hinumber(.))"/>
                    <xsl:value-of select="cpm:numbasesep(.)"/>
                </xsl:when>
            </xsl:choose>
                                           
        </xsl:if>

        <xsl:value-of select="cpm:locnumber(.)"/>

    </xsl:template>


    <!-- 
        Assembling a 'flat' number for an element
    -->
    <xsl:template match="*" mode="cpm.fastcust.flat">

        <!-- 
            OVERLOAD: Strongly not recommended.
        -->

        <!-- Taking a numbering sequence descriptor for an element -->
        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <!-- Taking a name of a numbering sequence -->
        <xsl:variable name="numseqname">
            <xsl:value-of select="cpm:numseqname(.)"/>
        </xsl:variable>

        <!-- Taking a base numbering sequence name -->
        <xsl:variable name="base" select="cpm:numbase(.)"/>

        <!-- Taking an element name -->
        <xsl:variable name="elname" select="name()"/>

        <!-- Counting preceding "siblings" over the numbering sequence -->
        <xsl:variable name="count">

            <xsl:choose>

                <!-- The case when a base numbering sequence is defined -->
                <xsl:when test="$base != ''">

                    <!-- Taking an ID of a closest ancestor that belongs to the base numbering sequence -->
                    <xsl:variable name="baseid"
                        select="cpm:misc.id(ancestor::*[cpm:numseqname(.) = $base][1])"/>

                    <!-- Counting preceding "numbering siblings" having the same "numbering ancestor" -->
                    <!--
                        TBD: either title or element
                    -->
                    <xsl:value-of
                        select="count(preceding::*[name() = $elname and ancestor::*[cpm:misc.id(.) = $baseid] and cpm:numseqname(.) = $numseqname])"/>

                </xsl:when>

                <!-- The case when the numbering sequence is true flat -->
                <xsl:otherwise>

                    <!--
                        TBD: either title or element
                    -->

                    <xsl:value-of
                        select="count(preceding::*[name() = $elname and cpm:numseqname(.) = $numseqname])"
                    />
                </xsl:otherwise>

            </xsl:choose>

        </xsl:variable>

        <!-- Calculating a local number of an element -->
        <xsl:variable name="locnumber" select="cpm:fastcust.numval($count + 1, $numseq//numseq)"/>

        <!-- Assembling a number -->
        <xsl:variable name="number">

            <xsl:choose>

                <!-- The case when a base numbering sequence is defined -->
                <xsl:when test="$base != ''">

                    <!-- Taking an ID of a closest ancestor that belongs to the base numbering sequence -->
                    <xsl:variable name="hinumber"
                        select="cpm:number(ancestor::*[cpm:numseqname(.) = $base][1])"/>

                    <!-- Assembling a number -->
                    <xsl:value-of
                        select="cpm:fastcust.nummerge($hinumber, $locnumber, $numseq//numseq)"/>

                </xsl:when>

                <!-- The case when the numbering sequence is true flat -->
                <xsl:otherwise>
                    <xsl:value-of select="$locnumber"/>
                </xsl:otherwise>

            </xsl:choose>

        </xsl:variable>

        <!-- Returning a number -->
        <xsl:value-of select="string($number)"/>

    </xsl:template>


    <!-- 
        Tadaaam! Assembling an element number
    -->

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.number">

        <!-- 
            OVERLOAD: Strongly not recommended.
        -->

        <!-- A higher number -->
        <xsl:param name="hinumber" select="''"/>

        <!-- A higher numbering sequence -->
        <xsl:param name="hinumseq"/>

        <!-- Taking a mode -->
        <xsl:variable name="mode" select="cpm:nummode(.)"/>

        <xsl:choose>

            <!-- ... the case when a number is decimal -->
            <xsl:when test="$mode = 'decimal'">
                <xsl:apply-templates select="." mode="cpm.fastcust.decimal">
                    <xsl:with-param name="hinumber" select="$hinumber"/>
                    <xsl:with-param name="hinumseq" select="$hinumseq"/>
                </xsl:apply-templates>
            </xsl:when>

            <!-- ... the case when a number is flat  -->
            <xsl:when test="$mode = 'flat'">
                <xsl:apply-templates select="." mode="cpm.fastcust.flat"/>
            </xsl:when>

        </xsl:choose>

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
