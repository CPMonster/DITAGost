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

    <!-- FastCust wrapper functions -->
    <xsl:import href="funcs.xsl"/>



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
    <xsl:function name="cpm:fastcust.numbers.incchar">

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
    <xsl:function name="cpm:fastcust.numbers.char">

        <!-- A current character -->
        <xsl:param name="index"/>

        <!-- A sequence of characters -->
        <xsl:param name="alphabet"/>

        <xsl:value-of select="substring($alphabet, $index, 1)"/>

    </xsl:function>


    <!--  
        Taking the next number for a Roman number
    -->
    <xsl:function name="cpm:fastcust.numbers.incroman">

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
    <xsl:template name="cpm.fastcust.numbers.sequence">

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
    <xsl:template name="cpm.fastcust.numbers.charlist">

        <xsl:param name="name"/>
        <xsl:param name="chars"/>
        <xsl:param name="mode" select="''"/>
        <xsl:param name="base" select="''"/>
        <xsl:param name="caption" select="''"/>

        <xsl:call-template name="cpm.fastcust.numbers.sequence">
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
    <xsl:template name="cpm.fastcust.numbers.standard">

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

        <xsl:call-template name="cpm.fastcust.numbers.sequence">
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
    <xsl:function name="cpm:fastcust.numbers.name">

        <xsl:param name="numseq"/>

        <xsl:if test="not($numseq instance of xs:string)">
            <xsl:value-of select="$numseq//numseq/@name"/>
        </xsl:if>

    </xsl:function>

    <!-- A type -->
    <xsl:function name="cpm:fastcust.numbers.type">

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
    <xsl:function name="cpm:fastcust.numbers.mode">

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
    <xsl:function name="cpm:fastcust.numbers.start_from">

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
    <xsl:function name="cpm:fastcust.numbers.chars">

        <xsl:param name="numseq"/>

        <xsl:value-of select="$numseq//numseq/@chars"/>

    </xsl:function>

    <!-- A base -->
    <xsl:function name="cpm:fastcust.numbers.base">

        <xsl:param name="numseq"/>

        <xsl:value-of select="$numseq//numseq/@base"/>

    </xsl:function>

    <!-- A caption (template) -->
    <xsl:template match="numseq" mode="cpm.fastcust.numbers.caption">

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

    <!-- A caption (wrapper) -->
    <xsl:function name="cpm:fastcust.numbers.caption">

        <xsl:param name="numseq"/>

        <xsl:apply-templates select="$numseq//numseq" mode="cpm.fastcust.numbers.caption"/>

    </xsl:function>
    
    
    <!-- A navigation caption (template) -->
    <xsl:template match="numseq" mode="cpm.fastcust.numbers.navcaption">
        
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
    
    <!-- A navigation caption (wrapper) -->
    <xsl:function name="cpm:fastcust.numbers.navcaption">
        
        <xsl:param name="numseq"/>
        
        <xsl:apply-templates select="$numseq//numseq" mode="cpm.fastcust.numbers.navcaption"/>
        
    </xsl:function>



    <!-- ====================== -->
    <!--  Incrementing numbers  -->
    <!-- ====================== -->

    <!-- 
        A dummy template
    -->
    <xsl:template match="numseq" mode="cpm.fastcust.numbers.inc">

        <xsl:param name="number"/>

        <xsl:value-of select="0"/>

    </xsl:template>


    <xsl:template match="numseq[@type = 'dummy']" mode="cpm.fastcust.numbers.inc"/>


    <!-- 
        Calculating the next number for 1, 2, 3...
    -->
    <xsl:template match="numseq[@type = 'arabic']" mode="cpm.fastcust.numbers.inc">

        <xsl:param name="number"/>

        <xsl:variable name="start_from">
            <xsl:value-of select="cpm:fastcust.numbers.start_from(.)"/>
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
    <xsl:template match="numseq[@type = 'roman']" mode="cpm.fastcust.numbers.inc">

        <xsl:param name="number"/>

        <xsl:value-of select="cpm:fastcust.numbers.incroman($number)"/>

    </xsl:template>


    <!-- 
        Calculating the next number for A, B, C...
    -->
    <xsl:template match="numseq[@chars]" mode="cpm.fastcust.numbers.inc">

        <xsl:param name="number"/>

        <xsl:value-of select="cpm:fastcust.numbers.incchar($number, @chars)"/>

    </xsl:template>


    <!--  
        A wrapper function for "increment" templates
    -->
    <xsl:function name="cpm:fastcust.numbers.inc">

        <!-- A current number -->
        <xsl:param name="number"/>

        <!-- A numbering sequence-->
        <xsl:param name="numseq"/>

        <xsl:apply-templates select="$numseq//numseq" mode="cpm.fastcust.numbers.inc">
            <xsl:with-param name="number" select="$number"/>
        </xsl:apply-templates>

    </xsl:function>



    <!-- ===================================================== -->
    <!--  Converting an natural index to a local number value  -->
    <!-- ===================================================== -->

    <xsl:template match="numseq[@type = 'dummy']" mode="cpm.fastcust.numbers.value"/>

    <!-- 
        Taking a natural number by an index (not so fast!)
    -->
    <xsl:template match="numseq[@type = 'arabic']" mode="cpm.fastcust.numbers.value">

        <xsl:param name="index"/>

        <xsl:variable name="start_from">
            <xsl:value-of select="cpm:fastcust.numbers.start_from(.)"/>
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
    <xsl:template match="numseq[@type = 'roman']" mode="cpm.fastcust.numbers.value">

        <xsl:param name="index"/>

        <xsl:text>IV</xsl:text>

    </xsl:template>


    <!-- 
        Taking a character by an index
    -->
    <xsl:template match="numseq[@chars]" mode="cpm.fastcust.numbers.value">

        <xsl:param name="index"/>

        <xsl:value-of select="cpm:fastcust.numbers.char($index, @chars)"/>

    </xsl:template>


    <!-- 
        Taking a local number by an index
    -->
    <xsl:function name="cpm:fastcust.numbers.value">

        <!-- An index -->
        <xsl:param name="index"/>

        <!-- A numbering sequence-->
        <xsl:param name="numseq"/>

        <xsl:apply-templates select="$numseq//numseq" mode="cpm.fastcust.numbers.value">
            <xsl:with-param name="index" select="$index"/>
        </xsl:apply-templates>

    </xsl:function>



    <!-- ==================== -->
    <!--  Assembling numbers  -->
    <!-- ==================== -->

    <!-- 
        Assembling a "decimal" number
    -->
    <xsl:function name="cpm:fastcust.numbers.merge">

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
    <xsl:function name="cpm:fastcust.numbers.format">

        <xsl:param name="number"/>

        <xsl:param name="numseq"/>

        <xsl:variable name="caption">
            <xsl:value-of select="cpm:fastcust.numbers.caption($numseq)"/>
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
    <xsl:function name="cpm:fastcust.numbers.navformat">
        
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

    <!-- Returning an empty value for a common element -->
    <xsl:template match="*" mode="cpm.fastcust.numbers.numlevel"/>

    <!-- A default template for sections (topics) -->
    <xsl:template match="*[cpm:fastcust.is_section(.)]" mode="cpm.fastcust.numbers.numlevel">
        <xsl:if test="cpm:fastcust.is_docmamber(.)">
            <xsl:value-of select="count(ancestor::*[cpm:fastcust.is_section(.)]) + 1"/>
        </xsl:if>
    </xsl:template>

    <!-- A default template for section (topic) titles -->
    <xsl:template match="*[cpm:fastcust.is_section(.)]/title" mode="cpm.fastcust.numbers.numlevel">
        <xsl:value-of select="count(ancestor::*[cpm:fastcust.is_section(.)])"/>
    </xsl:template>


    <!-- 
        Do elements belong to the same numbering sequence?
    -->
    <xsl:function name="cpm:fastcust.numbers.eqnumseq" as="xs:boolean">

        <!-- An element -->
        <xsl:param name="element1"/>

        <!-- Anothe one -->
        <xsl:param name="element2"/>

        <xsl:variable name="numseqname1">
            <xsl:value-of select="cpm:fastcust.numseqname($element1)"/>
        </xsl:variable>

        <xsl:variable name="numseqname2">
            <xsl:value-of select="cpm:fastcust.numseqname($element2)"/>
        </xsl:variable>

        <xsl:value-of select="boolean($numseqname1 = $numseqname2)"/>

    </xsl:function>


    <!-- 
        Do element local numbers belong to the same local sequence?
    -->
    <xsl:function name="cpm:fastcust.numbers.sibs" as="xs:boolean">

        <!-- 
            The word "preceding" means preceding, not the previous. This 
            function allows us to apply a filter to the ./preceding-sibling::* 
            sequence. Another function or a template that calls this function 
            should contain code like the following:
            
            preceding-sibling::*[cpm:fastcust.numbering.is_local_sibling(.)][1]            
        -->

        <!-- An element -->
        <xsl:param name="element1"/>

        <!-- Another one -->
        <xsl:param name="element2"/>

        <xsl:variable name="same_numlevel" as="xs:boolean">
            <xsl:value-of select="cpm:fastcust.eqnumlevel($element1, $element2)"/>
        </xsl:variable>

        <xsl:variable name="same_numseq" as="xs:boolean">
            <xsl:value-of select="cpm:fastcust.numbers.eqnumseq($element1, $element2)"/>
        </xsl:variable>

        <xsl:value-of select="boolean($same_numlevel and $same_numseq)"/>

    </xsl:function>



    <!-- ============================================ -->
    <!--  Assembling a number for a document element  -->
    <!-- ============================================ -->

    <!-- 
        Taking a local number of an element
    -->

    <!-- A template -->
    <xsl:template match="*" mode="cpm.fastcust.numbers.locnumber">

        <!-- Retrieving a numbering sequence for an element -->
        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <!-- Calculating an index of the element in a local sequence -->
        <xsl:variable name="index">
            <xsl:value-of
                select="count(preceding-sibling::*[cpm:fastcust.numbers.sibs(current(), .)]) + 1"/>
        </xsl:variable>

        <xsl:value-of select="cpm:fastcust.numbers.value($index, $numseq)"/>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.numbers.locnumber">

        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="cpm.fastcust.numbers.locnumber"/>

    </xsl:function>


    <!-- 
        Taking a number of a higher element
    -->

    <!-- A working template -->
    <xsl:template match="*" mode="cpm.fastcust.numbers.hinumber">

        <xsl:choose>

            <!-- Retrieving a higher number in the same numbering sequence -->
            <xsl:when test="ancestor::*[cpm:fastcust.numbers.eqnumseq(current(), .)]">
                <xsl:for-each select="ancestor::*[cpm:fastcust.numbers.eqnumseq(current(), .)][1]">
                    <xsl:value-of select="cpm:fastcust.number(.)"/>
                </xsl:for-each>
            </xsl:when>

            <!-- Trying with a base numbering sequence (when available) -->
            <xsl:otherwise>

                <xsl:variable name="numseq">
                    <xsl:apply-templates select="." mode="numseq"/>
                </xsl:variable>

                <xsl:variable name="base">
                    <xsl:value-of select="cpm:fastcust.numbers.base($numseq)"/>
                </xsl:variable>

                <xsl:if test="$base != ''">
                    <xsl:if test="ancestor::*[cpm:fastcust.numseqname(.) = $base]">
                        <xsl:for-each select="ancestor::*[cpm:fastcust.numseqname(.) = $base][1]">
                            <xsl:value-of select="cpm:fastcust.number(.)"/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:if>

            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.numbers.hinumber">

        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="cpm.fastcust.numbers.hinumber"/>

    </xsl:function>


    <!-- 
        Assembling a 'decimal' number for an element
    -->
    <xsl:template match="*" mode="cpm.fastcust.numbers.decimal">

        <!-- 
            OVERLOAD: Strongly not recommended.
        -->

        <!-- A higher number -->
        <xsl:param name="hinumber" select="''"/>

        <!-- A higher numbering sequence -->
        <xsl:param name="hinumseq"/>

        <!-- Taking a name of a numbering section -->
        <xsl:variable name="numseqname">
            <xsl:value-of select="cpm:fastcust.numseqname(.)"/>
        </xsl:variable>

        <!-- Taking a numbering sequence descriptor for an element -->
        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <!-- Retrieving a number of a previous element -->
        <xsl:variable name="locnumber">
            <xsl:value-of select="cpm:fastcust.numbers.locnumber(.)"/>
        </xsl:variable>

        <!-- Retrieving a number of a higher element -->
        <xsl:variable name="higher">

            <xsl:choose>

                <!-- ... the case when someone provides a higher number -->
                <xsl:when test="$hinumber != ''">
                    <!-- <xsl:text>*****</xsl:text> -->
                    <!-- <xsl:value-of select="cpm:fastcust.numbers.hinumber(.)"/> -->

                    <xsl:value-of select="$hinumber"/>

                </xsl:when>

                <!-- ... the case when we have to calculate a higher number -->
                <xsl:otherwise>
                    <!-- <xsl:text>???</xsl:text> -->
                    <xsl:value-of select="cpm:fastcust.numbers.hinumber(.)"/>
                </xsl:otherwise>

            </xsl:choose>

        </xsl:variable>

        <!-- Finally, assembling a number -->

        <xsl:variable name="base">
            <xsl:value-of select="cpm:fastcust.numbers.base($numseq)"/>
        </xsl:variable>

        <xsl:variable name="hinumseqname">
            <xsl:value-of select="cpm:fastcust.numbers.name($hinumseq)"/>
        </xsl:variable>

        <xsl:choose>

            <!-- Appending a local number to a higher number -->
            <xsl:when test="$numseqname = $hinumseqname or $base = $hinumseqname">
                <xsl:value-of select="cpm:fastcust.numbers.merge($higher, $locnumber, $numseq)"/>
            </xsl:when>

            <xsl:when test="empty($hinumseq)">
                <xsl:value-of select="cpm:fastcust.numbers.merge($higher, $locnumber, $numseq)"/>
            </xsl:when>

            <!-- Using a local number -->
            <xsl:otherwise>
                <!-- <xsl:text>!!!!!</xsl:text> -->
                <xsl:value-of select="cpm:fastcust.numbers.merge($higher, $locnumber, $numseq)"/>
                <!--
                <xsl:value-of select="$locnumber"/>
                -->
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>


    <!-- 
        Assembling a 'flat' number for an element
    -->
    <xsl:template match="*" mode="cpm.fastcust.numbers.flat">

        <!-- 
            OVERLOAD: Strongly not recommended.
        -->

        <!-- Taking a numbering sequence descriptor for an element -->
        <xsl:variable name="numseq">
            <xsl:apply-templates select="." mode="numseq"/>
        </xsl:variable>

        <!-- Taking a name of a numbering sequence -->
        <xsl:variable name="numseqname">
            <xsl:value-of select="cpm:fastcust.numseqname(.)"/>
        </xsl:variable>

        <!-- Taking a base numbering sequence name -->
        <xsl:variable name="basename">
            <xsl:value-of select="cpm:fastcust.numbers.base($numseq)"/>
        </xsl:variable>
        
        <!-- Taking an element name -->
        <xsl:variable name="elname" select="name()"/>

        <!-- Counting preceding "siblings" over the numbering sequence -->
        <xsl:variable name="count">

            <xsl:choose>

                <!-- The case when a base numbering sequence is defined -->
                <xsl:when test="$basename != ''">

                    <!-- Taking an ID of a closest ancestor that belongs to the base numbering sequence -->
                    <xsl:variable name="baseid"
                        select="cpm:fastcust.id(ancestor::*[cpm:fastcust.numseqname(.) = $basename][1])"/>

                    <!-- Counting preceding "numbering siblings" having the same "numbering ancestor" -->
                    <!--
                        TBD: either title or element
                    -->
                    <xsl:value-of
                        select="count(preceding::*[name()=$elname and ancestor::*[cpm:fastcust.id(.) = $baseid] and cpm:fastcust.numseqname(.) = $numseqname])"/>

                </xsl:when>

                <!-- The case when the numbering sequence is true flat -->
                <xsl:otherwise>
                    
                    <!--
                        TBD: either title or element
                    -->
                    
                    <xsl:value-of
                        select="count(preceding::*[name()=$elname and cpm:fastcust.numseqname(.) = $numseqname])"/>
                </xsl:otherwise>

            </xsl:choose>

        </xsl:variable>

        <!-- Calculating a local number of an element -->
        <xsl:variable name="locnumber" select="cpm:fastcust.numbers.value($count + 1, $numseq)"/>

        <!-- Assembling a number -->
        <xsl:variable name="number">

            <xsl:choose>

                <!-- The case when a base numbering sequence is defined -->
                <xsl:when test="$basename != ''">

                    <!-- Taking an ID of a closest ancestor that belongs to the base numbering sequence -->
                    <xsl:variable name="hinumber"
                        select="cpm:fastcust.number(ancestor::*[cpm:fastcust.numseqname(.) = $basename][1])"/>

                    <!-- Assembling a number -->
                    <xsl:value-of
                        select="cpm:fastcust.numbers.merge($hinumber, $locnumber, $numseq)"/>

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
        Assembling a number for an element
    -->

    <!-- A template -->
    <xsl:template match="*" mode="cpm.fastcust.numbers.number">

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
            <xsl:value-of select="cpm:fastcust.numbers.type($numseq)"/>
        </xsl:variable>        

        <!-- Calculating a number depending on a mode -->
        <xsl:if test="$type != 'dummy'">
            
            <!-- Taking a mode -->
            <xsl:variable name="mode">
                <xsl:value-of select="cpm:fastcust.numbers.mode($numseq)"/>
            </xsl:variable>
            
            <xsl:choose>

                <!-- ... the case when a number is decimal -->
                <xsl:when test="$mode = 'decimal'">
                    <xsl:apply-templates select="." mode="cpm.fastcust.numbers.decimal">
                        <xsl:with-param name="hinumber" select="$hinumber"/>
                        <xsl:with-param name="hinumseq" select="$hinumseq"/>
                    </xsl:apply-templates>
                </xsl:when>

                <!-- ... the case when a number is flat  -->
                <xsl:when test="$mode = 'flat'">
                    <xsl:apply-templates select="." mode="cpm.fastcust.numbers.flat"/>
                </xsl:when>

            </xsl:choose>

        </xsl:if>

    </xsl:template>

</xsl:stylesheet>
