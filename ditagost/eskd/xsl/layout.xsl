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
      <xsl:attribute name="name">Шрифт</xsl:attribute>
      <xsl:attribute name="type">common</xsl:attribute>
      <xsl:attribute name="font-family">Sans</xsl:attribute>
      <xsl:attribute name="font-size">12pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Базовый -->
<xsl:attribute-set name="Bazovyi" use-attribute-sets="Wrift">
      <xsl:attribute name="name">Базовый</xsl:attribute>
      <xsl:attribute name="base">Шрифт</xsl:attribute>
      <xsl:attribute name="type">common</xsl:attribute>
      <xsl:attribute name="line-height">18pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Блок основного текста -->
<xsl:attribute-set name="Blok_osnovnogo_teksta" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">Блок основного текста</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
      <xsl:attribute name="type">block</xsl:attribute>
   </xsl:attribute-set>
   <!-- Блок иллюстрации -->
<xsl:attribute-set name="Blok_illqstracii" use-attribute-sets="Blok_osnovnogo_teksta">
      <xsl:attribute name="name">Блок иллюстрации</xsl:attribute>
      <xsl:attribute name="base">Блок основного текста</xsl:attribute>
      <xsl:attribute name="margin-top">18pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">18pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Внутренний блок текста -->
<xsl:attribute-set name="Vnutrennii_blok_teksta" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">Внутренний блок текста</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
      <xsl:attribute name="type">block</xsl:attribute>
   </xsl:attribute-set>
   <!-- Основной шрифт -->
<xsl:attribute-set name="Osnovnoi_wrift" use-attribute-sets="Wrift">
      <xsl:attribute name="name">Основной шрифт</xsl:attribute>
      <xsl:attribute name="base">Шрифт</xsl:attribute>
      <xsl:attribute name="type">span</xsl:attribute>
   </xsl:attribute-set>
   <!-- Верхний колонтитул. Обозначение -->
<xsl:attribute-set name="Verhnii_kolontitul._Oboznacenie" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">Верхний колонтитул. Обозначение</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
      <xsl:attribute name="font-size">9pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Верхний колонтитул. Номер страницы -->
<xsl:attribute-set name="Verhnii_kolontitul._Nomer_stranicy" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">Верхний колонтитул. Номер страницы</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
      <xsl:attribute name="font-size">14pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок -->
<xsl:attribute-set name="Zagolovok" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">Заголовок</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
      <xsl:attribute name="type">block</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
      <xsl:attribute name="keep-together.within-column">always</xsl:attribute>
      <xsl:attribute name="hyphenate">false</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пустой заголовок -->
<xsl:attribute-set name="Pustoi_zagolovok" use-attribute-sets="Zagolovok">
      <xsl:attribute name="name">Пустой заголовок</xsl:attribute>
      <xsl:attribute name="base">Заголовок</xsl:attribute>
      <xsl:attribute name="visibility">hidden</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок по центру -->
<xsl:attribute-set name="Zagolovok_po_centru" use-attribute-sets="Zagolovok">
      <xsl:attribute name="name">Заголовок по центру</xsl:attribute>
      <xsl:attribute name="base">Заголовок</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок с отступом -->
<xsl:attribute-set name="Zagolovok_s_otstupom" use-attribute-sets="Zagolovok">
      <xsl:attribute name="name">Заголовок с отступом</xsl:attribute>
      <xsl:attribute name="base">Заголовок</xsl:attribute>
      <xsl:attribute name="margin-left">1cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок перечня -->
<xsl:attribute-set name="Zagolovok_perecna" use-attribute-sets="Zagolovok">
      <xsl:attribute name="name">Заголовок перечня</xsl:attribute>
      <xsl:attribute name="base">Заголовок</xsl:attribute>
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
      <xsl:attribute name="name">Заголовок 1</xsl:attribute>
      <xsl:attribute name="base">Заголовок по центру</xsl:attribute>
      <xsl:attribute name="font-size">18pt</xsl:attribute>
      <xsl:attribute name="text-transform">uppercase</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="line-height">22pt</xsl:attribute>
      <xsl:attribute name="page-break-before">always</xsl:attribute>
      <xsl:attribute name="margin-bottom">22pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 2 -->
<xsl:attribute-set name="Zagolovok_2" use-attribute-sets="Zagolovok_s_otstupom">
      <xsl:attribute name="name">Заголовок 2</xsl:attribute>
      <xsl:attribute name="base">Заголовок с отступом</xsl:attribute>
      <xsl:attribute name="font-size">18pt</xsl:attribute>
      <xsl:attribute name="font-variant">small-caps</xsl:attribute>
      <xsl:attribute name="line-height">22pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">22pt</xsl:attribute>
      <xsl:attribute name="margin-top">22pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 3 -->
<xsl:attribute-set name="Zagolovok_3" use-attribute-sets="Zagolovok_s_otstupom">
      <xsl:attribute name="name">Заголовок 3</xsl:attribute>
      <xsl:attribute name="base">Заголовок с отступом</xsl:attribute>
      <xsl:attribute name="font-size">18pt</xsl:attribute>
      <xsl:attribute name="line-height">22pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">22pt</xsl:attribute>
      <xsl:attribute name="margin-top">22pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 4 -->
<xsl:attribute-set name="Zagolovok_4" use-attribute-sets="Zagolovok_s_otstupom">
      <xsl:attribute name="name">Заголовок 4</xsl:attribute>
      <xsl:attribute name="base">Заголовок с отступом</xsl:attribute>
      <xsl:attribute name="font-size">16pt</xsl:attribute>
      <xsl:attribute name="line-height">19pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">19pt</xsl:attribute>
      <xsl:attribute name="margin-top">19pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 5 -->
<xsl:attribute-set name="Zagolovok_5" use-attribute-sets="Zagolovok_s_otstupom">
      <xsl:attribute name="name">Заголовок 5</xsl:attribute>
      <xsl:attribute name="base">Заголовок с отступом</xsl:attribute>
      <xsl:attribute name="font-size">16pt</xsl:attribute>
      <xsl:attribute name="line-height">19pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">19pt</xsl:attribute>
      <xsl:attribute name="margin-top">19pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Заголовок 6 -->
<xsl:attribute-set name="Zagolovok_6" use-attribute-sets="Zagolovok_s_otstupom">
      <xsl:attribute name="name">Заголовок 6</xsl:attribute>
      <xsl:attribute name="base">Заголовок с отступом</xsl:attribute>
      <xsl:attribute name="font-size">16pt</xsl:attribute>
      <xsl:attribute name="line-height">19pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">19pt</xsl:attribute>
      <xsl:attribute name="margin-top">19pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Основной -->
<xsl:attribute-set name="Osnovnoi" use-attribute-sets="Blok_osnovnogo_teksta">
      <xsl:attribute name="name">Основной</xsl:attribute>
      <xsl:attribute name="base">Блок основного текста</xsl:attribute>
      <xsl:attribute name="text-indent">1cm</xsl:attribute>
      <xsl:attribute name="text-align">justify</xsl:attribute>
   </xsl:attribute-set>
   <!-- Список -->
<xsl:attribute-set name="Spisok" use-attribute-sets="Blok_osnovnogo_teksta">
      <xsl:attribute name="name">Список</xsl:attribute>
      <xsl:attribute name="base">Блок основного текста</xsl:attribute>
      <xsl:attribute name="provisional-label-separation">inherit</xsl:attribute>
   </xsl:attribute-set>
   <!-- Главный список -->
<xsl:attribute-set name="Glavnyi_spisok" use-attribute-sets="Spisok">
      <xsl:attribute name="name">Главный список</xsl:attribute>
      <xsl:attribute name="base">Список</xsl:attribute>
      <xsl:attribute name="margin-left">1cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Главный список в таблице -->
<xsl:attribute-set name="Glavnyi_spisok_v_tablice" use-attribute-sets="Spisok">
      <xsl:attribute name="name">Главный список в таблице</xsl:attribute>
      <xsl:attribute name="base">Список</xsl:attribute>
   </xsl:attribute-set>
   <!-- Вложенный список -->
