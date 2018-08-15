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
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Modules
    -->
    
    <xsl:import href="queries-structure.xsl"/>  
    <xsl:import href="queries-numbers.xsl"/>
    <xsl:import href="queries-crossrefs.xsl"/>   
    <xsl:import href="queries-tocton.xsl"/>

</xsl:stylesheet>
