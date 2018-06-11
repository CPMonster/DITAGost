<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    CopyPaste Monster   
    Level:      Library
    
    Part:       DITA
    Module:     docparams.xsl 
    
    Scope:      DITA
    
    Func:       Working with named values that are defined in 
                content using tables, etc.
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->

    <!-- Translit -->
    <xsl:import href="../../common/xsl-2.0/translit.xsl"/>



    <!-- ================ -->
    <!--  Testing tables  -->
    <!-- ================ -->

    <!-- 
        Taking a row that contains column captions
    -->

    <!-- Doing this for a tgroup -->
    <xsl:template match="tgroup" mode="cpm.dita.colcaprow">
        
        <xsl:choose>
            <xsl:when test="thead">
                <xsl:copy-of select="thead/row[1]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="tbody/row[1]"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!-- Doing this for a table -->
    <xsl:template match="table" mode="cpm.dita.colcaprow">
        <xsl:apply-templates select="tgroup[1]" mode="cpm.dita.colcaprow"/>
    </xsl:template>


    <!-- 
        Taking a column that contains row captions
    -->

    <!-- Doing this for a tgroup -->
    <xsl:template match="tgroup" mode="cpm.dita.rowcapcol">

        <column>
            <xsl:copy-of select="tbody/row/entry[1]"/>
        </column>

    </xsl:template>

    <!-- Doing this for a table -->
    <xsl:template match="table" mode="cpm.dita.cpm.dita.rowcapcol">
        <xsl:apply-templates select="tgroup[1]" mode="cpm.dita.rowcapcol"/>
    </xsl:template>


    <!-- 
        Are all the caps belong to a row or a column? 
    -->
    <xsl:function name="cpm:dita.testcaps" as="xs:boolean">

        <!-- Entries containing captions -->
        <xsl:param name="entries"/>

        <!-- A list of strings separated by , or ; -->
        <xsl:param name="caps"/>

        <!-- Detecting a separator character -->
        <xsl:variable name="sep">
            <xsl:choose>
                <xsl:when test="contains($caps, ';')">
                    <xsl:text>;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>,</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- Assembling a regexp for going over captions -->
        <xsl:variable name="regexp">
            <xsl:text>[^</xsl:text>
            <xsl:value-of select="$sep"/>
            <xsl:text>]+</xsl:text>
        </xsl:variable>

        <!-- Collecting captions standing out of a row or a column -->
        <xsl:variable name="tmp">
            <xsl:analyze-string select="$caps" regex="{$regexp}">
                <xsl:matching-substring>
                    <xsl:variable name="cap" select="."/>
                    <xsl:if test="not($entries//entry[cpm:translit.eqht(., $cap)])">
                        <xsl:value-of select="."/>
                    </xsl:if>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </xsl:variable>

        <!-- If each caption has been found then true  -->
        <xsl:value-of select="boolean($tmp = '')"/>

    </xsl:function>


    <!-- 
        Does a table have all the given column captions?
    -->
    <xsl:function name="cpm:dita.testcols" as="xs:boolean">

        <!-- A table or a tgroup element -->
        <xsl:param name="element"/>

        <!-- A list of column captions -->
        <xsl:param name="colcaps"/>

        <xsl:variable name="colcaprow">
            <xsl:apply-templates select="$element" mode="cpm.dita.colcaprow"/>
        </xsl:variable>

        <xsl:value-of select="cpm:dita.testcaps($colcaprow, $colcaps)"/>

    </xsl:function>


    <!-- 
        Does a table have given row captions?
    -->
    <xsl:function name="cpm:dita.testrows" as="xs:boolean">

        <!-- A table or a tgroup element -->
        <xsl:param name="element"/>

        <!-- A list of column captions -->
        <xsl:param name="rowcaps"/>

        <xsl:variable name="rowcapcol">
            <xsl:apply-templates select="$element" mode="cpm.dita.rowcapcol"/>
        </xsl:variable>
        
        <!--
        <xsl:message>
            <xsl:text>::: </xsl:text>            
            <xsl:copy-of select="$rowcapcol"/>
        </xsl:message>
        -->

        <xsl:value-of select="cpm:dita.testcaps($rowcapcol, $rowcaps)"/>

    </xsl:function>



    <!-- ================================ -->
    <!--  Retrieving values from columns  -->
    <!-- ================================ -->

    <!-- 
        Calculating a column position by a column caption
    -->
    <xsl:function name="cpm:dita.colpos">

        <!-- A row element -->
        <xsl:param name="row"/>

        <!-- A column caption -->
        <xsl:param name="colcap"/>

        <!-- Taking a row containing column captions  -->
        <xsl:variable name="colcaprow">
            <xsl:apply-templates select="$row/ancestor::tgroup[1]" mode="cpm.dita.colcaprow"/>
        </xsl:variable>        

        <xsl:choose>
            <xsl:when test="$colcaprow/row/entry[cpm:translit.eqht(., $colcap)]">
                <xsl:value-of
                    select="count($colcaprow/row/entry[cpm:translit.eqht(., $colcap)]/preceding-sibling::*) + 1"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="0"/>
            </xsl:otherwise>
        </xsl:choose>                

    </xsl:function>


    <!-- 
        Retrieving a column value by a column caption
    -->
    <xsl:function name="cpm:dita.colval">

        <!-- A row element (Native only! A variable is not allowed here!) -->
        <xsl:param name="row"/>

        <!-- A column caption -->
        <xsl:param name="colcap"/>

        <xsl:variable name="colpos">
            <xsl:value-of select="cpm:dita.colpos($row, $colcap)"/>
        </xsl:variable>

        <xsl:value-of select="normalize-space($row/entry[position() = $colpos])"/>

    </xsl:function>



    <!-- ============================= -->
    <!--  Retrieving values from rows  -->
    <!-- ============================= -->

    <!-- 
        An row is a row that consists of two entries: 
        a caption and a value. More columns may present 
        in a table optionally 
    -->

    <!-- 
        Retrieving a parameter value from a table
    -->
    <xsl:function name="cpm:dita.rowval">

        <!-- A table element -->
        <xsl:param name="element"/>

        <!-- A parameter label -->
        <xsl:param name="rowcap"/>

        <!-- Retrieving a parmeter value -->
        <xsl:variable name="tmp">
            <xsl:value-of select="$element//row[cpm:translit.eqht(entry[1], $rowcap)]/entry[2]"/>
        </xsl:variable>

        <!-- Returning a value -->
        <xsl:value-of select="normalize-space($tmp)"/>

    </xsl:function>



    <!-- ======= -->
    <!--  DEBUG  -->
    <!-- ======= -->
    <!--
    <xsl:template match="/">

        <xsl:variable name="table">
            <table>
                <tgroup>
                    <thead>
                        <row>
                            <entry>Вид</entry>
                            <entry>Имя</entry>
                            <entry>Цвет</entry>
                            <entry>Примечания</entry>
                        </row>
                    </thead>
                    <tbody>
                        <row>
                            <entry>Кошка</entry>
                            <entry>Мурка</entry>
                            <entry>Белая</entry>
                            <entry>Любит сметану</entry>
                        </row>
                        <row>
                            <entry>Крокодил</entry>
                            <entry>Гена</entry>
                            <entry>Зеленый</entry>
                            <entry>Съел Чебурашку</entry>
                        </row>
                    </tbody>
                </tgroup>
            </table>
        </xsl:variable>

        <xsl:variable name="docparams">
            <table>
                <tgroup>
                    <thead>
                        <row>
                            <entry>Параметр</entry>
                            <entry>Значение</entry>
                        </row>
                    </thead>
                    <tbody>
                        <row>
                            <entry>Изделие</entry>
                            <entry>Бурбулятор</entry>
                        </row>
                        <row>
                            <entry>Документ</entry>
                            <entry>Руководство раскумарщика</entry>
                        </row>
                    </tbody>
                </tgroup>
            </table>

        </xsl:variable>

        <xsl:value-of select="cpm:dita.rowval($docparams/table, 'Изделие')"/>        
        <xsl:value-of select="cpm:dita.testcols($table//table, ' Цвет, Имя')"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="cpm:dita.colval($table//tbody/row[2], ' цвет')"/>
                      
    </xsl:template>
    -->

</xsl:stylesheet>