<xsl:attribute-set name="Vlojennyi_spisok" use-attribute-sets="Spisok">
      <xsl:attribute name="name">Вложенный список</xsl:attribute>
      <xsl:attribute name="base">Список</xsl:attribute>
      <xsl:attribute name="margin-top">0cm</xsl:attribute>
      <xsl:attribute name="margin-bottom">0cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пункт списка -->
<xsl:attribute-set name="Punkt_spiska">
      <xsl:attribute name="name">Пункт списка</xsl:attribute>
   </xsl:attribute-set>
   <!-- Первый пункт списка -->
<xsl:attribute-set name="Pervyi_punkt_spiska" use-attribute-sets="Punkt_spiska">
      <xsl:attribute name="name">Первый пункт списка</xsl:attribute>
      <xsl:attribute name="base">Пункт списка</xsl:attribute>
   </xsl:attribute-set>
   <!-- Непервый пункт списка -->
<xsl:attribute-set name="Nepervyi_punkt_spiska" use-attribute-sets="Punkt_spiska">
      <xsl:attribute name="name">Непервый пункт списка</xsl:attribute>
      <xsl:attribute name="base">Пункт списка</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пункт списка. Текст -->
<xsl:attribute-set name="Punkt_spiska._Tekst" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">Пункт списка. Текст</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
      <xsl:attribute name="line-height">18pt</xsl:attribute>
      <xsl:attribute name="text-align">justify</xsl:attribute>
   </xsl:attribute-set>
   <!-- Маркер списка. Текст -->
<xsl:attribute-set name="Marker_spiska._Tekst" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">Маркер списка. Текст</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пункт списка 1. Текст -->
<xsl:attribute-set name="Punkt_spiska_1._Tekst" use-attribute-sets="Punkt_spiska._Tekst">
      <xsl:attribute name="name">Пункт списка 1. Текст</xsl:attribute>
      <xsl:attribute name="base">Пункт списка. Текст</xsl:attribute>
      <xsl:attribute name="start-indent">1.45cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пункт списка 2. Текст -->
<xsl:attribute-set name="Punkt_spiska_2._Tekst" use-attribute-sets="Punkt_spiska._Tekst">
      <xsl:attribute name="name">Пункт списка 2. Текст</xsl:attribute>
      <xsl:attribute name="base">Пункт списка. Текст</xsl:attribute>
      <xsl:attribute name="start-indent">1.90cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пункт списка 3. Текст -->
<xsl:attribute-set name="Punkt_spiska_3._Tekst" use-attribute-sets="Punkt_spiska._Tekst">
      <xsl:attribute name="name">Пункт списка 3. Текст</xsl:attribute>
      <xsl:attribute name="base">Пункт списка. Текст</xsl:attribute>
      <xsl:attribute name="start-indent">2.35cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Пункт списка. Текст -->
<xsl:attribute-set name="Tablica._Punkt_spiska._Tekst" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">Таблица. Пункт списка. Текст</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
      <xsl:attribute name="text-align">left</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Маркер списка. Текст -->
<xsl:attribute-set name="Tablica._Marker_spiska._Tekst"
                      use-attribute-sets="Vnutrennii_blok_teksta">
      <xsl:attribute name="name">Таблица. Маркер списка. Текст</xsl:attribute>
      <xsl:attribute name="base">Внутренний блок текста</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Пункт списка 1. Текст -->
<xsl:attribute-set name="Tablica._Punkt_spiska_1._Tekst"
                      use-attribute-sets="Tablica._Punkt_spiska._Tekst">
      <xsl:attribute name="name">Таблица. Пункт списка 1. Текст</xsl:attribute>
      <xsl:attribute name="base">Таблица. Пункт списка. Текст</xsl:attribute>
      <xsl:attribute name="start-indent">0.45cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Пункт списка 2. Текст -->
<xsl:attribute-set name="Tablica._Punkt_spiska_2._Tekst"
                      use-attribute-sets="Tablica._Punkt_spiska._Tekst">
      <xsl:attribute name="name">Таблица. Пункт списка 2. Текст</xsl:attribute>
      <xsl:attribute name="base">Таблица. Пункт списка. Текст</xsl:attribute>
      <xsl:attribute name="start-indent">0.90cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Пункт списка 3. Текст -->
<xsl:attribute-set name="Tablica._Punkt_spiska_3._Tekst"
                      use-attribute-sets="Tablica._Punkt_spiska._Tekst">
      <xsl:attribute name="name">Таблица. Пункт списка 3. Текст</xsl:attribute>
      <xsl:attribute name="base">Таблица. Пункт списка. Текст</xsl:attribute>
      <xsl:attribute name="start-indent">1.35cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Рисунок -->
<xsl:attribute-set name="Risunok" use-attribute-sets="Blok_illqstracii">
      <xsl:attribute name="name">Рисунок</xsl:attribute>
      <xsl:attribute name="base">Блок иллюстрации</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="keep-together">always</xsl:attribute>
   </xsl:attribute-set>
   <!-- Рисунок. Изображение -->
<xsl:attribute-set name="Risunok._Izobrajenie" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">Рисунок. Изображение</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
   </xsl:attribute-set>
   <!-- Рисунок. Подпись -->
<xsl:attribute-set name="Risunok._Podpisx" use-attribute-sets="Vnutrennii_blok_teksta">
      <xsl:attribute name="name">Рисунок. Подпись</xsl:attribute>
      <xsl:attribute name="base">Внутренний блок текста</xsl:attribute>
      <xsl:attribute name="margin-top">9pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Блок -->
<xsl:attribute-set name="Tablica._Blok" use-attribute-sets="Blok_osnovnogo_teksta">
      <xsl:attribute name="name">Таблица. Блок</xsl:attribute>
      <xsl:attribute name="base">Блок основного текста</xsl:attribute>
      <xsl:attribute name="margin-top">18pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">18pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Название -->
<xsl:attribute-set name="Tablica._Nazvanie" use-attribute-sets="Vnutrennii_blok_teksta">
      <xsl:attribute name="name">Таблица. Название</xsl:attribute>
      <xsl:attribute name="base">Внутренний блок текста</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="text-align">right</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
      <xsl:attribute name="line-height">18pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">6pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица -->
<xsl:attribute-set name="Tablica" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">Таблица</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
      <xsl:attribute name="text-align">left</xsl:attribute>
      <xsl:attribute name="text-indent">0cm</xsl:attribute>
      <xsl:attribute name="start-indent">0cm</xsl:attribute>
      <xsl:attribute name="border-style">solid</xsl:attribute>
      <xsl:attribute name="border-width">1pt</xsl:attribute>
      <xsl:attribute name="border-color">#000000</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Шапка -->
<xsl:attribute-set name="Tablica._Wapka" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">Таблица. Шапка</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
      <xsl:attribute name="line-height">15pt</xsl:attribute>
      <xsl:attribute name="hyphenate">true</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Строка -->
<xsl:attribute-set name="Tablica._Stroka" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">Таблица. Строка</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Пустая строка -->
<xsl:attribute-set name="Tablica._Pustaa_stroka" use-attribute-sets="Tablica._Stroka">
      <xsl:attribute name="name">Таблица. Пустая строка</xsl:attribute>
      <xsl:attribute name="base">Таблица. Строка</xsl:attribute>
      <xsl:attribute name="height">18pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Ячейка -->
<xsl:attribute-set name="Tablica._Aceika" use-attribute-sets="Tablica._Stroka">
      <xsl:attribute name="name">Таблица. Ячейка</xsl:attribute>
      <xsl:attribute name="base">Таблица. Строка</xsl:attribute>
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
<xsl:attribute-set name="Tablica._Podzagolovok" use-attribute-sets="Tablica._Aceika">
      <xsl:attribute name="name">Таблица. Подзаголовок</xsl:attribute>
      <xsl:attribute name="base">Таблица. Ячейка</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Номер строки -->
<xsl:attribute-set name="Tablica._Nomer_stroki" use-attribute-sets="Tablica._Podzagolovok">
      <xsl:attribute name="name">Таблица. Номер строки</xsl:attribute>
      <xsl:attribute name="base">Таблица. Подзаголовок</xsl:attribute>
   </xsl:attribute-set>
   <!-- Таблица. Итог по строке -->
