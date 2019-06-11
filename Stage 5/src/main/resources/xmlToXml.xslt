<?xml version="1.0" encoding="UTF-8"?>
<!-- Created with Liquid Studio 2019 (https://www.liquid-technologies.com) -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:mc="urn:musicCollection">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:key use="@idGenre" name="GenreKey" match="/mc:Project/Collection/Genres/Genre"/>
    <xsl:key use="@idArtist" name="AlbumKey" match="/mc:Project/Collection/Albums/Album"/>

    <xsl:template match="/">
        <Project>
            <xsl:apply-templates/>
            <xsl:element name="Statistics">
                <xsl:element name="GenreQuantities">
                    <xsl:for-each select="/mc:Project/Collection/Genres/Genre">
                        <xsl:variable name="id" select="@idGenre"/>
                        <xsl:element name="Quantity">
                            <xsl:element name="Name">
                                <xsl:value-of select="."/>
                            </xsl:element>
                            <xsl:element name="NumberOfAlbums">
                                <xsl:value-of select="count(/mc:Project/Collection/Albums/Album/fn:tokenize(@idGenre, '\s+')[. = $id])"/>
                            </xsl:element>
                            <xsl:element name="NumberOfTracksTotal">
                                <xsl:value-of select="sum(/mc:Project/Collection/Albums/Album[fn:tokenize(@idGenre, '\s+') = $id]/NumberOfTracks)"/>
                            </xsl:element>
                            <xsl:variable name="count" select="count(/mc:Project/Collection/Albums/Album/fn:tokenize(@idGenre, '\s+')[. = $id])"/>
                            <xsl:element name="NumberOfTracksAverage">
                                <xsl:value-of select="if ($count=0) then 0 else round(sum(/mc:Project/Collection/Albums/Album[fn:tokenize(@idGenre, '\s+') = $id]/NumberOfTracks) div $count)"/>
                            </xsl:element>
                            <xsl:element name="AverageLengthOfAlbum">
                                <xsl:variable name="intTime" as="element()*">
                                    <xsl:for-each select="/mc:Project/Collection/Albums/Album[fn:tokenize(@idGenre, '\s+') = $id]">
                                        <xsl:element name="item">
                                            <xsl:call-template name="timeToInteger">
                                                <xsl:with-param name="time" select="Length"/>
                                            </xsl:call-template>
                                        </xsl:element>
                                    </xsl:for-each>
                                </xsl:variable>
                                <xsl:variable name="avgOfInt" select="avg($intTime)"/>
                                <xsl:call-template name="integerToTime">
                                    <xsl:with-param name="integer" select="$avgOfInt"/>
                                </xsl:call-template>
                            </xsl:element>
                            <xsl:element name="AverageLengthOfTrack">
                                <xsl:variable name="intTime" as="element()*">
                                    <xsl:for-each select="/mc:Project/Collection/Albums/Album[fn:tokenize(@idGenre, '\s+') = $id]">
                                        <xsl:element name="item">
                                            <xsl:call-template name="timeToInteger">
                                                <xsl:with-param name="time" select="Length"/>
                                            </xsl:call-template>
                                        </xsl:element>
                                    </xsl:for-each>
                                </xsl:variable>
                                <xsl:variable name="sum" select="sum(/mc:Project/Collection/Albums/Album[fn:tokenize(@idGenre, '\s+') = $id]/NumberOfTracks)"/>
                                <xsl:variable name="avgOfInt" select="if ($count=0) then 0 else sum($intTime) div $sum"/>
                                <xsl:call-template name="integerToTime">
                                    <xsl:with-param name="integer" select="$avgOfInt"/>
                                </xsl:call-template>
                            </xsl:element>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
                <xsl:element name="ArtistQuantities">
                    <xsl:for-each select="/mc:Project/Collection/Artists/Artist">
                        <xsl:variable name="id" select="@idArtist"/>
                        <xsl:element name="Quantity">
                            <xsl:element name="Name">
                                <xsl:value-of select="BandName"/>
                            </xsl:element>
                            <xsl:element name="NumberOfAlbums">
                                <xsl:value-of select="count(/mc:Project/Collection/Albums/Album/@idArtist[. = $id])"/>
                            </xsl:element>
                            <xsl:element name="NumberOfTracksTotal">
                                <xsl:value-of select="sum(/mc:Project/Collection/Albums/Album[@idArtist = $id]/NumberOfTracks)"/>
                            </xsl:element>
                            <xsl:element name="NumberOfTracksAverage">
                                <xsl:variable name="count" select="count(/mc:Project/Collection/Albums/Album/@idArtist[. = $id])"/>
                                <xsl:value-of select="if ($count=0) then 0 else round(sum(/mc:Project/Collection/Albums/Album[@idArtist = $id]/NumberOfTracks) div $count)"/>
                            </xsl:element>
                            <xsl:element name="AverageLengthOfAlbum">
                                <xsl:variable name="intTime" as="element()*">
                                    <xsl:for-each select="/mc:Project/Collection/Albums/Album[@idArtist = $id]">
                                        <xsl:element name="item">
                                            <xsl:call-template name="timeToInteger">
                                                <xsl:with-param name="time" select="Length"/>
                                            </xsl:call-template>
                                        </xsl:element>
                                    </xsl:for-each>
                                </xsl:variable>
                                <xsl:variable name="avgOfInt" select="avg($intTime)"/>
                                <xsl:call-template name="integerToTime">
                                    <xsl:with-param name="integer" select="$avgOfInt"/>
                                </xsl:call-template>
                            </xsl:element>
                            <xsl:element name="AverageLengthOfTrack">
                                <xsl:variable name="intTime" as="element()*">
                                    <xsl:for-each select="/mc:Project/Collection/Albums/Album[@idArtist = $id]">
                                        <xsl:element name="item">
                                            <xsl:call-template name="timeToInteger">
                                                <xsl:with-param name="time" select="Length"/>
                                            </xsl:call-template>
                                        </xsl:element>
                                    </xsl:for-each>
                                </xsl:variable>
                                <xsl:variable name="sum" select="sum(/mc:Project/Collection/Albums/Album[@idArtist = $id]/NumberOfTracks)"/>
                                <xsl:variable name="avgOfInt" select="if ($sum=0) then 0 else sum($intTime) div $sum"/>
                                <xsl:call-template name="integerToTime">
                                    <xsl:with-param name="integer" select="$avgOfInt"/>
                                </xsl:call-template>
                            </xsl:element>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:element>
            <xsl:element name="RaportDate">
                <xsl:value-of select="fn:current-date()"/>
            </xsl:element>
        </Project>
    </xsl:template>

    <xsl:template match="mc:Project/Head">
        <xsl:element name="Head">
            <xsl:copy-of select="Title"/>
            <xsl:element name="Authors">
                <xsl:apply-templates select="Author"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="Author">
        <xsl:element name="Author">
            <xsl:value-of select="Name|Surname"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="@index"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="mc:Project/Collection">
        <xsl:element name="Bands">
            <xsl:apply-templates select="Artists/Artist"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="Artists/Artist">
        <xsl:element name="Band">
            <xsl:copy-of select="BandName"/>
            <xsl:element name="Nationality">
                <xsl:if test="@nationality = 'POL'">
                    <xsl:value-of select="'Polish'"/>
                </xsl:if>
                <xsl:if test="@nationality = 'SWE'">
                    <xsl:value-of select="'Swedish'"/>
                </xsl:if>
                <xsl:if test="@nationality = 'GBR'">
                    <xsl:value-of select="'British'"/>
                </xsl:if>
                <xsl:if test="@nationality = 'USA'">
                    <xsl:value-of select="'American'"/>
                </xsl:if>
                <xsl:if test="@nationality = 'DEU'">
                    <xsl:value-of select="'German'"/>
                </xsl:if>
            </xsl:element>
            <xsl:element name="Members">
                <xsl:apply-templates select="Member">
                    <xsl:sort select="@frontman" order="descending"/>
                </xsl:apply-templates>
            </xsl:element>
            <xsl:element name="Albums">
                <xsl:variable name="ArtistAlbum" select="key('AlbumKey', @idArtist)" />
                <xsl:apply-templates select="$ArtistAlbum">
                    <xsl:sort select="ReleaseDate"/>
                </xsl:apply-templates>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="Member">
        <xsl:element name="Member">
            <xsl:copy-of select="Name"/>
            <xsl:copy-of select="StageName[last()]"/>
            <xsl:copy-of select="Surname"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="/mc:Project/Collection/Albums/Album">
        <xsl:element name="Album">
            <xsl:copy-of select="Title"/>
            <xsl:copy-of select="NumberOfTracks"/>
            <xsl:copy-of select="Length"/>
            <xsl:copy-of select="ReleaseDate"/>
            <xsl:element name="Genres">
                <xsl:for-each select="for $ref in fn:tokenize(@idGenre, '\s+') return key('GenreKey', $ref)">
                    <xsl:element name="Genre">
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template name="timeToInteger">
        <xsl:param name="time"/>
        <xsl:variable name="hour" select="fn:substring($time, 1, 2)"/>
        <xsl:variable name="minute" select="fn:substring($time, 4, 2)"/>
        <xsl:variable name="second" select="fn:substring($time, 7, 2)"/>
        <xsl:value-of select="(3600 * fn:number($hour)) + (60 * fn:number($minute)) + fn:number($second)"/>
    </xsl:template>

    <xsl:template name="integerToTime">
        <xsl:param name="integer"/>
        <xsl:variable name="hour" select="format-number(fn:floor($integer div 3600), '00')"/>
        <xsl:variable name="minute" select="format-number(fn:floor($integer  mod 3600 div 60), '00')"/>
        <xsl:variable name="second" select="format-number(fn:round($integer mod 60), '00')"/>
        <xsl:value-of select="fn:concat($hour,':',$minute,':',$second)"/>
    </xsl:template>

</xsl:stylesheet>
