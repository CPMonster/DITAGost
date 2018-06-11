<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster    
    
    Level:      Library
    
    Part:       FastCust
    Module:     queries.xsl
    
    Scope:      Generic
    
    Func:       Detecting and testing document elements                 
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Wrapper functions -->
    <xsl:import href="numbers.xsl"/>



    <!-- ============= -->
    <!--  Element IDs  -->
    <!-- ============= -->

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



    <!-- ======================== -->
    <!--  Working with languages  -->
    <!-- ======================== -->

    <!-- 
        Assigning a language code to an element in a source/improved document
    -->

    <!-- A working template -->
    <xsl:template match="*" mode="cpm.fastcust.lang">

        <!-- * is an element of a document -->

        <xsl:variable name="tmp">
            <xsl:choose>
                <xsl:when test="@xml:lang">
                    <xsl:value-of select="@xml:lang"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="ancestor::*[@xml:lang][1]/@xml:lang"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$tmp != ''">
                <xsl:value-of select="$tmp"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>en</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>



    <!-- ================================================= -->
    <!--  Detecting core elements of a document structure  -->
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



    <!-- ====================== -->
    <!--  Classifying elements  -->
    <!-- ====================== -->

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
                        <xsl:when test="descendant::*[@outputclass = 'tocentry']">
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


    <!-- 
        Testing a element for being a list topic
    -->

    <!-- A default working template -->
    <xsl:template match="*" mode="cpm.fastcust.is_tontopic">

        <!-- * is an element of a document -->

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="cpm:fastcust.is_topic(.)">
                    <xsl:choose>
                        <xsl:when test="descendant::cpm:ton">
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
    <xsl:template match="*" mode="is_tontopic">
        <xsl:apply-templates select="." mode="cpm.fastcust.is_tontopic"/>
    </xsl:template>


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
                    not(cpm:fastcust.is_resource(.)
                    or cpm:fastcust.is_auxiliary(.)
                    or cpm:fastcust.is_toctopic(.)
                    or cpm:fastcust.is_tontopic(.)
                    or cpm:fastcust.is_cover(.))"
            />
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:template>

    <!-- A custom working template -->
    <xsl:template match="*" mode="is_informative">
        <xsl:apply-templates select="." mode="cpm.fastcust.is_informative"/>
    </xsl:template>


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


    <!-- 
        Detecting an element category
    -->

    <!-- A default working template -->
    <xsl:template match="*" mode="cpm.fastcust.sectype">

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
            <xsl:when test="cpm:fastcust.is_tontopic(.)">
                <xsl:text>tontopic</xsl:text>
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
    <xsl:template match="*" mode="sectype">
        <xsl:apply-templates select="." mode="cpm.fastcust.sectype"/>
    </xsl:template>



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



    <!-- ========================================================= -->
    <!--  Detecting positions of elements in a document structure  -->
    <!-- ========================================================= -->

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
    <xsl:template match="*" mode="level" priority="1">
        <xsl:if test="name() = 'cpm:cover'">
            <xsl:message>
                <xsl:text>Cover!!</xsl:text>
            </xsl:message>
        </xsl:if>
        <xsl:apply-templates select="." mode="cpm.fastcust.level"/>
    </xsl:template>



    <!-- ====================== -->
    <!--  Numbering properties  -->
    <!-- ====================== -->

    <!-- 
        Calculating an element level for numerating purpose
    -->

    <!-- A custom template -->
    <xsl:template match="*" mode="numlevel">
        <xsl:apply-templates select="." mode="cpm.fastcust.numbers.numlevel"/>
    </xsl:template>


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
                        <xsl:apply-templates select="$numseq/numseq"
                            mode="cpm.fastcust.numbers.caption"/>
                    </xsl:otherwise>

                </xsl:choose>

            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>

    <!-- A custom working template -->
    <xsl:template match="*" mode="caption">
        <xsl:apply-templates select="." mode="cpm.fastcust.caption"/>
    </xsl:template>
    
    
    <!-- 
        Taking a navogation caption of an element
    -->
    
    <!-- A custom working template -->
    <xsl:template match="*" mode="cpm.fastcust.navcaption">
        
        <!-- * is an element of a document -->
        
        <xsl:choose>
            
            <!-- Flat document -->
            <xsl:when test="@cpm:navcaption">
                <xsl:value-of select="@cpm:navcaption"/>
            </xsl:when>
            
            <xsl:when test="not(@cpm:navcaption) and @cpm:caption">
                <xsl:value-of select="@cpm:caption"/>
            </xsl:when>
            
            <!-- Improved document -->
            <xsl:otherwise>
                <xsl:variable name="numseq">
                    <xsl:apply-templates select="." mode="numseq"/>
                </xsl:variable>                
                
                <xsl:apply-templates select="$numseq/numseq"
                    mode="cpm.fastcust.numbers.navcaption"/>                               
               
                <!--
                <xsl:variable name="explicit_navcaption">
                    
                    <xsl:apply-templates select="." mode="cpm.fastcust.explicit_navcaption"/>
                    
                   
                </xsl:variable>
                
                <xsl:choose>
                    
                    <xsl:when test="$explicit_navcaption != ''">
                        <xsl:value-of select="$explicit_navcaption"/>
                    </xsl:when>
                    
                    <xsl:otherwise>
                        <xsl:variable name="numseq">
                            <xsl:apply-templates select="." mode="numseq"/>
                        </xsl:variable>
                        
                        <xsl:apply-templates select="$numseq/numseq"
                            mode="cpm.fastcust.numbers.navcaption"/>
                              
                        
                        <xsl:apply-templates select="$numseq/numseq"
                            mode="cpm.fastcust.numbers.caption"/>
                           
                    </xsl:otherwise>
                    
                </xsl:choose>
                -->
                
            </xsl:otherwise>
            
        </xsl:choose>
        
    </xsl:template>
    
    <!-- A custom working template -->
    <xsl:template match="*" mode="navcaption">        
        <xsl:apply-templates select="." mode="cpm.fastcust.navcaption"/>                
    </xsl:template>


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
        <xsl:apply-templates select="." mode="cpm.fastcust.numbers.number">
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
        <xsl:choose>

            <!-- Using an explicit higher number  -->
            <xsl:when test="$hinumber != ''">
                <xsl:value-of select="$hinumber"/>
            </xsl:when>

            <!-- Calculating an higher number -->
            <xsl:otherwise>
                <xsl:value-of select="cpm:fastcust.number(..)"/>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>



    <!-- ================ -->
    <!--  TOC properties  -->
    <!-- ================ -->

    <!-- 
        Detecting if an element appears in a TOC
    -->

    <!-- A default working template -->
    <xsl:template match="*" mode="cpm.fastcust.is_tocmamber">

        <!-- * is an element of a document -->

        <!-- Improved document -->

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:value-of select="cpm:fastcust.is_informative(.) or cpm:fastcust.is_tontopic(.)"/>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:template>

    <!-- A custom working template -->
    <xsl:template match="*" mode="is_tocmamber">
        <xsl:apply-templates select="." mode="cpm.fastcust.is_tocmamber"/>
    </xsl:template>


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

</xsl:stylesheet>
