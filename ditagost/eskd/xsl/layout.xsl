<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:cpm="http://cpmonster.com/xmlns/cpm"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0">
   <xsl:import href="layout-master-set.xsl"/>
   <xsl:template name="cpm.fastcust.get_master_name">
      <xsl:param name="master_alias"/>
      <xsl:choose>
         <xsl:when test="$master_alias='LU'">
            <xsl:text>LU</xsl:text>
         </xsl:when>
         <xsl:when test="$master_alias='ESKD.Cover'">
            <xsl:text>ESKD.Cover.A4</xsl:text>
         </xsl:when>
         <xsl:when test="$master_alias='ESKD.TOC'">
            <xsl:text>ESKD.TOC.A4</xsl:text>
         </xsl:when>
         <xsl:when test="$master_alias='ESKD.Content.Portrait'">
            <xsl:text>ESKD.Text.A4.Portrait</xsl:text>
         </xsl:when>
         <xsl:when test="$master_alias='ESKD.Content.PortraitRotated'">
            <xsl:text>ESKD.Text.A4.PortraitRotated</xsl:text>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <!-- Базовый -->
<xsl:attribute-set name="Bazovyi">
      <xsl:attribute name="line-height">16pt</xsl:attribute>
      <xsl:attribute name="font-family">GOST type B</xsl:attribute>
      <xsl:attribute name="font-size">14pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Блок основного текста -->
<xsl:attribute-set name="Blok_osnovnogo_teksta" use-attribute-sets="Bazovyi">
      <xsl:attribute name="margin-top">0.21cm</xsl:attribute>
      <xsl:attribute name="margin-bottom">0.21cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Основной шрифт -->
<xsl:attribute-set name="Osnovnoi_wrift"/>
   <!-- header_subject -->
<xsl:attribute-set name="header_subject" use-attribute-sets="Bazovyi">
      <xsl:attribute name="font-size">9pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- header_pagenumber -->
<xsl:attribute-set name="header_pagenumber" use-attribute-sets="Bazovyi">
      <xsl:attribute name="font-size">14pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пустой заголовок -->
<xsl:attribute-set name="Pustoi_zagolovok" use-attribute-sets="Bazovyi">
      <xsl:attribute name="font-size">1pt</xsl:attribute>
      <xsl:attribute name="color">#ffffff</xsl:attribute>
      <xsl:attribute name="line-height">1pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок базовый -->
<xsl:attribute-set name="Zagolovok_bazovyi" use-attribute-sets="Bazovyi">
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок центрированный -->
<xsl:attribute-set name="Zagolovok_centrirovannyi" use-attribute-sets="Zagolovok_bazovyi">
      <xsl:attribute name="text-align">center</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок с отступом -->
<xsl:attribute-set name="Zagolovok_s_otstupom" use-attribute-sets="Zagolovok_bazovyi">
      <xsl:attribute name="text-align">left</xsl:attribute>
      <xsl:attribute name="margin-left">1.63cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок перечня -->
<xsl:attribute-set name="Zagolovok_perecna" use-attribute-sets="Zagolovok_bazovyi">
      <xsl:attribute name="font-size">18pt</xsl:attribute>
      <xsl:attribute name="text-transform">uppercase</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="margin-left">0pt</xsl:attribute>
      <xsl:attribute name="line-height">20pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">20pt</xsl:attribute>
      <xsl:attribute name="page-break-before">always</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок без нумерации 1 -->
<xsl:attribute-set name="Zagolovok_bez_numeracii_1" use-attribute-sets="Zagolovok_bazovyi">
      <xsl:attribute name="color">#005EB8</xsl:attribute>
      <xsl:attribute name="font-size">18pt</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
      <xsl:attribute name="line-height">22pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">22pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок без нумерации 2 -->
<xsl:attribute-set name="Zagolovok_bez_numeracii_2" use-attribute-sets="Zagolovok_bazovyi">
      <xsl:attribute name="font-size">16pt</xsl:attribute>
      <xsl:attribute name="line-height">20pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">20pt</xsl:attribute>
      <xsl:attribute name="margin-top">20pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 1 -->
<xsl:attribute-set name="Zagolovok_1" use-attribute-sets="Zagolovok_centrirovannyi">
      <xsl:attribute name="font-size">18pt</xsl:attribute>
      <xsl:attribute name="text-transform">uppercase</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
      <xsl:attribute name="line-height">22pt</xsl:attribute>
      <xsl:attribute name="page-break-before">always</xsl:attribute>
      <xsl:attribute name="margin-bottom">22pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 2 -->
<xsl:attribute-set name="Zagolovok_2" use-attribute-sets="Zagolovok_s_otstupom">
      <xsl:attribute name="font-size">18pt</xsl:attribute>
      <xsl:attribute name="font-variant">small-caps</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
      <xsl:attribute name="line-height">22pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">22pt</xsl:attribute>
      <xsl:attribute name="margin-top">22pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 3 -->
<xsl:attribute-set name="Zagolovok_3" use-attribute-sets="Zagolovok_s_otstupom">
      <xsl:attribute name="font-size">18pt</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
      <xsl:attribute name="line-height">22pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">22pt</xsl:attribute>
      <xsl:attribute name="margin-top">22pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 4 -->
