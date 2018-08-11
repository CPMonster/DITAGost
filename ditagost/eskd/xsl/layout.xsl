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
   <!-- Шрифт -->
<xsl:attribute-set name="Wrift">
      <xsl:attribute name="font-family">Sans</xsl:attribute>
      <xsl:attribute name="font-size">12pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Базовый -->
<xsl:attribute-set name="Bazovyi" use-attribute-sets="Wrift">
      <xsl:attribute name="line-height">18pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Блок основного текста -->
<xsl:attribute-set name="Blok_osnovnogo_teksta" use-attribute-sets="Bazovyi"/>
   <!-- Блок иллюстрации -->
<xsl:attribute-set name="Blok_illqstracii" use-attribute-sets="Blok_osnovnogo_teksta">
      <xsl:attribute name="margin-top">18pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">18pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Внутренний блок текста -->
<xsl:attribute-set name="Vnutrennii_blok_teksta" use-attribute-sets="Bazovyi"/>
   <!-- Основной шрифт -->
<xsl:attribute-set name="Osnovnoi_wrift" use-attribute-sets="Wrift"/>
   <!-- Верхний колонтитул. Обозначение -->
<xsl:attribute-set name="Verhnii_kolontitul._Oboznacenie" use-attribute-sets="Bazovyi">
      <xsl:attribute name="font-size">9pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Верхний колонтитул. Номер страницы -->
<xsl:attribute-set name="Verhnii_kolontitul._Nomer_stranicy" use-attribute-sets="Bazovyi">
      <xsl:attribute name="font-size">14pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок -->
<xsl:attribute-set name="Zagolovok" use-attribute-sets="Bazovyi">
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
      <xsl:attribute name="keep-together.within-column">always</xsl:attribute>
      <xsl:attribute name="hyphenate">false</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пустой заголовок -->
<xsl:attribute-set name="Pustoi_zagolovok" use-attribute-sets="Zagolovok">
      <xsl:attribute name="visibility">hidden </xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок по центру -->
<xsl:attribute-set name="Zagolovok_po_centru" use-attribute-sets="Zagolovok">
      <xsl:attribute name="text-align">center</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок с отступом -->
<xsl:attribute-set name="Zagolovok_s_otstupom" use-attribute-sets="Zagolovok">
      <xsl:attribute name="margin-left">1cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок перечня -->
<xsl:attribute-set name="Zagolovok_perecna" use-attribute-sets="Zagolovok">
      <xsl:attribute name="font-size">18pt</xsl:attribute>
      <xsl:attribute name="text-transform">uppercase</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="margin-left">0pt</xsl:attribute>
      <xsl:attribute name="line-height">20pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">20pt</xsl:attribute>
      <xsl:attribute name="page-break-before">always</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 1 -->
<xsl:attribute-set name="Zagolovok_1" use-attribute-sets="Zagolovok_po_centru">
      <xsl:attribute name="font-size">18pt</xsl:attribute>
      <xsl:attribute name="text-transform">uppercase</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="line-height">22pt</xsl:attribute>
      <xsl:attribute name="page-break-before">always</xsl:attribute>
      <xsl:attribute name="margin-bottom">22pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 2 -->
<xsl:attribute-set name="Zagolovok_2" use-attribute-sets="Zagolovok_s_otstupom">
      <xsl:attribute name="font-size">18pt</xsl:attribute>
      <xsl:attribute name="font-variant">small-caps</xsl:attribute>
      <xsl:attribute name="line-height">22pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">22pt</xsl:attribute>
      <xsl:attribute name="margin-top">22pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 3 -->
<xsl:attribute-set name="Zagolovok_3" use-attribute-sets="Zagolovok_s_otstupom">
      <xsl:attribute name="font-size">18pt</xsl:attribute>
      <xsl:attribute name="line-height">22pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">22pt</xsl:attribute>
      <xsl:attribute name="margin-top">22pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 4 -->
<xsl:attribute-set name="Zagolovok_4" use-attribute-sets="Zagolovok_s_otstupom">
      <xsl:attribute name="font-size">16pt</xsl:attribute>
      <xsl:attribute name="line-height">19pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">19pt</xsl:attribute>
      <xsl:attribute name="margin-top">19pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 5 -->
