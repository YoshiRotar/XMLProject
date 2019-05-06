<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	
	<xsl:output method="xml" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" 
	  doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" indent="yes"/>
	
	<xsl:template match="/">
		<html >
		   <head>
			 <title>
			   <xsl:value-of select="Project/Head/Title"/>
			 </title>
		   </head>
		   <style>
				table, th, td {
				  border: 1px solid black;
				  border-collapse: collapse;
				}
				th, td {
				  padding: 5px;
				  text-align: left;    
				}
		   </style>
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
			<p>
				<xsl:apply-templates/>
			</p>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="BandName">
		<h3>
			Nazwa zespołu: <xsl:value-of select="."/>
		</h3>
	</xsl:template>
	
	<xsl:template match="Nationality">
		Narodowość: <xsl:value-of select="."/>
		<br/>
	</xsl:template>
		
	
	<xsl:template match="Members">
		Członkowie:
		<ul>
			<xsl:for-each select="Member">
				<li><xsl:apply-templates/></li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	
	<!--<xsl:template match="Member">
		<h3>
			<xsl:value-of select="FirstName"/>
			<xsl:value-of select="LastName"/>
			<xsl:value-of select="StageName"/>
		</h3>
	</xsl:template>-->
	
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
					<ul>
						<xsl:for-each select="Genres/Genre">
							<li>
								<xsl:value-of select="."/>
							</li>
						</xsl:for-each>					
					</ul>
					</th>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	
	<xsl:template match="Statistics">
		<p>
			<table>
				<tbody>
					<tr>
						<th><b>Gatunek</b></th>
						<th><b>Liczba albumów</b></th>
					</tr>
					<xsl:for-each select="GenreQuantities/Quantity">
						<xsl:sort select="Count" order="descending" data-type="number"/>
						<tr>
							<th><xsl:value-of select="Name"/></th>
							<th><xsl:value-of select="Count"/></th>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
		</p>
		<p>
			<table>
				<tbody>
					<tr>
						<th><b>Artysta</b></th>
						<th><b>Liczba albumów</b></th>
					</tr>
					<xsl:for-each select="ArtistQuantities/Quantity">
						<xsl:sort select="Count" order="descending" data-type="number"/>
						<tr>
							<th><xsl:value-of select="Name"/></th>
							<th><xsl:value-of select="Count"/></th>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
		</p>		
	</xsl:template>
</xsl:stylesheet>
