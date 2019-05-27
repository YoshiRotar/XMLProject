<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
    <xsl:output method="text" indent="yes"/>

    <xsl:template match="Project/Bands/Band">
        <xsl:for-each select="Albums/Album">
            <xsl:text>&#xd;</xsl:text>
            
            <xsl:variable name="maxBandName" select="max(../../../Band/string-length(BandName))"/>
            <xsl:call-template name="extendTo">
                <xsl:with-param name="length" select="$maxBandName"/>
                <xsl:with-param name="word" select="../../BandName"/>
                <xsl:with-param name="orientation" select="'left'"/>
            </xsl:call-template>
            <xsl:text> | </xsl:text>

            <xsl:variable name="maxNationality" select="fn:max(../../../Band/fn:string-length(Nationality))"/>
            <xsl:call-template name="extendTo">
                <xsl:with-param name="length" select="$maxNationality"/>
                <xsl:with-param name="word" select="../../Nationality"/>
                <xsl:with-param name="orientation" select="'left'"/>
            </xsl:call-template>
            <xsl:text> | </xsl:text>

            <xsl:variable name="maxFrontman" select="max(../../../Band/Members/string-length(concat(Member[1]/Name[1], ' ', Member[1]/Surname)))"/>
            <xsl:call-template name="extendTo">
                <xsl:with-param name="length" select="$maxFrontman"/>
                <xsl:with-param name="word" select="../../Members/concat(Member[1]/Name[1], ' ', Member[1]/Surname)"/>
                <xsl:with-param name="orientation" select="'left'"/>
            </xsl:call-template>
            <xsl:text> | </xsl:text>

            <xsl:variable name="maxTitle" select="max(../../../Band/Albums/Album/string-length(Title))"/>
            <xsl:call-template name="extendTo">
                <xsl:with-param name="length" select="$maxTitle"/>
                <xsl:with-param name="word" select="Title"/>
                <xsl:with-param name="orientation" select="'left'"/>
            </xsl:call-template>
            <xsl:text> | </xsl:text>

            <xsl:variable name="maxGenre" select="max(../../../Band/Albums/Album/Genres/string-length(Genre[1]))"/>
            <xsl:call-template name="extendTo">
                <xsl:with-param name="length" select="$maxGenre"/>
                <xsl:with-param name="word" select="Genres/Genre[1]"/>
                <xsl:with-param name="orientation" select="'left'"/>
            </xsl:call-template>
            <xsl:text> | </xsl:text>

            <xsl:variable name="maxNumberOfTracks" select="max(../../../Band/Albums/Album/string-length(NumberOfTracks))"/>
            <xsl:call-template name="extendTo">
                <xsl:with-param name="length" select="$maxNumberOfTracks"/>
                <xsl:with-param name="word" select="NumberOfTracks"/>
                <xsl:with-param name="orientation" select="'right'"/>
            </xsl:call-template>
            <xsl:text> | </xsl:text>

            <xsl:variable name="maxLength" select="max(../../../Band/Albums/Album/string-length(Length))"/>
            <xsl:call-template name="extendTo">
                <xsl:with-param name="length" select="$maxLength"/>
                <xsl:with-param name="word" select="Length"/>
                <xsl:with-param name="orientation" select="'right'"/>
            </xsl:call-template>
            <xsl:text> | </xsl:text>

            <xsl:variable name="maxReleaseDate" select="max(../../../Band/Albums/Album/string-length(ReleaseDate))"/>
            <xsl:call-template name="extendTo">
                <xsl:with-param name="length" select="$maxReleaseDate"/>
                <xsl:with-param name="word" select="ReleaseDate"/>
                <xsl:with-param name="orientation" select="'right'"/>
            </xsl:call-template>
            
        </xsl:for-each>
    </xsl:template>


    <xsl:template name="extendTo">
        <xsl:param name="length"/>
        <xsl:param name="word"/>
        <xsl:param name="orientation"/>
            <xsl:if test="string-length($word) &lt; $length" >
                <xsl:choose>
                    <xsl:when test="$orientation = 'right'">
                        <xsl:call-template name="extendTo">
                            <xsl:with-param name="word" select="concat(' ', $word)" />
                            <xsl:with-param name="length" select="$length" />
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="extendTo">
                            <xsl:with-param name="word" select="concat($word, ' ')" />
                            <xsl:with-param name="length" select="$length" />
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
        </xsl:if>
        <xsl:if test="string-length($word) = $length">
            <xsl:value-of select="$word"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Project/Head"/>
    <xsl:template match="Project/Statistics"/>
    <xsl:template match="RaportDate"/>
</xsl:stylesheet>