<xsl:attribute-set name="Tablica._Itog_po_stroke" use-attribute-sets="Tablica._Aceika">
      <xsl:attribute name="name">Таблица. Итог по строке</xsl:attribute>
      <xsl:attribute name="base">Таблица. Ячейка</xsl:attribute>
      <xsl:attribute name="border-left-style">solid</xsl:attribute>
      <xsl:attribute name="border-left-width">1pt</xsl:attribute>
      <xsl:attribute name="border-left-color">#000000</xsl:attribute>
   </xsl:attribute-set>
   <!-- ВНИМАНИЕ -->
<xsl:attribute-set name="VNIMANIE" use-attribute-sets="Osnovnoi">
      <xsl:attribute name="name">ВНИМАНИЕ</xsl:attribute>
      <xsl:attribute name="base">Основной</xsl:attribute>
      <xsl:attribute name="keep-with-next">always</xsl:attribute>
   </xsl:attribute-set>
   <!-- Листинг -->
<xsl:attribute-set name="Listing" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">Листинг</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
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
      <xsl:attribute name="name">Форма</xsl:attribute>
      <xsl:attribute name="base">Блок основного текста</xsl:attribute>
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
      <xsl:attribute name="name">Абзац в форме</xsl:attribute>
      <xsl:attribute name="type">paragraph</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
      <xsl:attribute name="font-size">11pt</xsl:attribute>
      <xsl:attribute name="text-align">left</xsl:attribute>
   </xsl:attribute-set>
   <!-- Приложение. Заголовок -->
<xsl:attribute-set name="Prilojenie._Zagolovok" use-attribute-sets="Pustoi_zagolovok">
      <xsl:attribute name="name">Приложение. Заголовок</xsl:attribute>
      <xsl:attribute name="base">Пустой заголовок</xsl:attribute>
      <xsl:attribute name="font-size">1pt</xsl:attribute>
      <xsl:attribute name="color">#ffffff</xsl:attribute>
      <xsl:attribute name="page-break-before">always</xsl:attribute>
      <xsl:attribute name="margin-top">0pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Приложение. Номер -->
<xsl:attribute-set name="Prilojenie._Nomer" use-attribute-sets="Zagolovok_1">
      <xsl:attribute name="name">Приложение. Номер</xsl:attribute>
      <xsl:attribute name="base">Заголовок 1</xsl:attribute>
      <xsl:attribute name="page-break-before">avoid</xsl:attribute>
      <xsl:attribute name="margin-bottom">10pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Приложение. Обязательность -->
<xsl:attribute-set name="Prilojenie._Obazatelxnostx" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">Приложение. Обязательность</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
      <xsl:attribute name="font-size">12pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">10pt</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
   </xsl:attribute-set>
   <!-- Приложение. Название -->
<xsl:attribute-set name="Prilojenie._Nazvanie" use-attribute-sets="Zagolovok_1">
      <xsl:attribute name="name">Приложение. Название</xsl:attribute>
      <xsl:attribute name="base">Заголовок 1</xsl:attribute>
      <xsl:attribute name="margin-top">12pt</xsl:attribute>
      <xsl:attribute name="page-break-before">avoid</xsl:attribute>
   </xsl:attribute-set>
   <!-- Рамка. Боковик -->
<xsl:attribute-set name="Ramka._Bokovik">
      <xsl:attribute name="name">Рамка. Боковик</xsl:attribute>
      <xsl:attribute name="type">copy</xsl:attribute>
      <xsl:attribute name="font-family">Sans</xsl:attribute>
   </xsl:attribute-set>
   <!-- Рамка. Штамп -->
<xsl:attribute-set name="Ramka._Wtamp">
      <xsl:attribute name="name">Рамка. Штамп</xsl:attribute>
      <xsl:attribute name="type">copy</xsl:attribute>
      <xsl:attribute name="font-family">Sans</xsl:attribute>
   </xsl:attribute-set>
   <!-- Рамка. Крупный -->
<xsl:attribute-set name="Ramka._Krupnyi">
      <xsl:attribute name="name">Рамка. Крупный</xsl:attribute>
      <xsl:attribute name="type">copy</xsl:attribute>
      <xsl:attribute name="font-family">Sans</xsl:attribute>
   </xsl:attribute-set>
   <!-- Титул -->
<xsl:attribute-set name="Titul" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">Титул</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
      <xsl:attribute name="type">block</xsl:attribute>
      <xsl:attribute name="font-size">14pt</xsl:attribute>
      <xsl:attribute name="margin-top">14pt</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
   </xsl:attribute-set>
   <!-- Титул. Утвержден -->
<xsl:attribute-set name="Titul._Utverjden" use-attribute-sets="Titul">
      <xsl:attribute name="name">Титул. Утвержден</xsl:attribute>
      <xsl:attribute name="base">Титул</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="margin-top">1cm</xsl:attribute>
      <xsl:attribute name="margin-right">11cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Титул. ЛУ -->
<xsl:attribute-set name="Titul._LU" use-attribute-sets="Titul">
      <xsl:attribute name="name">Титул. ЛУ</xsl:attribute>
      <xsl:attribute name="base">Титул</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="margin-right">11cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Титул. Центр -->
<xsl:attribute-set name="Titul._Centr" use-attribute-sets="Titul">
      <xsl:attribute name="name">Титул. Центр</xsl:attribute>
      <xsl:attribute name="base">Титул</xsl:attribute>
      <xsl:attribute name="font-size">14pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">14pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Титул. Заголовок -->
<xsl:attribute-set name="Titul._Zagolovok" use-attribute-sets="Titul._Centr">
      <xsl:attribute name="name">Титул. Заголовок</xsl:attribute>
      <xsl:attribute name="base">Титул. Центр</xsl:attribute>
      <xsl:attribute name="font-size">24pt</xsl:attribute>
      <xsl:attribute name="margin-top">7cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Титул. Подзаголовок -->
<xsl:attribute-set name="Titul._Podzagolovok" use-attribute-sets="Titul._Centr">
      <xsl:attribute name="name">Титул. Подзаголовок</xsl:attribute>
      <xsl:attribute name="base">Титул. Центр</xsl:attribute>
   </xsl:attribute-set>
   <!-- Титул. Обозначение -->
<xsl:attribute-set name="Titul._Oboznacenie" use-attribute-sets="Titul._Centr">
      <xsl:attribute name="name">Титул. Обозначение</xsl:attribute>
      <xsl:attribute name="base">Титул. Центр</xsl:attribute>
   </xsl:attribute-set>
   <!-- Титул. Страницы -->
<xsl:attribute-set name="Titul._Stranicy" use-attribute-sets="Titul._Centr">
      <xsl:attribute name="name">Титул. Страницы</xsl:attribute>
      <xsl:attribute name="base">Титул. Центр</xsl:attribute>
   </xsl:attribute-set>
   <!-- Титул. Год -->
<xsl:attribute-set name="Titul._God" use-attribute-sets="Titul">
      <xsl:attribute name="name">Титул. Год</xsl:attribute>
      <xsl:attribute name="base">Титул</xsl:attribute>
   </xsl:attribute-set>
   <!-- Оглавление. Заголовок -->
<xsl:attribute-set name="Oglavlenie._Zagolovok" use-attribute-sets="Zagolovok_po_centru">
      <xsl:attribute name="name">Оглавление. Заголовок</xsl:attribute>
      <xsl:attribute name="base">Заголовок по центру</xsl:attribute>
      <xsl:attribute name="font-size">18pt</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="line-height">22pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">12pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Оглавление. Точки -->
<xsl:attribute-set name="Oglavlenie._Tocki">
      <xsl:attribute name="name">Оглавление. Точки</xsl:attribute>
      <xsl:attribute name="leader-pattern">dots</xsl:attribute>
      <xsl:attribute name="leader-length.maximum">20cm</xsl:attribute>
   </xsl:attribute-set>
   <!-- Оглавление -->
<xsl:attribute-set name="Oglavlenie" use-attribute-sets="Blok_osnovnogo_teksta">
      <xsl:attribute name="name">Оглавление</xsl:attribute>
      <xsl:attribute name="base">Блок основного текста</xsl:attribute>
      <xsl:attribute name="text-align">justify</xsl:attribute>
      <xsl:attribute name="text-align-last">justify</xsl:attribute>
      <xsl:attribute name="margin-bottom">7pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Оглавление 0 -->
