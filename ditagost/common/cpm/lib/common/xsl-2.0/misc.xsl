<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">


    <!-- 
        Detecting or generating an ID for an element
    -->
    <xsl:function name="cpm:misc.id">

        <xsl:param name="element"/>

        <xsl:if test="cpm:misc.is_element($element)">
            <xsl:choose>
                <xsl:when test="$element/@id">
                    <xsl:value-of select="$element/@id"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="generate-id($element)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>

    </xsl:function>


    <!-- 
        Assembling an attribute for a non-empty value
    -->
    <xsl:function name="cpm:misc.attr">

        <xsl:param name="attr_name"/>

        <xsl:param name="attr_value"/>

        <!-- Escaping sequences, numbers, etc. -->
        <xsl:variable name="tmp">
            <xsl:value-of select="$attr_value"/>
        </xsl:variable>

        <xsl:if test="$tmp != ''">
            <xsl:attribute name="{$attr_name}">
                <xsl:value-of select="$attr_value"/>
            </xsl:attribute>
        </xsl:if>

    </xsl:function>


    <!-- 
        Assembling a missing attribute for an element
    -->
    <xsl:function name="cpm:misc.mattr">

        <xsl:param name="element"/>

        <xsl:param name="attr_name"/>

        <xsl:param name="attr_value"/>

        <xsl:if test="not($element/@*[name() = $attr_name])">
            <xsl:attribute name="{$attr_name}">
                <xsl:value-of select="$attr_value"/>
            </xsl:attribute>
        </xsl:if>

    </xsl:function>


    <!-- 
        Assembling an @id attribute
    -->
    <xsl:function name="cpm:misc.attrid">

        <xsl:param name="element"/>

        <xsl:choose>
            <xsl:when test="$element/@id">
                <xsl:copy-of select="$element/@id"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id($element)"/>
                </xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>


    <!-- 
        Assembling a missing @id attribute for an element
    -->
    <xsl:function name="cpm:misc.mattrid">

        <xsl:param name="element"/>

        <xsl:if test="not($element/@id)">
            <xsl:attribute name="id">
                <xsl:value-of select="generate-id($element)"/>
            </xsl:attribute>
        </xsl:if>

    </xsl:function>


    <!-- 
        Detecting elements vs. text
    -->

    <!-- Any element works -->
    <xsl:function name="cpm:misc.is_element" as="xs:boolean">

        <xsl:param name="data"/>

        <xsl:variable name="tmp">
            <wrapper>
                <xsl:copy-of select="$data"/>
            </wrapper>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$tmp/wrapper/*">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>

    <!-- Checking an element name -->
    <xsl:function name="cpm:misc.is_element" as="xs:boolean">

        <xsl:param name="data"/>

        <xsl:param name="elname"/>

        <xsl:variable name="tmp">
            <wrapper>
                <xsl:copy-of select="$data"/>
            </wrapper>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$tmp/wrapper/*[name() = $elname]">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>


    <!-- 
        Returns a default value if a value is empty
    -->
    <xsl:function name="cpm:misc.defval">

        <xsl:param name="value"/>

        <xsl:param name="default"/>

        <xsl:choose>
            <xsl:when test="$value != ''">
                <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$default"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>


    <!-- 
        Returns a default numeric value if a value is 0
    -->
    <xsl:function name="cpm:misc.defnum">

        <xsl:param name="value"/>

        <xsl:param name="default"/>

        <xsl:choose>
            <xsl:when test="$value != 0">
                <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$default"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>


    <!-- 
        Taking a number; zero is a default value
    -->
    <xsl:function name="cpm:misc.defnum0">

        <!-- A value pretending to be numeric -->
        <xsl:param name="val"/>

        <xsl:choose>
            <xsl:when test="$val castable as xs:decimal">
                <xsl:value-of select="number($val)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="0"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>


    <!-- 
        Taking a number; 1 is a default value
    -->
    <xsl:function name="cpm:misc.defnum1">

        <!-- A value pretending to be numeric -->
        <xsl:param name="val"/>

        <xsl:choose>
            <xsl:when test="$val castable as xs:decimal">
                <xsl:value-of select="number($val)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="1"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>


    <!-- 
        Taking a number; the infinity is a default value
    -->

    <!-- Generating the actual infinity -->
    <xsl:template name="cpm.misc.infinity">
        <xsl:value-of select="999999999"/>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:misc.defnuminf">

        <!-- A value pretending to be numeric -->
        <xsl:param name="val"/>

        <xsl:choose>
            <xsl:when test="$val castable as xs:decimal">
                <xsl:value-of select="number($val)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="cpm.misc.infinity"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>


    <!-- 
        Returns a default sequence if a sequence is empty
    -->
    <xsl:function name="cpm:misc.defseq">

        <xsl:param name="seq"/>

        <xsl:param name="defseq"/>

        <xsl:choose>
            <xsl:when test="exists($seq)">
                <xsl:copy-of select="$seq"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="$defseq"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>

</xsl:stylesheet>