<xsl:attribute-set name="Zagolovok_5" use-attribute-sets="Zagolovok_s_otstupom">
      <xsl:attribute name="font-size">16pt</xsl:attribute>
      <xsl:attribute name="line-height">19pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">19pt</xsl:attribute>
      <xsl:attribute name="margin-top">19pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 6 -->
<xsl:attribute-set name="Zagolovok_6" use-attribute-sets="Zagolovok_s_otstupom">
      <xsl:attribute name="font-size">16pt</xsl:attribute>
      <xsl:attribute name="line-height">19pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">19pt</xsl:attribute>
      <xsl:attribute name="margin-top">19pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Основной -->
<xsl:attribute-set name="Osnovnoi" use-attribute-sets="Blok_osnovnogo_teksta">
      <xsl:attribute name="text-indent">1cm</xsl:attribute>
      <xsl:attribute name="text-align">justify</xsl:attribute>
   </xsl:attribute-set>
   <!-- Список -->
<xsl:attribute-set name="Spisok" use-attribute-sets="Blok_osnovnogo_teksta">
      <xsl:attribute name="provisional-label-separation">inherit</xsl:attribute>
   </xsl:attribute-set>
   <!-- Главный список -->
<xsl:attribute-set name="Glavnyi_spisok" use-attribute-sets="Spisok">
      <xsl:attribute name="margin-left">1cm</xsl:attribute>
   </xsl:attribute-set>
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
<xsl:attribute-set name="Nepervyi_punkt_spiska" use-attribute-sets="Punkt_spiska"/>
   <!-- Пункт списка. Текст -->
<xsl:attribute-set name="Punkt_spiska._Tekst" use-attribute-sets="Bazovyi">
      <xsl:attribute name="line-height">18pt</xsl:attribute>
      <xsl:attribute name="text-align">justify</xsl:attribute>
   </xsl:attribute-set>
   <!-- Маркер списка. Текст -->
<xsl:attribute-set name="Marker_spiska._Tekst" use-attribute-sets="Bazovyi"/>
   <!-- Пункт списка 1. Текст -->
<xsl:attribute-set name="Punkt_spiska_1._Tekst" use-attribute-sets="Punkt_spiska._Tekst">
      <xsl:attribute name="start-indent">1.45cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пункт списка 2. Текст -->
<xsl:attribute-set name="Punkt_spiska_2._Tekst" use-attribute-sets="Punkt_spiska._Tekst">
      <xsl:attribute name="start-indent">1.90cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пункт списка 3. Текст -->
<xsl:attribute-set name="Punkt_spiska_3._Tekst" use-attribute-sets="Punkt_spiska._Tekst">
      <xsl:attribute name="start-indent">2.35cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Пункт списка. Текст -->
<xsl:attribute-set name="Tablica._Punkt_spiska._Tekst" use-attribute-sets="Bazovyi">
      <xsl:attribute name="text-align">left</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Маркер списка. Текст -->
<xsl:attribute-set name="Tablica._Marker_spiska._Tekst"
                      use-attribute-sets="Vnutrennii_blok_teksta"/>
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
<xsl:attribute-set name="Risunok" use-attribute-sets="Blok_illqstracii">
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="keep-together">always</xsl:attribute>
   </xsl:attribute-set>
   <!-- Рисунок. Изображение -->
<xsl:attribute-set name="Risunok._Izobrajenie" use-attribute-sets="Bazovyi"/>
   <!-- Рисунок. Подпись -->
<xsl:attribute-set name="Risunok._Podpisx" use-attribute-sets="Vnutrennii_blok_teksta">
      <xsl:attribute name="margin-top">9pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Блок -->
<xsl:attribute-set name="Tablica._Blok" use-attribute-sets="Blok_osnovnogo_teksta">
      <xsl:attribute name="margin-top">18pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">18pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Название -->
<xsl:attribute-set name="Tablica._Nazvanie" use-attribute-sets="Vnutrennii_blok_teksta">
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="text-align">right</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
      <xsl:attribute name="line-height">18pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">6pt</xsl:attribute>
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
      <xsl:attribute name="line-height">18pt</xsl:attribute>
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
   <!-- Рамка. Боковик -->
<xsl:attribute-set name="Ramka._Bokovik">
      <xsl:attribute name="font-family">Sans</xsl:attribute>
   </xsl:attribute-set>
   <!-- Рамка. Штамп -->
