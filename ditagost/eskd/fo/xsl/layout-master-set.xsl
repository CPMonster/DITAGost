<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* --> 
<!--
    Product:    DITA GOST
    
    Level:      DITA OT customization, shared files
        
    Part:       Page Layouts    
    Module:     layout-master-set.xsl
    
    Scope:      DITA, DITA OT, Russian, ESKD
    
    Func:       Defining page layouts and section layouts
-->   
<!-- * * ** *** ***** ******** ************* ********************* -->  
<xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <!-- 
        Assembling FO master page sequences definition
    -->
    <xsl:template match="node()" mode="cpm.fastcust.layout_master_set">

        <fo:layout-master-set>

            <!-- ================ -->
            <!--  Long documents  -->
            <!-- ================ -->

            <!-- 
                Master pages
            -->

            <!-- Portrait A4, a cover page -->
            <fo:simple-page-master master-name="ESKD.Cover.A4.Unique" page-width="210mm"
                page-height="297mm" margin-right="20mm">
                <fo:region-body margin-top="20mm" margin-bottom="60mm"
                    margin-left="30mm"/>
                <fo:region-before region-name="Cover-first-before" extent="20mm"/>
                <fo:region-after  region-name="Cover-first-after" extent="20mm"/>
                <fo:region-start region-name="Cover-first-start" extent="30mm"/>
            </fo:simple-page-master>

            <!-- Portrait A4, TOC, the 1st page -->
            <fo:simple-page-master master-name="ESKD.TOC.A4.First" page-width="210mm"
                page-height="297mm">
                <fo:region-body margin-top="20mm" margin-right="20mm" margin-bottom="60mm"
                    margin-left="30mm"/>
                <fo:region-before region-name="TOC-first-before" extent="20mm"/>
                <fo:region-start region-name="TOC-first-start" extent="20mm"/>
            </fo:simple-page-master>

            <!--  Portrait А4, a regular page -->
            <fo:simple-page-master master-name="ESKD.Text.A4.Portrait.Regular" page-width="210mm"
                page-height="297mm" margin-top="10mm" margin-right="20mm">
                <fo:region-body margin-top="30mm" margin-bottom="30mm"
                    margin-left="30mm"/>
                <fo:region-before region-name="A4-portrait-before"
                     extent="20mm"/>
                <fo:region-start region-name="A4-portrait-start" extent="30mm"/>
            </fo:simple-page-master>

            <!-- Portrait A4, a rotated regular page -->
            <fo:simple-page-master master-name="ESKD.Text.A4.PortraitRotated.Regular"
                page-width="297mm" page-height="210mm">
                <fo:region-body margin-top="30mm" margin-right="30mm" margin-bottom="30mm"
                    margin-left="30mm" reference-orientation="90"/>
                <fo:region-start region-name="A4-portrait-start" extent="30mm"/>
            </fo:simple-page-master>


            <!-- 
                Master sections
            -->

            <!-- A cover page section -->
            <fo:page-sequence-master master-name="ESKD.Cover.A4">
                <fo:single-page-master-reference master-reference="ESKD.Cover.A4.Unique"/>
            </fo:page-sequence-master>

            <!-- A TOC section with an irregular 1st page -->
            <fo:page-sequence-master master-name="ESKD.TOC.A4">
                <fo:repeatable-page-master-alternatives>
                    <fo:conditional-page-master-reference master-reference="ESKD.TOC.A4.First"
                        page-position="first"/>
                    <fo:conditional-page-master-reference
                        master-reference="ESKD.Text.A4.Portrait.Regular" page-position="rest"/>
                </fo:repeatable-page-master-alternatives>
            </fo:page-sequence-master>

            <!-- A regular portrait A4 section -->
            <fo:page-sequence-master master-name="ESKD.Text.A4.Portrait">
                <fo:single-page-master-reference master-reference="ESKD.Text.A4.Portrait.Regular"/>
            </fo:page-sequence-master>

            <!-- A regular rotated A4 section -->
            <fo:page-sequence-master master-name="ESKD.Text.A4.PortraitRotated">
                <fo:single-page-master-reference
                    master-reference="ESKD.Text.A4.PortraitRotated.Regular"/>
            </fo:page-sequence-master>



            <!-- ==== -->
            <!--  LU  -->
            <!-- ==== -->

            <!-- A LU master section -->
            <fo:page-sequence-master master-name="LU">
                <fo:repeatable-page-master-alternatives>
                    <fo:conditional-page-master-reference master-reference="ESKD.Cover.A4.Unique"
                        page-position="first"/>
                    <fo:conditional-page-master-reference
                        master-reference="ESKD.Text.A4.Portrait.Regular" page-position="rest"/>
                </fo:repeatable-page-master-alternatives>
            </fo:page-sequence-master>

        </fo:layout-master-set>

    </xsl:template>

</xsl:stylesheet>
