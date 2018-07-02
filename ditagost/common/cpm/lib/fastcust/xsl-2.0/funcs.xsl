<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster    
    
    Level:      Library
    
    Part:       FastCust
    Module:     funcs.xsl
    
    Scope:      Generic
    
    Func:       Wrapper functions for query templates                 
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">

    <!-- ================= -->
    <!--  Misc. functions  -->
    <!-- ================= -->

    <!-- 
        Taking a number; zero is a default value
    -->
    <xsl:function name="cpm:fastcust.num0">

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
        Taking a number; zero is a default value
    -->
    <xsl:function name="cpm:fastcust.num1">

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
        Taking a number; infinity is a default value
    -->
    <xsl:function name="cpm:fastcust.numinf">

        <!-- A value pretending to be numeric -->
        <xsl:param name="val"/>

        <xsl:choose>
            <xsl:when test="$val castable as xs:decimal">
                <xsl:value-of select="number($val)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="1000000000"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>



    <!-- ============= -->
    <!--  Element IDs  -->
    <!-- ============= -->

    <!-- 
        Retrieving an element ID
    -->
    <xsl:function name="cpm:fastcust.id">

        <!-- A "native" element, not a variable -->
        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="cpm.fastcust.id"/>

    </xsl:function>



    <!-- ======================== -->
    <!--  Working with languages  -->
    <!-- ======================== -->

    <!-- 
        Detecting an element language
    -->
    <xsl:function name="cpm:fastcust.lang">

        <!-- A "native" element, not a variable -->
        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="lang"/>

    </xsl:function>



    <!-- ================================================= -->
    <!--  Detecting core elements of a document structure  -->
    <!-- ================================================= -->

    <!-- 
        Detecting a document root element    
    -->
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
        Detecting sections (including terminal topics)
    -->

    <!-- A working function -->
    <xsl:function name="cpm:fastcust.is_section" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="exists($element)">
                    <xsl:apply-templates select="$element" mode="is_section"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>

    <!-- A short wrapper -->
    <xsl:function name="cpm:is_section" as="xs:boolean">

        <xsl:param name="element"/>

        <xsl:value-of select="cpm:fastcust.is_section($element)"/>

    </xsl:function>


    <!-- 
        Detecting non-terminal sections
    -->

    <!-- A working function -->
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

    <!-- A short wrapper -->
    <xsl:function name="cpm:is_supsect" as="xs:boolean">

        <xsl:param name="element"/>

        <xsl:value-of select="cpm:fastcust.is_supsect($element)"/>

    </xsl:function>


    <!-- 
        Detecting terminal topics
    -->

    <!-- A working function -->
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

    <!-- A short wrapper -->
    <xsl:function name="cpm:is_topic">

        <xsl:param name="element"/>

        <xsl:value-of select="cpm:fastcust.is_topic($element)"/>

    </xsl:function>



    <!-- =================================== -->
    <!--  Navigating over section hierarchy  -->
    <!-- =================================== -->

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
        Detecting a section that contains resource (not content)
    -->
    <xsl:function name="cpm:fastcust.is_resource" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:apply-templates select="$element" mode="is_resource"/>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Detecting an element that represents a cover page
    -->
    <xsl:function name="cpm:fastcust.is_cover" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:value-of select="boolean(name($element) = 'cpm:cover')"/>

    </xsl:function>


    <!-- 
        Detecting a topic that contains a TOC
    -->
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
        Detecting a topic that contains a list of tables, etc.
    -->
    <xsl:function name="cpm:fastcust.is_tontopic" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="cpm:fastcust.is_topic($element)">
                    <xsl:apply-templates select="$element" mode="is_tontopic"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Detecting a section that contains auxiliary matter
    -->
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
        Detecting a section that contains information a document is targeted at
    -->
    <xsl:function name="cpm:fastcust.is_informative" as="xs:boolean">

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
        Detecting an appendix section
    -->
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
        Detecting preface or conclusion sections
    -->
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
        Detecting if an element is a section title
    -->
    <xsl:function name="cpm:fastcust.is_sectitle" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="cpm:fastcust.is_title($element)">
                    <xsl:value-of select="cpm:fastcust.is_section($element/..)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Detecting a type of a section
    -->
    <xsl:function name="cpm:fastcust.sectype">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:choose>

            <!-- ... a flat document -->
            <xsl:when test="$element/@cpm:level">
                <xsl:value-of select="$element/@cpm:sectype"/>
            </xsl:when>

            <!-- ... an improved document -->
            <xsl:otherwise>

                <xsl:choose>

                    <xsl:when test="cpm:fastcust.is_section($element)">
                        <xsl:apply-templates select="$element" mode="sectype"/>
                    </xsl:when>

                    <xsl:when test="cpm:fastcust.is_sectitle($element)">
                        <xsl:apply-templates select="$element/.." mode="sectype"/>
                    </xsl:when>

                </xsl:choose>

            </xsl:otherwise>

        </xsl:choose>

    </xsl:function>


    <!-- 
        Detecting a type of a section (a compact form)
    -->
    <xsl:function name="cpm:sectype">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:value-of select="cpm:fastcust.sectype($element)"/>

    </xsl:function>



    <!-- ==================================================== -->
    <!--  Detecting the presence of an element in a document  -->
    <!-- ==================================================== -->

    <!-- 
        Detecting a section that should appear in a document
    -->
    <xsl:function name="cpm:fastcust.is_docmamber" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:apply-templates select="$element" mode="is_docmamber"/>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>



    <!-- ========================================================= -->
    <!--  Detecting positions of elements in a document structure  -->
    <!-- ========================================================= -->

    <!-- 
        Calculating an element level
    -->
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


    <!-- 
        Calculating an element level (a short form)
    -->
    <xsl:function name="cpm:level">

        <xsl:param name="element"/>

        <xsl:value-of select="cpm:fastcust.level($element)"/>

    </xsl:function>



    <!-- ============================================ -->
    <!--  Detecting numbering properties of elements  -->
    <!-- ============================================ -->

    <!-- 
        Calculating a numbering level of an element
    -->
    <xsl:function name="cpm:fastcust.numlevel">

        <!-- An element of a complete document -->
        <xsl:param name="element"/>

        <xsl:variable name="tmp">

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

        </xsl:variable>

        <!-- Making a function more reliable -->
        <xsl:choose>
            <xsl:when test="$tmp castable as xs:decimal">
                <xsl:value-of select="number($tmp)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="0"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>


    <!-- 
        Calculating a numbering level of an element (a short form)
    -->
    <xsl:function name="cpm:numlevel">

        <xsl:param name="element"/>

        <xsl:value-of select="cpm:fastcust.numlevel($element)"/>

    </xsl:function>


    <!-- 
        Comparing numbering lavels of two elements
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
        Retrieving a numbering sequence name of an element
    -->
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


    <xsl:function name="cpm:fastcust.numseq">

        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="numseq"/>

    </xsl:function>


    <!-- 
        Retrieving a number caption, e.g. Table, Figure, etc. 
    -->
    <xsl:function name="cpm:fastcust.caption">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:choose>

            <!-- ... for a flat document -->
            <xsl:when test="$element/@cpm:caption">
                <xsl:value-of select="$element/@cpm:caption"/>
            </xsl:when>

            <!-- ... for an improved document -->
            <xsl:otherwise>
                <xsl:apply-templates select="$element" mode="caption"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:function>


    <!-- 
        Retrieving a number navigation caption, e.g. Table, Figure, etc. 
    -->
    <xsl:function name="cpm:fastcust.navcaption">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:choose>

            <!-- ... for a flat document -->
            <xsl:when test="$element/@cpm:navcaption">
                <xsl:value-of select="$element/@cpm:navcaption"/>
            </xsl:when>

            <!-- ... for a flat document (@navcaption is not defined) -->
            <xsl:when test="not($element/@cpm:navcaption) and $element/@cpm:caption">
                <xsl:value-of select="$element/@cpm:caption"/>
            </xsl:when>

            <!-- ... for an improved document -->
            <xsl:otherwise>
                <xsl:apply-templates select="$element" mode="navcaption"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:function>


    <!-- 
        Calculating an element number (fast mode)
    -->
    <xsl:function name="cpm:fastcust.fastnumber">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <!-- A higher number -->
        <xsl:param name="hinumber"/>

        <!-- A higher numbering sequence -->
        <xsl:param name="hinumseq"/>

        <xsl:choose>

            <!-- ... for a flat document -->
            <xsl:when test="$element/@cpm:number">
                <xsl:value-of select="$element/@cpm:number"/>
            </xsl:when>

            <!-- ... for an improved document -->
            <xsl:otherwise>
                <xsl:apply-templates select="$element" mode="number">
                    <xsl:with-param name="hinumber" select="$hinumber"/>
                    <xsl:with-param name="hinumseq" select="$hinumseq"/>
                </xsl:apply-templates>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:function>


    <!-- 
        Calculating an element number (regular mode)
    -->
    <xsl:function name="cpm:fastcust.number">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:choose>

            <!-- ... for a flat document -->
            <xsl:when test="$element/@cpm:number">
                <xsl:value-of select="$element/@cpm:number"/>
            </xsl:when>

            <!-- ... for an improved document -->
            <xsl:otherwise>
                <xsl:apply-templates select="$element" mode="number"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:function>


    <!-- 
        Assembling a full number for an element
    -->
    <xsl:function name="cpm:fastcust.full_number">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <!-- Improved document & flat document-->
        <xsl:variable name="tmp">

            <xsl:choose>

                <!-- ... for a flat document -->
                <xsl:when test="$element/@cpm:full-number">
                    <xsl:value-of select="$element/@cpm:full-number"/>
                </xsl:when>

                <xsl:when test="not($element/@cpm:full-number) and $element/@cpm:level"/>

                <!-- ... for an improved document -->
                <xsl:otherwise>

                    <xsl:variable name="caption">
                        <xsl:value-of select="cpm:fastcust.caption($element)"/>
                    </xsl:variable>

                    <xsl:value-of select="substring-before($caption, '%n')"/>
                    <xsl:value-of select="cpm:fastcust.number($element)"/>
                    <xsl:value-of select="substring-after($caption, '%n')"/>

                </xsl:otherwise>

            </xsl:choose>

        </xsl:variable>

        <xsl:value-of select="string($tmp)"/>

    </xsl:function>


    <!-- 
        Assembling a full number for an element
    -->
    <xsl:function name="cpm:fastcust.nav_full_number">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <!-- Improved document & flat document-->
        <xsl:variable name="tmp">

            <xsl:choose>

                <xsl:when test="not($element/@cpm:nav-full-number) and $element/@cpm:level"/>

                <!-- ... for an improved document -->
                <xsl:otherwise>

                    <xsl:variable name="navcaption">
                        <xsl:value-of select="cpm:fastcust.navcaption($element)"/>
                    </xsl:variable>

                    <xsl:value-of select="substring-before($navcaption, '%n')"/>
                    <xsl:value-of select="cpm:fastcust.number($element)"/>
                    <xsl:value-of select="substring-after($navcaption, '%n')"/>

                </xsl:otherwise>

            </xsl:choose>

        </xsl:variable>

        <xsl:value-of select="string($tmp)"/>

    </xsl:function>


    <!-- 
        Extracting a separator between a full number and a title
    -->
    <xsl:function name="cpm:fastcust.numsep">

        <xsl:param name="element"/>

        <xsl:variable name="ft">
            <xsl:value-of select="cpm:fastcust.full_title($element)"/>
        </xsl:variable>

        <xsl:variable name="fn">
            <xsl:value-of select="cpm:fastcust.full_number($element)"/>
        </xsl:variable>

        <xsl:variable name="ti">
            <xsl:value-of select="cpm:fastcust.title($element)"/>
        </xsl:variable>

        <xsl:value-of select="substring-before(substring-after($ft, $fn), $ti)"/>

    </xsl:function>



    <!-- ================== -->
    <!--  Cross references  -->
    <!-- ================== -->

    <!-- 
        Retrieving an ID of a cross reference target elemet 
    -->
    <xsl:function name="cpm:fastcust.refid">

        <!-- A target element, e.g. concept, table, title, etc. -->
        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="refid"/>

    </xsl:function>



    <!-- ================ -->
    <!--  TOC properties  -->
    <!-- ================ -->

    <!-- 
        Detecting elements that should appear in a TOC    
    -->
    <xsl:function name="cpm:fastcust.is_tocmamber" as="xs:boolean">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <!-- Improved document -->

        <xsl:choose>
            <xsl:when test="cpm:fastcust.level($element) &gt; -1">
                <xsl:apply-templates select="$element" mode="is_tocmamber"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>


    <!-- 
        Retrieving an element title
    -->
    <xsl:function name="cpm:fastcust.title">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="title"/>

    </xsl:function>


    <!-- 
        Assembling a full title for an element
    -->
    <xsl:function name="cpm:fastcust.full_title">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <!-- Improved document & flat document-->

        <xsl:value-of select="cpm:fastcust.full_number($element)"/>
        <xsl:value-of select="cpm:fastcust.title($element)"/>

    </xsl:function>


    <!-- 
        Assembling a full title TOC/TON for an element
    -->
    <xsl:function name="cpm:fastcust.nav_full_title">

        <!-- A "native" element; not a variable -->
        <xsl:param name="element"/>

        <!-- Improved document & flat document-->

        <xsl:value-of select="cpm:fastcust.nav_full_number($element)"/>
        <xsl:value-of select="cpm:fastcust.title($element)"/>

    </xsl:function>



    <!-- ======================= -->
    <!--  Formatting properties  -->
    <!-- ======================= -->

    <!-- 
        Detecting an element class
    -->
    <xsl:function name="cpm:eclass" as="xs:boolean">

        <!-- 
            An element class is a value that allowes a customization
            to detect a "nature" of an element. The "nature" is 
            paragraph, list, list item, etc. 
            
            The function returns a string value that formatting rules
            can refer on, e.g.:            
            
            <element context="*[cpm:eclass()='topic/li']" style="List Item"/>
        -->

        <!-- Any element in a document -->
        <xsl:param name="element"/>

        <!-- A class we check an element -->
        <xsl:param name="class"/>

        <!-- 
            A customization should provide a template (templates) having
            mode="eclass". 
        -->

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:apply-templates select="$element" mode="eclass">
                <xsl:with-param name="class" select="$class"/>
            </xsl:apply-templates>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Detecting a strict element class
    -->
    <xsl:function name="cpm:sclass">

        <!-- 
            An element class is a value that allowes a customization
            to detect a "nature" of an element. The "nature" is 
            paragraph, list, list item, etc. 
            
            The function returns a string value that formatting rules
            can refer on, e.g.:        
            
            Unlike cpm:eclass() the cpm:sclass() function returns the 
            most specific element class. E.g. cpm:sclass(.)='topic/li'
            is true for a list item but it's false for a task step. 
            At the same time  cpm:sclass(.)='task/step' is true for 
            a task step. 
            
            <element context="*[cpm:eclass()='topic/li']" style="List Item"/>
        -->

        <!-- Any element in a document -->
        <xsl:param name="element"/>

        <!-- 
            A customization should provide a template (templates) having
            mode="sclass". 
        -->
        <xsl:apply-templates select="$element" mode="sclass"/>

    </xsl:function>


    <!-- 
        Output class
    -->

    <!-- Detecting an output class value -->
    <xsl:function name="cpm:oclass">

        <!-- 
            The function returns a string value that formatting rules
            can refer on, e.g.:            
            
            <element context="p[cpm:oclass()='foo']" style="Foo Top Heading"/>
        -->

        <!-- Any element in a document -->
        <xsl:param name="element"/>

        <!-- 
            A customization should provide a template (templates) having
            mode="oclass". 
        -->
        <xsl:apply-templates select="$element" mode="oclass"/>

    </xsl:function>

    <!-- Detecting elements having empty output class -->
    <xsl:function name="cpm:noclass" as="xs:boolean">

        <xsl:param name="element"/>

        <xsl:value-of select="cpm:oclass($element) = ''"/>

    </xsl:function>


    <!-- 
        FO element name for a source element
    -->
    <xsl:function name="cpm:fastcust.foname">

        <xsl:param name="element"/>

        <xsl:apply-templates select="$element" mode="foname"/>

    </xsl:function>


    <!-- 
        Detecting elements that are nested into an appendix
    -->
    <xsl:function name="cpm:in_appendix" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="in_appendix"/>
    </xsl:function>


    <!--
        Detecting elements nested into listitems
    -->
    <xsl:function name="cpm:in_list" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="in_list"/>
    </xsl:function>


    <!-- 
        Detecting elements that are nested into a table
    -->
    <xsl:function name="cpm:in_table" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="in_table"/>
    </xsl:function>


    <!--
        Detecting an element that has no any specific nesting
    -->
    <xsl:function name="cpm:is_normal" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="is_normal"/>
    </xsl:function>

    <xsl:template match="*" mode="colclass"/>

    <xsl:function name="cpm:colclass">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="colclass"/>
    </xsl:function>

    <xsl:function name="cpm:colpos">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="colpos"/>
    </xsl:function>

    <xsl:function name="cpm:rowclass">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="rowclass"/>
    </xsl:function>

    


</xsl:stylesheet>
