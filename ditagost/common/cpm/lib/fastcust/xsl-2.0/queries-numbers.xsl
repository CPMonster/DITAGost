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

        <!-- 
            TBD: Write a function ;)
        -->

        <xsl:text>IV</xsl:text>

    </xsl:function>



    <!-- ================================= -->
    <!--  Assembling  numbering sequences  -->
    <!-- ================================= -->

    <!-- 
        Assembling a common numbering sequence
    -->
    <xsl:template name="cpm.fastcust.sequence">

        <!-- 
            This is a constructor template for a numbering sequence.
            The aim is to keep the most of templates imdependant of
            numbering sequence descriptor format. 
        -->

        <!-- A name of a numbering sequence -->
        <xsl:param name="name"/>

        <!-- A numbering sequence type -->
        <xsl:param name="type" select="'custom'"/>

        <!-- An initail number value -->
        <xsl:param name="start_from" select="''"/>

        <!-- Decimal or flat? -->
        <xsl:param name="mode" select="''"/>

        <!-- A list of characters (when required) -->
        <xsl:param name="chars" select="''"/>

        <!-- A name of a base numbering sequence (when required) -->
        <xsl:param name="base" select="''"/>

        <!-- A caption string -->
        <xsl:param name="caption" select="''"/>

        <numseq>

            <xsl:attribute name="name">
                <xsl:value-of select="$name"/>
            </xsl:attribute>

            <xsl:attribute name="type">
                <xsl:value-of select="$type"/>
            </xsl:attribute>

            <xsl:if test="$start_from != ''">
                <xsl:attribute name="start-from">
                    <xsl:value-of select="$start_from"/>
                </xsl:attribute>
            </xsl:if>

            <xsl:attribute name="mode">
                <xsl:choose>
                    <xsl:when test="$type = 'dummy'">
                        <xsl:value-of select="'flat'"/>
                    </xsl:when>
                    <xsl:when test="$type != 'dummy' and $mode = ''">
                        <xsl:value-of select="'decimal'"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$mode"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>

            <xsl:if test="$chars != ''">
                <xsl:attribute name="chars">
                    <xsl:value-of select="$chars"/>
                </xsl:attribute>
            </xsl:if>

            <xsl:if test="$base != ''">
                <xsl:attribute name="base">
                    <xsl:value-of select="$base"/>
                </xsl:attribute>
            </xsl:if>

            <xsl:if test="$caption != ''">
                <xsl:attribute name="caption">
                    <xsl:value-of select="$caption"/>
                </xsl:attribute>
            </xsl:if>

        </numseq>

    </xsl:template>


    <!-- 
        Assembling a numbering sequence based on a character set
    -->
    <xsl:template name="cpm.fastcust.charlist">

        <xsl:param name="name"/>
        <xsl:param name="chars"/>
        <xsl:param name="mode" select="''"/>
        <xsl:param name="base" select="''"/>
        <xsl:param name="caption" select="''"/>

        <xsl:call-template name="cpm.fastcust.sequence">
            <xsl:with-param name="name" select="$name"/>
            <xsl:with-param name="type" select="'charlist'"/>
            <xsl:with-param name="mode" select="$mode"/>
            <xsl:with-param name="chars" select="$chars"/>
            <xsl:with-param name="base" select="$base"/>
            <xsl:with-param name="caption" select="$caption"/>
        </xsl:call-template>

    </xsl:template>


    <!-- 
        Assembling a numbering sequence using a standard type
    -->
    <xsl:template name="cpm.fastcust.standard">

        <xsl:param name="name"/>
        <xsl:param name="type"/>
        <xsl:param name="start_from" select="''"/>
        <xsl:param name="mode" select="''"/>
        <xsl:param name="base" select="''"/>
        <xsl:param name="caption" select="''"/>

        <!-- 
            Type: Arabic|Latin-caps|Latin-small
        -->

        <xsl:variable name="actual_type">
            <xsl:value-of select="lower-case($type)"/>
        </xsl:variable>

        <xsl:variable name="chars">
            <xsl:choose>
                <xsl:when test="$actual_type = 'latin-caps'">
                    <xsl:text>ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:text>
                </xsl:when>
                <xsl:when test="$actual_type = 'latin-small'">
                    <xsl:text>abcdefghijklmnopqrstuvwxyz</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>

        <xsl:call-template name="cpm.fastcust.sequence">
            <xsl:with-param name="name" select="$name"/>
            <xsl:with-param name="type" select="$actual_type"/>
            <xsl:with-param name="start_from" select="$start_from"/>
            <xsl:with-param name="mode" select="$mode"/>
            <xsl:with-param name="chars" select="$chars"/>
            <xsl:with-param name="base" select="$base"/>
            <xsl:with-param name="caption" select="$caption"/>
        </xsl:call-template>

    </xsl:template>



    <!-- ========================================== -->
    <!--  Retrieving numbering sequence properties  -->
    <!-- ========================================== -->

    <!-- 
        Taking a numeration sequence property values
    -->

    <!-- A name -->
    <xsl:function name="cpm:fastcust.numname">

        <xsl:param name="numseq"/>

        <xsl:if test="not($numseq instance of xs:string)">
            <xsl:value-of select="$numseq//numseq/@name"/>
        </xsl:if>

    </xsl:function>

    <!-- A type -->
    <xsl:function name="cpm:fastcust.numtype">

        <xsl:param name="numseq"/>

        <xsl:choose>
            <xsl:when test="$numseq//numseq/@type">
                <xsl:value-of select="$numseq//numseq/@type"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>arabic</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>

    <!-- A mode -->
    <xsl:function name="cpm:fastcust.nummode">

        <xsl:param name="numseq"/>

        <xsl:choose>
            <xsl:when test="$numseq//numseq/@mode">
                <xsl:value-of select="$numseq//numseq/@mode"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>decimal</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>

    <!-- A sequence of characters -->
    <xsl:function name="cpm:fastcust.start_from">

        <xsl:param name="numseq"/>

        <xsl:choose>
            <xsl:when test="$numseq//numseq/@start-from">
                <xsl:value-of select="$numseq//numseq/@start-from"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="1"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>

    <!-- A sequence of characters -->
    <xsl:function name="cpm:fastcust.chars">

        <xsl:param name="numseq"/>

        <xsl:value-of select="$numseq//numseq/@chars"/>

    </xsl:function>

    <!-- A base -->
    <xsl:template match="numseq" mode="cpm.fastcust.numbase">       
        <xsl:value-of select="@base"/>
    </xsl:template>

    <!-- A caption (template) -->
    <xsl:template match="numseq" mode="cpm.fastcust.caption">

        <xsl:choose>
            <xsl:when test="@caption">
                <xsl:value-of select="@caption"/>
            </xsl:when>
            <xsl:when test="@type = 'dummy'">
                <xsl:value-of select="''"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>%n. </xsl:text>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- A navigation caption (template) -->
    <xsl:template match="numseq" mode="cpm.fastcust.navcaption">

        <xsl:choose>
            <xsl:when test="@navcaption">
                <xsl:value-of select="@navcaption"/>
            </xsl:when>
            <xsl:when test="not(@navcaption) and @caption">
                <xsl:value-of select="@caption"/>
            </xsl:when>
            <xsl:when test="@type = 'dummy'">
                <xsl:value-of select="''"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>%n. </xsl:text>
            </xsl:otherwise>
        </xsl:choose>

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

        <xsl:variable name="start_from">
            <xsl:value-of select="cpm:fastcust.start_from(.)"/>
        </xsl:variable>

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

        <xsl:variable name="start_from">
            <xsl:value-of select="cpm:fastcust.start_from(.)"/>
        </xsl:variable>

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

        <!-- 
            TBD: Provide the support for other possible delimiters e.g. dash, etc.
        -->

        <xsl:if test="$hinumber != ''">
            <xsl:value-of select="$hinumber"/>
            <xsl:text>.</xsl:text>
        </xsl:if>

        <xsl:value-of select="$locnumber"/>

    </xsl:function>


    <!-- 
        Formatting a number
    -->
    <xsl:function name="cpm:fastcust.numformat">

        <xsl:param name="number"/>

        <xsl:param name="numseq"/>

        <xsl:variable name="caption">
            <xsl:value-of select="cpm:fastcust.caption($numseq)"/>
        </xsl:variable>

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

        <xsl:variable name="navcaption">
            <xsl:value-of select="cpm:fastcust.navcaption($numseq)"/>
        </xsl:variable>

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



    <!-- ========================================= -->
    <!--  Retrieving numbering sequence and names  -->
    <!-- ========================================= -->

    <!-- 
        Detecting an element numbering sequence name
    -->

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
        Retrieving a numbering section for an element
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
        Detecting base numbering sequence name
    -->

    <!-- A default template (should be overloaded in a generated layout.xsl) -->
    <xsl:template match="*" mode="cpm.fastcust.numbase">

        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <xsl:if test="cpm:misc.is_element($numseq, 'numseq')">            
            <xsl:apply-templates select="$numseq/numseq" mode="#current"/>
        </xsl:if>

    </xsl:template>

    <!-- A default template for a flat documnet (always wins) -->
    <xsl:template match="*[@cpm:numbase]" mode="cpm.fastcust.numbase" priority="2">
        <xsl:value-of select="@cpm:numbase"/>
    </xsl:template>

    <!-- A custom template -->    
    <xsl:template match="*" mode="numbase">
        <xsl:value-of select="cpm:fastcust.numbase(.)"/>
    </xsl:template>



    <!-- ============================================ -->
    <!--  Assembling a number for a document element  -->
    <!-- ============================================ -->

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

        <!-- Taking a name of a numbering section -->
        <xsl:variable name="numseqname">
            <xsl:value-of select="cpm:numseqname(.)"/>
        </xsl:variable>

        <!-- Taking a numbering sequence descriptor for an element -->
        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <!-- Retrieving a number of a previous element -->
        <xsl:variable name="locnumber">
            <xsl:value-of select="cpm:fastcust.locnumber(.)"/>
        </xsl:variable>

        <!-- Retrieving a number of a higher element -->
        <xsl:variable name="higher">

            <xsl:choose>

                <!-- ... the case when someone provides a higher number -->
                <xsl:when test="$hinumber != ''">
                    <xsl:value-of select="$hinumber"/>
                </xsl:when>

                <!-- ... the case when we have to calculate a higher number -->
                <xsl:otherwise>
                    <xsl:value-of select="cpm:fastcust.hinumber(.)"/>
                </xsl:otherwise>

            </xsl:choose>

        </xsl:variable>

        <!-- Finally, assembling a number -->

        <xsl:variable name="base" select="cpm:numbase($numseq)"/>

        <xsl:variable name="hinumseqname" select="cpm:fastcust.numname($hinumseq)"/>

        <xsl:choose>

            <!-- Appending a local number to a higher number -->
            <xsl:when test="$numseqname = $hinumseqname or $base = $hinumseqname">
                <xsl:value-of select="cpm:fastcust.nummerge($higher, $locnumber, $numseq)"/>
            </xsl:when>

            <xsl:when test="empty($hinumseq)">
                <xsl:value-of select="cpm:fastcust.nummerge($higher, $locnumber, $numseq)"/>
            </xsl:when>

            <!-- Using a local number -->
            <xsl:otherwise>
                <xsl:value-of select="cpm:fastcust.nummerge($higher, $locnumber, $numseq)"/>
            </xsl:otherwise>

        </xsl:choose>

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
        <xsl:variable name="base" select="cpm:numbase($numseq/numseq)"/>                

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
        <xsl:variable name="locnumber" select="cpm:fastcust.numval($count + 1, $numseq)"/>

        <!-- Assembling a number -->
        <xsl:variable name="number">

            <xsl:choose>

                <!-- The case when a base numbering sequence is defined -->
                <xsl:when test="$base != ''">

                    <!-- Taking an ID of a closest ancestor that belongs to the base numbering sequence -->
                    <xsl:variable name="hinumber"
                        select="cpm:number(ancestor::*[cpm:numseqname(.) = $base][1])"/>

                    <!-- Assembling a number -->
                    <xsl:value-of select="cpm:fastcust.nummerge($hinumber, $locnumber, $numseq)"/>

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

        <!-- Taking a numbering sequence descriptor for an element -->
        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <!-- Taking a type -->
        <xsl:variable name="type">
            <xsl:value-of select="cpm:fastcust.numtype($numseq)"/>
        </xsl:variable>

        <!-- Calculating a number depending on a mode -->
        <xsl:if test="$type != 'dummy'">

            <!-- Taking a mode -->
            <xsl:variable name="mode">
                <xsl:value-of select="cpm:fastcust.nummode($numseq)"/>
            </xsl:variable>

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

        </xsl:if>

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
        Retrieving a caption for an element
    -->

    <!-- A default template -->
    <xsl:template match="*[name() != 'numseq']" mode="cpm.fastcust.caption">

        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <xsl:apply-templates select="$numseq/numseq" mode="cpm.fastcust.caption"/>

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

    <!-- A default template -->
    <xsl:template match="*[name() != 'numseq']" mode="cpm.fastcust.navcaption">

        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <xsl:apply-templates select="$numseq/numseq" mode="cpm.fastcust.navcaption"/>

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
        Assembling a full number for an element
    -->

    <!-- A default template -->
    <xsl:template match="*" mode="cpm.fastcust.full_number">

        <xsl:variable name="caption">
            <xsl:value-of select="cpm:caption(.)"/>
        </xsl:variable>

        <xsl:value-of select="substring-before(., '%n')"/>
        <xsl:value-of select="cpm:number(.)"/>
        <xsl:value-of select="substring-after(., '%n')"/>

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

        <xsl:variable name="caption">
            <xsl:value-of select="cpm:navcaption(.)"/>
        </xsl:variable>

        <xsl:value-of select="substring-before(., '%n')"/>
        <xsl:value-of select="cpm:number(.)"/>
        <xsl:value-of select="substring-after(., '%n')"/>

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