<xsl:attribute-set name="Ramka._Wtamp">
      <xsl:attribute name="font-family">Sans</xsl:attribute>
   </xsl:attribute-set>
   <!-- Рамка. Крупный -->
<xsl:attribute-set name="Ramka._Krupnyi">
      <xsl:attribute name="font-family">Sans</xsl:attribute>
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
<xsl:attribute-set name="Oglavlenie._Zagolovok" use-attribute-sets="Zagolovok_po_centru">
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
<xsl:attribute-set name="Oglavlenie" use-attribute-sets="Blok_osnovnogo_teksta">
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
   <xsl:template match="fo:leader" mode="foname">
      <xsl:text>fo:leader</xsl:text>
   </xsl:template>
   <xsl:template match="image" mode="foname">
      <xsl:text>fo:external-graphic</xsl:text>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='border.sidebar']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Ramka._Bokovik"
               role="{concat(name(),'/Рамка. Боковик')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='border.details']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Ramka._Wtamp" role="{concat(name(),'/Рамка. Штамп')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.approved']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Titul._Utverjden"
               role="{concat(name(),'/Титул. Утвержден')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.LU']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Titul._LU" role="{concat(name(),'/Титул. ЛУ')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.title']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Titul._Zagolovok"
               role="{concat(name(),'/Титул. Заголовок')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.subtitle']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Titul._Podzagolovok"
               role="{concat(name(),'/Титул. Подзаголовок')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.docnumber']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Titul._Oboznacenie"
               role="{concat(name(),'/Титул. Обозначение')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.pages']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Titul._Stranicy"
               role="{concat(name(),'/Титул. Страницы')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.year']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Titul._God" role="{concat(name(),'/Титул. Год')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='auxiliary']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_perecna"
               role="{concat(name(),'/Заголовок перечня')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='intro']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_1" role="{concat(name(),'/Заголовок 1')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and cpm:sectype(.)='intro']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_2" role="{concat(name(),'/Заголовок 2')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and cpm:sectype(.)='intro']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_3" role="{concat(name(),'/Заголовок 3')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and cpm:sectype(.)='intro']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_4" role="{concat(name(),'/Заголовок 4')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_1" role="{concat(name(),'/Заголовок 1')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_2" role="{concat(name(),'/Заголовок 2')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_3" role="{concat(name(),'/Заголовок 3')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_4" role="{concat(name(),'/Заголовок 4')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=5 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_5" role="{concat(name(),'/Заголовок 5')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=6 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_6" role="{concat(name(),'/Заголовок 6')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='slacking']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Pustoi_zagolovok"
               role="{concat(name(),'/Пустой заголовок')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='appendix']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Prilojenie._Zagolovok"
               role="{concat(name(),'/Приложение. Заголовок')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_2" role="{concat(name(),'/Заголовок 2')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_3" role="{concat(name(),'/Заголовок 3')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_4" role="{concat(name(),'/Заголовок 4')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=5 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_5" role="{concat(name(),'/Заголовок 5')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=6 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_6" role="{concat(name(),'/Заголовок 6')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='toctopic']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Oglavlenie._Zagolovok"
               role="{concat(name(),'/Оглавление. Заголовок')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='tontopic']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_perecna"
               role="{concat(name(),'/Заголовок перечня')}"/>
   </xsl:template>
   <xsl:template match="fo:leader" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Oglavlenie._Tocki"
               role="{concat(name(),'/Оглавление. Точки')}"/>
   </xsl:template>
   <xsl:template match="fo:block[cpm:numlevel(.)=0 and cpm:oclass(.)='tocentry']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Oglavlenie_0" role="{concat(name(),'/Оглавление 0')}"/>
   </xsl:template>
   <xsl:template match="fo:block[cpm:numlevel(.)=1 and cpm:oclass(.)='tocentry']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Oglavlenie_1" role="{concat(name(),'/Оглавление 1')}"/>
   </xsl:template>
   <xsl:template match="fo:block[cpm:numlevel(.)=2 and cpm:oclass(.)='tocentry']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Oglavlenie_2" role="{concat(name(),'/Оглавление 2')}"/>
   </xsl:template>
   <xsl:template match="fo:block[cpm:numlevel(.)=3 and cpm:oclass(.)='tocentry']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Oglavlenie_3" role="{concat(name(),'/Оглавление 3')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:noclass(.) and cpm:is_normal(.)]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Osnovnoi" role="{concat(name(),'/Основной')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:in_table(.)]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Vnutrennii_blok_teksta"
               role="{concat(name(),'/Внутренний блок текста')}"/>
   </xsl:template>
   <xsl:template match="section/title" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_4" role="{concat(name(),'/Заголовок 4')}"/>
   </xsl:template>
   <xsl:template match="table" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Tablica._Blok" role="{concat(name(),'/Таблица. Блок')}"/>
   </xsl:template>
   <xsl:template match="tgroup" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Tablica" role="{concat(name(),'/Таблица')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)!='appendix']//table/title" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Tablica._Nazvanie"
               role="{concat(name(),'/Таблица. Название')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='appendix']//table/title" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Tablica._Nazvanie"
               role="{concat(name(),'/Таблица. Название')}"/>
   </xsl:template>
   <xsl:template match="thead/row" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Tablica._Wapka"
               role="{concat(name(),'/Таблица. Шапка')}"/>
   </xsl:template>
   <xsl:template match="table[cpm:noclass(.)]//entry" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Tablica._Aceika"
               role="{concat(name(),'/Таблица. Ячейка')}"/>
   </xsl:template>
   <xsl:template match="fig" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Risunok" role="{concat(name(),'/Рисунок')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='main']//fig/title" mode="fostyle">
      <fostyle xsl:use-attribute-sets="" role="{concat(name(),'/')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='appendix']//fig/title" mode="fostyle">
      <fostyle xsl:use-attribute-sets="" role="{concat(name(),'/')}"/>
   </xsl:template>
   <xsl:template match="fo:block[cpm:oclass(.)='image']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Risunok._Izobrajenie"
               role="{concat(name(),'/Рисунок. Изображение')}"/>
   </xsl:template>
   <xsl:template match="image" mode="fostyle">
      <fostyle xsl:use-attribute-sets="" role="{concat(name(),'/')}"/>
   </xsl:template>
   <xsl:template match="fig/p" mode="fostyle">
      <fostyle xsl:use-attribute-sets="" role="{concat(name(),'/')}"/>
   </xsl:template>
   <xsl:template match="fo:list-item-label/fo:block[cpm:noclass(.)]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Marker_spiska._Tekst"
               role="{concat(name(),'/Маркер списка. Текст')}"/>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=1 and cpm:noclass(.)]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Punkt_spiska_1._Tekst"
               role="{concat(name(),'/Пункт списка 1. Текст')}"/>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=2 and cpm:noclass(.)]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Punkt_spiska_2._Tekst"
               role="{concat(name(),'/Пункт списка 2. Текст')}"/>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=3 and cpm:noclass(.)]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Punkt_spiska_3._Tekst"
               role="{concat(name(),'/Пункт списка 3. Текст')}"/>
   </xsl:template>
   <xsl:template match="fo:list-item-label/fo:block[cpm:in_table(.)]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Tablica._Marker_spiska._Tekst"
               role="{concat(name(),'/Таблица. Маркер списка. Текст')}"/>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=1 and cpm:in_table(.)]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Tablica._Punkt_spiska_1._Tekst"
               role="{concat(name(),'/Таблица. Пункт списка 1. Текст')}"/>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=2 and cpm:in_table(.)]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Tablica._Punkt_spiska_2._Tekst"
               role="{concat(name(),'/Таблица. Пункт списка 2. Текст')}"/>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=3 and cpm:in_table(.)]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Tablica._Punkt_spiska_3._Tekst"
               role="{concat(name(),'/Таблица. Пункт списка 3. Текст')}"/>
   </xsl:template>
   <xsl:template match="ul" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Glavnyi_spisok"
               role="{concat(name(),'/Главный список')}"/>
   </xsl:template>
   <xsl:template match="ul[ancestor::li]|ul[cpm:in_table(.)]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Vlojennyi_spisok"
               role="{concat(name(),'/Вложенный список')}"/>
   </xsl:template>
   <xsl:template match="ul/li[not(ancestor::li) and position()=1]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Pervyi_punkt_spiska"
               role="{concat(name(),'/Первый пункт списка')}"/>
   </xsl:template>
   <xsl:template match="ul/li[ancestor::li or position()!=1]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Nepervyi_punkt_spiska"
               role="{concat(name(),'/Непервый пункт списка')}"/>
   </xsl:template>
   <xsl:template match="ol" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Glavnyi_spisok"
               role="{concat(name(),'/Главный список')}"/>
   </xsl:template>
   <xsl:template match="ol[ancestor::li]|ol[cpm:in_table(.)]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Vlojennyi_spisok"
               role="{concat(name(),'/Вложенный список')}"/>
   </xsl:template>
   <xsl:template match="ol/li[not(ancestor::li) and position()=1]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Pervyi_punkt_spiska"
               role="{concat(name(),'/Первый пункт списка')}"/>
   </xsl:template>
   <xsl:template match="ol/li[ancestor::li or position()!=1]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Nepervyi_punkt_spiska"
               role="{concat(name(),'/Непервый пункт списка')}"/>
   </xsl:template>
   <xsl:template match="steps" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Glavnyi_spisok"
               role="{concat(name(),'/Главный список')}"/>
   </xsl:template>
   <xsl:template match="step[position()=1]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Pervyi_punkt_spiska"
               role="{concat(name(),'/Первый пункт списка')}"/>
   </xsl:template>
   <xsl:template match="step[position()!=1]" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Nepervyi_punkt_spiska"
               role="{concat(name(),'/Непервый пункт списка')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='notecaption']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="VNIMANIE" role="{concat(name(),'/ВНИМАНИЕ')}"/>
   </xsl:template>
   <xsl:template match="pre" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Listing" role="{concat(name(),'/Листинг')}"/>
   </xsl:template>
   <xsl:template match="div[cpm:oclass(.)='form']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Forma" role="{concat(name(),'/Форма')}"/>
   </xsl:template>
   <xsl:template match="div[cpm:oclass(.)='form']/p" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Abzac_v_forme" role="{concat(name(),'/Абзац в форме')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='listregizm']" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Zagolovok_1" role="{concat(name(),'/Заголовок 1')}"/>
   </xsl:template>
   <xsl:template match="table[cpm:oclass(.)='listregizm']//thead/row/entry" mode="fostyle">
      <fostyle xsl:use-attribute-sets="LRI._Wapka" role="{concat(name(),'/ЛРИ. Шапка')}"/>
   </xsl:template>
   <xsl:template match="table[cpm:oclass(.)='listregizm']//tbody/row/entry" mode="fostyle">
      <fostyle xsl:use-attribute-sets="LRI._Aceika" role="{concat(name(),'/ЛРИ. Ячейка')}"/>
   </xsl:template>
   <xsl:template match="table[cpm:oclass(.)='listregizm']//tbody/row" mode="fostyle">
      <fostyle xsl:use-attribute-sets="LRI._Stroka" role="{concat(name(),'/ЛРИ. Строка')}"/>
   </xsl:template>
   <xsl:template match="apiname" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Kod_v_stroke" role="{concat(name(),'/Код в строке')}"/>
   </xsl:template>
   <xsl:template match="cite" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Citata_v_stroke"
               role="{concat(name(),'/Цитата в строке')}"/>
   </xsl:template>
   <xsl:template match="codeph" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Kod_v_stroke" role="{concat(name(),'/Код в строке')}"/>
   </xsl:template>
   <xsl:template match="filepath" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Fail" role="{concat(name(),'/Файл')}"/>
   </xsl:template>
   <xsl:template match="keyword" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Osnovnoi_wrift"
               role="{concat(name(),'/Основной шрифт')}"/>
   </xsl:template>
   <xsl:template match="menucascade" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Menq" role="{concat(name(),'/Меню')}"/>
   </xsl:template>
   <xsl:template match="term" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Termin" role="{concat(name(),'/Термин')}"/>
   </xsl:template>
   <xsl:template match="uicontrol" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Knopki_i_vse_takoe"
               role="{concat(name(),'/Кнопки и все такое')}"/>
   </xsl:template>
   <xsl:template match="userinput" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Kod_v_stroke" role="{concat(name(),'/Код в строке')}"/>
   </xsl:template>
   <xsl:template match="xmlatt" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Kod_v_stroke" role="{concat(name(),'/Код в строке')}"/>
   </xsl:template>
   <xsl:template match="xmlelement" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Kod_v_stroke" role="{concat(name(),'/Код в строке')}"/>
   </xsl:template>
   <xsl:template match="cpm:wrapper" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Osnovnoi" role="{concat(name(),'/Основной')}"/>
   </xsl:template>
   <xsl:template match="cpm:keyword" mode="fostyle">
      <fostyle xsl:use-attribute-sets="Osnovnoi" role="{concat(name(),'/Основной')}"/>
   </xsl:template>
   <xsl:template match="*[contains(@class, 'topic/body')]//p[cpm:oclass(.)='shortdesc']"
                 mode="fostyle">
      <fostyle xsl:use-attribute-sets="Osnovnoi" role="{concat(name(),'/Основной')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='auxiliary']" mode="numseq">
      <numseq name="Без номеров" type="dummy" mode="decimal"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="numseq">
      <numseq name="Разделы" type="arabic" mode="decimal" caption="%n "/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="numseq">
      <numseq name="Разделы" type="arabic" mode="decimal" caption="%n "/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="numseq">
      <numseq name="Разделы" type="arabic" mode="decimal" caption="%n "/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="numseq">
      <numseq name="Разделы" type="arabic" mode="decimal" caption="%n "/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=5 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="numseq">
      <numseq name="Разделы" type="arabic" mode="decimal" caption="%n "/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=6 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="numseq">
      <numseq name="Разделы" type="arabic" mode="decimal" caption="%n "/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='appendix']" mode="numseq">
      <numseq name="Приложения" type="char" mode="decimal" chars="АБВГДЕЖИКЛМППРСТУФХЦЧШЩЭЮЯ"
              caption="Приложение %n. "/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="numseq">
      <numseq name="Разделы приложений" type="arabic" mode="decimal" caption="%n "
              base="Приложения"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="numseq">
      <numseq name="Разделы приложений" type="arabic" mode="decimal" caption="%n "
              base="Приложения"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="numseq">
      <numseq name="Разделы приложений" type="arabic" mode="decimal" caption="%n "
              base="Приложения"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=5 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="numseq">
      <numseq name="Разделы приложений" type="arabic" mode="decimal" caption="%n "
              base="Приложения"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=6 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="numseq">
      <numseq name="Разделы приложений" type="arabic" mode="decimal" caption="%n "
              base="Приложения"/>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)!='appendix']//table/title" mode="numseq">
      <numseq name="Таблицы" type="arabic" mode="flat" caption="Таблица %n — "/>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='appendix']//table/title" mode="numseq">
      <numseq name="Таблицы в приложении" type="arabic" mode="flat" caption="Таблица %n — "
              base="Приложения"/>
   </xsl:template>
   <xsl:template match="fig" mode="numseq"/>
   <xsl:template match="*[cpm:sectype(.)='main']//fig/title" mode="numseq">
      <numseq name="Рисунки" type="arabic" mode="flat" caption="Рисунок %n — "/>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='appendix']//fig/title" mode="numseq">
      <numseq name="Рисунки в приложении" type="arabic" mode="flat" caption="Рисунок %n — "
              base="Приложения"/>
   </xsl:template>
   <xsl:template match="ul[ancestor::li]|ul[cpm:in_table(.)]" mode="numseq">
      <numseq name="Блок списка" type="dummy" mode="decimal"/>
   </xsl:template>
   <xsl:template match="ol" mode="numseq">
      <numseq name="Блок списка" type="dummy" mode="decimal"/>
   </xsl:template>
   <xsl:template match="ol[ancestor::li]|ol[cpm:in_table(.)]" mode="numseq">
      <numseq name="Блок списка" type="dummy" mode="decimal"/>
   </xsl:template>
   <xsl:template match="ol/li[not(ancestor::li) and position()=1]" mode="numseq">
      <numseq name="Пункт списка" type="arabic" mode="flat" caption="%n." base="Блок списка"/>
   </xsl:template>
   <xsl:template match="ol/li[ancestor::li or position()!=1]" mode="numseq">
      <numseq name="Пункт списка" type="arabic" mode="flat" caption="%n." base="Блок списка"/>
   </xsl:template>
   <xsl:template match="steps" mode="numseq">
      <numseq name="Блок списка" type="dummy" mode="decimal"/>
   </xsl:template>
   <xsl:template match="step[position()=1]" mode="numseq">
      <numseq name="Пункт списка" type="arabic" mode="flat" caption="%n." base="Блок списка"/>
   </xsl:template>
   <xsl:template match="step[position()!=1]" mode="numseq">
      <numseq name="Пункт списка" type="arabic" mode="flat" caption="%n." base="Блок списка"/>
   </xsl:template>
</xsl:stylesheet>