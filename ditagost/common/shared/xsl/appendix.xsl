<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      ESKD shared files
        
    Part:       ESKD  
    Module:     appendix.xsl
    
    Scope:      DITA, DITA OT, Russian, ESKD
    
    Func:       Working with appendices
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">

    <!-- =========== -->
    <!--  Improving  -->
    <!-- =========== -->

    <!-- 
        Detecting an appendix
    -->
    <xsl:function name="cpm:is_appendix" as="xs:boolean">

        <xsl:param name="element"/>

        <xsl:variable name="id">
            <xsl:value-of select="$element/@id"/>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="root($element)//appendix[@id = $id]">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>

</xsl:stylesheet>
