<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product: CopyPaste Monster
    
    Level:   Library    
    
    Part:    Common libraries 
    Module:  translit.xsl
    
    Scope:   Russian (shall become international in the future)
    
    Func:    Transliterating strings.                  
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Assembling a list of national characters
    -->
    <xsl:function name="cpm:trnslit.national">

        <xsl:variable name="tmp">
            <xsl:text>АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ</xsl:text>
            <xsl:text>абвгдеёжзийклмнопрстуфхцчшщъыьэюя</xsl:text>
        </xsl:variable>

        <xsl:value-of select="string($tmp)"/>

    </xsl:function>


    <!-- 
        Assembling a list of Latin substitutors
    -->
    <xsl:function name="cpm:translit.latin">

        <xsl:variable name="tmp">
            <xsl:text>ABVGDEEJZIIKLMNOPRSTUFHCCWWXYXEQA</xsl:text>
            <xsl:text>abvgdeejziiklmnoprstufhccwwxyxeqa</xsl:text>
        </xsl:variable>

        <xsl:value-of select="string($tmp)"/>

    </xsl:function>


    <!-- 
        Checking if a character Litin 
    -->
    <xsl:function name="cpm:translit.is_latin" as="xs:boolean">

        <xsl:param name="char"/>

        <xsl:variable name="latin" select="cpm:translit.latin()"/>

        <xsl:value-of select="boolean(contains($latin, $char))"/>

    </xsl:function>


    <!-- 
        Transliterating a string
    -->
    <xsl:function name="cpm:translit">

        <!-- A string to be transliterated -->
        <xsl:param name="str"/>

        <!-- Assembling a list of national characters-->
        <xsl:variable name="national" select="cpm:trnslit.national()"/>

        <!-- Assembling a list of substitutors -->
        <xsl:variable name="latin" select="cpm:translit.latin()"/>

        <!-- Replacing each national character with a substitutor -->
        <xsl:value-of select="translate($str, $national, $latin)"/>

    </xsl:function>


    <!-- 
        Transliterating a string for using it as a part of an URI
    -->
    <xsl:function name="cpm:translit.uri">

        <xsl:param name="str"/>

        <xsl:variable name="tmp1" select="cpm:translit(normalize-space($str))"/>

        <xsl:variable name="tmp2" select="translate($tmp1, ' ', '_')"/>

        <xsl:value-of select="encode-for-uri($tmp2)"/>

    </xsl:function>


    <!-- 
        Transliterating a string for using it as a name
    -->
    <xsl:function name="cpm:translit.name">

        <xsl:param name="str"/>

        <xsl:variable name="tmp1" select="cpm:translit.uri($str)"/>

        <xsl:variable name="tmp2" select="translate($tmp1, '%', '')"/>

        <xsl:variable name="tmp3">

            <xsl:if test="not(cpm:translit.is_latin(substring($tmp2, 1, 1)))">
                <xsl:text>_</xsl:text>
            </xsl:if>

            <xsl:value-of select="$tmp2"/>

        </xsl:variable>

        <xsl:value-of select="$tmp3"/>

    </xsl:function>


    <!-- 
        Converting a string to a valid hashtag
    -->

    <!-- 
        TBD: Removing redundant first, than removing restricted
    -->

    <!-- Characters that should be removed from a hashtag -->
    <xsl:function name="cpm:translit.hashtag.restricted">
        <xsl:text>.,:;?!'"“”«»—–-/\|`~@#$%^&amp;*+=[](){}№&gt;&lt;</xsl:text>
    </xsl:function>

    <!-- Regexp for strings that should be removed from a hashtag -->
    <xsl:function name="cpm:translit.hashtag.redundant">
        <xsl:text>^\d+\s</xsl:text>
    </xsl:function>

    <!-- Assembling a hashtag -->
    <xsl:function name="cpm:translit.hashtag">

        <!-- 
            The $str parameter is a probable title of a section, a document,
            a topic, etc. The aim of assigning hashtags to topics is making
            references that are based on titles more redundant.
        -->

        <xsl:param name="str"/>

        <!-- Characters that are undesired in a hashtag -->
        <xsl:variable name="restricted" select="cpm:translit.hashtag.restricted()"/>

        <!-- Removing redundant spaces -->
        <xsl:variable name="tmp1">
            <xsl:value-of select="normalize-space($str)"/>
        </xsl:variable>

        <!-- Removing undesired characters -->
        <xsl:variable name="tmp2">
            <xsl:value-of select="translate($tmp1, $restricted, '')"/>
        </xsl:variable>

        <!-- Substrings that should be removed from a hashtag -->
        <xsl:variable name="redundant" select="cpm:translit.hashtag.redundant()"/>

        <!-- Removing a probable section numder -->
        <xsl:variable name="tmp3">
            <xsl:analyze-string select="$tmp2" regex="{$redundant}">
                <xsl:non-matching-substring>
                    <xsl:value-of select="."/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:variable>

        <!-- Finally, asembling a hashtag -->
        <xsl:value-of select="lower-case(cpm:translit.name($tmp3))"/>

    </xsl:function>


    <!-- 
        Comparing two strings as hashtags
    -->
    <xsl:function name="cpm:translit.eqht" as="xs:boolean">

        <xsl:param name="str1"/>

        <xsl:param name="str2"/>

        <xsl:variable name="ht1">
            <xsl:value-of select="cpm:translit.hashtag($str1)"/>
        </xsl:variable>

        <xsl:variable name="ht2">
            <xsl:value-of select="cpm:translit.hashtag($str2)"/>
        </xsl:variable>

        <xsl:value-of select="boolean($ht1 = $ht2)"/>

    </xsl:function>


    <!--
        Transforming a list of strings to a list of hashtags
    -->
    <xsl:function name="cpm:translit.hashtagize">

        <!-- A string -->
        <xsl:param name="list"/>

        <!-- A separator pattern -->
        <xsl:param name="sep_pattern"/>

        <!-- A separator -->
        <xsl:param name="outsep"/>

        <xsl:for-each select="tokenize($list, $sep_pattern)">
            <xsl:value-of select="cpm:translit.hashtag(.)"/>
            <xsl:if test="position() != last()">
                <xsl:value-of select="$outsep"/>
            </xsl:if>
        </xsl:for-each>

    </xsl:function>


    <!-- 
        Matching a string with a list of strings as hashtags
    -->
    <xsl:function name="cpm:translit.mlht" as="xs:boolean">

        <!-- A target string -->
        <xsl:param name="str"/>

        <!-- A list of strings -->
        <xsl:param name="list"/>

        <!-- A pattern for a list separator -->
        <xsl:param name="sep_pattern"/>

        <xsl:variable name="tmp">
            <xsl:analyze-string select="$list" regex="{$sep_pattern}">
                <xsl:non-matching-substring>
                    <xsl:if test="cpm:translit.eqht($str, .)">
                        <xsl:text>yes</xsl:text>
                    </xsl:if>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp != '')"/>

    </xsl:function>
    
    
    <!-- 
        Matching a string with a sequence of elements as hashtags
    -->
    <xsl:function name="cpm:translit.msht" as="xs:boolean">
        
        <!-- A target string -->
        <xsl:param name="str"/>
        
        <!-- A list of strings -->
        <xsl:param name="sequence"/>                
        
        <!-- Checking a value-->
        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="$sequence//*[cpm:translit.eqht(., $str)]">
                    <xsl:value-of select="true()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:value-of select="$tmp"/>
        
    </xsl:function>



    <!-- ======= -->
    <!--  DEBUG  -->
    <!-- ======= -->
    <!--			
    <xsl:template match="/">

        <xsl:copy-of select="cpm:translit.hashtagize('cat ; dog ; `лягушка`  ', ';', ';')"/>

    </xsl:template>
    -->

</xsl:stylesheet>