<xsl:attribute-set name="Oglavlenie_0" use-attribute-sets="Oglavlenie">
      <xsl:attribute name="name">Оглавление 0</xsl:attribute>
      <xsl:attribute name="base">Оглавление</xsl:attribute>
   </xsl:attribute-set>
   <!-- Оглавление 1 -->
<xsl:attribute-set name="Oglavlenie_1" use-attribute-sets="Oglavlenie">
      <xsl:attribute name="name">Оглавление 1</xsl:attribute>
      <xsl:attribute name="base">Оглавление</xsl:attribute>
      <xsl:attribute name="text-transform">uppercase</xsl:attribute>
   </xsl:attribute-set>
   <!-- Оглавление 2 -->
<xsl:attribute-set name="Oglavlenie_2" use-attribute-sets="Oglavlenie">
      <xsl:attribute name="name">Оглавление 2</xsl:attribute>
      <xsl:attribute name="base">Оглавление</xsl:attribute>
      <xsl:attribute name="margin-left">14.15pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Оглавление 3 -->
<xsl:attribute-set name="Oglavlenie_3" use-attribute-sets="Oglavlenie">
      <xsl:attribute name="name">Оглавление 3</xsl:attribute>
      <xsl:attribute name="base">Оглавление</xsl:attribute>
      <xsl:attribute name="margin-left">28.3pt</xsl:attribute>
      <xsl:attribute name="margin-bottom">6pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Строка списка -->
<xsl:attribute-set name="Stroka_spiska" use-attribute-sets="Oglavlenie">
      <xsl:attribute name="name">Строка списка</xsl:attribute>
      <xsl:attribute name="base">Оглавление</xsl:attribute>
   </xsl:attribute-set>
   <!-- ЛРИ. Шапка -->
<xsl:attribute-set name="LRI._Wapka" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">ЛРИ. Шапка</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
      <xsl:attribute name="font-size">9pt</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="border-style">solid</xsl:attribute>
      <xsl:attribute name="border-width">1pt</xsl:attribute>
      <xsl:attribute name="border-color">#000000</xsl:attribute>
   </xsl:attribute-set>
   <!-- ЛРИ. Ячейка -->
<xsl:attribute-set name="LRI._Aceika" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">ЛРИ. Ячейка</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
      <xsl:attribute name="font-size">12pt</xsl:attribute>
      <xsl:attribute name="height">12pt</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
      <xsl:attribute name="border-style">solid</xsl:attribute>
      <xsl:attribute name="border-width">1pt</xsl:attribute>
      <xsl:attribute name="border-color">#000000</xsl:attribute>
   </xsl:attribute-set>
   <!-- ЛРИ. Строка -->
<xsl:attribute-set name="LRI._Stroka" use-attribute-sets="Bazovyi">
      <xsl:attribute name="name">ЛРИ. Строка</xsl:attribute>
      <xsl:attribute name="base">Базовый</xsl:attribute>
      <xsl:attribute name="height">12pt</xsl:attribute>
   </xsl:attribute-set>
   <!-- Термин -->
<xsl:attribute-set name="Termin" use-attribute-sets="Osnovnoi_wrift">
      <xsl:attribute name="name">Термин</xsl:attribute>
      <xsl:attribute name="base">Основной шрифт</xsl:attribute>
      <xsl:attribute name="font-style">italic</xsl:attribute>
   </xsl:attribute-set>
   <!-- Файл -->
<xsl:attribute-set name="Fail" use-attribute-sets="Osnovnoi_wrift">
      <xsl:attribute name="name">Файл</xsl:attribute>
      <xsl:attribute name="base">Основной шрифт</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>
   <!-- Меню -->
<xsl:attribute-set name="Menq" use-attribute-sets="Osnovnoi_wrift">
      <xsl:attribute name="name">Меню</xsl:attribute>
      <xsl:attribute name="base">Основной шрифт</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>
   <!-- Пользовательский ввод -->
<xsl:attribute-set name="Polxzovatelxskii_vvod" use-attribute-sets="Osnovnoi_wrift">
      <xsl:attribute name="name">Пользовательский ввод</xsl:attribute>
      <xsl:attribute name="base">Основной шрифт</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>
   <!-- Код в строке -->
<xsl:attribute-set name="Kod_v_stroke" use-attribute-sets="Osnovnoi_wrift">
      <xsl:attribute name="name">Код в строке</xsl:attribute>
      <xsl:attribute name="base">Основной шрифт</xsl:attribute>
      <xsl:attribute name="font-family">Courier New</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>
   <!-- Кнопки и все такое -->
<xsl:attribute-set name="Knopki_i_vse_takoe" use-attribute-sets="Osnovnoi_wrift">
      <xsl:attribute name="name">Кнопки и все такое</xsl:attribute>
      <xsl:attribute name="base">Основной шрифт</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>
   <!-- Цитата в строке -->
