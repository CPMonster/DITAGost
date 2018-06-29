<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster    
    
    Level:      Library
    
    Part:       Common 
    Module:     typo.xsl
    
    Scope:      English, FO
    
    Func:       Calculating sizes, formatting strings, etc.
                  
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">


    <!-- 
        Converting pt, mm, or cm to inches
    -->
    <xsl:function name="cpm:typo.units2inches">

        <xsl:param name="value"/>

        <xsl:param name="unit"/>

        <xsl:choose>
            <xsl:when test="$unit = 'pt'">
                <xsl:value-of select="$value * 0.01388888888889"/>
            </xsl:when>
            <xsl:when test="$unit = 'mm'">
                <xsl:value-of select="$value * 0.03937007874016"/>
            </xsl:when>
            <xsl:when test="$unit = 'cm'">
                <xsl:value-of select="$value * 0.3937007874016"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$value"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>


    <!--
        Converting inches to pt, mm, or cm
    -->
    <xsl:function name="cpm:typo.inches2units">

        <xsl:param name="value"/>

        <xsl:param name="unit"/>

        <xsl:choose>
            <xsl:when test="$unit = 'pt'">
                <xsl:value-of select="$value div 0.01388888888889"/>
            </xsl:when>
            <xsl:when test="$unit = 'mm'">
                <xsl:value-of select="$value div 0.03937007874016"/>
            </xsl:when>
            <xsl:when test="$unit = 'cm'">
                <xsl:value-of select="$value div 0.3937007874016"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$value"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>


    <!-- 
        Extracting a value form a size (e.g. 123 from 123cm)
    -->

    <!-- Extracting a string representation of a value -->
    <xsl:function name="cpm:typo.get_value_string">

        <!-- A string like 1234.56in -->
        <xsl:param name="size"/>

        <xsl:analyze-string select="$size" regex="^(\+|-)?((\d+(,|\.)?\d*)|((,|\.)\d+))">
            <xsl:matching-substring>
                <xsl:value-of select="."/>
            </xsl:matching-substring>
        </xsl:analyze-string>

    </xsl:function>

    <!-- Extracting a numeric value -->
    <xsl:function name="cpm:typo.get_value">
        <xsl:param name="size"/>
        <xsl:value-of select="number(cpm:typo.get_value_string($size))"/>
    </xsl:function>


    <!-- 
        Extracting a unit form a size (e.g. cm from 123cm)
    -->
    <xsl:function name="cpm:typo.get_unit">

        <xsl:param name="size"/>

        <xsl:variable name="value_string">
            <xsl:value-of select="cpm:typo.get_value_string($size)"/>
        </xsl:variable>

        <xsl:value-of select="normalize-space(substring-after($size, $value_string))"/>

    </xsl:function>


    <!-- 
        Converting a size from to any units
    -->

    <!-- The image resolution is required -->
    <xsl:function name="cpm:typo.size2units">

        <!-- A size -->
        <xsl:param name="size"/>

        <!-- An output unit: mm, cm, etc. -->
        <xsl:param name="unit"/>

        <!-- Image resolution (is required for $unit='px') -->
        <xsl:param name="res"/>

        <xsl:variable name="source_unit">
            <xsl:value-of select="cpm:typo.get_unit($size)"/>
        </xsl:variable>

        <xsl:variable name="source_value">
            <xsl:value-of select="cpm:typo.get_value($size)"/>
        </xsl:variable>

        <xsl:choose>

            <xsl:when test="$source_unit = 'mm' and $unit = 'cm'">
                <xsl:value-of select="$source_value div 10"/>
            </xsl:when>

            <xsl:when test="$source_unit = 'cm' and $unit = 'mm'">
                <xsl:value-of select="$source_value * 10"/>
            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="inches">
                    <xsl:choose>
                        <xsl:when test="$source_unit = 'px'">
                            <xsl:value-of select="$source_value div $res"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="cpm:typo.units2inches($source_value, $source_unit)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:choose>
                    <xsl:when test="$unit = 'px'">
                        <xsl:value-of select="round($inches * $res)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="cpm:typo.inches2units($inches, $unit)"/>
                    </xsl:otherwise>
                </xsl:choose>

            </xsl:otherwise>

        </xsl:choose>

        <xsl:value-of select="$unit"/>

    </xsl:function>

    <!-- The image resolution is not required  -->
    <xsl:function name="cpm:typo.size2units">

        <xsl:param name="size"/>

        <xsl:param name="unit"/>

        <xsl:value-of select="cpm:typo.size2units($size, $unit, 1)"/>

    </xsl:function>

</xsl:stylesheet>
