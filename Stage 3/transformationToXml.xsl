<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:key use="@idGenre" name="GenreKey" match="/Project/Collection/Genres/Genre"/>
	<xsl:key use="@idArtist" name="AlbumKey" match="/Project/Collection/Albums/Album"/>
	
	<xsl:template match="/">
		<Project>
			<xsl:apply-templates/>
			<xsl:element name="Statistics">
				<xsl:element name="GenreQuantities">
					<xsl:for-each select="/Project/Collection/Genres/Genre">
						<xsl:variable name="id" select="@idGenre"/>
						<xsl:element name="Quantity">
							<xsl:element name="Name">
								<xsl:value-of select="."/>
							</xsl:element> 
							<xsl:element name="NumberOfAlbums">
								<xsl:value-of select="count(/Project/Collection/Albums/Album/fn:tokenize(@idGenre, '\s+')[. = $id])"/>
							</xsl:element>
							<xsl:element name="NumberOfTracksTotal">
								<xsl:value-of select="sum(/Project/Collection/Albums/Album[fn:tokenize(@idGenre, '\s+') = $id]/NumberOfTracks)"/>
							</xsl:element>
							<xsl:element name="NumberOfTracksAverage">
								<xsl:value-of select="round(sum(/Project/Collection/Albums/Album[fn:tokenize(@idGenre, '\s+') = $id]/NumberOfTracks) div 
								count(/Project/Collection/Albums/Album/fn:tokenize(@idGenre, '\s+')[. = $id]))"/>
							</xsl:element>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
				<xsl:element name="ArtistQuantities">
					<xsl:for-each select="/Project/Collection/Artists/Artist">
						<xsl:variable name="id" select="@idArtist"/>
						<xsl:element name="Quantity">
							<xsl:element name="Name">
								<xsl:value-of select="BandName"/>
							</xsl:element>
							<xsl:element name="NumberOfAlbums">
								<xsl:value-of select="count(/Project/Collection/Albums/Album/@idArtist[. = $id])"/>
							</xsl:element>
							<xsl:element name="NumberOfTracksTotal">
								<xsl:value-of select="sum(/Project/Collection/Albums/Album[@idArtist = $id]/NumberOfTracks)"/>
							</xsl:element>
							<xsl:element name="NumberOfTracksAverage">
								<xsl:value-of select="round(sum(/Project/Collection/Albums/Album[@idArtist = $id]/NumberOfTracks) div 
								count(/Project/Collection/Albums/Album/@idArtist[. = $id]))"/>
							</xsl:element>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
				<xsl:element name="AverageLengthsPerArtist">
					<xsl:for-each select="/Project/Collection/Artists/Artist">
						<xsl:variable name="id" select="@idArtist"/>
						<xsl:element name="AverageLength">
							<xsl:element name="Name">
								<xsl:value-of select="BandName"/>
							</xsl:element>
							<xsl:element name="Average">
								<xsl:variable name="intTime">
									<xsl:for-each select="/Project/Collection/Albums/Album[@idArtist = $id]">
										<xsl:call-template name="timeToInteger">
											<xsl:with-param name="time" select="Length"/>
										</xsl:call-template>
									</xsl:for-each>
								</xsl:variable>
                <xsl:variable name="sumOfInit" select="sum($intTime)"/>
								<xsl:value-of select="fn:tokenize($intTime)"/>
							</xsl:element>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:element>
		</Project>
	</xsl:template>
		
	<xsl:template match="Project/Head">
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
	
	<xsl:template match="Project/Collection">
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
	
	<xsl:template match="/Project/Collection/Albums/Album"> 
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

</xsl:stylesheet>