<xsl:attribute-set name="Citata_v_stroke" use-attribute-sets="Osnovnoi_wrift">
      <xsl:attribute name="name">Цитата в строке</xsl:attribute>
      <xsl:attribute name="base">Основной шрифт</xsl:attribute>
      <xsl:attribute name="font-style">italic</xsl:attribute>
   </xsl:attribute-set>
   <xsl:template match="fo:leader" mode="foname" priority="30">
      <xsl:text>fo:leader</xsl:text>
   </xsl:template>
   <xsl:template match="image" mode="foname" priority="48">
      <xsl:text>fo:external-graphic</xsl:text>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Шрифт']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Wrift" role="{concat(name(),'/Шрифт')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Базовый']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Bazovyi" role="{concat(name(),'/Базовый')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Блок основного текста']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Blok_osnovnogo_teksta"
               role="{concat(name(),'/Блок основного текста')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Блок иллюстрации']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Blok_illqstracii"
               role="{concat(name(),'/Блок иллюстрации')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Внутренний блок текста']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Vnutrennii_blok_teksta"
               role="{concat(name(),'/Внутренний блок текста')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Основной шрифт']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Osnovnoi_wrift"
               role="{concat(name(),'/Основной шрифт')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Верхний колонтитул. Обозначение']" mode="fostyle"
                 priority="91">
      <fostyle xsl:use-attribute-sets="Verhnii_kolontitul._Oboznacenie"
               role="{concat(name(),'/Верхний колонтитул. Обозначение')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Верхний колонтитул. Номер страницы']" mode="fostyle"
                 priority="91">
      <fostyle xsl:use-attribute-sets="Verhnii_kolontitul._Nomer_stranicy"
               role="{concat(name(),'/Верхний колонтитул. Номер страницы')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Заголовок']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Zagolovok" role="{concat(name(),'/Заголовок')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Пустой заголовок']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Pustoi_zagolovok"
               role="{concat(name(),'/Пустой заголовок')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Заголовок по центру']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Zagolovok_po_centru"
               role="{concat(name(),'/Заголовок по центру')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Заголовок с отступом']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Zagolovok_s_otstupom"
               role="{concat(name(),'/Заголовок с отступом')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Заголовок перечня']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Zagolovok_perecna"
               role="{concat(name(),'/Заголовок перечня')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Заголовок 1']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Zagolovok_1" role="{concat(name(),'/Заголовок 1')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Заголовок 2']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Zagolovok_2" role="{concat(name(),'/Заголовок 2')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Заголовок 3']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Zagolovok_3" role="{concat(name(),'/Заголовок 3')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Заголовок 4']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Zagolovok_4" role="{concat(name(),'/Заголовок 4')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Заголовок 5']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Zagolovok_5" role="{concat(name(),'/Заголовок 5')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Заголовок 6']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Zagolovok_6" role="{concat(name(),'/Заголовок 6')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Основной']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Osnovnoi" role="{concat(name(),'/Основной')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Список']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Spisok" role="{concat(name(),'/Список')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Главный список']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Glavnyi_spisok"
               role="{concat(name(),'/Главный список')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Главный список в таблице']" mode="fostyle"
                 priority="91">
      <fostyle xsl:use-attribute-sets="Glavnyi_spisok_v_tablice"
               role="{concat(name(),'/Главный список в таблице')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Вложенный список']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Vlojennyi_spisok"
               role="{concat(name(),'/Вложенный список')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Пункт списка']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Punkt_spiska" role="{concat(name(),'/Пункт списка')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Первый пункт списка']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Pervyi_punkt_spiska"
               role="{concat(name(),'/Первый пункт списка')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Непервый пункт списка']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Nepervyi_punkt_spiska"
               role="{concat(name(),'/Непервый пункт списка')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Пункт списка. Текст']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Punkt_spiska._Tekst"
               role="{concat(name(),'/Пункт списка. Текст')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Маркер списка. Текст']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Marker_spiska._Tekst"
               role="{concat(name(),'/Маркер списка. Текст')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Пункт списка 1. Текст']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Punkt_spiska_1._Tekst"
               role="{concat(name(),'/Пункт списка 1. Текст')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Пункт списка 2. Текст']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Punkt_spiska_2._Tekst"
               role="{concat(name(),'/Пункт списка 2. Текст')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Пункт списка 3. Текст']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Punkt_spiska_3._Tekst"
               role="{concat(name(),'/Пункт списка 3. Текст')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Таблица. Пункт списка. Текст']" mode="fostyle"
                 priority="91">
      <fostyle xsl:use-attribute-sets="Tablica._Punkt_spiska._Tekst"
               role="{concat(name(),'/Таблица. Пункт списка. Текст')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Таблица. Маркер списка. Текст']" mode="fostyle"
                 priority="91">
      <fostyle xsl:use-attribute-sets="Tablica._Marker_spiska._Tekst"
               role="{concat(name(),'/Таблица. Маркер списка. Текст')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Таблица. Пункт списка 1. Текст']" mode="fostyle"
                 priority="91">
      <fostyle xsl:use-attribute-sets="Tablica._Punkt_spiska_1._Tekst"
               role="{concat(name(),'/Таблица. Пункт списка 1. Текст')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Таблица. Пункт списка 2. Текст']" mode="fostyle"
                 priority="91">
      <fostyle xsl:use-attribute-sets="Tablica._Punkt_spiska_2._Tekst"
               role="{concat(name(),'/Таблица. Пункт списка 2. Текст')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Таблица. Пункт списка 3. Текст']" mode="fostyle"
                 priority="91">
      <fostyle xsl:use-attribute-sets="Tablica._Punkt_spiska_3._Tekst"
               role="{concat(name(),'/Таблица. Пункт списка 3. Текст')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Рисунок']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Risunok" role="{concat(name(),'/Рисунок')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Рисунок. Изображение']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Risunok._Izobrajenie"
               role="{concat(name(),'/Рисунок. Изображение')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Рисунок. Подпись']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Risunok._Podpisx"
               role="{concat(name(),'/Рисунок. Подпись')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Таблица. Блок']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Tablica._Blok" role="{concat(name(),'/Таблица. Блок')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Таблица. Название']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Tablica._Nazvanie"
               role="{concat(name(),'/Таблица. Название')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Таблица']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Tablica" role="{concat(name(),'/Таблица')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Таблица. Шапка']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Tablica._Wapka"
               role="{concat(name(),'/Таблица. Шапка')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Таблица. Строка']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Tablica._Stroka"
               role="{concat(name(),'/Таблица. Строка')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Таблица. Пустая строка']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Tablica._Pustaa_stroka"
               role="{concat(name(),'/Таблица. Пустая строка')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Таблица. Ячейка']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Tablica._Aceika"
               role="{concat(name(),'/Таблица. Ячейка')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Таблица. Подзаголовок']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Tablica._Podzagolovok"
               role="{concat(name(),'/Таблица. Подзаголовок')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Таблица. Номер строки']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Tablica._Nomer_stroki"
               role="{concat(name(),'/Таблица. Номер строки')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Таблица. Итог по строке']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Tablica._Itog_po_stroke"
               role="{concat(name(),'/Таблица. Итог по строке')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='ВНИМАНИЕ']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="VNIMANIE" role="{concat(name(),'/ВНИМАНИЕ')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Листинг']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Listing" role="{concat(name(),'/Листинг')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Форма']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Forma" role="{concat(name(),'/Форма')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Абзац в форме']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Abzac_v_forme" role="{concat(name(),'/Абзац в форме')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Приложение. Заголовок']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Prilojenie._Zagolovok"
               role="{concat(name(),'/Приложение. Заголовок')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Приложение. Номер']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Prilojenie._Nomer"
               role="{concat(name(),'/Приложение. Номер')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Приложение. Обязательность']" mode="fostyle"
                 priority="91">
      <fostyle xsl:use-attribute-sets="Prilojenie._Obazatelxnostx"
               role="{concat(name(),'/Приложение. Обязательность')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Приложение. Название']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Prilojenie._Nazvanie"
               role="{concat(name(),'/Приложение. Название')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Рамка. Боковик']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Ramka._Bokovik"
               role="{concat(name(),'/Рамка. Боковик')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Рамка. Штамп']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Ramka._Wtamp" role="{concat(name(),'/Рамка. Штамп')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Рамка. Крупный']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Ramka._Krupnyi"
               role="{concat(name(),'/Рамка. Крупный')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Титул']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Titul" role="{concat(name(),'/Титул')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Титул. Утвержден']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Titul._Utverjden"
               role="{concat(name(),'/Титул. Утвержден')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Титул. ЛУ']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Titul._LU" role="{concat(name(),'/Титул. ЛУ')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Титул. Центр']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Titul._Centr" role="{concat(name(),'/Титул. Центр')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Титул. Заголовок']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Titul._Zagolovok"
               role="{concat(name(),'/Титул. Заголовок')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Титул. Подзаголовок']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Titul._Podzagolovok"
               role="{concat(name(),'/Титул. Подзаголовок')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Титул. Обозначение']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Titul._Oboznacenie"
               role="{concat(name(),'/Титул. Обозначение')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Титул. Страницы']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Titul._Stranicy"
               role="{concat(name(),'/Титул. Страницы')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Титул. Год']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Titul._God" role="{concat(name(),'/Титул. Год')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Оглавление. Заголовок']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Oglavlenie._Zagolovok"
               role="{concat(name(),'/Оглавление. Заголовок')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Оглавление. Точки']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Oglavlenie._Tocki"
               role="{concat(name(),'/Оглавление. Точки')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Оглавление']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Oglavlenie" role="{concat(name(),'/Оглавление')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Оглавление 0']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Oglavlenie_0" role="{concat(name(),'/Оглавление 0')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Оглавление 1']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Oglavlenie_1" role="{concat(name(),'/Оглавление 1')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Оглавление 2']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Oglavlenie_2" role="{concat(name(),'/Оглавление 2')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Оглавление 3']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Oglavlenie_3" role="{concat(name(),'/Оглавление 3')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Строка списка']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Stroka_spiska" role="{concat(name(),'/Строка списка')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='ЛРИ. Шапка']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="LRI._Wapka" role="{concat(name(),'/ЛРИ. Шапка')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='ЛРИ. Ячейка']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="LRI._Aceika" role="{concat(name(),'/ЛРИ. Ячейка')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='ЛРИ. Строка']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="LRI._Stroka" role="{concat(name(),'/ЛРИ. Строка')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Термин']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Termin" role="{concat(name(),'/Термин')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Файл']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Fail" role="{concat(name(),'/Файл')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Меню']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Menq" role="{concat(name(),'/Меню')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Пользовательский ввод']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Polxzovatelxskii_vvod"
               role="{concat(name(),'/Пользовательский ввод')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Код в строке']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Kod_v_stroke" role="{concat(name(),'/Код в строке')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Кнопки и все такое']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Knopki_i_vse_takoe"
               role="{concat(name(),'/Кнопки и все такое')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='Цитата в строке']" mode="fostyle" priority="91">
      <fostyle xsl:use-attribute-sets="Citata_v_stroke"
               role="{concat(name(),'/Цитата в строке')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='border.sidebar']" mode="fostyle" priority="1">
      <fostyle xsl:use-attribute-sets="Ramka._Bokovik"
               role="{concat(name(),'/Рамка. Боковик')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='border.details']" mode="fostyle" priority="2">
      <fostyle xsl:use-attribute-sets="Ramka._Wtamp" role="{concat(name(),'/Рамка. Штамп')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.approved']" mode="fostyle" priority="3">
      <fostyle xsl:use-attribute-sets="Titul._Utverjden"
               role="{concat(name(),'/Титул. Утвержден')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.LU']" mode="fostyle" priority="4">
      <fostyle xsl:use-attribute-sets="Titul._LU" role="{concat(name(),'/Титул. ЛУ')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.title']" mode="fostyle" priority="5">
      <fostyle xsl:use-attribute-sets="Titul._Zagolovok"
               role="{concat(name(),'/Титул. Заголовок')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.subtitle']" mode="fostyle" priority="6">
      <fostyle xsl:use-attribute-sets="Titul._Podzagolovok"
               role="{concat(name(),'/Титул. Подзаголовок')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.docnumber']" mode="fostyle" priority="7">
      <fostyle xsl:use-attribute-sets="Titul._Oboznacenie"
               role="{concat(name(),'/Титул. Обозначение')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.pages']" mode="fostyle" priority="8">
      <fostyle xsl:use-attribute-sets="Titul._Stranicy"
               role="{concat(name(),'/Титул. Страницы')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:oclass(.)='cover.year']" mode="fostyle" priority="9">
      <fostyle xsl:use-attribute-sets="Titul._God" role="{concat(name(),'/Титул. Год')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='auxiliary']" mode="fostyle" priority="10">
      <fostyle xsl:use-attribute-sets="Zagolovok_perecna"
               role="{concat(name(),'/Заголовок перечня')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='intro']" mode="fostyle"
                 priority="11">
      <fostyle xsl:use-attribute-sets="Zagolovok_1" role="{concat(name(),'/Заголовок 1')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and cpm:sectype(.)='intro']" mode="fostyle"
                 priority="12">
      <fostyle xsl:use-attribute-sets="Zagolovok_2" role="{concat(name(),'/Заголовок 2')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and cpm:sectype(.)='intro']" mode="fostyle"
                 priority="13">
      <fostyle xsl:use-attribute-sets="Zagolovok_3" role="{concat(name(),'/Заголовок 3')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and cpm:sectype(.)='intro']" mode="fostyle"
                 priority="14">
      <fostyle xsl:use-attribute-sets="Zagolovok_4" role="{concat(name(),'/Заголовок 4')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="fostyle"
                 priority="15">
      <fostyle xsl:use-attribute-sets="Zagolovok_1" role="{concat(name(),'/Заголовок 1')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="fostyle"
                 priority="16">
      <fostyle xsl:use-attribute-sets="Zagolovok_2" role="{concat(name(),'/Заголовок 2')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="fostyle"
                 priority="17">
      <fostyle xsl:use-attribute-sets="Zagolovok_3" role="{concat(name(),'/Заголовок 3')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="fostyle"
                 priority="18">
      <fostyle xsl:use-attribute-sets="Zagolovok_4" role="{concat(name(),'/Заголовок 4')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=5 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="fostyle"
                 priority="19">
      <fostyle xsl:use-attribute-sets="Zagolovok_5" role="{concat(name(),'/Заголовок 5')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=6 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="fostyle"
                 priority="20">
      <fostyle xsl:use-attribute-sets="Zagolovok_6" role="{concat(name(),'/Заголовок 6')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='slacking']" mode="fostyle" priority="21">
      <fostyle xsl:use-attribute-sets="Pustoi_zagolovok"
               role="{concat(name(),'/Пустой заголовок')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='appendix']" mode="fostyle"
                 priority="22">
      <fostyle xsl:use-attribute-sets="Prilojenie._Zagolovok"
               role="{concat(name(),'/Приложение. Заголовок')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="fostyle"
                 priority="23">
      <fostyle xsl:use-attribute-sets="Zagolovok_2" role="{concat(name(),'/Заголовок 2')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="fostyle"
                 priority="24">
      <fostyle xsl:use-attribute-sets="Zagolovok_3" role="{concat(name(),'/Заголовок 3')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="fostyle"
                 priority="25">
      <fostyle xsl:use-attribute-sets="Zagolovok_4" role="{concat(name(),'/Заголовок 4')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=5 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="fostyle"
                 priority="26">
      <fostyle xsl:use-attribute-sets="Zagolovok_5" role="{concat(name(),'/Заголовок 5')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=6 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="fostyle"
                 priority="27">
      <fostyle xsl:use-attribute-sets="Zagolovok_6" role="{concat(name(),'/Заголовок 6')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='toctopic']" mode="fostyle" priority="28">
      <fostyle xsl:use-attribute-sets="Oglavlenie._Zagolovok"
               role="{concat(name(),'/Оглавление. Заголовок')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='tontopic']" mode="fostyle" priority="29">
      <fostyle xsl:use-attribute-sets="Zagolovok_perecna"
               role="{concat(name(),'/Заголовок перечня')}"/>
   </xsl:template>
   <xsl:template match="fo:leader" mode="fostyle" priority="30">
      <fostyle xsl:use-attribute-sets="Oglavlenie._Tocki"
               role="{concat(name(),'/Оглавление. Точки')}"/>
   </xsl:template>
   <xsl:template match="fo:block[cpm:numlevel(.)=0 and cpm:oclass(.)='tocentry']" mode="fostyle"
                 priority="31">
      <fostyle xsl:use-attribute-sets="Oglavlenie_0" role="{concat(name(),'/Оглавление 0')}"/>
   </xsl:template>
   <xsl:template match="fo:block[cpm:numlevel(.)=1 and cpm:oclass(.)='tocentry']" mode="fostyle"
                 priority="32">
      <fostyle xsl:use-attribute-sets="Oglavlenie_1" role="{concat(name(),'/Оглавление 1')}"/>
   </xsl:template>
   <xsl:template match="fo:block[cpm:numlevel(.)=2 and cpm:oclass(.)='tocentry']" mode="fostyle"
                 priority="33">
      <fostyle xsl:use-attribute-sets="Oglavlenie_2" role="{concat(name(),'/Оглавление 2')}"/>
   </xsl:template>
   <xsl:template match="fo:block[cpm:numlevel(.)=3 and cpm:oclass(.)='tocentry']" mode="fostyle"
                 priority="34">
      <fostyle xsl:use-attribute-sets="Oglavlenie_3" role="{concat(name(),'/Оглавление 3')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:noclass(.) and cpm:is_normal(.)]" mode="fostyle" priority="35">
      <fostyle xsl:use-attribute-sets="Osnovnoi" role="{concat(name(),'/Основной')}"/>
   </xsl:template>
   <xsl:template match="p[cpm:in_table(.)]" mode="fostyle" priority="36">
      <fostyle xsl:use-attribute-sets="Vnutrennii_blok_teksta"
               role="{concat(name(),'/Внутренний блок текста')}"/>
   </xsl:template>
   <xsl:template match="section/title" mode="fostyle" priority="37">
      <fostyle xsl:use-attribute-sets="Zagolovok_4" role="{concat(name(),'/Заголовок 4')}"/>
   </xsl:template>
   <xsl:template match="table" mode="fostyle" priority="38">
      <fostyle xsl:use-attribute-sets="Tablica._Blok" role="{concat(name(),'/Таблица. Блок')}"/>
   </xsl:template>
   <xsl:template match="tgroup" mode="fostyle" priority="39">
      <fostyle xsl:use-attribute-sets="Tablica" role="{concat(name(),'/Таблица')}"/>
   </xsl:template>
   <xsl:template match="table/title" mode="fostyle" priority="40">
      <fostyle xsl:use-attribute-sets="Tablica._Nazvanie"
               role="{concat(name(),'/Таблица. Название')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='appendix']//table/title" mode="fostyle" priority="41">
      <fostyle xsl:use-attribute-sets="Tablica._Nazvanie"
               role="{concat(name(),'/Таблица. Название')}"/>
   </xsl:template>
   <xsl:template match="thead/row" mode="fostyle" priority="42">
      <fostyle xsl:use-attribute-sets="Tablica._Wapka"
               role="{concat(name(),'/Таблица. Шапка')}"/>
   </xsl:template>
   <xsl:template match="table[cpm:noclass(.)]//entry" mode="fostyle" priority="43">
      <fostyle xsl:use-attribute-sets="Tablica._Aceika"
               role="{concat(name(),'/Таблица. Ячейка')}"/>
   </xsl:template>
   <xsl:template match="fig" mode="fostyle" priority="44">
      <fostyle xsl:use-attribute-sets="Risunok" role="{concat(name(),'/Рисунок')}"/>
   </xsl:template>
   <xsl:template match="fig/title" mode="fostyle" priority="45">
      <fostyle xsl:use-attribute-sets="" role="{concat(name(),'/')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='appendix']//fig/title" mode="fostyle" priority="46">
      <fostyle xsl:use-attribute-sets="" role="{concat(name(),'/')}"/>
   </xsl:template>
   <xsl:template match="fo:block[cpm:oclass(.)='image']" mode="fostyle" priority="47">
      <fostyle xsl:use-attribute-sets="Risunok._Izobrajenie"
               role="{concat(name(),'/Рисунок. Изображение')}"/>
   </xsl:template>
   <xsl:template match="image" mode="fostyle" priority="48">
      <fostyle xsl:use-attribute-sets="" role="{concat(name(),'/')}"/>
   </xsl:template>
   <xsl:template match="fig/p" mode="fostyle" priority="49">
      <fostyle xsl:use-attribute-sets="" role="{concat(name(),'/')}"/>
   </xsl:template>
   <xsl:template match="fo:list-item-label/fo:block[cpm:noclass(.)]" mode="fostyle"
                 priority="50">
      <fostyle xsl:use-attribute-sets="Marker_spiska._Tekst"
               role="{concat(name(),'/Маркер списка. Текст')}"/>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=1 and cpm:noclass(.)]" mode="fostyle"
                 priority="51">
      <fostyle xsl:use-attribute-sets="Punkt_spiska_1._Tekst"
               role="{concat(name(),'/Пункт списка 1. Текст')}"/>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=2 and cpm:noclass(.)]" mode="fostyle"
                 priority="52">
      <fostyle xsl:use-attribute-sets="Punkt_spiska_2._Tekst"
               role="{concat(name(),'/Пункт списка 2. Текст')}"/>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=3 and cpm:noclass(.)]" mode="fostyle"
                 priority="53">
      <fostyle xsl:use-attribute-sets="Punkt_spiska_3._Tekst"
               role="{concat(name(),'/Пункт списка 3. Текст')}"/>
   </xsl:template>
   <xsl:template match="fo:list-item-label/fo:block[cpm:in_table(.)]" mode="fostyle"
                 priority="54">
      <fostyle xsl:use-attribute-sets="Tablica._Marker_spiska._Tekst"
               role="{concat(name(),'/Таблица. Маркер списка. Текст')}"/>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=1 and cpm:in_table(.)]" mode="fostyle"
                 priority="55">
      <fostyle xsl:use-attribute-sets="Tablica._Punkt_spiska_1._Tekst"
               role="{concat(name(),'/Таблица. Пункт списка 1. Текст')}"/>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=2 and cpm:in_table(.)]" mode="fostyle"
                 priority="56">
      <fostyle xsl:use-attribute-sets="Tablica._Punkt_spiska_2._Tekst"
               role="{concat(name(),'/Таблица. Пункт списка 2. Текст')}"/>
   </xsl:template>
   <xsl:template match="fo:list-item-body[cpm:numlevel(.)=3 and cpm:in_table(.)]" mode="fostyle"
                 priority="57">
      <fostyle xsl:use-attribute-sets="Tablica._Punkt_spiska_3._Tekst"
               role="{concat(name(),'/Таблица. Пункт списка 3. Текст')}"/>
   </xsl:template>
   <xsl:template match="ul" mode="fostyle" priority="58">
      <fostyle xsl:use-attribute-sets="Glavnyi_spisok"
               role="{concat(name(),'/Главный список')}"/>
   </xsl:template>
   <xsl:template match="ul[ancestor::li]|ul[cpm:in_table(.)]" mode="fostyle" priority="59">
      <fostyle xsl:use-attribute-sets="Vlojennyi_spisok"
               role="{concat(name(),'/Вложенный список')}"/>
   </xsl:template>
   <xsl:template match="ul/li[not(ancestor::li) and position()=1]" mode="fostyle" priority="60">
      <fostyle xsl:use-attribute-sets="Pervyi_punkt_spiska"
               role="{concat(name(),'/Первый пункт списка')}"/>
   </xsl:template>
   <xsl:template match="ul/li[ancestor::li or position()!=1]" mode="fostyle" priority="61">
      <fostyle xsl:use-attribute-sets="Nepervyi_punkt_spiska"
               role="{concat(name(),'/Непервый пункт списка')}"/>
   </xsl:template>
   <xsl:template match="ol" mode="fostyle" priority="62">
      <fostyle xsl:use-attribute-sets="Glavnyi_spisok"
               role="{concat(name(),'/Главный список')}"/>
   </xsl:template>
   <xsl:template match="ol[ancestor::li]|ol[cpm:in_table(.)]" mode="fostyle" priority="63">
      <fostyle xsl:use-attribute-sets="Vlojennyi_spisok"
               role="{concat(name(),'/Вложенный список')}"/>
   </xsl:template>
   <xsl:template match="ol/li[not(ancestor::li) and position()=1]" mode="fostyle" priority="64">
      <fostyle xsl:use-attribute-sets="Pervyi_punkt_spiska"
               role="{concat(name(),'/Первый пункт списка')}"/>
   </xsl:template>
   <xsl:template match="ol/li[ancestor::li or position()!=1]" mode="fostyle" priority="65">
      <fostyle xsl:use-attribute-sets="Nepervyi_punkt_spiska"
               role="{concat(name(),'/Непервый пункт списка')}"/>
   </xsl:template>
   <xsl:template match="steps" mode="fostyle" priority="66">
      <fostyle xsl:use-attribute-sets="Glavnyi_spisok"
               role="{concat(name(),'/Главный список')}"/>
   </xsl:template>
   <xsl:template match="step[position()=1]" mode="fostyle" priority="67">
      <fostyle xsl:use-attribute-sets="Pervyi_punkt_spiska"
               role="{concat(name(),'/Первый пункт списка')}"/>
   </xsl:template>
   <xsl:template match="step[position()!=1]" mode="fostyle" priority="68">
      <fostyle xsl:use-attribute-sets="Nepervyi_punkt_spiska"
               role="{concat(name(),'/Непервый пункт списка')}"/>
   </xsl:template>
   <xsl:template match="*[cpm:oclass(.)='notecaption']" mode="fostyle" priority="69">
      <fostyle xsl:use-attribute-sets="VNIMANIE" role="{concat(name(),'/ВНИМАНИЕ')}"/>
   </xsl:template>
   <xsl:template match="pre" mode="fostyle" priority="70">
      <fostyle xsl:use-attribute-sets="Listing" role="{concat(name(),'/Листинг')}"/>
   </xsl:template>
   <xsl:template match="div[cpm:oclass(.)='form']" mode="fostyle" priority="71">
      <fostyle xsl:use-attribute-sets="Forma" role="{concat(name(),'/Форма')}"/>
   </xsl:template>
   <xsl:template match="div[cpm:oclass(.)='form']/p" mode="fostyle" priority="72">
      <fostyle xsl:use-attribute-sets="Abzac_v_forme" role="{concat(name(),'/Абзац в форме')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='listregizm']" mode="fostyle" priority="73">
      <fostyle xsl:use-attribute-sets="Zagolovok_1" role="{concat(name(),'/Заголовок 1')}"/>
   </xsl:template>
   <xsl:template match="table[cpm:oclass(.)='listregizm']//thead/row/entry" mode="fostyle"
                 priority="74">
      <fostyle xsl:use-attribute-sets="LRI._Wapka" role="{concat(name(),'/ЛРИ. Шапка')}"/>
   </xsl:template>
   <xsl:template match="table[cpm:oclass(.)='listregizm']//tbody/row/entry" mode="fostyle"
                 priority="75">
      <fostyle xsl:use-attribute-sets="LRI._Aceika" role="{concat(name(),'/ЛРИ. Ячейка')}"/>
   </xsl:template>
   <xsl:template match="table[cpm:oclass(.)='listregizm']//tbody/row" mode="fostyle"
                 priority="76">
      <fostyle xsl:use-attribute-sets="LRI._Stroka" role="{concat(name(),'/ЛРИ. Строка')}"/>
   </xsl:template>
   <xsl:template match="apiname" mode="fostyle" priority="77">
      <fostyle xsl:use-attribute-sets="Kod_v_stroke" role="{concat(name(),'/Код в строке')}"/>
   </xsl:template>
   <xsl:template match="cite" mode="fostyle" priority="78">
      <fostyle xsl:use-attribute-sets="Citata_v_stroke"
               role="{concat(name(),'/Цитата в строке')}"/>
   </xsl:template>
   <xsl:template match="codeph" mode="fostyle" priority="79">
      <fostyle xsl:use-attribute-sets="Kod_v_stroke" role="{concat(name(),'/Код в строке')}"/>
   </xsl:template>
   <xsl:template match="filepath" mode="fostyle" priority="80">
      <fostyle xsl:use-attribute-sets="Fail" role="{concat(name(),'/Файл')}"/>
   </xsl:template>
   <xsl:template match="keyword" mode="fostyle" priority="81">
      <fostyle xsl:use-attribute-sets="Osnovnoi_wrift"
               role="{concat(name(),'/Основной шрифт')}"/>
   </xsl:template>
   <xsl:template match="menucascade" mode="fostyle" priority="82">
      <fostyle xsl:use-attribute-sets="Menq" role="{concat(name(),'/Меню')}"/>
   </xsl:template>
   <xsl:template match="term" mode="fostyle" priority="83">
      <fostyle xsl:use-attribute-sets="Termin" role="{concat(name(),'/Термин')}"/>
   </xsl:template>
   <xsl:template match="uicontrol" mode="fostyle" priority="84">
      <fostyle xsl:use-attribute-sets="Knopki_i_vse_takoe"
               role="{concat(name(),'/Кнопки и все такое')}"/>
   </xsl:template>
   <xsl:template match="userinput" mode="fostyle" priority="85">
      <fostyle xsl:use-attribute-sets="Kod_v_stroke" role="{concat(name(),'/Код в строке')}"/>
   </xsl:template>
   <xsl:template match="xmlatt" mode="fostyle" priority="86">
      <fostyle xsl:use-attribute-sets="Kod_v_stroke" role="{concat(name(),'/Код в строке')}"/>
   </xsl:template>
   <xsl:template match="xmlelement" mode="fostyle" priority="87">
      <fostyle xsl:use-attribute-sets="Kod_v_stroke" role="{concat(name(),'/Код в строке')}"/>
   </xsl:template>
   <xsl:template match="cpm:wrapper" mode="fostyle" priority="88">
      <fostyle xsl:use-attribute-sets="Osnovnoi" role="{concat(name(),'/Основной')}"/>
   </xsl:template>
   <xsl:template match="cpm:keyword" mode="fostyle" priority="89">
      <fostyle xsl:use-attribute-sets="Osnovnoi" role="{concat(name(),'/Основной')}"/>
   </xsl:template>
   <xsl:template match="*[contains(@class, 'topic/body')]//p[cpm:oclass(.)='shortdesc']"
                 mode="fostyle"
                 priority="90">
      <fostyle xsl:use-attribute-sets="Osnovnoi" role="{concat(name(),'/Основной')}"/>
   </xsl:template>
   <xsl:template match="title[cpm:sectype(.)='auxiliary']" mode="numseq" priority="26">
      <numseq name="Без номеров" type="dummy" mode="decimal"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="numseq"
                 priority="31">
      <numseq name="Разделы" type="arabic" mode="decimal" caption="%n "/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="numseq"
                 priority="32">
      <numseq name="Разделы" type="arabic" mode="decimal" caption="%n "/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="numseq"
                 priority="33">
      <numseq name="Разделы" type="arabic" mode="decimal" caption="%n "/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="numseq"
                 priority="34">
      <numseq name="Разделы" type="arabic" mode="decimal" caption="%n "/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=5 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="numseq"
                 priority="35">
      <numseq name="Разделы" type="arabic" mode="decimal" caption="%n "/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=6 and cpm:sectype(.)='main' and not(starts-with(., 'Перечень'))]"
                 mode="numseq"
                 priority="36">
      <numseq name="Разделы" type="arabic" mode="decimal" caption="%n "/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=1 and cpm:sectype(.)='appendix']" mode="numseq"
                 priority="38">
      <numseq name="Приложения" type="char" mode="decimal" chars="АБВГДЕЖИКЛМППРСТУФХЦЧШЩЭЮЯ"
              caption="Приложение %n. "/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=2 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="numseq"
                 priority="39">
      <numseq name="Разделы приложений" type="arabic" mode="decimal" caption="%n "
              base="Приложения"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=3 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="numseq"
                 priority="40">
      <numseq name="Разделы приложений" type="arabic" mode="decimal" caption="%n "
              base="Приложения"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=4 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="numseq"
                 priority="41">
      <numseq name="Разделы приложений" type="arabic" mode="decimal" caption="%n "
              base="Приложения"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=5 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="numseq"
                 priority="42">
      <numseq name="Разделы приложений" type="arabic" mode="decimal" caption="%n "
              base="Приложения"/>
   </xsl:template>
   <xsl:template match="title[cpm:numlevel(.)=6 and ancestor::*[cpm:sectype(.)='appendix']]"
                 mode="numseq"
                 priority="43">
      <numseq name="Разделы приложений" type="arabic" mode="decimal" caption="%n "
              base="Приложения"/>
   </xsl:template>
   <xsl:template match="table/title" mode="numseq" priority="56">
      <numseq name="Таблицы" type="arabic" mode="flat" caption="Таблица %n — "/>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='appendix']//table/title" mode="numseq" priority="57">
      <numseq name="Таблицы в приложении" type="arabic" mode="flat" caption="Таблица %n — "
              base="Приложения"/>
   </xsl:template>
   <xsl:template match="fig" mode="numseq" priority="60"/>
   <xsl:template match="fig/title" mode="numseq" priority="61">
      <numseq name="Рисунки" type="arabic" mode="flat" caption="Рисунок %n — "/>
   </xsl:template>
   <xsl:template match="*[cpm:sectype(.)='appendix']//fig/title" mode="numseq" priority="62">
      <numseq name="Рисунки в приложении" type="arabic" mode="flat" caption="Рисунок %n — "
              base="Приложения"/>
   </xsl:template>
   <xsl:template match="ul[ancestor::li]|ul[cpm:in_table(.)]" mode="numseq" priority="75">
      <numseq name="Блок списка" type="dummy" mode="decimal"/>
   </xsl:template>
   <xsl:template match="ol" mode="numseq" priority="78">
      <numseq name="Блок списка" type="dummy" mode="decimal"/>
   </xsl:template>
   <xsl:template match="ol[ancestor::li]|ol[cpm:in_table(.)]" mode="numseq" priority="79">
      <numseq name="Блок списка" type="dummy" mode="decimal"/>
   </xsl:template>
   <xsl:template match="ol/li[not(ancestor::li) and position()=1]" mode="numseq" priority="80">
      <numseq name="Пункт списка" type="arabic" mode="flat" caption="%n." base="Блок списка"/>
   </xsl:template>
   <xsl:template match="ol/li[ancestor::li or position()!=1]" mode="numseq" priority="81">
      <numseq name="Пункт списка" type="arabic" mode="flat" caption="%n." base="Блок списка"/>
   </xsl:template>
   <xsl:template match="steps" mode="numseq" priority="82">
      <numseq name="Блок списка" type="dummy" mode="decimal"/>
   </xsl:template>
   <xsl:template match="step[position()=1]" mode="numseq" priority="83">
      <numseq name="Пункт списка" type="arabic" mode="flat" caption="%n." base="Блок списка"/>
   </xsl:template>
   <xsl:template match="step[position()!=1]" mode="numseq" priority="84">
      <numseq name="Пункт списка" type="arabic" mode="flat" caption="%n." base="Блок списка"/>
   </xsl:template>
</xsl:stylesheet>