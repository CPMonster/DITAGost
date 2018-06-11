<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster   
    
    Level:      Library
    
    Part:       DITA library
    Module:     queries-maps.xsl
    
    Scope:      DITA
    
    Func:       Retrieving data from source bookmaps, maps, etc.       
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->    


<!DOCTYPE xsl:stylesheet [
    
    <!ENTITY CPM.DITA.MAP "map | subjectScheme">
    
    <!ENTITY CPM.DITA.MAPINNER 
        "abbrevlist | amendments | appendices | appendix | backmatter | bibliolist | 
         booklists | bookabstract | booklist | chapter | colophon | dedication | 
         draftintro | figurelist | frontmatter | glossarylist | indexlist | 
         notices | part | preface | tablelist | toc | 
         topichead | topicref | topicset | topicsetref | trademarklist">
    
]>


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/" exclude-result-prefixes="cpm xs"
    version="2.0">

    <!-- 
        Modules
    -->

    <!-- Working with properties, translit -->
    <xsl:import href="../../common/xsl-2.0/props.xsl"/>


    <!-- 
        Output options (for debug purposes)
    -->
    <xsl:output method="xml" indent="yes"/>



    <!-- ============================= -->
    <!--  Retrieving othermeta values  -->
    <!-- ============================= -->

    <!-- 
        Retrieving an othermeta value from a bookmap
    -->

    <!-- ... using strict names -->
    <xsl:template match="bookmap" mode="cpm.dita.othermeta">

        <!-- An othermeta name -->
        <xsl:param name="name"/>

        <xsl:value-of select="bookmeta//othermeta[@name = $name]/@content"/>

    </xsl:template>

    <!-- ... using hashtags -->
    <xsl:template match="bookmap" mode="cpm.dita.othermeta_by_hashtag">

        <!-- An othermeta name -->
        <xsl:param name="name"/>

        <xsl:value-of select="bookmeta//othermeta[cpm:translit.eqht(@name, $name)]/@content"/>

    </xsl:template>


    <!-- 
        Retrieving an othermeta value from a map
    -->

    <!-- ... using a strict name -->
    <xsl:template match="map | &CPM.DITA.MAPINNER;" mode="cpm.dita.othermeta">

        <!-- An othermeta name -->
        <xsl:param name="name"/>

        <xsl:value-of select="topicmeta/othermeta[@name = $name]/@content"/>

    </xsl:template>


    <!-- ... using hashtags -->
    <xsl:template match="*" mode="cpm.dita.othermeta_by_hashtag">

        <!-- An othermeta name -->
        <xsl:param name="name"/>

        <xsl:value-of select="topicmeta/othermeta[cpm:translit.eqht(@name, $name)]/@content"/>

    </xsl:template>



    <!-- =================== -->
    <!--  Retrieving titles  -->
    <!-- =================== -->

    <!-- 
        A bookmap title
    -->
    <xsl:template match="bookmap" mode="cpm.dita.title">

        <xsl:choose>
            <xsl:when test="booktitle">
                <xsl:value-of select="booktitle/mainbooktitle"/>
            </xsl:when>
            <xsl:when test="title">
                <xsl:value-of select="title"/>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>

    </xsl:template>


    <!-- 
        A map title
    -->
    <xsl:template match="&CPM.DITA.MAP;" mode="cpm.dita.title">
        <xsl:value-of select="title"/>
    </xsl:template>
    
    
    <!-- 
        A map inner element title
    -->
    <xsl:template match="&CPM.DITA.MAPINNER;" mode="cpm.dita.title">
        <xsl:value-of select="@navtitle"/>
    </xsl:template>
    


    <!-- ====================== -->
    <!--  Testing map elements  -->
    <!-- ====================== -->

    <!-- 
        Does an element represent a significant element of a document structure?
    -->

    <!-- Assembling a regexp for checking element names -->
    <xsl:function name="cpm:dita.maps.section_element_names_regexp">
        <xsl:text>^bookmap$|^chapter$|^map$|^topichead$|^topicref$</xsl:text>
    </xsl:function>

    <!-- Checking an element -->
    <xsl:function name="cpm:dita.maps.is_section" as="xs:boolean">

        <!-- 
            A section is a topic, a significant group, or a map
        -->

        <!-- An element that probably represents a section -->
        <xsl:param name="element"/>

        <xsl:variable name="senr">
            <xsl:value-of select="cpm:dita.maps.section_element_names_regexp()"/>
        </xsl:variable>

        <xsl:value-of select="boolean(matches(name($element), $senr))"/>

    </xsl:function>


    <!-- 
        Does an element represent a topic?
    -->

    <!-- Assembling a regexp for checking element names -->
    <xsl:function name="cpm:dita.maps.topic_element_names_regexp">
        <xsl:text>^chapter$|^topicref$</xsl:text>
    </xsl:function>

    <!-- Checking an element -->
    <xsl:function name="cpm:dita.maps.is_topic" as="xs:boolean">

        <!-- An element that probably represents a topic -->
        <xsl:param name="element"/>

        <xsl:variable name="tenr">
            <xsl:value-of select="cpm:dita.maps.topic_element_names_regexp()"/>
        </xsl:variable>

        <xsl:value-of select="boolean(matches(name($element), $tenr))"/>

    </xsl:function>


    <!-- 
        Does an element represent a map?
    -->

    <!-- Assembling a regexp for checking element names -->
    <xsl:function name="cpm:dita.maps.map_element_names_regexp">
        <xsl:text>^bookmap$|^map$</xsl:text>
    </xsl:function>

    <!-- Checking an element -->
    <xsl:function name="cpm:dita.maps.is_map" as="xs:boolean">

        <!-- An element that probably represents a map -->
        <xsl:param name="element"/>

        <xsl:variable name="menr">
            <xsl:value-of select="cpm:dita.maps.map_element_names_regexp()"/>
        </xsl:variable>

        <xsl:value-of select="boolean(matches(name($element), $menr))"/>

    </xsl:function>



    <!-- =================================== -->
    <!--  Retrieving map element properties  -->
    <!-- =================================== -->

    <!-- 
        Retrieving a bookmap/map, chapter, or topicref title
    -->

    <!-- A template for a bookmap/map -->
    <xsl:template match="bookmap | map" mode="cpm.dita.maps.title">
        <xsl:value-of select="title"/>
    </xsl:template>

    <!-- A template for a chapter, topicref, and topichead -->
    <xsl:template match="chapter | topichead | topicref" mode="cpm.dita.maps.title">

        <!-- 
            TBD: Extracting title from *[@href and not(@navtitle)]
        -->

        <xsl:value-of select="@navtitle"/>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:dita.maps.title">

        <!-- An element that may have a title -->
        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="cpm.dita.maps.title"/>

    </xsl:function>



    <!-- ====================== -->
    <!--  Assembling sequences  -->
    <!-- ====================== -->

    <!-- 
        Assembling a sequence of titles from a map/bookmap to a section  
    -->

    <!-- A working template -->
    <xsl:template match="*" mode="cpm.dita.maps.crumbs">

        <!-- * is an element representing a topic -->

        <!-- Should we include an element itself to a sequence? -->
        <xsl:param name="self" select="'include'"/>

        <!-- Should we include a map element to a sequence? -->
        <xsl:param name="map" select="'include'"/>

        <!-- Should we cut off a few elements from the end of a sequence? -->
        <xsl:param name="length" select="0"/>

        <!-- Assembling a sequence of element titles from a map to an element -->
        <xsl:variable name="stage1" as="xs:string*">

            <xsl:variable name="tmp1">
                <xsl:for-each select="ancestor-or-self::*">
                    <xsl:if test="cpm:dita.maps.is_section(.)">
                        <title>
                            <xsl:value-of select="cpm:dita.maps.title(.)"/>
                        </title>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>

            <xsl:sequence select="$tmp1/node()"/>

            <!--            
                The following solution brings incredible output.
            
                TBD: 
            
                    Explore the behaviour of the following statement.
                    
                    <xsl:sequence
                        select="ancestor-or-self::*[cpm:dita.maps.is_section(.)]/cpm:dita.maps.title(.)"/>
            -->

        </xsl:variable>

        <!-- What do we do with the element? -->
        <xsl:variable name="stage2" as="xs:string*">

            <xsl:choose>

                <!-- Cutting off the element from the end of the sequence -->
                <xsl:when test="$self = 'exclude'">
                    <xsl:copy-of select="remove($stage1, count($stage1))"/>
                </xsl:when>

                <!-- The element should stay with us -->
                <xsl:otherwise>
                    <xsl:copy-of select="$stage1"/>
                </xsl:otherwise>

            </xsl:choose>

        </xsl:variable>

        <!-- What do we do with a map (bookmap) element -->
        <xsl:variable name="stage3" as="xs:string*">

            <xsl:choose>

                <!-- Cutting a map (bookmap) off -->
                <xsl:when test="$map = 'exclude'">
                    <xsl:copy-of select="remove($stage2, 1)"/>
                </xsl:when>

                <!-- A map (bookmap) stays with us-->
                <xsl:otherwise>
                    <xsl:copy-of select="$stage2"/>
                </xsl:otherwise>

            </xsl:choose>

        </xsl:variable>

        <!-- What do we do with leading elements? -->
        <xsl:choose>

            <!-- Cutting the leading elements off; final elements stay with us -->
            <xsl:when test="$length != 0">

                <xsl:variable name="firstpos">
                    <xsl:value-of select="count($stage3) - $length + 1"/>
                </xsl:variable>

                <xsl:copy-of select="subsequence($stage3, $firstpos, $length)"/>

            </xsl:when>

            <!-- The leading elements stay with us -->
            <xsl:otherwise>
                <xsl:copy-of select="$stage3"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>

    <!-- A wrapper function: usual breadcrumbs -->
    <xsl:function name="cpm:dita.maps.crumbs" as="xs:string*">

        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="cpm.dita.maps.crumbs">
            <xsl:with-param name="self" select="'exclude'"/>
            <xsl:with-param name="map" select="'include'"/>
        </xsl:apply-templates>

    </xsl:function>

    <!-- A wrapper function: breadcrumbs + an element itself -->
    <xsl:function name="cpm:dita.maps.crumbs_and_self" as="xs:string*">

        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="cpm.dita.maps.crumbs">
            <xsl:with-param name="self" select="'include'"/>
            <xsl:with-param name="map" select="'include'"/>
        </xsl:apply-templates>

    </xsl:function>

    <!-- A wrapper function: breadcrumbs + an element itself, N final elements -->
    <xsl:function name="cpm:dita.maps.crumbs_MUTS" as="xs:string*">

        <xsl:param name="element"/>

        <xsl:param name="length"/>

        <xsl:apply-templates select="$element" mode="cpm.dita.maps.crumbs">
            <xsl:with-param name="self" select="'include'"/>
            <xsl:with-param name="length" select="$length"/>
        </xsl:apply-templates>

    </xsl:function>



    <!-- =================================== -->
    <!--  Assembling unique title sequences  -->
    <!-- =================================== -->

    <!-- 
        Is a chapter or a topicref title unique within a map?
    -->

    <!-- A service function -->
    <xsl:function name="cpm:dita.maps.serv01" as="xs:boolean">

        <!-- An element that probably has a unique title -->
        <xsl:param name="element"/>

        <!-- An element that probably has the same title -->
        <xsl:param name="candidate"/>

        <xsl:variable name="title">
            <xsl:value-of select="cpm:dita.maps.title($element)"/>
        </xsl:variable>

        <xsl:value-of
            select="boolean(cpm:dita.maps.is_topic($candidate) and cpm:dita.maps.title($candidate) = $title)"/>

    </xsl:function>

    <!-- The function itself -->
    <xsl:function name="cpm:dita.maps.is_unique_title" as="xs:boolean">

        <!-- An element that probably has a unique title -->
        <xsl:param name="element"/>

        <xsl:variable name="title">
            <xsl:value-of select="cpm:dita.maps.title($element)"/>
        </xsl:variable>

        <xsl:variable name="count">
            <xsl:value-of
                select="count($element/ancestor::*[cpm:dita.maps.is_map(.)]//*[cpm:dita.maps.serv01($element, .)])"
            />
        </xsl:variable>

        <xsl:value-of select="boolean($count = 1)"/>

    </xsl:function>


    <!-- 
        Is a pair of titles unique within a map?
    -->

    <!-- A service function -->
    <xsl:function name="cpm:dita.maps.serv02" as="xs:boolean">

        <!-- An element that probably has a unique pair (title, parent's title) -->
        <xsl:param name="element"/>

        <!-- An element that probably has the same pair -->
        <xsl:param name="candidate"/>

        <xsl:variable name="cr" as="xs:string*">
            <xsl:copy-of select="cpm:dita.maps.crumbs_MUTS($element, 2)"/>
        </xsl:variable>

        <xsl:value-of select="deep-equal($cr, cpm:dita.maps.crumbs_MUTS($candidate, 2))"/>

    </xsl:function>

    <!-- The function itself -->
    <xsl:function name="cpm:dita.maps.is_unique_2titles" as="xs:boolean">

        <!-- An element that probably has a unique pair (title, parent's title) -->
        <xsl:param name="element"/>

        <xsl:variable name="count">
            <xsl:value-of
                select="count($element/ancestor::*[cpm:dita.maps.is_map(.)]//*[cpm:dita.maps.serv02($element, .)])"
            />
        </xsl:variable>

        <xsl:value-of select="boolean($count = 1)"/>

    </xsl:function>


    <!-- 
        Assembling a MUTS for a chapter or a topicref
    -->
    <xsl:template match="chapter | topicref" mode="cpm.dita.maps.MUTS">

        <!-- 
            MUTS - minimal ancestor unique title sequence
            
            A MUTS is a minimal sequence of higher titles enough for assembling 
            a unique title for a section
        -->

        <xsl:if test="not(cpm:dita.maps.is_unique_title(.))">

            <xsl:choose>

                <xsl:when test="cpm:dita.maps.is_unique_2titles(.)">

                    <xsl:apply-templates select="." mode="cpm.dita.maps.crumbs">
                        <xsl:with-param name="self" select="'exclude'"/>
                        <xsl:with-param name="map" select="'exclude'"/>
                        <xsl:with-param name="length" select="1"/>
                    </xsl:apply-templates>

                </xsl:when>

                <xsl:otherwise>

                    <xsl:apply-templates select="." mode="cpm.dita.maps.crumbs">
                        <xsl:with-param name="self" select="'exclude'"/>
                        <xsl:with-param name="map" select="'exclude'"/>
                    </xsl:apply-templates>

                </xsl:otherwise>

            </xsl:choose>

            <!--
            <xsl:sequence select="(cpm:dita.maps.title(..))"/>
            -->

        </xsl:if>

    </xsl:template>

</xsl:stylesheet>