<xsl:attribute-set name="Zagolovok_4" use-attribute-sets="Zagolovok_s_otstupom">
      <xsl:attribute name="font-size">16pt</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
      <xsl:attribute name="line-height">19pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">19pt</xsl:attribute>
      <xsl:attribute name="margin-top">19pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 5 -->
<xsl:attribute-set name="Zagolovok_5" use-attribute-sets="Zagolovok_s_otstupom">
      <xsl:attribute name="font-size">16pt</xsl:attribute>
      <xsl:attribute name="keep-together">always</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
      <xsl:attribute name="line-height">19pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">19pt</xsl:attribute>
      <xsl:attribute name="margin-top">19pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 6 -->
<xsl:attribute-set name="Zagolovok_6" use-attribute-sets="Zagolovok_s_otstupom">
      <xsl:attribute name="font-size">16pt</xsl:attribute>
      <xsl:attribute name="keep-together">always</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
      <xsl:attribute name="line-height">19pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">19pt</xsl:attribute>
      <xsl:attribute name="margin-top">19pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Основной -->
<xsl:attribute-set name="Osnovnoi" use-attribute-sets="Blok_osnovnogo_teksta">
      <xsl:attribute name="text-indent">1.63cm</xsl:attribute>
      <xsl:attribute name="line-height">21pt</xsl:attribute>
      <xsl:attribute name="text-align">justify</xsl:attribute>
   </xsl:attribute-set>
   <!-- Список -->
<xsl:attribute-set name="Spisok" use-attribute-sets="Blok_osnovnogo_teksta"/>
   <!-- Главный список -->
<xsl:attribute-set name="Glavnyi_spisok" use-attribute-sets="Spisok"/>
   <!-- Главный список в таблице -->
<xsl:attribute-set name="Glavnyi_spisok_v_tablice" use-attribute-sets="Spisok"/>
   <!-- Вложенный список -->
<xsl:attribute-set name="Vlojennyi_spisok" use-attribute-sets="Spisok">
      <xsl:attribute name="margin-top">0cm</xsl:attribute>
      <xsl:attribute name="margin-bottom">0cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пункт списка -->
<xsl:attribute-set name="Punkt_spiska"/>
   <!-- Первый пункт списка -->
<xsl:attribute-set name="Pervyi_punkt_spiska" use-attribute-sets="Punkt_spiska"/>
   <!-- Непервый пункт списка -->
<xsl:attribute-set name="Nepervyi_punkt_spiska" use-attribute-sets="Punkt_spiska">
      <xsl:attribute name="margin-top">0.21cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пункт списка. Текст -->
<xsl:attribute-set name="Punkt_spiska._Tekst" use-attribute-sets="Bazovyi">
      <xsl:attribute name="line-height">21pt</xsl:attribute>
      <xsl:attribute name="text-align">justify</xsl:attribute>
   </xsl:attribute-set>
   <!-- Маркер списка. Текст -->
<xsl:attribute-set name="Marker_spiska._Tekst" use-attribute-sets="Bazovyi">
      <xsl:attribute name="line-height">21pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пункт списка 1. Текст -->
<xsl:attribute-set name="Punkt_spiska_1._Tekst" use-attribute-sets="Punkt_spiska._Tekst">
      <xsl:attribute name="start-indent">0.45cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пункт списка 2. Текст -->
<xsl:attribute-set name="Punkt_spiska_2._Tekst" use-attribute-sets="Punkt_spiska._Tekst">
      <xsl:attribute name="start-indent">0.90cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пункт списка 3. Текст -->
<xsl:attribute-set name="Punkt_spiska_3._Tekst" use-attribute-sets="Punkt_spiska._Tekst">
      <xsl:attribute name="start-indent">1.35cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Пункт списка. Текст -->
<xsl:attribute-set name="Tablica._Punkt_spiska._Tekst" use-attribute-sets="Bazovyi">
      <xsl:attribute name="text-align">left</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Маркер списка. Текст -->
<xsl:attribute-set name="Tablica._Marker_spiska._Tekst" use-attribute-sets="Bazovyi"/>
   <!-- Таблица. Пункт списка 1. Текст -->
<xsl:attribute-set name="Tablica._Punkt_spiska_1._Tekst"
                      use-attribute-sets="Tablica._Punkt_spiska._Tekst">
      <xsl:attribute name="start-indent">0.45cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Пункт списка 2. Текст -->
<xsl:attribute-set name="Tablica._Punkt_spiska_2._Tekst"
                      use-attribute-sets="Tablica._Punkt_spiska._Tekst">
      <xsl:attribute name="start-indent">0.90cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Пункт списка 3. Текст -->
<xsl:attribute-set name="Tablica._Punkt_spiska_3._Tekst"
                      use-attribute-sets="Tablica._Punkt_spiska._Tekst">
      <xsl:attribute name="start-indent">1.35cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Рисунок -->
<xsl:attribute-set name="Risunok" use-attribute-sets="Blok_osnovnogo_teksta">
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="keep-together">always</xsl:attribute>
   </xsl:attribute-set>
   <!-- Рисунок. Изображение -->
<xsl:attribute-set name="Risunok._Izobrajenie" use-attribute-sets="Bazovyi">
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="margin-top">16pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">16pt</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
   </xsl:attribute-set>
   <!-- Рисунок. Подпись -->
