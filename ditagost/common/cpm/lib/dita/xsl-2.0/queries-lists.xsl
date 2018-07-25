<?xml version="1.0" encoding="UTF-8"?>

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
    
    <!-- Wrapper functions -->
    <xsl:import href="funcs.xsl"/>
    

    <!-- 
        Detecting list elements        
    -->

    <xsl:template match="*" mode="cpm.dita.is_ul" as="xs:boolean">
        <xsl:value-of select="cpm:dita.eclass(., '&DITA_CLASS_UL;')"/>
    </xsl:template>

    <xsl:template match="*" mode="cpm.dita.is_ol" as="xs:boolean">
        <xsl:value-of select="cpm:dita.eclass(., '&DITA_CLASS_OL;')"/>
    </xsl:template>

    <xsl:template match="*" mode="cpm.dita.is_li" as="xs:boolean">
        <xsl:value-of select="cpm:dita.eclass(., '&DITA_CLASS_LI;')"/>
    </xsl:template>

    <xsl:template match="*" mode="cpm.dita.in_list" as="xs:boolean">
        <xsl:choose>
            <xsl:when test="ancestor::&DITA_LI;">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
