<?xml version="1.0" encoding="UTF-8"?>
<!-- Created with Liquid Studio 2019 (https://www.liquid-technologies.com) -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:fn="http://www.w3.org/2005/xpath-functions" version="1.0">
    <xsl:output encoding="UTF-8" method="xml"/>
    <xsl:template match="/">
        <fo:root>

            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4" margin-top="10mm" margin-bottom="10mm" margin-left="10mm" margin-right="10mm">
                    <fo:region-body region-name="body" margin-top="25mm" margin-bottom="20mm"/>
                    <fo:region-before region-name="header"/>
                    <fo:region-after region-name="bottom"/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <xsl:for-each select="Project/Bands/Band">
                <fo:page-sequence master-reference="A4">
                    <fo:static-content flow-name="header">
                        <fo:block font-size="16pt" text-align="center" font-weight="bold" font-style="italic">
                            <xsl:value-of select="/Project/Head/Title"/>
                        </fo:block>
                        <xsl:for-each select="/Project/Head/Authors/Author">
                            <fo:block font-size="12pt" text-align="center">
                                <xsl:value-of select="."/>
                            </fo:block>
                        </xsl:for-each>
                    </fo:static-content>

                    <fo:static-content flow-name="bottom">
                        <fo:block text-align="center">
                            Strona <fo:page-number/>
                        </fo:block>
                        <fo:block font-size="8pt" text-align="right">
                            <xsl:value-of select="/Project/RaportDate"/>
                        </fo:block>
                    </fo:static-content>

                    <fo:flow flow-name="body">
                        <fo:table table-layout="fixed" width="100%" font-size="10pt" border-color="black" border-width="0.5mm" border-style="solid" text-align="center" display-align="center" space-after="5mm">
                            <fo:table-body>

                                <fo:table-row>
                                    <fo:table-cell font-size="12pt" border-width="0.5mm" border-style="solid" number-columns-spanned="4">
                                        <fo:block font-weight="bold" color="#FF0000">
                                            Zespół
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>

                                <fo:table-row>
                                    <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid" number-columns-spanned="2">
                                        <fo:block>
                                            <xsl:value-of select="BandName"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid" number-columns-spanned="2">
                                        <fo:block>
                                            <xsl:value-of select="Nationality"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>

                                <fo:table-row>
                                    <fo:table-cell font-size="12pt" border-width="0.5mm" border-style="solid" number-columns-spanned="4">
                                        <fo:block font-weight="bold" color="#FF0000">
                                            Członkowie
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>

                                <xsl:for-each select="Members/Member">
                                    <fo:table-row>
                                        <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid" number-columns-spanned="4">
                                            <fo:block>
                                                <xsl:value-of select="."/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:for-each>

                                <fo:table-row>
                                    <fo:table-cell font-size="12pt" border-width="0.5mm" border-style="solid" number-columns-spanned="4">
                                        <fo:block font-weight="bold" color="#FF0000">
                                            Albumy
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>

                                <xsl:for-each select="Albums/Album">
                                    <fo:table-row>
                                        <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid">
                                            <fo:block font-weight="bold" color="#FF0000">
                                                Tytuł
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid">
                                            <fo:block font-weight="bold" color="#FF0000">
                                                Liczba Utworów
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid">
                                            <fo:block font-weight="bold" color="#FF0000">
                                                Długość
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid">
                                            <fo:block font-weight="bold" color="#FF0000">
                                                Data Wydania
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    
                                    <fo:table-row>
                                        <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid" number-rows-spanned="{fn:count(./Genres/Genre) + 2}">
                                            <fo:block>
                                                <xsl:value-of select="Title"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid">
                                            <fo:block>
                                                <xsl:value-of select="NumberOfTracks"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid">
                                            <fo:block>
                                                <xsl:value-of select="Length"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid">
                                            <fo:block>
                                                <xsl:value-of select="ReleaseDate"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row>
                                        <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid" number-columns-spanned="3">
                                            <fo:block font-weight="bold" color="#FF0000">
                                                Gatunki
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <xsl:for-each select="Genres/Genre">
                                        <fo:table-row>
                                            <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid" number-columns-spanned="3">
                                                <fo:block>
                                                    <xsl:value-of select="."/>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </xsl:for-each>
                                </xsl:for-each>

                                <fo:table-row>
                                    <fo:table-cell font-size="12pt" border-width="0.5mm" border-style="solid" number-columns-spanned="4">
                                        <fo:block font-weight="bold" color="#FF0000">
                                            Statystyki
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>

                                <xsl:variable name="artist" select="BandName"/>
                                
                                <fo:table-row>
                                    <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid" number-columns-spanned="2">
                                        <fo:block>
                                            Całkowita ilość albumów
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid" number-columns-spanned="2">
                                        <fo:block>
                                            <xsl:value-of select="/Project/Statistics/ArtistQuantities/Quantity[Name = $artist]/NumberOfAlbums" />
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid" number-columns-spanned="2">
                                        <fo:block>
                                            Całkowita ilość utworów
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid" number-columns-spanned="2">
                                        <fo:block>
                                            <xsl:value-of select="/Project/Statistics/ArtistQuantities/Quantity[Name = $artist]/NumberOfTracksTotal" />
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid" number-columns-spanned="2">
                                        <fo:block>
                                            Średnia ilość utworów na album
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid" number-columns-spanned="2">
                                        <fo:block>
                                            <xsl:value-of select="/Project/Statistics/ArtistQuantities/Quantity[Name = $artist]/NumberOfTracksAverage" />
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid" number-columns-spanned="2">
                                        <fo:block>
                                            Średnia długość albumów
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid" number-columns-spanned="2">
                                        <fo:block>
                                            <xsl:value-of select="/Project/Statistics/ArtistQuantities/Quantity[Name = $artist]/AverageLengthOfAlbum" />
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid" number-columns-spanned="2">
                                        <fo:block>
                                            Średnia długość utworów
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell font-size="10pt" border-width="0.5mm" border-style="solid" number-columns-spanned="2">
                                        <fo:block>
                                            <xsl:value-of select="/Project/Statistics/ArtistQuantities/Quantity[Name = $artist]/AverageLengthOfTrack" />
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                
                            </fo:table-body>
                        </fo:table>
                    </fo:flow>
                </fo:page-sequence>
            </xsl:for-each>



        </fo:root>
    </xsl:template>
</xsl:stylesheet>
