<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	
	<xsl:output method="xhtml" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" 
	  doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" indent="yes"/>
	
	<xsl:template match="/">
		<html >
		   <head>
				<title>
					<xsl:value-of select="Project/Head/Title"/>
				</title>
				<style type="text/css">
					table, th, td {
					  border: 1px solid black;
					  border-collapse: collapse;
					}
					th, td {
					  padding: 5px;
					  text-align: left;    
					}
			   </style>
		   </head>
		   <body>
				<xsl:apply-templates/>
		   </body>
		 </html>
	</xsl:template>

	<xsl:template match="Head">
		<h1>
			<strong>
				<xsl:value-of select="Title"/>			
			</strong>
		</h1>
		<h3>
			<xsl:for-each select="Authors/Author">
				<xsl:value-of select="."/>
				<br/>
			</xsl:for-each>	
		</h3>
	</xsl:template>
	
	<xsl:template match="Bands">
		<xsl:for-each select="Band">
				<xsl:apply-templates/>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="BandName">
		<h3>
			Nazwa zespołu: <xsl:value-of select="."/>
		</h3>
	</xsl:template>
	
	<xsl:template match="Nationality">
		<p>
			Kraj: 
			<xsl:choose>
				<xsl:when test=". = 'American'">
					Stany Zjednoczone
				</xsl:when>
				<xsl:when test=". = 'Polish'">
					Polska
				</xsl:when>
				<xsl:when test=". = 'British'">
					Wielka Brytania
				</xsl:when>
				<xsl:when test=". = 'German'">
					Niemcy
				</xsl:when> 
				<xsl:when test=". = 'Swedish'">
					Szwecja
				</xsl:when> 
				<xsl:otherwise>
					Nieznany
				</xsl:otherwise>
			</xsl:choose>
			<br/>
		</p>
	</xsl:template>
		
	
	<xsl:template match="Members">
		<p>Członkowie:</p>
		<ul>
			<xsl:apply-templates/>
		</ul>
	</xsl:template>
	
	<xsl:template match="Member[1]">
		<li>
			<b><xsl:apply-templates/> - frontman</b>
		</li>
	</xsl:template>
	
	<xsl:template match="Member">
		<li>
			<xsl:apply-templates/>
		</li>
	</xsl:template>
	
	<xsl:template match="StageName">
		"<xsl:value-of select="."/>"
	</xsl:template>	
	
	<xsl:template match="Albums">
		<table>
			<tr>
				<th>Nazwa albumu</th>
				<th>Liczba utworów</th>
				<th>Długość</th>
				<th>Data wydania</th>
				<th>Gatunki</th>
			</tr>
			<xsl:for-each select="Album">
				<tr>
					<th><xsl:value-of select="Title"/></th>
					<th><xsl:value-of select="NumberOfTracks"/></th>
					<th><xsl:value-of select="Length"/></th>
					<th><xsl:value-of select="ReleaseDate"/></th>
					<th>
						<xsl:for-each select="Genres/Genre">
							<xsl:value-of select="."/>
							<br/>
						</xsl:for-each>		
					</th>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	
	<xsl:template match="Statistics">
		<div>
			<br/>
			<table>
				<tbody>
					<tr>
						<th><b>Gatunek</b></th>
						<th><b>Liczba albumów</b></th>
						<th><b>Liczba utworów</b></th>
						<th><b>Średnia liczba utworów na album</b></th>
						<th><b>Średnia długość albumu</b></th>
						<th><b>Średnia długość utworu</b></th>
					</tr>
					<xsl:for-each select="GenreQuantities/Quantity">
						<xsl:sort select="NumberOfAlbums" order="descending" data-type="number"/>
						<tr>
							<th><xsl:value-of select="Name"/></th>
							<th><xsl:value-of select="NumberOfAlbums"/></th>
							<th><xsl:value-of select="NumberOfTracksTotal"/></th>
							<th><xsl:value-of select="NumberOfTracksAverage"/></th>
							<th><xsl:value-of select="AverageLengthOfAlbum"/></th>
							<th><xsl:value-of select="AverageLengthOfTrack"/></th>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
			<br/>
			<table>
				<tbody>
					<tr>
						<th><b>Artysta</b></th>
						<th><b>Liczba albumów</b></th>
						<th><b>Liczba utworów</b></th>
						<th><b>Średnia liczba utworów na album</b></th>
						<th><b>Średnia długość albumu</b></th>
						<th><b>Średnia długość utworu</b></th>
					</tr>
					<xsl:for-each select="ArtistQuantities/Quantity">
						<xsl:sort select="NumberOfAlbums" order="descending" data-type="number"/>
						<tr>
							<th><xsl:value-of select="Name"/></th>
							<th><xsl:value-of select="NumberOfAlbums"/></th>
							<th><xsl:value-of select="NumberOfTracksTotal"/></th>
							<th><xsl:value-of select="NumberOfTracksAverage"/></th>
							<th><xsl:value-of select="AverageLengthOfAlbum"/></th>
							<th><xsl:value-of select="AverageLengthOfTrack"/></th>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
		</div>
	</xsl:template>
	
	<xsl:template match="RaportDate">	
		<p>
			<i>
				Data wygenerowania raportu:
				<xsl:value-of select="."/>
			</i>
		</p>	
	</xsl:template>
</xsl:stylesheet>