<xsl:attribute-set name="Risunok._Podpisx" use-attribute-sets="Osnovnoi">
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="line-height">13pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">13pt</xsl:attribute>
      <xsl:attribute name="margin-top">13pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Рисунок. Описание -->
<xsl:attribute-set name="Risunok._Opisanie" use-attribute-sets="Risunok._Podpisx">
      <xsl:attribute name="font-size">10pt</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="line-height">13pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица -->
<xsl:attribute-set name="Tablica" use-attribute-sets="Bazovyi">
      <xsl:attribute name="text-align">left</xsl:attribute>
      <xsl:attribute name="text-indent">0cm</xsl:attribute>
      <xsl:attribute name="start-indent">0cm</xsl:attribute>
      <xsl:attribute name="border-style">solid</xsl:attribute>
      <xsl:attribute name="border-width">1pt</xsl:attribute>
      <xsl:attribute name="border-color">#000000</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Название -->
<xsl:attribute-set name="Tablica._Nazvanie" use-attribute-sets="Bazovyi">
      <xsl:attribute name="text-align">right</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
      <xsl:attribute name="line-height">15pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">4pt</xsl:attribute>
      <xsl:attribute name="margin-top">15pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Шапка -->
<xsl:attribute-set name="Tablica._Wapka" use-attribute-sets="Bazovyi">
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
      <xsl:attribute name="line-height">15pt</xsl:attribute>
      <xsl:attribute name="hyphenate">true</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Строка -->
<xsl:attribute-set name="Tablica._Stroka" use-attribute-sets="Bazovyi"/>
   <!-- Таблица. Пустая строка -->
<xsl:attribute-set name="Tablica._Pustaa_stroka" use-attribute-sets="Tablica._Stroka">
      <xsl:attribute name="height">18pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Ячейка -->
<xsl:attribute-set name="Tablica._Aceika" use-attribute-sets="Tablica._Stroka">
      <xsl:attribute name="line-height">14pt</xsl:attribute>
      <xsl:attribute name="padding-left">2.85pt</xsl:attribute>
      <xsl:attribute name="padding-right">2.85pt</xsl:attribute>
      <xsl:attribute name="padding-bottom">4pt</xsl:attribute>
      <xsl:attribute name="padding-top">4pt</xsl:attribute>
      <xsl:attribute name="border-style">solid</xsl:attribute>
      <xsl:attribute name="border-width">1pt</xsl:attribute>
      <xsl:attribute name="border-color">#000000</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Подзаголовок -->
<xsl:attribute-set name="Tablica._Podzagolovok" use-attribute-sets="Tablica._Aceika"/>
   <!-- Таблица. Номер строки -->
<xsl:attribute-set name="Tablica._Nomer_stroki" use-attribute-sets="Tablica._Podzagolovok"/>
   <!-- Таблица. Итог по строке -->
<xsl:attribute-set name="Tablica._Itog_po_stroke" use-attribute-sets="Tablica._Aceika">
      <xsl:attribute name="border-left-style">solid</xsl:attribute>
      <xsl:attribute name="border-left-width">1pt</xsl:attribute>
      <xsl:attribute name="border-left-color">#000000</xsl:attribute>
   </xsl:attribute-set>
   <!-- ВНИМАНИЕ -->
<xsl:attribute-set name="VNIMANIE" use-attribute-sets="Osnovnoi">
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
   </xsl:attribute-set>
   <!-- Листинг -->
<xsl:attribute-set name="Listing" use-attribute-sets="Bazovyi">
      <xsl:attribute name="font-family">Courier New</xsl:attribute>
      <xsl:attribute name="font-size">10pt</xsl:attribute>
      <xsl:attribute name="margin-top">18pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">18pt</xsl:attribute>
      <xsl:attribute name="text-align">start</xsl:attribute>
      <xsl:attribute name="wrap-option">no-wrap</xsl:attribute>
      <xsl:attribute name="white-space-collapse">false</xsl:attribute>
      <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
      <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
   </xsl:attribute-set>
   <!-- Форма -->
<xsl:attribute-set name="Forma" use-attribute-sets="Blok_osnovnogo_teksta">
      <xsl:attribute name="keep-together.within-page">always</xsl:attribute>
      <xsl:attribute name="margin-top">18pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">18pt</xsl:attribute>
      <xsl:attribute name="padding">14pt</xsl:attribute>
      <xsl:attribute name="text-indent">0</xsl:attribute>
      <xsl:attribute name="text-align">left</xsl:attribute>
      <xsl:attribute name="border-style">solid</xsl:attribute>
      <xsl:attribute name="border-width">1pt</xsl:attribute>
      <xsl:attribute name="border-color">#000000</xsl:attribute>
   </xsl:attribute-set>
   <!-- Абзац в форме -->
<xsl:attribute-set name="Abzac_v_forme" use-attribute-sets="Bazovyi">
      <xsl:attribute name="font-size">11pt</xsl:attribute>
      <xsl:attribute name="text-align">left</xsl:attribute>
   </xsl:attribute-set>
   <!-- Приложение. Заголовок -->
