<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster
    
    Level:      Library    
    
    Part:       Common libraries 
    Module:     props.xsl
    
    Scope:      Generic
    
    Func:       Working with CPM properties and alias lists                 
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">


    <!-- 
        A CPM property contains a value that is important for an application.        
        A prpperty element represents a property.         
        A property element has the following attributes:        
        @name (required) - a property name, e.g. "Font weight";        
        @value (optional) - a property value.         
        Nesting a property value into a property element is also allowed.     
        A record element represents a meaningful group of properties.         
        A record element has the following attributes:        
        @name (required) - a rector type name, e.g. "Style" or "Paragraph format".        
        Use a property[@name='name'] for assigning a name to a particular record.        
        Nesting a record into a record is allowed.        
        An array element represents a sequence of records of records having a same type.        
        An alias is a string value that an application should treat as another one.            
    -->

    <!-- 
        Modules
    -->

    <!-- Transliterating characters -->
    <xsl:import href="translit.xsl"/>



    <!-- ========================= -->
    <!--  Working with parameters  -->
    <!-- ========================= -->

    <!-- 
        An element or a string?
    -->
    <xsl:function name="cpm:props.is_element" as="xs:boolean">

        <!-- An element or a string -->
        <xsl:param name="candidate"/>

        <xsl:variable name="tmp">
            <tmp>
                <xsl:copy-of select="$candidate"/>
            </tmp>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$tmp/tmp/*">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:function>



    <!-- ========================== -->
    <!--  Working with alias lists  -->
    <!-- ========================== -->

    <!-- 
        Detecting if a custom alias strategy defined in an application
    -->
    <xsl:function name="cpm:props.is_custom_alias_strategy_defined" as="xs:boolean">

        <xsl:variable name="tmp1">
            <tmp/>
        </xsl:variable>

        <xsl:variable name="tmp2">
            <xsl:apply-templates select="$tmp1/tmp" mode="is_custom_alias_strategy_defined"/>
        </xsl:variable>

        <xsl:value-of select="$tmp2 != ''"/>

    </xsl:function>


    <!-- 
        Transforming an alias list to an alias sequence
    -->
    <xsl:function name="cpm:props.alias_sequence" as="xs:string*">

        <!-- A list of aliases, e.g. "Product;Product name" -->
        <xsl:param name="alias_list"/>

        <xsl:variable name="tmp">
            <tmp>
                <xsl:value-of select="$alias_list"/>
            </tmp>
        </xsl:variable>

        <xsl:variable name="seqtmp" as="xs:string*">

            <xsl:choose>

                <xsl:when test="cpm:props.is_custom_alias_strategy_defined()">
                    <xsl:apply-templates select="$tmp/tmp" mode="alias_sequence"/>
                </xsl:when>

                <xsl:otherwise>
                    <xsl:sequence select="tokenize($alias_list, ';')"/>
                </xsl:otherwise>

            </xsl:choose>

        </xsl:variable>

        <xsl:for-each select="$seqtmp">
            <xsl:value-of select="normalize-space(.)"/>
        </xsl:for-each>

    </xsl:function>


    <!-- 
        Transforming an alias list to a hashtag sequence
    -->
    <xsl:function name="cpm:props.hashtag_sequence" as="xs:string*">

        <!-- A list of aliases, e.g. "Product;Product name" -->
        <xsl:param name="alias_list"/>

        <xsl:variable name="tmp" select="cpm:props.alias_sequence($alias_list)" as="xs:string*"/>


        <xsl:for-each select="$tmp">
            <xsl:value-of select="cpm:translit.hashtag(.)"/>
        </xsl:for-each>

    </xsl:function>


    <!-- 
        Matching a value with an alias list by hashtags
    -->
    <xsl:function name="cpm:props.match" as="xs:boolean">

        <!-- A value to be checked -->
        <xsl:param name="candidate"/>

        <!-- A list of available alieses -->
        <xsl:param name="alias_list"/>

        <xsl:variable name="hashtag">
            <xsl:value-of select="cpm:translit.hashtag($candidate)"/>
        </xsl:variable>

        <xsl:variable name="hashtag_sequence" as="xs:string*">
            <xsl:copy-of select="cpm:props.hashtag_sequence($alias_list)"/>
        </xsl:variable>
        
        <xsl:value-of select="$hashtag = $hashtag_sequence"/>

    </xsl:function>



    <!-- =========================== -->
    <!--  Accessing property values  -->
    <!-- =========================== -->

    <!-- 
        Retrieving a property value
    -->
    <xsl:function name="cpm:props.get_property_value">

        <!-- A property element or a variable containing one -->
        <xsl:param name="property"/>

        <!-- 
            Both syntax options are allowed for a property element:
            
            <property name="foo" value="bar"/>
            
            <property name="foo">bar</property>        
        -->

        <xsl:variable name="tmp">
            <xsl:choose>
                <xsl:when test="$property/property">
                    <xsl:copy-of select="$property/property"/>
                </xsl:when>
                <xsl:when test="name($property) = 'property'">
                    <xsl:copy-of select="$property"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>

        <xsl:if test="$tmp/property">
            <xsl:choose>
                <xsl:when test="$tmp/property/@value">
                    <xsl:value-of select="$tmp/property/@value"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$tmp/property"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>

    </xsl:function>



    <!-- ============================================== -->
    <!--  Accessing properties by exact names and keys  -->
    <!-- ============================================== -->

    <!-- 
        Testing a property for matching a (key, keyvalue) pair
    -->
    <xsl:function name="cpm:props.testprop" as="xs:boolean">

        <!-- A property we are going to test -->
        <xsl:param name="property"/>

        <!-- A key name -->
        <xsl:param name="key"/>

        <!-- A key value -->
        <xsl:param name="keyval"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="$property/@name = $key">
                    <xsl:value-of
                        select="boolean(cpm:props.get_property_value($property) = $keyval)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Testing a record for matching a type name and a key value
    -->
    <xsl:function name="cpm:props.testrec" as="xs:boolean">

        <!-- A record element we are going to test -->
        <xsl:param name="record"/>

        <!-- A record type name -->
        <xsl:param name="recname"/>

        <!-- A record key name -->
        <xsl:param name="key"/>

        <!-- A record key value -->
        <xsl:param name="keyval"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="$record/@name = $recname">
                    <xsl:choose>
                        <xsl:when test="$record/property[cpm:props.testprop(., $key, $keyval)]">
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

    </xsl:function>


    <!-- 
        Retrieving a record
    -->
    <xsl:function name="cpm:props.get_record">

        <!-- A data structure containing properties -->
        <xsl:param name="set"/>

        <!-- A record type name -->
        <xsl:param name="recname"/>

        <!-- A record key name -->
        <xsl:param name="key"/>

        <!-- A record key value -->
        <xsl:param name="keyval"/>

        <xsl:copy-of select="$set//record[cpm:props.testrec(., $recname, $key, $keyval)]"/>

    </xsl:function>


    <!-- 
        Getting a property value by a key
    -->

    <!-- A template -->
    <xsl:template name="cpm.props.get" as="xs:string">

        <!-- A data structure containing properties -->
        <xsl:param name="set"/>

        <!-- A record type name -->
        <xsl:param name="recname"/>

        <!-- A record key name -->
        <xsl:param name="key"/>

        <!-- A record key value -->
        <xsl:param name="keyval"/>

        <!-- A property name -->
        <xsl:param name="name"/>

        <!-- Getting a target record -->
        <xsl:variable name="record">
            <xsl:copy-of select="cpm:props.get_record($set, $recname, $key, $keyval)"/>
        </xsl:variable>

        <!-- Getting a target property -->
        <xsl:variable name="property">
            <xsl:copy-of select="$record//property[@name = $name]"/>
        </xsl:variable>

        <!-- Returning a value -->
        <xsl:value-of select="cpm:props.get_property_value($property)"/>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:props.get">

        <!-- A data structure containing properties -->
        <xsl:param name="set"/>

        <!-- A record type name -->
        <xsl:param name="recname"/>

        <!-- A record key name -->
        <xsl:param name="key"/>

        <!-- A record key value -->
        <xsl:param name="keyval"/>

        <!-- A property name -->
        <xsl:param name="name"/>

        <xsl:call-template name="cpm.props.get">
            <xsl:with-param name="set" select="$set"/>
            <xsl:with-param name="recname" select="$recname"/>
            <xsl:with-param name="key" select="$key"/>
            <xsl:with-param name="keyval" select="$keyval"/>
            <xsl:with-param name="name" select="$name"/>
        </xsl:call-template>

    </xsl:function>



    <!-- ================================== -->
    <!--  Accessing properties by hashtags  -->
    <!-- ================================== -->

    <!-- 
        Testing a property for matching a (key, keyvalue) hashtag pair
    -->
    <xsl:function name="cpm:props.ht_testprop" as="xs:boolean">

        <!-- A property we are going to test -->
        <xsl:param name="property"/>

        <!-- A key name -->
        <xsl:param name="key"/>

        <!-- A key value -->
        <xsl:param name="keyval"/>

        <xsl:variable name="tmp" as="xs:boolean">

            <xsl:choose>

                <xsl:when test="cpm:translit.eqht($property/@name, $key)">

                    <xsl:variable name="propval">
                        <xsl:value-of select="cpm:props.get_property_value($property)"/>
                    </xsl:variable>

                    <xsl:value-of select="cpm:translit.eqht($propval, $keyval)"/>

                </xsl:when>

                <xsl:otherwise>
                    <xsl:value-of select="false()"/>
                </xsl:otherwise>

            </xsl:choose>

        </xsl:variable>

        <xsl:value-of select="boolean($tmp)"/>

    </xsl:function>


    <!-- 
        Testing a record for matching record name, key, & key value hashtags
    -->
    <xsl:function name="cpm:props.ht_testrec" as="xs:boolean">

        <!-- A record element we are going to test -->
        <xsl:param name="record"/>

        <!-- A record type name -->
        <xsl:param name="recname"/>

        <!-- A record key name -->
        <xsl:param name="key"/>

        <!-- A record key value -->
        <xsl:param name="keyval"/>

        <xsl:variable name="tmp" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="cpm:translit.eqht($record/@name, $recname)">
                    <xsl:choose>
                        <xsl:when test="$record/property[cpm:props.ht_testprop(., $key, $keyval)]">
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

    </xsl:function>


    <!-- 
        Retrieving a record by record name, key, & key value hashtags
    -->
    <xsl:function name="cpm:props.ht_get_record">

        <!-- A data structure containing properties -->
        <xsl:param name="set"/>

        <!-- A record type name -->
        <xsl:param name="recname"/>

        <!-- A record key name -->
        <xsl:param name="key"/>

        <!-- A record key value -->
        <xsl:param name="keyval"/>

        <xsl:copy-of select="$set//record[cpm:props.ht_testrec(., $recname, $key, $keyval)]"/>

    </xsl:function>


    <!-- 
        Taking a property value by record name, key, & key value hashtags
    -->

    <!-- A template -->
    <xsl:template name="cpm.props.ht_get" as="xs:string">

        <!-- A data structure containing properties -->
        <xsl:param name="set"/>

        <!-- A record type name -->
        <xsl:param name="recname"/>

        <!-- A record key name -->
        <xsl:param name="key"/>

        <!-- A record key value -->
        <xsl:param name="keyval"/>

        <!-- A property name -->
        <xsl:param name="name"/>

        <!-- Getting a target record -->
        <xsl:variable name="record">
            <xsl:copy-of select="cpm:props.ht_get_record($set, $recname, $key, $keyval)"/>
        </xsl:variable>

        <!-- Getting a target property -->
        <xsl:variable name="property">
            <xsl:copy-of select="$record//property[cpm:translit.eqht(@name, $name)]"/>
        </xsl:variable>

        <!-- Returning a value -->
        <xsl:value-of select="cpm:props.get_property_value($property)"/>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:props.ht_get">

        <!-- A data structure containing properties -->
        <xsl:param name="set"/>

        <!-- A record type name -->
        <xsl:param name="recname"/>

        <!-- A record key name -->
        <xsl:param name="key"/>

        <!-- A record key value -->
        <xsl:param name="keyval"/>

        <!-- A property name -->
        <xsl:param name="name"/>

        <xsl:call-template name="cpm.props.ht_get">
            <xsl:with-param name="set" select="$set"/>
            <xsl:with-param name="recname" select="$recname"/>
            <xsl:with-param name="key" select="$key"/>
            <xsl:with-param name="keyval" select="$keyval"/>
            <xsl:with-param name="name" select="$name"/>
        </xsl:call-template>

    </xsl:function>



    <!-- ======================= -->
    <!--  Assembling properties  -->
    <!-- ======================= -->

    <!-- 
        Assembling a property having a non-empty value
    -->
    <xsl:template name="cpm.props.set">

        <!-- A property name -->
        <xsl:param name="name"/>

        <!-- A property value -->
        <xsl:param name="value" select="''"/>

        <!-- Assembling a property for a non-empty value -->
        <xsl:if test="$value != ''">
            <property name="{$name}" value="{$value}"/>
        </xsl:if>

    </xsl:template>



    <!-- ======= -->
    <!--  DEBUG  -->
    <!-- ======= -->

    <xsl:template match="/">

        <xsl:variable name="settings">
            <record>
                <record name="style">
                    <property name="name" value="style1"/>
                    <property name="foo" value="123456"/>
                    <property name="bar" value="QWERTY"/>
                </record>
                <record name="style">
                    <property name="name" value="style2"/>
                    <property name="foo" value="7890"/>
                    <property name="bar" value="ASDFG"/>
                </record>
                <record name="style">
                    <property name="name" value="Цыпа дрипа ежкин кот"/>
                    <property name="foo" value="Получилось"/>
                    <property name="bar" value="ASDFG"/>
                </record>
            </record>
        </xsl:variable>

        <xsl:value-of
            select="cpm:props.ht_get($settings, 'style', 'name', 'Цыпа, Дрипа ежкин кот', 'foo')"/>

        <xsl:value-of select="cpm:props.ht_get($settings, 'style', 'name', 'Style1', 'foo')"/>

    </xsl:template>

</xsl:stylesheet>
