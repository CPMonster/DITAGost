<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product: CopyPaste Monster
    
    Level:   Library    

    Part:    Common libraries
    Module:  pathuri.xsl
        
    Scope:   Windows, pretends to become generic
    
    Func:    Provides aid for processing paths and URIs: converting absolute URI 
             to a relative one and vice versa, replacing an extension, etc.                 
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->    
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:java-urldecode="java:java.net.URLDecoder" exclude-result-prefixes="cpm xs" version="2.0">

    <!-- Separator between folder names in a path -->
    <xsl:param name="cpm.pathuri.foldersep" select="'\'"/>

    <!-- Separator after a dick latter in a path -->
    <xsl:param name="cpm.pathuri.drivesep" select="':'"/>


    <!-- 
        Returns an URI converted from a path 
    -->
    <xsl:template name="cpm.pathuri.path2uri">

        <xsl:param name="path"/>

        <xsl:variable name="uri_raw1">
            <xsl:value-of select="'file:///'"/>
            <xsl:value-of select="$path"/>
        </xsl:variable>

        <xsl:variable name="uri_raw2">
            <xsl:value-of select="translate($uri_raw1, $cpm.pathuri.foldersep, '/')"/>
        </xsl:variable>

        <xsl:value-of select="iri-to-uri($uri_raw2)"/>

    </xsl:template>


    <!--
        Returns a decoded URI    
    -->
    <xsl:template name="cpm.pathuri.decode_uri">

        <xsl:param name="s"/>

        <xsl:value-of select="java-urldecode:decode($s, 'UTF-8')"/>

    </xsl:template>


    <!-- 
        Returns a path converted from an URI 
    -->

    <!-- A template -->
    <xsl:template name="cpm.pathuri.uri2path">

        <xsl:param name="uri"/>

        <xsl:variable name="raw_path">
            <xsl:choose>
                <xsl:when test="contains($uri, 'file:///')">
                    <xsl:value-of select="substring-after($uri, 'file:///')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="contains($uri, 'file:/')">
                            <xsl:value-of select="substring-after($uri, 'file:/')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$uri"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:call-template name="cpm.pathuri.decode_uri">
            <xsl:with-param name="s">
                <xsl:value-of select="translate($raw_path, '/', $cpm.pathuri.foldersep)"/>
            </xsl:with-param>
        </xsl:call-template>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:pathuri.path" as="xs:string">

        <xsl:param name="smth"/>

        <xsl:call-template name="cpm.pathuri.uri2path">
            <xsl:with-param name="uri" select="$smth"/>
        </xsl:call-template>

    </xsl:function>


    <!-- 
        Check if an URI or a path is absolute  
    -->

    <!-- A template -->
    <xsl:template name="cpm.pathuri.is_absolute">

        <xsl:param name="uri" select="''"/>
        <xsl:param name="path" select="''"/>
        <xsl:param name="smth" select="''"/>

        <xsl:choose>
            <xsl:when test="not($uri = '')">
                <xsl:if test="starts-with($uri, 'file:/')">
                    <xsl:text>yes</xsl:text>
                </xsl:if>
            </xsl:when>
            <xsl:when test="not($path = '')">
                <xsl:if test="contains($path, ':\')">
                    <xsl:text>yes</xsl:text>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="starts-with($smth, 'file:/') or contains($smth, ':\')">
                    <xsl:text>yes</xsl:text>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:pathuri.is_absolute" as="xs:boolean">

        <xsl:param name="pathuri"/>

        <xsl:variable name="tmp">
            <xsl:call-template name="cpm.pathuri.is_absolute">
                <xsl:with-param name="smth" select="$pathuri"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="boolean($tmp != '')"/>

    </xsl:function>


    <!-- 
        Check if a value pretends to be URI  
    -->
    <xsl:template name="cpm.pathuri.is_URI">

        <xsl:param name="value"/>

        <xsl:if test="not(contains($value, '\'))">
            <xsl:text>yes</xsl:text>
        </xsl:if>

    </xsl:template>


    <!-- 
        Returns an URI converted from a absolure/relative path/URI
    -->
    <xsl:template name="cpm.pathuri.smth2uri">

        <!-- Abs. path, abs. URI, rel. path, or rel. URI -->
        <xsl:param name="smth"/>

        <!-- Abs. path or abs. URI -->
        <!-- A $base will be ignored if $smth is absolute -->
        <xsl:param name="base">
            <!--
            <xsl:call-template name="cpm.pathuri.get_folder">
                <xsl:with-param name="uri" select="base-uri(/)"/>
            </xsl:call-template>
            -->
        </xsl:param>

        <xsl:choose>

            <!-- We've got an absolute URI -->
            <xsl:when test="starts-with($smth, 'file:///')">
                <xsl:value-of select="$smth"/>
            </xsl:when>

            <!-- We've got an empty URI -->
            <xsl:when test="$smth = ''">
                <xsl:value-of select="$base"/>
            </xsl:when>

            <xsl:otherwise>

                <xsl:choose>

                    <!-- We've got an absolute URI -->
                    <xsl:when test="starts-with($smth, 'file:/')">
                        <xsl:text>file:///</xsl:text>
                        <xsl:value-of select="substring-after($smth, 'file:/')"/>
                    </xsl:when>

                    <xsl:otherwise>

                        <xsl:variable name="abs">
                            <xsl:if test="contains($smth, ':')">
                                <xsl:text>yes</xsl:text>
                            </xsl:if>
                        </xsl:variable>

                        <xsl:choose>

                            <!-- We've got an absolute path -->
                            <xsl:when test="$abs = 'yes'">
                                <xsl:call-template name="cpm.pathuri.path2uri">
                                    <xsl:with-param name="path" select="$smth"/>
                                </xsl:call-template>
                            </xsl:when>

                            <xsl:otherwise>

                                <!-- We've got something relative -->

                                <!-- Assemble a base URI -->
                                <xsl:variable name="base_uri">
                                    <xsl:variable name="is_uri">
                                        <xsl:call-template name="cpm.pathuri.is_URI">
                                            <xsl:with-param name="value" select="$base"/>
                                        </xsl:call-template>
                                    </xsl:variable>
                                    <xsl:choose>
                                        <xsl:when test="$is_uri = 'yes'">
                                            <xsl:value-of select="$base"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:call-template name="cpm.pathuri.path2uri">
                                                <xsl:with-param name="path" select="$base"/>
                                            </xsl:call-template>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>

                                <!-- Assemble an URI -->
                                <xsl:value-of select="$base_uri"/>
                                <xsl:text>/</xsl:text>

                                <!-- Just say goodbye to the back slash -->
                                <xsl:value-of select="translate($smth, '\', '/')"/>

                            </xsl:otherwise>

                        </xsl:choose>

                    </xsl:otherwise>

                </xsl:choose>

            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>
    
    <xsl:function name="cpm:pathuri.uri">
        
        <xsl:param name="smth"/>
        
        <xsl:call-template name="cpm.pathuri.smth2uri">
            <xsl:with-param name="smth" select="$smth"/>
        </xsl:call-template>
        
    </xsl:function>


    <!-- 
        Convert something to a path
    -->
    <xsl:template name="cpm.pathuri.smth2path">

        <!-- Abs. path, abs. URI, rel. path, or rel. URI -->
        <xsl:param name="smth"/>

        <!-- Abs. path or abs. URI -->
        <!-- A $base will be ignored if $smth is absolute -->
        <xsl:param name="base">
            <xsl:call-template name="cpm.pathuri.get_folder">
                <xsl:with-param name="uri" select="base-uri()"/>
            </xsl:call-template>
        </xsl:param>

        <xsl:variable name="uri">
            <xsl:call-template name="cpm.pathuri.smth2uri">
                <xsl:with-param name="smth" select="$smth"/>
                <xsl:with-param name="base" select="$base"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:call-template name="cpm.pathuri.uri2path">
            <xsl:with-param name="uri" select="$uri"/>
        </xsl:call-template>

    </xsl:template>


    <!-- 
        Reverse a string, e.g. turn qwerty to ytrewq
    -->
    <xsl:template name="cpm.pathuri.reverse">

        <xsl:param name="s" select="''"/>

        <xsl:value-of select="substring($s, string-length($s), string-length($s))"/>

        <xsl:if test="string-length($s) > 0">
            <xsl:call-template name="cpm.pathuri.reverse">
                <xsl:with-param name="s" select="substring($s, 1, string-length($s) - 1)"/>
            </xsl:call-template>
        </xsl:if>

    </xsl:template>


    <!-- 
        Convert a filename from string to a sequence format
    -->
    <xsl:template name="cpm.pathuri.parse_filename">

        <!-- Filename is a string like kab.foo.bar where bar is an extension -->
        <xsl:param name="filename" select="''"/>

        <!-- 
            As a result we get XML: 
            <name>kab.foo</name>
            <extansion>bar</extension>              
        -->

        <file>
            <xsl:choose>

                <xsl:when test="contains($filename, '.')">

                    <xsl:variable name="tmp">
                        <xsl:call-template name="cpm.pathuri.reverse">
                            <xsl:with-param name="s" select="$filename"/>
                        </xsl:call-template>
                    </xsl:variable>

                    <name>
                        <xsl:call-template name="cpm.pathuri.reverse">
                            <xsl:with-param name="s" select="substring-after($tmp, '.')"/>
                        </xsl:call-template>
                    </name>

                    <extension>
                        <xsl:call-template name="cpm.pathuri.reverse">
                            <xsl:with-param name="s" select="substring-before($tmp, '.')"/>
                        </xsl:call-template>
                    </extension>

                </xsl:when>

                <xsl:otherwise>
                    <name>
                        <xsl:value-of select="$filename"/>
                    </name>
                    <extension/>
                </xsl:otherwise>

            </xsl:choose>
        </file>

    </xsl:template>


    <!-- 
        Cunvert an URI from string to XML format 
    -->

    <!-- This template returns a sequence -->
    <xsl:template name="cpm.pathuri.parse_uri_raw">

        <xsl:param name="uri"/>

        <xsl:choose>

            <xsl:when test="contains($uri, 'file:/') and not(contains($uri, 'file:///'))">
                <xsl:call-template name="cpm.pathuri.parse_uri_raw">
                    <xsl:with-param name="uri">
                        <xsl:text>file:///</xsl:text>
                        <xsl:value-of select="substring-after($uri, 'file:/')"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>

            <xsl:when test="contains($uri, '://')">

                <xsl:variable name="protocol">
                    <xsl:value-of select="substring-before($uri, '://')"/>
                </xsl:variable>

                <xsl:variable name="tail1">
                    <xsl:value-of select="substring-after($uri, '//')"/>
                </xsl:variable>

                <protocol>
                    <xsl:value-of select="$protocol"/>
                </protocol>

                <xsl:variable name="host">
                    <xsl:value-of select="substring-before($tail1, '/')"/>
                </xsl:variable>

                <xsl:variable name="tail2">
                    <xsl:value-of select="substring-after($tail1, '/')"/>
                </xsl:variable>

                <host>
                    <xsl:value-of select="$host"/>
                </host>

                <xsl:choose>

                    <xsl:when test="contains($tail2, ':')">

                        <xsl:variable name="disk">
                            <xsl:value-of select="substring-before($tail2, ':')"/>
                        </xsl:variable>

                        <disk>
                            <xsl:value-of select="$disk"/>
                        </disk>

                        <xsl:call-template name="cpm.pathuri.parse_uri_raw">
                            <xsl:with-param name="uri" select="substring-after($tail2, ':/')"/>
                        </xsl:call-template>

                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:call-template name="cpm.pathuri.parse_uri_raw">
                            <xsl:with-param name="uri" select="$tail2"/>
                        </xsl:call-template>
                    </xsl:otherwise>

                </xsl:choose>

            </xsl:when>

            <xsl:otherwise>

                <xsl:choose>

                    <xsl:when test="contains($uri, '/')">

                        <folder>
                            <xsl:value-of select="substring-before($uri, '/')"/>
                        </folder>

                        <xsl:call-template name="cpm.pathuri.parse_uri_raw">
                            <xsl:with-param name="uri" select="substring-after($uri, '/')"/>
                        </xsl:call-template>

                    </xsl:when>

                    <xsl:otherwise>

                        <xsl:variable name="filename">
                            <xsl:choose>
                                <xsl:when test="contains($uri, '#')">
                                    <xsl:value-of select="substring-before($uri, '#')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$uri"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>

                        <xsl:call-template name="cpm.pathuri.parse_filename">
                            <xsl:with-param name="filename" select="$filename"/>
                        </xsl:call-template>

                        <xsl:if test="contains($uri, '#')">
                            <id>
                                <xsl:value-of select="substring-after($uri, '#')"/>
                            </id>
                        </xsl:if>

                    </xsl:otherwise>

                </xsl:choose>

            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>


    <!-- Converts an URI to XML -->
    <xsl:template name="cpm.pathuri.parse_uri">

        <!-- URI is a string like file:///C:/kaboom/foo.bar -->
        <xsl:param name="uri"/>

        <!-- 
            As a result we get XML:
            <uri>
                <protocol>file</protocol>
                <host/>
                <disk>C</disk>
                <folder>kaboom</folder>
                <file>
                   <name>foo</name>
                   <extension>bar</extension>
                </file>
                <id>section2<id/>
            </uri>        
        -->

        <uri>
            <xsl:call-template name="cpm.pathuri.parse_uri_raw">
                <xsl:with-param name="uri" select="$uri"/>
            </xsl:call-template>
        </uri>

    </xsl:template>


    <!-- 
        Normalize an URI (it's really terrible so far)
    -->

    <!-- Recursive template for the .. 'operator' -->
    <xsl:template name="cpm.pathuri.normalize_uri_raw1">

        <xsl:param name="uri"/>

        <xsl:variable name="tail">
            <xsl:value-of select="substring-after($uri, '/../')"/>
        </xsl:variable>

        <xsl:variable name="nose0" select="substring-before($uri, '/../')"/>

        <xsl:variable name="nose1">
            <xsl:call-template name="cpm.pathuri.reverse">
                <xsl:with-param name="s" select="$nose0"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="nose2" select="substring-after($nose1, '/')"/>

        <xsl:variable name="nose">
            <xsl:call-template name="cpm.pathuri.reverse">
                <xsl:with-param name="s" select="$nose2"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="better_uri">
            <xsl:value-of select="$nose"/>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="$tail"/>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="contains($better_uri, '..')">
                <xsl:call-template name="cpm.pathuri.normalize_uri_raw1">
                    <xsl:with-param name="uri" select="$better_uri"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$better_uri"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- Recursive template for the . 'operator' -->
    <xsl:template name="cpm.pathuri.normalize_uri_raw2">

        <xsl:param name="uri"/>

        <xsl:variable name="tail" select="substring-after($uri, '/./')"/>

        <xsl:variable name="nose" select="substring-before($uri, '/./')"/>

        <xsl:variable name="better_uri">
            <xsl:value-of select="$nose"/>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="$tail"/>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="contains($better_uri, '/./')">
                <xsl:call-template name="cpm.pathuri.normalize_uri_raw2">
                    <xsl:with-param name="uri" select="$better_uri"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$better_uri"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- Wrapper -->
    <xsl:template name="cpm.pathuri.normalize_uri">

        <xsl:param name="uri"/>

        <xsl:variable name="stage1">
            <xsl:choose>
                <xsl:when test="contains($uri, '..')">
                    <xsl:call-template name="cpm.pathuri.normalize_uri_raw1">
                        <xsl:with-param name="uri" select="concat($uri, '/')"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$uri"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="stage2">
            <xsl:choose>
                <xsl:when test="contains($stage1, '/./')">
                    <xsl:call-template name="cpm.pathuri.normalize_uri_raw2">
                        <xsl:with-param name="uri" select="concat($stage1, '/')"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$stage1"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="stage3">
            <xsl:choose>
                <xsl:when test="ends-with($stage2, '/')">
                    <xsl:value-of select="substring($stage2, 1, string-length($stage2) - 1)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$stage2"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="contains($stage3, 'file:///')">
                <xsl:value-of select="$stage3"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="contains($stage3, 'file:/')">
                        <xsl:text>file:///</xsl:text>
                        <xsl:value-of select="substring-after($stage3, 'file:/')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$stage3"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- Wrapper function -->
    <xsl:function name="cpm:pathuri.normalize_uri">

        <xsl:param name="uri"/>

        <xsl:call-template name="cpm.pathuri.normalize_uri">
            <xsl:with-param name="uri" select="$uri"/>
        </xsl:call-template>

    </xsl:function>


    <!-- 
        Converts an URI from sequence to string format
    -->
    <xsl:template match="protocol" mode="cpm.pathuri.compile">
        <xsl:value-of select="."/>
        <xsl:text>://</xsl:text>
    </xsl:template>

    <xsl:template match="host" mode="cpm.pathuri.compile">
        <xsl:value-of select="."/>
        <xsl:text>/</xsl:text>
    </xsl:template>

    <xsl:template match="disk" mode="cpm.pathuri.compile">
        <xsl:value-of select="."/>
        <xsl:text>:</xsl:text>
    </xsl:template>

    <xsl:template match="folder" mode="cpm.pathuri.compile">
        <xsl:if test="preceding-sibling::*">
            <xsl:text>/</xsl:text>
        </xsl:if>
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="file" mode="cpm.pathuri.compile">
        <xsl:if test="preceding-sibling::*">
            <xsl:text>/</xsl:text>
        </xsl:if>
        <xsl:value-of select="name"/>
        <xsl:if test="not(extension = '')">
            <xsl:text>.</xsl:text>
            <xsl:value-of select="extension"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="id" mode="cpm.pathuri.compile">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template name="cpm.pathuri.compile_uri">
        <xsl:param name="uri"/>

        <xsl:apply-templates select="$uri" mode="cpm.pathuri.compile"/>

    </xsl:template>


    <!-- 
        Extract a name from uri
    -->

    <!-- The working template -->
    <xsl:template name="cpm.pathuri.get_name">

        <xsl:param name="uri"/>

        <xsl:variable name="uriseq">
            <xsl:call-template name="cpm.pathuri.parse_uri">
                <xsl:with-param name="uri" select="$uri"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="$uriseq/uri/file/name"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="$uriseq/uri/file/extension"/>

    </xsl:template>

    <!-- This template is for compatibility with early versions -->
    <xsl:template name="cpm.pathuri.get_filename">

        <xsl:param name="uri"/>

        <xsl:call-template name="cpm.pathuri.get_name">
            <xsl:with-param name="uri" select="$uri"/>
        </xsl:call-template>

    </xsl:template>


    <!-- 
        Extract an URI of a folder
    -->

    <!-- A template -->
    <xsl:template name="cpm.pathuri.get_folder">

        <xsl:param name="uri"/>

        <xsl:variable name="uriseq">
            <xsl:call-template name="cpm.pathuri.parse_uri">
                <xsl:with-param name="uri" select="$uri"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="folder">
            <uri>
                <xsl:copy-of select="$uriseq/uri/*[not(name() = 'file') and not(name() = 'id')]"/>
            </uri>
        </xsl:variable>

        <xsl:call-template name="cpm.pathuri.compile_uri">
            <xsl:with-param name="uri" select="$folder"/>
        </xsl:call-template>

    </xsl:template>

    <!-- Wrapper function -->
    <xsl:function name="cpm:pathuri.folder" as="xs:string">

        <xsl:param name="uri"/>

        <xsl:variable name="tmp">
            <xsl:call-template name="cpm.pathuri.get_folder">
                <xsl:with-param name="uri" select="$uri"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="string($tmp)"/>

    </xsl:function>


    <!-- 
        Extract a name from an uri omotting a type part
    -->
    <xsl:template name="cpm.pathuri.get_name_without_type">

        <xsl:param name="uri"/>

        <xsl:variable name="uriseq">
            <xsl:call-template name="cpm.pathuri.parse_uri">
                <xsl:with-param name="uri" select="$uri"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="$uriseq/uri/file/name"/>

    </xsl:template>


    <!-- 
        Extract a file type part from an uri
    -->

    <!-- The working template -->
    <xsl:template name="cpm.pathuri.get_type">

        <xsl:param name="uri"/>

        <xsl:variable name="uriseq">
            <xsl:call-template name="cpm.pathuri.parse_uri">
                <xsl:with-param name="uri" select="$uri"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="$uriseq/uri/file/extension"/>

    </xsl:template>

    <!-- This template is for compatibility with early versions -->
    <xsl:template name="cpm.pathuri.get_extension">

        <xsl:param name="uri"/>

        <xsl:call-template name="cpm.pathuri.get_type">
            <xsl:with-param name="uri" select="$uri"/>
        </xsl:call-template>

    </xsl:template>


    <!-- 
        Get URI beyond ID
    -->
    <xsl:template name="cpm.pathuri.get_file_uri">

        <xsl:param name="uri"/>

        <xsl:choose>
            <xsl:when test="contains($uri, '#')">
                <xsl:value-of select="substring-before($uri, '#')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$uri"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 
        Get ID
    -->
    <xsl:template name="cpm.pathuri.get_id">

        <xsl:param name="uri"/>

        <xsl:choose>
            <xsl:when test="contains($uri, '#')">
                <xsl:value-of select="substring-after($uri, '#')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="''"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- 
        Replace filename (e.g. foo/bar.dita to foo/rastobar.shmita)
    -->
    <xsl:template name="cpm.pathuri.replace_name">

        <xsl:param name="uri" select="''"/>

        <xsl:param name="name" select="''"/>

        <xsl:variable name="uriseq">
            <xsl:call-template name="cpm.pathuri.parse_uri">
                <xsl:with-param name="uri" select="$uri"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="name_xml">
            <xsl:call-template name="cpm.pathuri.parse_filename">
                <xsl:with-param name="filename" select="$name"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:call-template name="cpm.pathuri.compile_uri">
            <xsl:with-param name="uri">
                <xsl:copy-of select="$uriseq/uri/*[not(name() = 'file') and not(name() = 'id')]"/>
                <xsl:copy-of select="$name_xml"/>
                <xsl:copy-of select="$uriseq/uri/id"/>
            </xsl:with-param>
        </xsl:call-template>

    </xsl:template>


    <!-- 
        Replace type (e.g. foobar.dita to foobar.html)
    -->
    <xsl:template name="cpm.pathuri.replace_type">

        <xsl:param name="uri"/>

        <xsl:param name="type"/>

        <xsl:variable name="uriseq">
            <xsl:call-template name="cpm.pathuri.parse_uri">
                <xsl:with-param name="uri" select="$uri"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:call-template name="cpm.pathuri.compile_uri">
            <xsl:with-param name="uri">
                <xsl:copy-of select="$uriseq/uri/*[not(name() = 'file') and not(name() = 'id')]"/>
                <file>
                    <xsl:copy-of select="$uriseq/uri/file/name"/>
                    <extension>
                        <xsl:value-of select="$type"/>
                    </extension>
                </file>
                <xsl:copy-of select="$uriseq/uri/id"/>
            </xsl:with-param>
        </xsl:call-template>

    </xsl:template>

    <!-- That's for compatibility with legathy code -->
    <xsl:template name="phs.pathuri.replace_extension">

        <xsl:param name="uri"/>

        <xsl:param name="extension"/>

        <xsl:call-template name="cpm.pathuri.replace_type">
            <xsl:with-param name="uri" select="$uri"/>
            <xsl:with-param name="type" select="$extension"/>
        </xsl:call-template>

    </xsl:template>


    <!-- 
        Returns a relative URI from a file A to a file B 
    -->

    <!-- Perform the job for a sequences -->
    <xsl:template name="cpm.pathuri.get_relative_uri_raw">

        <xsl:param name="source" select="''"/>

        <xsl:param name="target" select="''"/>

        <xsl:variable name="s1" select="$source/*[1]"/>
        <xsl:variable name="d1" select="$target/*[1]"/>

        <xsl:variable name="equal">
            <xsl:choose>
                <xsl:when test="name($source/*[1]) = 'disk'">
                    <xsl:if test="upper-case($s1) = upper-case($d1)">
                        <xsl:text>yes</xsl:text>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="$s1 = $d1">
                        <xsl:text>yes</xsl:text>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$equal = 'yes'">
                <xsl:call-template name="cpm.pathuri.get_relative_uri_raw">
                    <xsl:with-param name="source">
                        <xsl:copy-of select="$source/*[position() > 1]"/>
                    </xsl:with-param>
                    <xsl:with-param name="target">
                        <xsl:copy-of select="$target/*[position() > 1]"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="cpm.pathuri.compile_uri">
                    <xsl:with-param name="uri">
                        <xsl:for-each select="$source/*[position() > 1]">
                            <folder>
                                <xsl:text>..</xsl:text>
                            </folder>
                        </xsl:for-each>
                        <xsl:copy-of select="$target/*"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <!-- Wrapper for strings -->
    <xsl:template name="cpm.pathuri.get_relative_uri">

        <xsl:param name="source"/>

        <xsl:param name="target"/>

        <xsl:variable name="absolute">
            <xsl:call-template name="cpm.pathuri.is_absolute">
                <xsl:with-param name="uri" select="$target"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:choose>

            <xsl:when test="$absolute = ''">
                <xsl:value-of select="$target"/>
            </xsl:when>

            <xsl:otherwise>

                <xsl:variable name="sseq">
                    <xsl:call-template name="cpm.pathuri.parse_uri">
                        <xsl:with-param name="uri" select="$source"/>
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="dseq">
                    <xsl:call-template name="cpm.pathuri.parse_uri">
                        <xsl:with-param name="uri" select="$target"/>
                    </xsl:call-template>
                </xsl:variable>

                <xsl:call-template name="cpm.pathuri.get_relative_uri_raw">
                    <xsl:with-param name="source">
                        <xsl:copy-of select="$sseq/uri/*"/>
                    </xsl:with-param>
                    <xsl:with-param name="target">
                        <xsl:copy-of select="$dseq/uri/*"/>
                    </xsl:with-param>
                </xsl:call-template>

            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>


    <xsl:function name="cpm:pathuri.get_relative_uri">

        <xsl:param name="source"/>

        <xsl:param name="target"/>

        <xsl:call-template name="cpm.pathuri.get_relative_uri">
            <xsl:with-param name="source" select="$source"/>
            <xsl:with-param name="target" select="$target"/>
        </xsl:call-template>

    </xsl:function>


    <!-- 
        Return an absolute URI for a reffered file
    -->

    <!-- A working template -->
    <xsl:template name="cpm.pathuri.get_referred_uri">

        <!-- URI as we see it in a @href attribute -->
        <xsl:param name="href" select="''"/>

        <!-- Initial folder for a relative URI we receive in $href -->
        <!-- 
            Optional. We use an URI of a document we are
            processing now as a default base. 
        -->
        <xsl:param name="base_uri" select="base-uri(/)"/>
        
        <xsl:variable name="actual_base_uri">
           <xsl:value-of select="cpm:pathuri.uri($base_uri)"/>
        </xsl:variable>

        <xsl:if test="cpm:pathuri.is_absolute($actual_base_uri)">

            <xsl:variable name="absolute">
                <xsl:call-template name="cpm.pathuri.is_absolute">
                    <xsl:with-param name="uri" select="$href"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:choose>

                <xsl:when test="$absolute = 'yes'">
                    <xsl:value-of select="$href"/>
                </xsl:when>

                <xsl:otherwise>

                    <xsl:variable name="raw_uri">
                        <xsl:value-of select="resolve-uri($href, $actual_base_uri)"/>
                    </xsl:variable>

                    <xsl:choose>

                        <xsl:when test="contains($raw_uri, 'file:///')">
                            <xsl:value-of select="$raw_uri"/>
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:text>file:///</xsl:text>
                            <xsl:value-of select="substring-after($raw_uri, 'file:/')"/>
                        </xsl:otherwise>

                    </xsl:choose>

                </xsl:otherwise>

            </xsl:choose>

        </xsl:if>

    </xsl:template>

    <!-- A wrapper function -->
    <xsl:function name="cpm:pathuri.get_referred_uri">

        <xsl:param name="base_uri"/>

        <xsl:param name="href"/>

        <xsl:call-template name="cpm.pathuri.get_referred_uri">

            <xsl:with-param name="base_uri" select="$base_uri"/>

            <xsl:with-param name="href" select="$href"/>

        </xsl:call-template>

    </xsl:function>


    <!-- 
        Compare URIs
    -->
    <xsl:template name="cpm.pathuri.equal">

        <xsl:param name="uri1"/>

        <xsl:param name="uri2"/>

        <xsl:param name="platform" select="'bat'"/>

        <xsl:variable name="uri1norm">
            <xsl:call-template name="cpm.pathuri.normalize_uri">
                <xsl:with-param name="uri" select="$uri1"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="uri2norm">
            <xsl:call-template name="cpm.pathuri.normalize_uri">
                <xsl:with-param name="uri" select="$uri2"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="uri1final">
            <xsl:choose>
                <xsl:when test="$platform = 'bat' or $platform = 'windows'">
                    <xsl:value-of select="lower-case($uri1norm)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$uri1norm"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="uri2final">
            <xsl:choose>
                <xsl:when test="$platform = 'bat' or $platform = 'windows'">
                    <xsl:value-of select="lower-case($uri2norm)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$uri2norm"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:if test="$uri1final = $uri2final">
            <xsl:text>yes</xsl:text>
        </xsl:if>

    </xsl:template>


    <!-- 
        Compare URIs beyond IDs
    -->
    <xsl:template name="cpm.pathuri.equal_files">

        <xsl:param name="uri1"/>

        <xsl:param name="uri2"/>

        <xsl:param name="platform" select="'bat'"/>

        <xsl:call-template name="cpm.pathuri.equal">
            <xsl:with-param name="uri1">
                <xsl:call-template name="cpm.pathuri.get_file_uri">
                    <xsl:with-param name="uri" select="$uri1"/>
                </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="uri2">
                <xsl:call-template name="cpm.pathuri.get_file_uri">
                    <xsl:with-param name="uri" select="$uri2"/>
                </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="platform" select="$platform"/>
        </xsl:call-template>

    </xsl:template>


    <!-- 
        Appending a "tail" to a base URI
    -->
    <xsl:function name="cpm:pathuri.join_uri">

        <!-- A base URI -->
        <xsl:param name="baseuri"/>

        <!-- A filename or a partial URI like foo/bar/rasfigar.xml -->
        <xsl:param name="tail"/>

        <!-- 
            TBD: Support for tails containing # and ?
        -->

        <xsl:variable name="tmp">

            <xsl:value-of select="$baseuri"/>

            <xsl:if test="$baseuri != '' and $tail != ''">
                <xsl:text>/</xsl:text>
            </xsl:if>

            <xsl:value-of select="encode-for-uri($tail)"/>

        </xsl:variable>

        <xsl:value-of select="string($tmp)"/>

    </xsl:function>



    <!--
    <xsl:template match="/">
        
        <xsl:call-template name="cpm.pathuri.equal">

            <xsl:with-param name="uri1" select="'file:///c:/foo/bar/../foooo/baarr.txt#tratata'"/>
            <xsl:with-param name="uri2" select="'file:/c:/foo/foooo/baarr.txt#tratata'"/>

        </xsl:call-template>
        
        
        <xsl:call-template name="cpm.pathuri.normalize_uri">
            <xsl:with-param name="uri" select="'file:///c:/foo/bar/../foooo/baaaar/../ttt.txt'"/>
        </xsl:call-template>        

    </xsl:template>
    -->


</xsl:stylesheet>
