<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product: CopyPaste Monster    
    
    Level:   Library
    
    Part:    FastCust
    Module:  structure.xsl
    
    Scope:   Generic
    
    Func:    Basic queries concerning a document structure                 
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- ================================================= -->
    <!--  Detecting a document root, sections, and topics  -->
    <!-- ================================================= -->

    <!-- 
        Detecting a document root element
    -->

    <!-- A default working template -->
    <xsl:template match="*" mode="cpm.fastcust.is_docroot">

        <!-- * is an element of a document -->

        <!-- Improved document & flat document-->

        <xsl:choose>
            <xsl:when test="parent::*">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="true()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- A custom working template -->
    <xsl:template match="*" mode="is_docroot">
        <xsl:apply-templates select="." mode="cpm.fastcust.is_docroot"/>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_docroot" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <!-- Improved document & flat document-->

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:apply-templates select="$element" mode="is_docroot"/>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Detecting a section in a source/improved document
    -->

    <!-- A custom working template -->
    <xsl:template match="*" mode="is_section">
        <!-- 
            A section is an element of a document formal structure
        -->

        <!-- Depends on a source markup language   -->
        <!-- MUST be overloaded somewhere outside  -->

        <!-- Sample code is below -->
        <xsl:choose>
            <xsl:when test="matches(name(), '^fig$|^figure$|^table$')">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:when test="not(parent::*)">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="title">
                        <xsl:value-of select="true()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="false()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_section" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:apply-templates select="$element" mode="is_section"/>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Testing a section in a source/improved document for having subsections
    -->
    <xsl:function name="cpm:fastcust.is_supsect" as="xs:boolean">

        <!-- 
            A topic is a terminal section (a "leaf" on the section "tree")
        -->

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:choose>

            <xsl:when test="cpm:fastcust.is_section($element)">

                <xsl:choose>
                    <xsl:when test="$element/descendant::*[cpm:fastcust.is_section(.)]">
                        <xsl:value-of select="true()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="false()"/>
                    </xsl:otherwise>
                </xsl:choose>

            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:function>


    <!-- 
        Testing a section in a source/improved document for being a topic
    -->
    <xsl:function name="cpm:fastcust.is_topic" as="xs:boolean">

        <!-- 
            A topic is a terminal section (a "leaf" on the section "tree")
        -->

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:choose>

            <xsl:when test="cpm:fastcust.is_section($element)">

                <xsl:choose>
                    <xsl:when test="$element/descendant::*[cpm:fastcust.is_section(.)]">
                        <xsl:value-of select="false()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="true()"/>
                    </xsl:otherwise>
                </xsl:choose>

            </xsl:when>

            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:function>



    <!-- ================== -->
    <!--  Working with IDs  -->
    <!-- ================== -->

    <!-- 
        Assigning an ID to an element in a source/improved document
    -->

    <!-- A working template -->
    <xsl:template match="*" mode="cpm.fastcust.id">

        <!-- * is an element of a document -->

        <xsl:choose>
            <xsl:when test="@id">
                <xsl:value-of select="@id"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="generate-id()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.id">

        <!-- A "native" element, not a variable -->
        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="cpm.fastcust.id"/>

    </xsl:function>



    <!-- ======================================== -->
    <!--  Navigating over with section hierarchy  -->
    <!-- ======================================== -->

    <!-- 
        Detecting an ID of a parent structural element in a source/improved document
    -->
    <xsl:function name="cpm:fastcust.parent_id">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:value-of select="cpm:fastcust.id($element/ancestor::*[cpm:fastcust.is_section(.)][1])"/>

    </xsl:function>


    <!-- 
        Detecting an ID of a grandparent structural element in a source/improved document
    -->
    <xsl:function name="cpm:fastcust.grandpa_id">

        <!-- A "native" element, not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="parent_id">
            <xsl:value-of select="cpm:fastcust.parent_id($element)"/>
        </xsl:variable>

        <xsl:value-of
            select="cpm:fastcust.parent_id($element/ancestor::*[cpm:fastcust.id(.) = $parent_id])"/>

    </xsl:function>



    <!-- ====================== -->
    <!--  Classifying elements  -->
    <!-- ====================== -->

    <!-- 
        Testing an element for being a cover page
    -->

    <!-- A working function so far -->
    <xsl:function name="cpm:fastcust.is_cover" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:value-of select="boolean(name($element) = 'cpm:cover')"/>

    </xsl:function>


    <!-- 
        Testing an element for being a TOC topic
    -->

    <!-- A default working template -->
    <xsl:template match="*" mode="cpm.fastcust.is_toctopic">

        <!-- * is an element of a document -->

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="cpm:fastcust.is_topic(.)">
                    <xsl:choose>
                        <xsl:when test="descendant::cpm:toc">
                            <xsl:value-of select="true()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="false()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:template>

    <!-- A custom working template -->
    <xsl:template match="*" mode="is_toctopic">
        <xsl:apply-templates select="." mode="cpm.fastcust.is_toctopic"/>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_toctopic" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="cpm:fastcust.is_topic($element)">
                    <xsl:apply-templates select="$element" mode="is_toctopic"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Testing a element for being a list topic
    -->

    <!-- A default working template -->
    <xsl:template match="*" mode="cpm.fastcust.is_listopic">

        <!-- * is an element of a document -->

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="cpm:fastcust.is_topic(.)">
                    <xsl:choose>
                        <xsl:when test="descendant::cpm:list">
                            <xsl:value-of select="true()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="false()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:template>

    <!-- A custom working template -->
    <xsl:template match="*" mode="is_listopic">
        <xsl:apply-templates select="." mode="cpm.fastcust.is_listopic"/>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_listopic" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="cpm:fastcust.is_topic($element)">
                    <xsl:apply-templates select="$element" mode="is_listopic"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Testing a section for being auxiliary
    -->

    <!-- A custom working template -->
    <xsl:template match="*" mode="is_auxiliary">

        <!-- * is an element of a document -->

        <!-- Depends on a source markup language     -->
        <!-- SHOULD be overloaded somewhere outside  -->

        <xsl:value-of select="false()"/>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_auxiliary" as="xs:boolean">

        <!-- 
            An auxiliary section is a section that is not informative.
            A cover page is a special case. Other special cases 
            are also allowed. A cover page is not a section at all.
        -->

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="cpm:fastcust.is_topic($element)">
                    <xsl:apply-templates select="$element" mode="is_auxiliary"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Testing a section for being informative
    -->

    <!-- A default working template -->
    <xsl:template match="*" mode="cpm.fastcust.is_informative">

        <!-- * is an element of a document -->

        <!-- ... an auxiliary matter section? -->
        <!-- ... a cover page? -->
        <!-- ... a toc? -->

        <!-- Otherwise, an element is informative -->

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:value-of
                select="
                    not(cpm:fastcust.is_auxiliary(.)
                    or cpm:fastcust.is_toctopic(.)
                    or cpm:fastcust.is_listopic(.)
                    or cpm:fastcust.is_cover(.))"
            />
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:template>

    <!-- A custom working template -->
    <xsl:template match="*" mode="is_informative">
        <xsl:apply-templates select="." mode="cpm.fastcust.is_informative"/>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_informative">

        <!-- 
            Informative section is a section that contains 
            a part of basic document content. Usually, we
            treat introductions, conclusions, appendixes,
            and middle sections as informative sections.
            Prefaces, TOCs, copyrights are not informative.
            A particular customization may provide its 
            own template for detecting informative sections.
            A section that is not informative is auxiliary
            unless it's a cover page or some other element 
            of a document layout that is specific for a 
            particular customization. By the way, a cover 
            page is not a section at all.
        -->

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="cpm:fastcust.is_section($element)">
                    <xsl:apply-templates select="$element" mode="is_informative"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Detecting if an element is an appendix
    -->

    <!-- A custom working template -->
    <xsl:template match="*" mode="is_appendix">

        <!-- * is an element of a document -->

        <!-- Depends on a source markup language & customization -->
        <!-- SHOULD be overloaded somewhere outside              -->

        <xsl:value-of select="false()"/>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_appendix" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="cpm:fastcust.is_section($element)">
                    <xsl:variable name="pid">
                        <xsl:value-of select="cpm:fastcust.parent_id($element)"/>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when
                            test="cpm:fastcust.is_appendix($element/ancestor::*[cpm:fastcust.id(.) = $pid])">
                            <xsl:value-of select="true()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="$element" mode="is_appendix"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Detecting if an element is a preface or a conclusion
    -->

    <!-- A custom working template -->
    <xsl:template match="*" mode="is_prefconcl">

        <!-- * is an element of a document -->

        <!-- Depends on a source markup language & customization -->
        <!-- SHOULD be overloaded somewhere outside              -->

        <xsl:value-of select="false()"/>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_prefconcl" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="cpm:fastcust.is_section($element)">
                    <xsl:variable name="pid">
                        <xsl:value-of select="cpm:fastcust.parent_id($element)"/>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when
                            test="cpm:fastcust.is_prefconcl($element/ancestor::*[cpm:fastcust.id(.) = $pid])">
                            <xsl:value-of select="true()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="$element" mode="is_prefconcl"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Detecting if an element is a title
    -->
    <xsl:function name="cpm:fastcust.is_title" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:apply-templates select="$element" mode="is_title"/>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Detecting resource only elements
    -->

    <!-- A default working template -->
    <xsl:template match="*" mode="cpm.fastcust.is_resource">
        <xsl:value-of select="false()"/>
    </xsl:template>

    <!-- A custom working template -->
    <xsl:template match="*" mode="is_resource">
        <xsl:apply-templates select="." mode="cpm.fastcust.is_resource"/>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_resource" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:apply-templates select="$element" mode="is_resource"/>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Detecting an element category
    -->

    <!-- A default working template -->
    <xsl:template match="*" mode="cpm.fastcust.category">

        <xsl:choose>
            <xsl:when test="cpm:fastcust.is_appendix(.)">
                <xsl:text>appendix</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:fastcust.is_auxiliary(.)">
                <xsl:text>auxiliary</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:fastcust.is_cover(.)">
                <xsl:text>cover</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:fastcust.is_listopic(.)">
                <xsl:text>listopic</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:fastcust.is_prefconcl(.)">
                <xsl:text>prefconcl</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:fastcust.is_resource(.)">
                <xsl:text>resource</xsl:text>
            </xsl:when>
            <xsl:when test="cpm:fastcust.is_toctopic(.)">
                <xsl:text>toctopic</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="cpm:fastcust.is_informative(.)">
                        <xsl:text>main</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>other</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- A custom working template -->
    <xsl:template match="*" mode="category">
        <xsl:apply-templates select="." mode="cpm.fastcust.category"/>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.category">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="category"/>

    </xsl:function>



    <!-- ==================================================== -->
    <!--  Detecting the presence of an element in a document  -->
    <!-- ==================================================== -->

    <!-- 
        Should an element appear in a document?
    -->

    <!-- A default working template -->
    <xsl:template match="*" mode="cpm.fastcust.is_docmamber">
        <xsl:value-of select="not(cpm:fastcust.is_resource(.))"/>
    </xsl:template>

    <!-- A default custom template -->
    <xsl:template match="*" mode="is_docmamber">
        <xsl:apply-templates select="." mode="cpm.fastcust.is_docmamber"/>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_docmamber" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:apply-templates select="$element" mode="is_docmamber"/>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>



    <!-- ================================================= -->
    <!--  Retrieving element (mostely section) properties  -->
    <!-- ================================================= -->

    <!-- 
        Calculating or retrieving a level of an element
    -->

    <!-- A default working template for a common element -->
    <xsl:template match="*" mode="cpm.fastcust.level">
        <xsl:value-of select="0"/>
    </xsl:template>

    <!-- A default working template for super section titles -->
    <xsl:template match="*[cpm:fastcust.is_supsect(.)]/title" mode="cpm.fastcust.level">
        <xsl:value-of select="count(ancestor::*[cpm:fastcust.is_section(.)])"/>
    </xsl:template>

    <!-- A default working template for topics -->
    <xsl:template match="*[cpm:fastcust.is_topic(.)]" mode="cpm.fastcust.level">

        <xsl:choose>

            <!-- Banning resource topics -->
            <xsl:when test="not(cpm:fastcust.is_docmamber(.))">
                <xsl:value-of select="-1"/>
            </xsl:when>

            <!-- Calculating a level of a "true" topic -->
            <xsl:otherwise>
                <xsl:value-of select="count(ancestor::*[cpm:fastcust.is_section(.)]) + 1"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>

    <!-- A default working template for topic titles -->
    <xsl:template match="*[cpm:fastcust.is_topic(.)]/title" mode="cpm.fastcust.level">
        <xsl:value-of select="cpm:fastcust.level(..)"/>
    </xsl:template>

    <!-- A default working template for topic titles in a flat (!) document -->
    <xsl:template match="*[@cpm:level]/title" mode="cpm.fastcust.level">
        <xsl:value-of select="number(../@cpm:level)"/>
    </xsl:template>

    <!-- A custom working template -->
    <xsl:template match="*" mode="level">
        <xsl:apply-templates select="." mode="cpm.fastcust.level"/>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.level">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="level">

            <xsl:choose>

                <!-- Flat document -->
                <xsl:when test="$element/@cpm:level">
                    <xsl:value-of select="$element/@cpm:level"/>
                </xsl:when>

                <!-- Improved document -->
                <xsl:otherwise>

                    <!-- Trying to calculate a level -->
                    <xsl:variable name="candidate">
                        <xsl:apply-templates select="$element" mode="level"/>
                    </xsl:variable>

                    <!-- Protecting the template from empty values -->
                    <xsl:choose>
                        <xsl:when test="$candidate = ''">
                            <xsl:value-of select="0"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$candidate"/>
                        </xsl:otherwise>
                    </xsl:choose>

                </xsl:otherwise>

            </xsl:choose>

        </xsl:variable>

        <xsl:value-of select="number($level)"/>

    </xsl:function>

    <!-- A wrapper for using it in rules -->
    <xsl:function name="cpm:level">

        <xsl:param name="element"/>

        <xsl:value-of select="cpm:fastcust.level($element)"/>

    </xsl:function>


    <!-- 
        Taking a title of an element
    -->

    <!-- A default working template -->
    <xsl:template match="*" mode="cpm.fastcust.title">

        <!-- * is an element of a document -->

        <xsl:choose>
            <xsl:when test="@title">
                <xsl:value-of select="@title"/>
            </xsl:when>
            <xsl:when test="name() = 'title'">
                <xsl:value-of select="."/>
            </xsl:when>
            <xsl:when test="title">
                <xsl:value-of select="title"/>
            </xsl:when>
        </xsl:choose>

    </xsl:template>

    <!-- A custom working template -->
    <xsl:template match="*" mode="title">
        <xsl:apply-templates select="." mode="cpm.fastcust.title"/>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.title">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="title"/>

    </xsl:function>



    <!-- ====================== -->
    <!--  Numbering properties  -->
    <!-- ====================== -->

    <!-- 
        Calculating an element level for numerating purpose
    -->
    
    <!-- Returning an empty value for a common element -->
    <xsl:template match="*" mode="cpm.fastcust.numlevel"/>

    <!-- A default template for sections (topics) -->
    <xsl:template match="*[cpm:fastcust.is_section(.)]" mode="cpm.fastcust.numlevel">
        <xsl:if test="cpm:fastcust.is_docmamber(.)">
            <xsl:value-of select="count(ancestor::*[cpm:fastcust.is_section(.)]) + 1"/>
        </xsl:if>
    </xsl:template>

    <!-- A default template for section (topic) titles -->
    <xsl:template match="*[cpm:fastcust.is_section(.)]/title" mode="cpm.fastcust.numlevel">
        <xsl:value-of select="count(ancestor::*[cpm:fastcust.is_section(.)])"/>
    </xsl:template>

    <!-- A custom template -->
    <xsl:template match="*" mode="numlevel">
        <xsl:apply-templates select="." mode="cpm.fastcust.numlevel"/>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.numlevel">

        <!-- An element of a complete document -->
        <xsl:param name="element"/>

        <xsl:choose>
            
            <!-- ... for a flat document -->
            <xsl:when test="$element/@cpm:numlevel">
                <xsl:value-of select="$element/@cpm:numlevel"/>
            </xsl:when>
            
            <!-- ... for an improved document -->
            <xsl:otherwise>
                <xsl:apply-templates select="$element" mode="numlevel"/>
            </xsl:otherwise>
            
        </xsl:choose>

    </xsl:function>


    <!-- 
        Do elements have the same level for numbering purpose?
    -->
    <xsl:function name="cpm:fastcust.eqnumlevel" as="xs:boolean">

        <!-- An element -->
        <xsl:param name="element1"/>

        <!-- Another one -->
        <xsl:param name="element2"/>

        <xsl:variable name="numlevel1">
            <xsl:value-of select="cpm:fastcust.numlevel($element1)"/>
        </xsl:variable>

        <xsl:variable name="numlevel2">
            <xsl:value-of select="cpm:fastcust.numlevel($element2)"/>
        </xsl:variable>

        <xsl:value-of select="boolean($numlevel1 = $numlevel2)"/>

    </xsl:function>
    
       
    <!-- 
        Retrieving a numbering sequence name
    -->

    <!-- A custom working template for element having no title -->
    <xsl:template match="*[not(title)]" mode="numseqname">
        <!-- Just retrieving a numbering sequence name -->
        <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
    </xsl:template>

    <!-- A custom working template for elements having got a title -->
    <xsl:template match="*[title]" mode="numseqname">
        <!-- Using a sequence name that is assigned to a title -->
        <xsl:apply-templates select="title" mode="cpm.fastcust.numseqname"/>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.numseqname">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:choose>
            
            <!-- ... for a flat document -->
            <xsl:when test="$element/@cpm:numseqname">
                <xsl:value-of select="$element/@cpm:numseqname"/>
            </xsl:when>
            
            <!-- ... for ane improved document -->
            <xsl:otherwise>
                <xsl:apply-templates select="$element" mode="numseqname"/>
            </xsl:otherwise>
            
        </xsl:choose>

    </xsl:function>


    <!-- 
        Do elements belong to the same numbering sequence?
    -->
    <xsl:function name="cpm:fastcust.eqnumseq" as="xs:boolean">

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
    <xsl:function name="cpm:fastcust.are_numsibs" as="xs:boolean">
        
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
            <xsl:value-of select="cpm:fastcust.eqnumseq($element1, $element2)"/>
        </xsl:variable>
        
        <xsl:value-of select="boolean($same_numlevel and $same_numseq)"/>
        
    </xsl:function>


    <!-- 
        Retrieving a numbering sequence for an element
    -->    
    <!-- A custom working template for element having no title -->
    <xsl:template match="*[not(title)]" mode="numseq">
        <!-- Just retrieving a numbering sequence -->
        <xsl:apply-templates select="." mode="cpm.fastcust.numseq"/>
    </xsl:template>
    
    <!-- A custom working template for elements having got a title -->
    <xsl:template match="*[title]" mode="numseq">
        <!-- Using a sequence that is assigned to a title -->
        <xsl:apply-templates select="title" mode="cpm.fastcust.numseq"/>
    </xsl:template>


    <!-- 
        Taking a caption of an element
    -->

    <!-- A custom working template -->
    <xsl:template match="*" mode="cpm.fastcust.caption">

        <!-- * is an element of a document -->                

        <xsl:choose>

            <!-- Flat document -->
            <xsl:when test="@cpm:caption">
                <xsl:value-of select="@cpm:caption"/>
            </xsl:when>

            <!-- Improved document -->
            <xsl:otherwise>

                <xsl:variable name="explicit_caption">
                    <xsl:apply-templates select="." mode="cpm.fastcust.explicit_caption"/>
                </xsl:variable>

                <xsl:choose>

                    <xsl:when test="$explicit_caption != ''">
                        <xsl:value-of select="$explicit_caption"/>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:variable name="numseq">
                            <xsl:apply-templates select="." mode="numseq"/>
                        </xsl:variable>
                        <xsl:value-of select="$numseq//numseq/@caption"/>                                                    
                    </xsl:otherwise>

                </xsl:choose>

            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>

    <!-- A custom working template -->
    <xsl:template match="*" mode="caption">
        <xsl:apply-templates select="." mode="cpm.fastcust.caption"/>        
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.caption">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:choose>
            <!-- Flat document -->
            <xsl:when test="$element/@cpm:caption">
                <xsl:value-of select="$element/@cpm:caption"/>
            </xsl:when>
            <!-- Improved document -->
            <xsl:otherwise>                
                <xsl:apply-templates select="$element" mode="caption"/>
                <!-- <xsl:text>@@@@</xsl:text> -->
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>


    <!-- 
        Taking a number of an element
    -->

    <!-- A custom working template for a common elements -->
    <xsl:template match="*[name() != 'title']" mode="number">              

        <!-- * is an element of a document -->
        
        <!-- A higher number -->
        <xsl:param name="hinumber" select="''"/>
        
        <!-- A higher numbering sequence -->
        <xsl:param name="hinumseq"/>

        <!-- Just calculate a number -->
        <xsl:apply-templates select="." mode="cpm.fastcust.number">
            <xsl:with-param name="hinumber" select="$hinumber"/>
            <xsl:with-param name="hinumseq" select="$hinumseq"/>
        </xsl:apply-templates>

    </xsl:template>

    <!-- A custom working template for titles -->
    <xsl:template match="title" mode="number">               

        <!-- * is an element of a document -->
        
        <!-- A higher number -->
        <xsl:param name="hinumber" select="''"/>
        
        <!-- A higher numbering sequence -->
        <xsl:param name="hinumseq"/>

        <!-- Inheriting a parent's number -->
        <xsl:apply-templates select=".." mode="cpm.fastcust.number">
            <xsl:with-param name="hinumber" select="$hinumber"/>
            <xsl:with-param name="hinumseq" select="$hinumseq"/>
        </xsl:apply-templates>

    </xsl:template>

    <!-- A fast wrapper function -->
    <xsl:function name="cpm:fastcust.fastnumber">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>
        
        <!-- A higher number -->
        <xsl:param name="hinumber"/>
        
        <!-- A higher numbering sequence -->
        <xsl:param name="hinumseq"/>

        <xsl:choose>
            <!-- Flat document -->
            <xsl:when test="$element/@cpm:number">
                <xsl:value-of select="$element/@cpm:number"/>
            </xsl:when>
            <!-- Improved document -->
            <xsl:otherwise>
                <xsl:apply-templates select="$element" mode="number">
                    <xsl:with-param name="hinumber" select="$hinumber"/>
                    <xsl:with-param name="hinumseq" select="$hinumseq"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>
    
    
    <!-- A simple wrapper function -->
    <xsl:function name="cpm:fastcust.number">
        
        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>               
        
        <xsl:choose>
            <!-- Flat document -->
            <xsl:when test="$element/@cpm:number">
                <xsl:value-of select="$element/@cpm:number"/>
            </xsl:when>
            <!-- Improved document -->
            <xsl:otherwise>
                <xsl:apply-templates select="$element" mode="number"/>                    
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:function>


    <!-- 
        Assembling a full number of an element
    -->
    <xsl:function name="cpm:fastcust.full_number">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <!-- Improved document & flat document-->

        <xsl:choose>

            <!-- Flat document -->
            <xsl:when test="$element/@cpm:full-number">
                <xsl:value-of select="$element/@cpm:full-number"/>
            </xsl:when>

            <xsl:when test="not($element/@cpm:full-number) and $element/@cpm:level"/>

            <!-- Improved document -->
            <xsl:otherwise>

                <xsl:variable name="caption">
                    <xsl:value-of select="cpm:fastcust.caption($element)"/>
                </xsl:variable>

                <xsl:value-of select="substring-before($caption, '%n')"/>
                <!--
                <xsl:value-of select="cpm:fastcust.number($element)"/>
                -->
                <xsl:value-of select="substring-after($caption, '%n')"/>

            </xsl:otherwise>

        </xsl:choose>

    </xsl:function>


    <!-- 
        Assembling a full title of an element
    -->
    <xsl:function name="cpm:fastcust.full_title">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <!-- Improved document & flat document-->

        <xsl:value-of select="cpm:fastcust.full_number($element)"/>
        <xsl:value-of select="cpm:fastcust.title($element)"/>

    </xsl:function>



    <!-- =============== -->
    <!--  TOC functions  -->
    <!-- =============== -->

    <!-- 
        Detecting if an element appears in a TOC
    -->

    <!-- A default working template -->
    <xsl:template match="*" mode="cpm.fastcust.is_tocmamber">

        <!-- * is an element of a document -->

        <!-- Improved document -->

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:value-of select="cpm:fastcust.is_informative(.) or cpm:fastcust.is_listopic(.)"/>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:template>

    <!-- A custom working template -->
    <xsl:template match="*" mode="is_tocmamber">
        <xsl:apply-templates select="." mode="cpm.fastcust.is_tocmamber"/>
    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.is_tocmamber" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <!-- Improved document -->

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:apply-templates select="$element" mode="is_tocmamber"/>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>

</xsl:stylesheet>