<xsl:attribute-set name="Prilojenie._Zagolovok" use-attribute-sets="Bazovyi">
      <xsl:attribute name="font-size">18pt</xsl:attribute>
      <xsl:attribute name="text-transform">uppercase</xsl:attribute>
      <xsl:attribute name="page-break-before">always</xsl:attribute>
      <xsl:attribute name="margin-bottom">9pt</xsl:attribute>
      <xsl:attribute name="text-align">right</xsl:attribute>
   </xsl:attribute-set>
   <!-- Титул -->
<xsl:attribute-set name="Titul" use-attribute-sets="Bazovyi">
      <xsl:attribute name="font-size">14pt</xsl:attribute>
      <xsl:attribute name="margin-top">14pt</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
   </xsl:attribute-set>
   <!-- Титул. Утвержден -->
<xsl:attribute-set name="Titul._Utverjden" use-attribute-sets="Titul">
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="margin-top">1cm</xsl:attribute>
      <xsl:attribute name="margin-right">11cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Титул. ЛУ -->
<xsl:attribute-set name="Titul._LU" use-attribute-sets="Titul">
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="margin-right">11cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Титул. Центр -->
<xsl:attribute-set name="Titul._Centr" use-attribute-sets="Titul">
      <xsl:attribute name="font-size">14pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">14pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Титул. Заголовок -->
<xsl:attribute-set name="Titul._Zagolovok" use-attribute-sets="Titul._Centr">
      <xsl:attribute name="font-size">24pt</xsl:attribute>
      <xsl:attribute name="margin-top">7cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Титул. Подзаголовок -->
<xsl:attribute-set name="Titul._Podzagolovok" use-attribute-sets="Titul._Centr"/>
   <!-- Титул. Обозначение -->
<xsl:attribute-set name="Titul._Oboznacenie" use-attribute-sets="Titul._Centr"/>
   <!-- Титул. Страницы -->
<xsl:attribute-set name="Titul._Stranicy" use-attribute-sets="Titul._Centr"/>
   <!-- Титул. Год -->
<xsl:attribute-set name="Titul._God" use-attribute-sets="Titul"/>
   <!-- Оглавление. Заголовок -->
<xsl:attribute-set name="Oglavlenie._Zagolovok" use-attribute-sets="Zagolovok_centrirovannyi">
      <xsl:attribute name="font-size">18pt</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="line-height">22pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">12pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Оглавление. Точки -->
<xsl:attribute-set name="Oglavlenie._Tocki">
      <xsl:attribute name="leader-pattern">dots</xsl:attribute>
      <xsl:attribute name="leader-length.maximum">20cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Оглавление -->
<xsl:attribute-set name="Oglavlenie" use-attribute-sets="Bazovyi">
      <xsl:attribute name="text-align">justify</xsl:attribute>
      <xsl:attribute name="text-align-last">justify</xsl:attribute>
      <xsl:attribute name="margin-bottom">7pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Оглавление 0 -->
<xsl:attribute-set name="Oglavlenie_0" use-attribute-sets="Oglavlenie"/>
   <!-- Оглавление 1 -->
<xsl:attribute-set name="Oglavlenie_1" use-attribute-sets="Oglavlenie">
      <xsl:attribute name="text-transform">uppercase</xsl:attribute>
   </xsl:attribute-set>
   <!-- Оглавление 2 -->
<xsl:attribute-set name="Oglavlenie_2" use-attribute-sets="Oglavlenie">
      <xsl:attribute name="margin-left">14.15pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Оглавление 3 -->
<xsl:attribute-set name="Oglavlenie_3" use-attribute-sets="Oglavlenie">
      <xsl:attribute name="margin-left">28.3pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">6pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Строка списка -->
<xsl:attribute-set name="Stroka_spiska" use-attribute-sets="Oglavlenie"/>
   <!-- ЛРИ. Шапка -->
<xsl:attribute-set name="LRI._Wapka" use-attribute-sets="Bazovyi">
      <xsl:attribute name="font-size">9pt</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="border-style">solid</xsl:attribute>
      <xsl:attribute name="border-width">1pt</xsl:attribute>
      <xsl:attribute name="border-color">#000000</xsl:attribute>
   </xsl:attribute-set>
   <!-- ЛРИ. Ячейка -->
<xsl:attribute-set name="LRI._Aceika" use-attribute-sets="Bazovyi">
      <xsl:attribute name="font-size">12pt</xsl:attribute>
      <xsl:attribute name="height">12pt</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="border-style">solid</xsl:attribute>
      <xsl:attribute name="border-width">1pt</xsl:attribute>
      <xsl:attribute name="border-color">#000000</xsl:attribute>
   </xsl:attribute-set>
   <!-- ЛРИ. Строка -->
<xsl:attribute-set name="LRI._Stroka" use-attribute-sets="Bazovyi">
      <xsl:attribute name="height">12pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Термин -->
<xsl:attribute-set name="Termin" use-attribute-sets="Osnovnoi_wrift">
      <xsl:attribute name="font-style">italic</xsl:attribute>
   </xsl:attribute-set>
   <!-- Файл -->
<xsl:attribute-set name="Fail" use-attribute-sets="Osnovnoi_wrift">
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>
   <!-- Меню -->
