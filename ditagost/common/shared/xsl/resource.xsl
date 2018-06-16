<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      Standalone library
        
    Part:       Common  
    Module:     resource.xsl
    
    Scope:      DITA, DITA OT
    
    Func:       Detecting resource topics
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
                
    <!-- 
        Detecting resource topics
    -->
    <xsl:template match="*" mode="is_resource">
        
        <xsl:choose>
            <xsl:when test=".//table[@outputclass = 'docparams']">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
</xsl:stylesheet>