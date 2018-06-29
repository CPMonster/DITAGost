<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Wrapper functions -->
    <xsl:import href="funcs.xsl"/>


    <!-- 
        Detecting elements representing topics 
    -->
    <xsl:template match="*" mode="cpm.dita.is_topic" as="xs:boolean">
        <xsl:value-of select="cpm:dita.eclass(., 'topic/topic')"/>
    </xsl:template>


    <!-- 
        Detecting appendices
    -->
    <xsl:template match="*" mode="cpm.dita.is_appendix" as="xs:boolean">

        <xsl:choose>
            <xsl:when test="root(.)//appendix[@id = current()/@id]">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 
        Detecting frontmatter topics
    -->
    <xsl:template match="*" mode="cpm.dita.is_frontmatter" as="xs:boolean">

        <xsl:variable name="id">
            <xsl:value-of select="@id"/>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="//frontmatter//*[@data-topic-id = $id]">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 
        Detecting backmatter elements
    -->
    <xsl:template match="*" mode="cpm.dita.is_backmatter" as="xs:boolean">

        <xsl:variable name="id">
            <xsl:value-of select="@id"/>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="//backmatter//*[@id = $id]">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 
        Detecting if an element is a title
    -->
    <xsl:template match="*" mode="cpm.dita.is_title" as="xs:boolean">
        <xsl:value-of select="cpm:dita.eclass(., 'topic/title')"/>
    </xsl:template>

</xsl:stylesheet>