<xsl:attribute-set name="Menq" use-attribute-sets="Osnovnoi_wrift">
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пользовательский ввод -->
<xsl:attribute-set name="Polxzovatelxskii_vvod" use-attribute-sets="Osnovnoi_wrift">
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>
   <!-- Код в строке -->
<xsl:attribute-set name="Kod_v_stroke" use-attribute-sets="Osnovnoi_wrift">
      <xsl:attribute name="font-family">Courier New</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>
   <!-- Кнопки и все такое -->
<xsl:attribute-set name="Knopki_i_vse_takoe" use-attribute-sets="Osnovnoi_wrift">
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>
   <!-- Цитата в строке -->
<xsl:attribute-set name="Citata_v_stroke" use-attribute-sets="Osnovnoi_wrift">
      <xsl:attribute name="font-style">italic</xsl:attribute>
   </xsl:attribute-set>
   <xsl:template match="p[cpm:oclass(.)='cover.approved']" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.LU']" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.title']" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.subtitle']" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.docnumber']" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.pages']" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.year']" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='auxiliary']" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='intro']"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and cpm:sectype(.)='intro']"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and cpm:sectype(.)='intro']"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and cpm:sectype(.)='intro']"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=5 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=6 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='slacking']" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='appendix']"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=5 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=6 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='toctopic']" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='tontopic']" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="fo:leader" mode="cpm.fastcust.foname">
      <xsl:text>fo:leader</xsl:text>
   </xsl:template>
   <xsl:template match="fo:block[cpm:numlevel(.)=0 and cpm:oclass(.)='tocentry']"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="fo:block[cpm:numlevel(.)=1 and cpm:oclass(.)='tocentry']"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="fo:block[cpm:numlevel(.)=2 and cpm:oclass(.)='tocentry']"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="fo:block[cpm:numlevel(.)=3 and cpm:oclass(.)='tocentry']"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="*[cpm:eclass(., 'topic/body')]//p[not(@outputclass) and not(ancestor::entry)]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="section/title" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="tgroup" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)!='appendix']//table/title" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='appendix']//table/title" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="thead/row" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="table[not(@outputclass)]//entry" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="table[not(@outputclass)]//entry[@outputclass='subtitle']"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="tbody//entry[position()=1 and ../../../thead/row/entry[1]/@outputclass='number']"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="tbody//entry[count(following-sibling::*)=0 and ../../../thead/row/entry[last()]/@outputclass='total']"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="fig" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='main']//fig/title" mode="cpm.fastcust.foname">
      <xsl:text/>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='appendix']//fig/title" mode="cpm.fastcust.foname">
      <xsl:text/>
   </xsl:template>
   <xsl:template match="fo:block[cpm:oclass(.)='image']" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="image" mode="cpm.fastcust.foname">
      <xsl:text>fo:external-graphic</xsl:text>
   </xsl:template>
   <xsl:template match="fig/p" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="fo:list-item-label/fo:block[not(@role)]" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=1 and not(@role)]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:list-item-body</xsl:text>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=2 and not(@role)]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:list-item-body</xsl:text>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=3 and not(@role)]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:list-item-body</xsl:text>
   </xsl:template>
   <xsl:template match="fo:list-item-label/fo:block[@role='table']" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=1 and @role='table']"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:list-item-body</xsl:text>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=2 and @role='table']"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:list-item-body</xsl:text>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=3 and @role='table']"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:list-item-body</xsl:text>
   </xsl:template>
   <xsl:template match="ul" mode="cpm.fastcust.foname">
      <xsl:text>fo:list-block</xsl:text>
   </xsl:template>
   <xsl:template match="ul[ancestor::li]|ul[ancestor::entry and not(preceding-sibling::*)]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:list-block</xsl:text>
   </xsl:template>
   <xsl:template match="ul/li[not(ancestor::li) and position()=1]" mode="cpm.fastcust.foname">
      <xsl:text>cpm:none</xsl:text>
   </xsl:template>
   <xsl:template match="ul/li[ancestor::li or position()!=1]" mode="cpm.fastcust.foname">
      <xsl:text>cpm:none</xsl:text>
   </xsl:template>
   <xsl:template match="ol" mode="cpm.fastcust.foname">
      <xsl:text>fo:list-block</xsl:text>
   </xsl:template>
   <xsl:template match="ol[ancestor::li]|ol[ancestor::entry and not(preceding-sibling::*)]"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:list-block</xsl:text>
   </xsl:template>
   <xsl:template match="ol/li[not(ancestor::li) and position()=1]" mode="cpm.fastcust.foname">
      <xsl:text>cpm:none</xsl:text>
   </xsl:template>
   <xsl:template match="ol/li[ancestor::li or position()!=1]" mode="cpm.fastcust.foname">
      <xsl:text>cpm:none</xsl:text>
   </xsl:template>
   <xsl:template match="steps" mode="cpm.fastcust.foname">
      <xsl:text>fo:list-block</xsl:text>
   </xsl:template>
   <xsl:template match="step[position()=1]" mode="cpm.fastcust.foname">
      <xsl:text>cpm:none</xsl:text>
   </xsl:template>
   <xsl:template match="step[position()!=1]" mode="cpm.fastcust.foname">
      <xsl:text>cpm:none</xsl:text>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='notecaption']" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="pre" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="div[cpm:oclass(.)='form']" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="div[cpm:oclass(.)='form']/p" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='listregizm']" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="table[cpm:oclass(.)='listregizm']//thead/row/entry"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="table[cpm:oclass(.)='listregizm']//tbody/row/entry"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="table[cpm:oclass(.)='listregizm']//tbody/row" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="apiname" mode="cpm.fastcust.foname">
      <xsl:text>fo:inline</xsl:text>
   </xsl:template>
   <xsl:template match="cite" mode="cpm.fastcust.foname">
      <xsl:text>fo:inline</xsl:text>
   </xsl:template>
   <xsl:template match="codeph" mode="cpm.fastcust.foname">
      <xsl:text>fo:inline</xsl:text>
   </xsl:template>
   <xsl:template match="filepath" mode="cpm.fastcust.foname">
      <xsl:text>fo:inline</xsl:text>
   </xsl:template>
   <xsl:template match="keyword" mode="cpm.fastcust.foname">
      <xsl:text>fo:inline</xsl:text>
   </xsl:template>
   <xsl:template match="menucascade" mode="cpm.fastcust.foname">
      <xsl:text>fo:inline</xsl:text>
   </xsl:template>
   <xsl:template match="term" mode="cpm.fastcust.foname">
      <xsl:text>fo:inline</xsl:text>
   </xsl:template>
   <xsl:template match="uicontrol" mode="cpm.fastcust.foname">
      <xsl:text>fo:inline</xsl:text>
   </xsl:template>
   <xsl:template match="userinput" mode="cpm.fastcust.foname">
      <xsl:text>fo:inline</xsl:text>
   </xsl:template>
   <xsl:template match="xmlatt" mode="cpm.fastcust.foname">
      <xsl:text>fo:inline</xsl:text>
   </xsl:template>
   <xsl:template match="xmlelement" mode="cpm.fastcust.foname">
      <xsl:text>fo:inline</xsl:text>
   </xsl:template>
   <xsl:template match="cpm:wrapper" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="cpm:keyword" mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="*[contains(@class, 'topic/body')]//p[cpm:oclass(.)='shortdesc']"
                 mode="cpm.fastcust.foname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.approved']" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Titul._Utverjden">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Титул. Утвержден</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.LU']" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Titul._LU">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Титул. ЛУ</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.title']" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Titul._Zagolovok">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Титул. Заголовок</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.subtitle']" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Titul._Podzagolovok">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Титул. Подзаголовок</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.docnumber']" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Titul._Oboznacenie">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Титул. Обозначение</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.pages']" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Titul._Stranicy">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Титул. Страницы</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.year']" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Titul._God">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Титул. Год</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='auxiliary']" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_perecna">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок перечня</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='intro']"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_1">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 1</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and cpm:sectype(.)='intro']"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_2">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 2</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and cpm:sectype(.)='intro']"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_3">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 3</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and cpm:sectype(.)='intro']"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_4">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 4</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_1">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 1</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_2">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 2</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_3">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 3</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_4">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 4</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=5 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_5">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 5</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=6 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_6">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 6</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='slacking']" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Pustoi_zagolovok">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Пустой заголовок</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='appendix']"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Prilojenie._Zagolovok">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Приложение. Заголовок</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_2">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 2</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_3">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 3</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_4">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 4</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=5 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_5">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 5</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=6 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_6">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 6</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='toctopic']" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Oglavlenie._Zagolovok">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Оглавление. Заголовок</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='tontopic']" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_perecna">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок перечня</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="fo:leader" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Oglavlenie._Tocki">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Оглавление. Точки</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="fo:block[cpm:numlevel(.)=0 and cpm:oclass(.)='tocentry']"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Oglavlenie_0">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Оглавление 0</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="fo:block[cpm:numlevel(.)=1 and cpm:oclass(.)='tocentry']"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Oglavlenie_1">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Оглавление 1</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="fo:block[cpm:numlevel(.)=2 and cpm:oclass(.)='tocentry']"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Oglavlenie_2">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Оглавление 2</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="fo:block[cpm:numlevel(.)=3 and cpm:oclass(.)='tocentry']"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Oglavlenie_3">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Оглавление 3</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="*[cpm:eclass(., 'topic/body')]//p[not(@outputclass) and not(ancestor::entry)]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Osnovnoi">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Основной</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="section/title" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_4">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 4</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="tgroup" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Tablica">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Таблица</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)!='appendix']//table/title" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Tablica._Nazvanie">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Таблица. Название</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='appendix']//table/title" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Tablica._Nazvanie">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Таблица. Название</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="thead/row" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Tablica._Wapka">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Таблица. Шапка</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="table[not(@outputclass)]//entry" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Tablica._Aceika">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Таблица. Ячейка</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="table[not(@outputclass)]//entry[@outputclass='subtitle']"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Tablica._Podzagolovok">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Таблица. Подзаголовок</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="tbody//entry[position()=1 and ../../../thead/row/entry[1]/@outputclass='number']"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Tablica._Nomer_stroki">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Таблица. Номер строки</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="tbody//entry[count(following-sibling::*)=0 and ../../../thead/row/entry[last()]/@outputclass='total']"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Tablica._Itog_po_stroke">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Таблица. Итог по строке</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="fig" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Risunok">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Рисунок</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='main']//fig/title" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text/>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='appendix']//fig/title" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text/>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="fo:block[cpm:oclass(.)='image']" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Risunok._Izobrajenie">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Рисунок. Изображение</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="image" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text/>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="fig/p" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Risunok._Opisanie">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Рисунок. Описание</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="fo:list-item-label/fo:block[not(@role)]" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Marker_spiska._Tekst">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Маркер списка. Текст</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=1 and not(@role)]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Punkt_spiska_1._Tekst">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Пункт списка 1. Текст</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=2 and not(@role)]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Punkt_spiska_2._Tekst">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Пункт списка 2. Текст</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=3 and not(@role)]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Punkt_spiska_3._Tekst">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Пункт списка 3. Текст</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="fo:list-item-label/fo:block[@role='table']" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Tablica._Marker_spiska._Tekst">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Таблица. Маркер списка. Текст</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=1 and @role='table']"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Tablica._Punkt_spiska_1._Tekst">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Таблица. Пункт списка 1. Текст</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=2 and @role='table']"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Tablica._Punkt_spiska_2._Tekst">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Таблица. Пункт списка 2. Текст</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=3 and @role='table']"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Tablica._Punkt_spiska_3._Tekst">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Таблица. Пункт списка 3. Текст</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="ul" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Glavnyi_spisok">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Главный список</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="ul[ancestor::li]|ul[ancestor::entry and not(preceding-sibling::*)]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Vlojennyi_spisok">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Вложенный список</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="ul/li[not(ancestor::li) and position()=1]" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Pervyi_punkt_spiska">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Первый пункт списка</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="ul/li[ancestor::li or position()!=1]" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Nepervyi_punkt_spiska">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Непервый пункт списка</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="ol" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Glavnyi_spisok">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Главный список</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="ol[ancestor::li]|ol[ancestor::entry and not(preceding-sibling::*)]"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Vlojennyi_spisok">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Вложенный список</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="ol/li[not(ancestor::li) and position()=1]" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Pervyi_punkt_spiska">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Первый пункт списка</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="ol/li[ancestor::li or position()!=1]" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Nepervyi_punkt_spiska">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Непервый пункт списка</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="steps" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Glavnyi_spisok">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Главный список</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="step[position()=1]" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Pervyi_punkt_spiska">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Первый пункт списка</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="step[position()!=1]" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Nepervyi_punkt_spiska">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Непервый пункт списка</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='notecaption']" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="VNIMANIE">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>ВНИМАНИЕ</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="pre" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Listing">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Листинг</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="div[cpm:oclass(.)='form']" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Forma">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Форма</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="div[cpm:oclass(.)='form']/p" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Abzac_v_forme">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Абзац в форме</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='listregizm']" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Zagolovok_1">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Заголовок 1</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="table[cpm:oclass(.)='listregizm']//thead/row/entry"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="LRI._Wapka">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>ЛРИ. Шапка</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="table[cpm:oclass(.)='listregizm']//tbody/row/entry"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="LRI._Aceika">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>ЛРИ. Ячейка</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="table[cpm:oclass(.)='listregizm']//tbody/row" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="LRI._Stroka">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>ЛРИ. Строка</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="apiname" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Kod_v_stroke">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Код в строке</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="cite" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Citata_v_stroke">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Цитата в строке</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="codeph" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Kod_v_stroke">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Код в строке</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="filepath" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Fail">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Файл</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="keyword" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Osnovnoi_wrift">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Основной шрифт</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="menucascade" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Menq">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Меню</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="term" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Termin">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Термин</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="uicontrol" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Knopki_i_vse_takoe">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Кнопки и все такое</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="userinput" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Kod_v_stroke">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Код в строке</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="xmlatt" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Kod_v_stroke">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Код в строке</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="xmlelement" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Kod_v_stroke">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Код в строке</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="cpm:wrapper" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Osnovnoi">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Основной</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="cpm:keyword" mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Osnovnoi">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Основной</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="*[contains(@class, 'topic/body')]//p[cpm:oclass(.)='shortdesc']"
                 mode="cpm.fastcust.foxml">
      <xsl:param name="foinner"/>
      <xsl:variable name="foname" select="cpm:fastcust.foname(.)"/>
      <xsl:choose>
         <xsl:when test="$foname=''"/>
         <xsl:when test="$foname='cpm:none'">
            <xsl:copy-of select="$foinner"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:element name="{$foname}" use-attribute-sets="Osnovnoi">
               <xsl:attribute name="id">
                  <xsl:value-of select="cpm:fastcust.id(.)"/>
               </xsl:attribute>
               <xsl:attribute name="language">
                  <xsl:value-of select="cpm:fastcust.lang(.)"/>
               </xsl:attribute>
               <xsl:attribute name="role">
                  <xsl:value-of select="name()"/>
                  <xsl:text>/</xsl:text>
                  <xsl:text>Основной</xsl:text>
               </xsl:attribute>
               <xsl:apply-templates select="." mode="foattrs"/>
               <xsl:copy-of select="$foinner"/>
            </xsl:element>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="*" mode="cpm.fastcust.explicit_caption"/>
   <xsl:template match="*" mode="cpm.fastcust.numseqname"/>
   <xsl:template match="title[cpm:sectype(.)='auxiliary']" mode="cpm.fastcust.numseqname">
      <xsl:text>Без номеров</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Разделы</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Разделы</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Разделы</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Разделы</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=5 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Разделы</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=6 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Разделы</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='appendix']"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Приложения</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Разделы приложений</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Разделы приложений</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Разделы приложений</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=5 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Разделы приложений</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=6 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Разделы приложений</xsl:text>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)!='appendix']//table/title"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Таблицы</xsl:text>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='appendix']//table/title"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Таблицы в приложении</xsl:text>
   </xsl:template>
   <xsl:template match="fig" mode="cpm.fastcust.numseqname">
      <xsl:text>fo:block</xsl:text>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='main']//fig/title" mode="cpm.fastcust.numseqname">
      <xsl:text>Рисунки</xsl:text>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='appendix']//fig/title" mode="cpm.fastcust.numseqname">
      <xsl:text>Рисунки в приложении</xsl:text>
   </xsl:template>
   <xsl:template match="ul[ancestor::li]|ul[ancestor::entry and not(preceding-sibling::*)]"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Блок списка</xsl:text>
   </xsl:template>
   <xsl:template match="ol" mode="cpm.fastcust.numseqname">
      <xsl:text>Блок списка</xsl:text>
   </xsl:template>
   <xsl:template match="ol[ancestor::li]|ol[ancestor::entry and not(preceding-sibling::*)]"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Блок списка</xsl:text>
   </xsl:template>
   <xsl:template match="ol/li[not(ancestor::li) and position()=1]"
                 mode="cpm.fastcust.numseqname">
      <xsl:text>Пункт списка</xsl:text>
   </xsl:template>
   <xsl:template match="ol/li[ancestor::li or position()!=1]" mode="cpm.fastcust.numseqname">
      <xsl:text>Пункт списка</xsl:text>
   </xsl:template>
   <xsl:template match="steps" mode="cpm.fastcust.numseqname">
      <xsl:text>Блок списка</xsl:text>
   </xsl:template>
   <xsl:template match="step[position()=1]" mode="cpm.fastcust.numseqname">
      <xsl:text>Пункт списка</xsl:text>
   </xsl:template>
   <xsl:template match="step[position()!=1]" mode="cpm.fastcust.numseqname">
      <xsl:text>Пункт списка</xsl:text>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='auxiliary']" mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=5 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=6 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='appendix']"
                 mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=5 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=6 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)!='appendix']//table/title" mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='appendix']//table/title" mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="fig" mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='main']//fig/title" mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='appendix']//fig/title" mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="ul[ancestor::li]|ul[ancestor::entry and not(preceding-sibling::*)]"
                 mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="ol" mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="ol[ancestor::li]|ol[ancestor::entry and not(preceding-sibling::*)]"
                 mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="ol/li[not(ancestor::li) and position()=1]" mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="ol/li[ancestor::li or position()!=1]" mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="steps" mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="step[position()=1]" mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template match="step[position()!=1]" mode="cpm.fastcust.numseq">
      <xsl:variable name="numseqname">
         <xsl:apply-templates select="." mode="cpm.fastcust.numseqname"/>
      </xsl:variable>
      <xsl:call-template name="cpm.fastcust.numseq">
         <xsl:with-param name="name">
            <xsl:value-of select="$numseqname"/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="cpm.fastcust.numseq">
      <xsl:param name="name"/>
      <xsl:choose>
         <xsl:when test="$name='Без номеров'">
            <numseq name="Без номеров" type="dummy" mode="decimal"/>
         </xsl:when>
         <xsl:when test="$name='Разделы'">
            <numseq name="Разделы" type="arabic" mode="decimal" caption="%n "/>
         </xsl:when>
         <xsl:when test="$name='Приложения'">
            <numseq name="Приложения" type="char" mode="decimal" chars="АБВГДЕЖИКЛМППРСТУФХЦЧШЩЭЮЯ"
                    caption="Приложение %n. "/>
         </xsl:when>
         <xsl:when test="$name='Разделы приложений'">
            <numseq name="Разделы приложений" type="arabic" mode="decimal" caption="%n "
                    base="Приложения"/>
         </xsl:when>
         <xsl:when test="$name='Таблицы'">
            <numseq name="Таблицы" type="arabic" mode="flat" caption="Таблица %n — "/>
         </xsl:when>
         <xsl:when test="$name='Таблицы в приложении'">
            <numseq name="Таблицы в приложении" type="arabic" mode="flat" caption="Таблица %n — "
                    base="Приложения"/>
         </xsl:when>
         <xsl:when test="$name='Рисунки'">
            <numseq name="Рисунки" type="arabic" mode="flat" caption="Рисунок %n — "/>
         </xsl:when>
         <xsl:when test="$name='Рисунки в приложении'">
            <numseq name="Рисунки в приложении" type="arabic" mode="flat" caption="Рисунок %n — "
                    base="Приложения"/>
         </xsl:when>
         <xsl:when test="$name='Блок списка'">
            <numseq name="Блок списка" type="dummy" mode="decimal"/>
         </xsl:when>
         <xsl:when test="$name='Пункт списка'">
            <numseq name="Пункт списка" type="arabic" mode="flat" caption="%n." base="Блок списка"/>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
</xsl:stylesheet>