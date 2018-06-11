<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster
    
    Level:      Library
    
    Part:       FastCust
    Module:     fastcust.xsl
    
    Scope:      Layout, FO
    
    Func:       Provides the support for DITA OT customization or 
                any other set of XSLT stylesheets that transforms
                a source XML document to FO
             
    Usage:      Import to an XSLT stylesheet that is specific for 
                a particular XML application, e.g. dita.xml. 
                A customization developer may overload templates
                that are defined here. 
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Queries over document content -->
    <xsl:import href="queries.xsl"/>

    <!-- Document parameters -->
    <xsl:import href="docparams.xsl"/>





    <!-- ============ -->
    <!--  Parameters  -->
    <!-- ============ -->

    <!-- Wrapping stray text into cpm:wrapper: on/off -->
    <xsl:param name="cpm.fastcust.wrapping_stray_text" select="''"/>

    <!-- Default font for elements tha have no explicit style -->
    <xsl:param name="cpm.fastcust.default_font_family" select="'Times New Roman'"/>



    <!-- ======= -->
    <!--  Misc.  -->
    <!-- ======= -->

    <!-- 
        Converting a sequence name to a page-sequence-master/@master-name
    -->
    <xsl:template name="cpm.fastcust.get_master_name">

        <!--                        
            OVERLOAD: in layout.xsl.
        -->

        <xsl:param name="master_alias"/>

        <xsl:value-of select="$master_alias"/>

    </xsl:template>



    <!-- ========================================= -->
    <!--  Completing content of a source document  -->
    <!-- ========================================= -->

    <!-- 
        Supressing redundant elements
    -->
    <xsl:template match="titlealts" mode="complete"/>


    <!-- 
        Generating content (the default template)
    -->
    <xsl:template match="*" mode="complete">

        <!-- 
            OVERLOAD: in a particular customization.
        -->

        <xsl:copy>

            <xsl:copy-of select="@*"/>

            <xsl:if test="not(@id)">
                <xsl:attribute name="id">
                    <xsl:value-of select="cpm:fastcust.id(.)"/>
                </xsl:attribute>
            </xsl:if>

            <xsl:apply-templates select="node()" mode="complete"/>

        </xsl:copy>

    </xsl:template>


    <!-- 
        Inserting generated content to a source XML
    -->
    <xsl:template match="*" mode="cpm.fastcust.complete">

        <!-- 
            OVERLOAD: never!
        -->

        <xsl:apply-templates select="." mode="complete"/>

    </xsl:template>



    <!-- =============================== -->
    <!--  Improving a complete document  -->
    <!-- =============================== -->

    <!-- 
        Calculating levels, numbers, etc. 
    -->
    <xsl:template match="*" mode="cpm.fastcust.improve">

        <!-- A number of a closest numbered ancestor -->
        <xsl:param name="hinumber" select="''"/>

        <!-- A numbering sequence of a closest numbered ancestor -->
        <xsl:param name="hinumseq"/>

        <!-- Copying an element -->
        <xsl:copy>

            <!-- Copying attributes -->
            <xsl:copy-of select="@*"/>

            <!-- Appending an ID if an element has no one -->
            <xsl:if test="not(@id)">
                <xsl:attribute name="id">
                    <xsl:value-of select="cpm:fastcust.id(.)"/>
                </xsl:attribute>
            </xsl:if>

            <!-- Calculating an element level -->
            <xsl:attribute name="cpm:level">
                <!--
                <xsl:if test="name()='cpm:cover'">                    
                    <xsl:message>
                        <xsl:text>Cover</xsl:text>
                    </xsl:message>                    
                </xsl:if>
                -->
                <xsl:value-of select="cpm:fastcust.level(.)"/>
            </xsl:attribute>

            <!-- Section type -->
            <xsl:variable name="sectype">
                <xsl:value-of select="cpm:fastcust.sectype(.)"/>
            </xsl:variable>

            <xsl:if test="$sectype != ''">
                <xsl:attribute name="cpm:sectype">
                    <xsl:value-of select="$sectype"/>
                </xsl:attribute>
            </xsl:if>

            <!-- Calculating an element level for numbering purpose -->
            <xsl:variable name="numlevel">
                <xsl:value-of select="cpm:fastcust.numlevel(.)"/>
            </xsl:variable>

            <!-- Appending a cpm:numlevel attribute to an element -->
            <xsl:if test="$numlevel != ''">
                <xsl:attribute name="cpm:numlevel">
                    <xsl:value-of select="$numlevel"/>
                </xsl:attribute>
            </xsl:if>

            <!-- Detecting a numbering sequence name for an element -->
            <xsl:variable name="numseqname">
                <xsl:value-of select="cpm:fastcust.numseqname(.)"/>
            </xsl:variable>

            <!-- Calculating a number of an element -->
            <xsl:variable name="number">
                <xsl:if test="$numseqname != ''">
                    <xsl:value-of select="cpm:fastcust.fastnumber(., $hinumber, $hinumseq)"/>
                </xsl:if>
            </xsl:variable>

            <!-- Retrieving a numbering sequence -->
            <xsl:variable name="numseq">
                <xsl:if test="$numseqname != ''">
                    <xsl:apply-templates select="." mode="numseq"/>
                </xsl:if>
            </xsl:variable>

            <!-- Detecting numbering properties for a numbered element -->
            <xsl:if test="$numseqname != ''">

                <xsl:attribute name="cpm:numseqname">
                    <xsl:value-of select="$numseqname"/>
                </xsl:attribute>

                <xsl:attribute name="cpm:number">
                    <xsl:value-of select="$number"/>
                </xsl:attribute>

                <xsl:attribute name="cpm:caption">
                    <xsl:value-of select="cpm:fastcust.caption(.)"/>
                </xsl:attribute>

                <xsl:attribute name="cpm:navcaption">
                    <xsl:value-of select="cpm:fastcust.navcaption(.)"/>
                </xsl:attribute>

                <xsl:attribute name="cpm:full-number">
                    <xsl:value-of select="cpm:fastcust.numbers.format($number, $numseq)"/>
                </xsl:attribute>

                <xsl:attribute name="cpm:nav-full-number">
                    <xsl:value-of select="cpm:fastcust.numbers.format($number, $numseq)"/>
                </xsl:attribute>

                <xsl:attribute name="cpm:title">
                    <xsl:value-of select="cpm:fastcust.title(.)"/>
                </xsl:attribute>

            </xsl:if>

            <!-- Should we proceed with a number element or with a higher number -->
            <xsl:variable name="actual_hinumber">
                <xsl:choose>
                    <xsl:when test="$number != ''">
                        <xsl:value-of select="$number"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$hinumber"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <!-- The same thing about a higher numbering sequence -->
            <xsl:variable name="actual_hinumseq">
                <xsl:choose>
                    <xsl:when test="$numseqname != ''">
                        <xsl:copy-of select="$numseq"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of select="$hinumseq"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:if test="name() = 'cpm:toc'">
                <xsl:message>
                    <xsl:text>TOC</xsl:text>
                </xsl:message>
            </xsl:if>

            <!-- Improving children elements -->
            <xsl:apply-templates select="node()" mode="cpm.fastcust.improve">
                <xsl:with-param name="hinumber" select="$actual_hinumber"/>
                <xsl:with-param name="hinumseq" select="$actual_hinumseq"/>
            </xsl:apply-templates>

        </xsl:copy>

    </xsl:template>



    <!-- =========================== -->
    <!--  Assembling static content  -->
    <!-- =========================== -->

    <!-- 
        Assembling cpm:sequence/cpm:region-*
    -->
    <xsl:template match="fo:region-before | fo:region-after | fo:region-start | fo:region-end"
        mode="cpm.fastcust.static">

        <!--            
            OVERLOAD: strongly not recommended.                   
        -->

        <!-- A 'human' name of a page sequence master -->
        <xsl:param name="master_alias"/>

        <!-- first, rest, etc. -->
        <xsl:param name="page_position"/>

        <xsl:element name="cpm:static-content">

            <xsl:attribute name="region-name">
                <xsl:value-of select="@region-name"/>
            </xsl:attribute>

            <xsl:attribute name="page-side">
                <xsl:value-of select="substring-after(name(), 'fo:region-')"/>
            </xsl:attribute>

            <xsl:if test="$page_position">
                <xsl:attribute name="page-position">
                    <xsl:value-of select="$page_position"/>
                </xsl:attribute>
            </xsl:if>

            <xsl:attribute name="master-alias">
                <xsl:value-of select="$master_alias"/>
            </xsl:attribute>

        </xsl:element>

    </xsl:template>


    <!-- 
        A wrapper
    -->
    <xsl:template match="fo:simple-page-master" mode="cpm.fastcust.static">

        <!--            
            OVERLOAD: strongly not recommended.                   
        -->

        <xsl:param name="master_alias"/>

        <xsl:param name="page_position"/>

        <xsl:apply-templates
            select="fo:region-before | fo:region-after | fo:region-start | fo:region-end"
            mode="cpm.fastcust.static">
            <xsl:with-param name="master_alias" select="$master_alias"/>
            <xsl:with-param name="page_position" select="$page_position"/>
        </xsl:apply-templates>

    </xsl:template>


    <!-- 
        A wrapper: accessing simple page masters associated with a page sequence master
    -->
    <xsl:template match="fo:conditional-page-master-reference | fo:single-page-master-reference"
        mode="cpm.fastcust.static">

        <!--            
            OVERLOAD: strongly not recommended.                   
        -->

        <xsl:param name="master_alias"/>

        <xsl:variable name="master_name">
            <xsl:value-of select="@master-reference"/>
        </xsl:variable>

        <xsl:apply-templates
            select="ancestor::fo:layout-master-set//fo:simple-page-master[@master-name = $master_name]"
            mode="cpm.fastcust.static">
            <xsl:with-param name="master_alias" select="$master_alias"/>
            <xsl:with-param name="page_position" select="@page-position"/>
        </xsl:apply-templates>

    </xsl:template>


    <!-- 
        A wrapper: diving into a page sequence master
    -->
    <xsl:template match="fo:page-sequence-master" mode="cpm.fastcust.static">

        <!--            
            OVERLOAD: strongly not recommended.                   
        -->

        <xsl:param name="master_alias"/>

        <xsl:apply-templates select="descendant::*[@master-reference]" mode="cpm.fastcust.static">
            <xsl:with-param name="master_alias" select="$master_alias"/>
        </xsl:apply-templates>

    </xsl:template>


    <!-- 
        Assembling cpm:region elements for a section
    -->
    <xsl:template name="cpm.fastcust.static">

        <!--            
            OVERLOAD: strongly not recommended.                   
        -->

        <xsl:param name="master_alias"/>

        <xsl:variable name="master_name">
            <xsl:call-template name="cpm.fastcust.get_master_name">
                <xsl:with-param name="master_alias" select="$master_alias"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="layout_master_set">
            <xsl:apply-templates select="." mode="cpm.fastcust.layout_master_set"/>
        </xsl:variable>

        <xsl:apply-templates
            select="$layout_master_set/*/descendant::fo:page-sequence-master[@master-name = $master_name]"
            mode="cpm.fastcust.static">
            <xsl:with-param name="master_alias" select="$master_alias"/>
        </xsl:apply-templates>

    </xsl:template>



    <!-- ================================= -->
    <!--  Flattening an improved document  -->
    <!-- ================================= -->

    <!-- 
        Return a type of a FO element (block or inline?)
    -->
    <xsl:template match="node()" mode="cpm.fastcust.fotype">

        <xsl:variable name="name">
            <xsl:apply-templates select="." mode="foname"/>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$name = ''">
                <xsl:text>inline</xsl:text>
            </xsl:when>
            <xsl:when test="$name = 'fo:inline'">
                <xsl:text>inline</xsl:text>
            </xsl:when>
            <xsl:when test="$name = 'fo:external-graphic'">
                <xsl:text>inline</xsl:text>
            </xsl:when>
            <xsl:when test="$name = 'cpm:none'">
                <xsl:text>block</xsl:text>
            </xsl:when>
            <xsl:when test="$name = 'fo:block-container'">
                <xsl:text>block</xsl:text>
            </xsl:when>
            <xsl:when test="$name = 'fo:block'">
                <xsl:text>block</xsl:text>
            </xsl:when>
            <xsl:when test="$name = 'fo:list-block'">
                <xsl:text>block</xsl:text>
            </xsl:when>
            <xsl:when test="$name = 'fo:list-item'">
                <xsl:text>block</xsl:text>
            </xsl:when>
            <xsl:when test="$name = 'fo:table'">
                <xsl:text>block</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>special</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 
        Detecting source elements that beget block FO elements
    -->
    <xsl:template match="*" mode="cpm.fastcust.bones">

        <xsl:for-each select="node()">

            <xsl:variable name="fotype">
                <xsl:apply-templates select="." mode="cpm.fastcust.fotype"/>
            </xsl:variable>

            <xsl:if test="$fotype = 'block'">
                <bone pos="{count(preceding-sibling::node())+1}"/>
            </xsl:if>

        </xsl:for-each>

        <bone pos="{count(node()) + 1}"/>

    </xsl:template>


    <!-- 
        Wrapping each snippet of stray text into a cpm:wrapper element
    -->
    <xsl:template match="*" mode="cpm.fastcust.meat">

        <xsl:param name="bones"/>

        <xsl:variable name="body">
            <xsl:copy-of select="node()"/>
        </xsl:variable>

        <xsl:for-each select="$bones/bone">

            <xsl:variable name="left">
                <xsl:choose>
                    <xsl:when test="position() = 1">
                        <xsl:value-of select="0"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="preceding-sibling::bone[1]/@pos"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:variable name="right">
                <xsl:value-of select="@pos"/>
            </xsl:variable>

            <xsl:variable name="meat">
                <xsl:for-each
                    select="$body/node()[$left &lt; count(preceding-sibling::node()) + 1 and count(preceding-sibling::node()) + 1 &lt; $right]">
                    <xsl:choose>
                        <xsl:when test="name() = ''">
                            <xsl:value-of select="normalize-space(.)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of select="."/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:variable>

            <xsl:if test="not($meat = '')">
                <cpm:wrapper>
                    <xsl:copy-of select="$meat/node()"/>
                </cpm:wrapper>
            </xsl:if>

            <xsl:if test="following-sibling::bone">
                <xsl:apply-templates select="$body/*[count(preceding-sibling::node()) + 1 = $right]"
                    mode="cpm.fastcust.stray"/>
            </xsl:if>

        </xsl:for-each>

    </xsl:template>


    <!-- 
        Processing an element that probably has stray text 
    -->
    <xsl:template match="*" mode="cpm.fastcust.stray">

        <xsl:variable name="bones">
            <xsl:apply-templates select="." mode="cpm.fastcust.bones"/>
        </xsl:variable>

        <xsl:choose>

            <xsl:when test="count($bones/bone) &lt;= 1">

                <xsl:copy-of select="."/>

            </xsl:when>

            <xsl:otherwise>

                <xsl:copy>

                    <xsl:copy-of select="@*"/>

                    <xsl:apply-templates select="." mode="cpm.fastcust.meat">
                        <xsl:with-param name="bones" select="$bones"/>
                    </xsl:apply-templates>

                </xsl:copy>

            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>


    <!-- 
        Copying an element having only inline children
    -->
    <xsl:template match="*[not(*)]" mode="cpm.fastcust.stray">
        <xsl:copy-of select="."/>
    </xsl:template>


    <!-- 
        We dive into a source element by default 
    -->


    <!-- 
        A master page sequence alias is not assigned  
    -->
    <xsl:template match="*" mode="sequence">
        <!--            
            OVERLOAD: for each element having a section                   
        -->
    </xsl:template>


    <!-- 
        Source element metadata is empty by default
    -->
    <xsl:template match="*" mode="info"/>


    <!-- 
        Moving a source document from the block model to the flat model 
    -->
    <xsl:template match="*" mode="cpm.fastcust.flat">

        <!--            
            OVERLOAD: strongly not recommended.                   
        -->

        <!-- 
            FastCust doesn't know anything about a markup language they
            use in a source document as well as about a layout of an 
            output document. A customization that imports FastCust should
            provide templates assigning a level to a source element.
            
            The following levels are allowed.
            =========+=======================================
             Value   | Effect on a source element
            =========+=======================================
             -1      | Totally ignoring
             0       | Passing and processing child elements
             1, 2... | Placing into an output document
            =========+=======================================
            
            Being placed into an output documents a source element obtains:
            
            - A level in an output document structure (@cpm:level), mandatory
            
            - A number, e.g. 1, 1.1, 1.1.2, etc. (@cpm:number), optional
            
            - An alias of a page-sequence-master (@cpm:master-alias), optional
            
            - Custom metadata (@cpm:info), optional            
        -->

        <!-- Requesting a level of an element in an output document -->
        <xsl:variable name="level" select="number(@cpm:level)"/>

        <xsl:choose>

            <!-- There is no place for the element in the output document -->
            <xsl:when test="$level = -1"/>

            <!-- Diving into the element -->
            <xsl:when test="$level = 0">
                <xsl:apply-templates select="*" mode="cpm.fastcust.flat"/>
            </xsl:when>

            <!-- Place the element into the output document structure -->
            <xsl:otherwise>

                <xsl:copy>

                    <!-- Master alias (optional) -->
                    <xsl:variable name="master_alias">
                        <xsl:apply-templates select="." mode="sequence"/>
                    </xsl:variable>

                    <xsl:if test="$master_alias != ''">
                        <xsl:attribute name="cpm:master-alias">
                            <xsl:value-of select="$master_alias"/>
                        </xsl:attribute>
                    </xsl:if>

                    <!-- Info (optional) -->
                    <xsl:variable name="info">
                        <xsl:apply-templates select="." mode="sequence"/>
                    </xsl:variable>

                    <xsl:if test="$info != ''">
                        <xsl:attribute name="cpm:info">
                            <xsl:value-of select="$info"/>
                        </xsl:attribute>
                    </xsl:if>

                    <xsl:copy-of select="@* | node()"/>

                </xsl:copy>

            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>


    <!-- 
        Splitting a flat document into page sequences
    -->

    <!-- Assigning a master page sequence name to an adjoining element -->
    <xsl:template match="*" mode="cpm.fastcust.master_alias">

        <!--            
            OVERLOAD: strongly not recommended.                   
        -->

        <xsl:choose>
            <xsl:when test="@cpm:master-alias">
                <xsl:value-of select="@cpm:master-alias"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="following-sibling::*[1]"
                    mode="cpm.fastcust.master_alias"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- Tuning a flat source document representation -->
    <xsl:template match="*" mode="cpm.fastcust.tune">

        <!--            
            OVERLOAD: strongly not recommended.                   
        -->

        <xsl:copy>

            <xsl:attribute name="cpm:index">
                <xsl:value-of select="position()"/>
            </xsl:attribute>

            <xsl:attribute name="cpm:master-alias">
                <xsl:apply-templates select="." mode="cpm.fastcust.master_alias"/>
            </xsl:attribute>

            <xsl:copy-of select="@*[not(name() = 'cpm:master-alias')] | node()"/>

        </xsl:copy>

    </xsl:template>


    <!-- Splitting a flat source document representation into sections -->
    <xsl:template match="cpm:root" mode="cpm.fastcust.sequences">

        <!--            
            OVERLOAD: strongly not recommended.                   
        -->

        <!-- Detecting bounds -->

        <xsl:variable name="bounds">
            <cpm:left index="1"/>
            <xsl:for-each
                select="*[following-sibling::* and not(@cpm:master-alias = following-sibling::*[1]/@cpm:master-alias)]">
                <cpm:right index="{@cpm:index}" master-alias="{@cpm:master-alias}"/>
                <cpm:left index="{following-sibling::*[1]/@cpm:index}"
                    master-alias="{following-sibling::*[1]/@cpm:master-alias}"/>
            </xsl:for-each>
            <cpm:right index="{count(*)}">
                <xsl:if test="count(*) = 1">
                    <xsl:attribute name="master-alias">
                        <xsl:value-of select="*/@cpm:master-alias"/>
                    </xsl:attribute>
                </xsl:if>
            </cpm:right>
        </xsl:variable>

        <!-- Assembling a list of sequences -->

        <xsl:variable name="xtrf" select="@xtrf"/>

        <xsl:variable name="sequences">
            <xsl:for-each select="$bounds/cpm:left">
                <cpm:sequence>
                    <xsl:attribute name="left">
                        <xsl:value-of select="@index"/>
                    </xsl:attribute>
                    <xsl:attribute name="right">
                        <xsl:value-of select="following-sibling::cpm:right[1]/@index"/>
                    </xsl:attribute>
                    <xsl:attribute name="master-alias">
                        <xsl:choose>
                            <xsl:when test="@master-alias">
                                <xsl:value-of select="@master-alias"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="following-sibling::cpm:right[1]/@master-alias"
                                />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </cpm:sequence>
            </xsl:for-each>
        </xsl:variable>

        <!-- Assembling sequences -->

        <xsl:variable name="flat">
            <xsl:copy-of select="*"/>
        </xsl:variable>

        <xsl:for-each select="$sequences/cpm:sequence">

            <xsl:variable name="left" select="@left"/>
            <xsl:variable name="right" select="@right"/>

            <cpm:page-sequence>

                <xsl:attribute name="xtrf">
                    <xsl:value-of select="$xtrf"/>
                </xsl:attribute>

                <xsl:attribute name="master-alias">
                    <xsl:value-of select="@master-alias"/>
                </xsl:attribute>

                <xsl:attribute name="master-name">
                    <xsl:call-template name="cpm.fastcust.get_master_name">
                        <xsl:with-param name="master_alias" select="@master-alias"/>
                    </xsl:call-template>
                </xsl:attribute>

                <!-- Static content -->
                <xsl:call-template name="cpm.fastcust.static">
                    <xsl:with-param name="master_alias" select="@master-alias"/>
                </xsl:call-template>

                <!-- Body content -->
                <cpm:flow>

                    <xsl:choose>

                        <xsl:when test="$cpm.fastcust.wrapping_stray_text = ''">
                            <xsl:copy-of
                                select="$flat/*[$left &lt;= position() and position() &lt;= $right]"
                            />
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:apply-templates
                                select="$flat/*[$left &lt;= position() and position() &lt;= $right]"
                                mode="cpm.fastcust.stray"/>
                        </xsl:otherwise>

                    </xsl:choose>

                </cpm:flow>

            </cpm:page-sequence>

        </xsl:for-each>

    </xsl:template>


    <!-- 
        Preprocessing a source XML
    -->
    <xsl:template match="*" mode="cpm.fastcust.flatten">

        <!--            
            OVERLOAD: strongly not recommended.                   
        -->

        <xsl:variable name="flat_raw">
            <cpm:root>
                <xsl:copy-of select="@*"/>
                <xsl:apply-templates select="*" mode="cpm.fastcust.flat"/>
            </cpm:root>
        </xsl:variable>

        <xsl:variable name="flat">
            <cpm:root>
                <xsl:copy-of select="$flat_raw/cpm:root/@*"/>
                <xsl:apply-templates select="$flat_raw/cpm:root/*" mode="cpm.fastcust.tune"/>
            </cpm:root>
        </xsl:variable>

        <xsl:apply-templates select="$flat/cpm:root" mode="cpm.fastcust.sequences"/>

    </xsl:template>



    <!-- ==================================== -->
    <!--  Transforming a flat document to FO  -->
    <!-- ==================================== -->

    <!-- 
        Calling a customization for assembling static content
    -->
    <xsl:template match="cpm:static-content" mode="cpm.fastcust.static">

        <!--            
            OVERRIDE: strongly not recommended.                   
        -->

        <!-- Assembling static content inner XML -->
        <xsl:variable name="static_content">
            <xsl:apply-templates select="." mode="static"/>
        </xsl:variable>

        <!-- 
            Assembling a static content FO element for non empty 
            static content inner XML.
            
            An empty static content element causes FO processor error. 
        -->

        <xsl:if test="$static_content != ''">
            <fo:static-content flow-name="{@region-name}">
                <xsl:apply-templates select="." mode="static"/>
            </fo:static-content>
        </xsl:if>

    </xsl:template>


    <!-- 
        Assembling inner FO for a FO element
    -->
    <xsl:template match="*" mode="foinner">

        <!--            
            OVERLOAD: for a particular element.                   
        -->

        <!-- Inserting a full number unless an element has a title -->
        <xsl:if test="not(title)">
            <xsl:value-of select="cpm:fastcust.full_number(.)"/>
        </xsl:if>

        <!-- Transforming child nodes to FO -->
        <xsl:apply-templates select="node()" mode="foxml"/>

    </xsl:template>


    <!-- 
        Choosing a default FO element name for an element
    -->
    <xsl:template match="*" mode="cpm.fastcust.default_foname">

        <!--            
            OVERLOAD: strongly not recommended.                   
        -->

        <xsl:choose>
            <xsl:when test="namespace-uri() = 'http://www.w3.org/1999/XSL/Format'">
                <xsl:value-of select="name()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>fo:block</xsl:text>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 
        Choosing a name for a FO element
    -->

    <!-- A default working template -->
    <xsl:template match="*" mode="cpm.fastcust.foname">

        <!--            
            OVERLOAD: strongly not recommended.                   
        -->

        <xsl:apply-templates select="." mode="cpm.fastcust.default_foname"/>

    </xsl:template>

    <!-- A custom working template -->
    <xsl:template match="*" mode="foname">

        <!--            
            OVERLOAD: for a particular element.                   
        -->

        <xsl:apply-templates select="." mode="cpm.fastcust.foname"/>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:fastcust.foname">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="foname"/>
    </xsl:function>


    <!-- 
        Assembling attributes for common elements
    -->
    <xsl:template match="*" mode="foattrs">
        <!--            
            OVERLOAD: for a particular element.                   
        -->
    </xsl:template>


    <!-- 
        Assembling attributes for explicit FO elements
    -->
    <xsl:template match="*[namespace-uri() = 'http://www.w3.org/1999/XSL/Format']" mode="foattrs">
        <xsl:copy-of
            select="@*[namespace-uri() != 'http://cpmonster.com/xmlns/cpm'] except (@outputclass, @xtrf)"
        />
    </xsl:template>


    <!-- 
        Applying a default style to an element
    -->
    <xsl:attribute-set name="cpm.fastcust.default_style">
        <!--            
            OVERLOAD: strongly not recommended.                   
        -->
        <!-- TBD: what do we do with a default style? -->
    </xsl:attribute-set>


    <!-- 
        A default formatting template
    -->
    <xsl:template match="*" mode="cpm.fastcust.foxml">

        <!--            
            OVERLOAD: in a generated layout.xsl.                   
        -->

        <xsl:param name="foinner"/>

        <xsl:variable name="element_name">
            <xsl:value-of select="cpm:fastcust.foname(.)"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$element_name = ''"/>
            <xsl:when test="$element_name = 'cpm:none'">
                <xsl:copy-of select="$foinner"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="{$element_name}" use-attribute-sets="cpm.fastcust.default_style">
                    <xsl:attribute name="id">
                        <xsl:value-of select="cpm:fastcust.id(.)"/>
                    </xsl:attribute>
                    <xsl:attribute name="language">
                        <xsl:value-of select="cpm:fastcust.lang(.)"/>
                    </xsl:attribute>
                    <xsl:attribute name="role">
                        <xsl:value-of select="name()"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="." mode="foattrs"/>
                    <xsl:copy-of select="$foinner"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- 
        Transforming a source element to a FO element 
    -->
    <xsl:template match="*" mode="foxml">

        <!-- 
            OVERLOAD: for a particular element. 
        -->

        <!-- Transforming an element to FO -->
        <xsl:apply-templates select="." mode="cpm.fastcust.foxml">

            <xsl:with-param name="foinner">
                <!-- Assembling inner FO for an element -->
                <xsl:apply-templates select="." mode="foinner"/>
            </xsl:with-param>

        </xsl:apply-templates>

    </xsl:template>


    <!-- 
        Assembling a FO page sequence
    -->
    <xsl:template match="cpm:page-sequence" mode="cpm.fastcust.fodraft">

        <!-- 
            OVERRIDE: strongly not recommended.
        -->

        <fo:page-sequence master-reference="{@master-name}">

            <xsl:apply-templates select="cpm:static-content" mode="cpm.fastcust.static"/>

            <fo:flow flow-name="xsl-region-body">

                <xsl:apply-templates select="cpm:flow/*" mode="foxml"/>

                <xsl:if test="position() = last()">
                    <fo:block id="cpm.fastcust.last_page"/>
                </xsl:if>

            </fo:flow>

        </fo:page-sequence>

    </xsl:template>



    <!-- ========================== -->
    <!--  Correcting a FO document  -->
    <!-- ========================== -->

    <!-- 
        Postprocessing FO
    -->

    <!-- 
        Supressing @role attributes 
    -->
    <xsl:template match="@role" mode="cpm.fastcust.fofinal"/>


    <!-- 
        Parsing final FO 
    -->
    <xsl:template match="node() | @*" mode="cpm.fastcust.fofinal">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="cpm.fastcust.fofinal"/>
        </xsl:copy>
    </xsl:template>



    <!-- ============================================ -->
    <!--  Main: transforming a source documnet to FO  -->
    <!-- ============================================ -->

    <!-- 
        Main
    -->
    <xsl:template match="/">

        <!-- 
            A context node here is a root of a source document (e.g. stage1a.xml) 
        -->

        <!-- 
            OVERLOAD: strongly not recommended.
        -->

        <!-- Supplemented content of a source document -->
        <xsl:variable name="complete_xml">
            <xsl:apply-templates select="*" mode="cpm.fastcust.complete"/>
        </xsl:variable>

        <!-- Assigning levels and numbers to document elements -->
        <xsl:variable name="improved_xml">
            <xsl:apply-templates select="$complete_xml/*" mode="cpm.fastcust.improve"/>
        </xsl:variable>

        <!-- Flattening the improved document and splitting it into sections -->
        <xsl:variable name="flat_xml">
            <xsl:apply-templates select="$improved_xml/*" mode="cpm.fastcust.flatten"/>
        </xsl:variable>

        <!-- Transforming flat sections to FO -->
        <xsl:variable name="fodraft_xml">
            <xsl:apply-templates select="$flat_xml/*" mode="cpm.fastcust.fodraft"/>
        </xsl:variable>

        <!-- Resolving issues in the draft FO -->
        <xsl:variable name="fofinal_xml">


            <xsl:comment>#####################</xsl:comment>
            <!-- <xsl:copy-of select="$improved_xml"/> -->
            <xsl:comment>#####################</xsl:comment>


            <xsl:apply-templates select="$fodraft_xml/*" mode="cpm.fastcust.fofinal"/>

        </xsl:variable>

        <!-- The FO root element -->
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"
            xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions">

            <!-- Assembling a page master set (is defined in layout.xsl) -->
            <xsl:apply-templates select="." mode="cpm.fastcust.layout_master_set"/>

            <!-- Writing the final FO output  -->
            <xsl:copy-of select="$fofinal_xml"/>

        </fo:root>

    </xsl:template>

</xsl:stylesheet>
