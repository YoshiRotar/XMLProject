<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns="http://www.w3.org/2000/svg">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	
	<xsl:variable name="width" select="1000"/>
	<xsl:variable name="height" select="3300"/>
	
    <xsl:template match="/">
		<svg version="1.0" height="{$height}" width="{$width}">
		<rect width="100%" height="100%" fill="rgb(196, 211, 175)"/>
		<script type="text/ecmascript"> 
			<![CDATA[
				function barMouseOver(evt) {
					var bar = evt.target;
					bar.setAttribute("fill-opacity", 0.5);
					value = bar.getElementsByTagName("value")[0].childNodes[0].nodeValue;
					name = bar.getElementsByTagName("objectName")[0].childNodes[0].nodeValue;
					bar.parentNode.getElementsByTagName("text")[0].textContent = name + ": " + value;
				}
				
				function barMouseOut(evt) {
					var bar = evt.target;
					bar.setAttribute("fill-opacity", 1.0);
				}
			]]> 
		</script>
			<xsl:apply-templates/>
		</svg>
    </xsl:template>

	<xsl:template match="/Project/Head/Title">		
		<text x="{($width div 2)}" y="50" text-anchor="middle" font-family="Verdana" font-size="40">
			<xsl:apply-templates/>
		</text>
	</xsl:template>
    
	<xsl:template match="/Project/Head/Authors">		
		<text x="{($width div 2)}" y="60" text-anchor="middle" font-family="Verdana" font-size="20">
			<xsl:apply-templates/>
		</text>
	</xsl:template>
	
	<xsl:template match="/Project/Head/Authors/Author">		
		<tspan x="{($width div 2)}" dy="50">
			<xsl:value-of select="."/>
		</tspan>
	</xsl:template>
	
	<xsl:template match="/Project/Bands">
	</xsl:template>
	
	<xsl:template match="/Project/RaportDate">
	</xsl:template>
	
	<xsl:template match="/Project/Statistics">
		<text x="{($width div 2)}" y="300" text-anchor="middle" font-family="Verdana" font-size="20">
			Liczba albumów
		</text>
		<xsl:call-template name="drawChart">
			<xsl:with-param name="startingY" select="320"/>
			<xsl:with-param name="valueNode" select="./GenreQuantities/Quantity/NumberOfAlbums"/>
			<xsl:with-param name="startingX" select="250"/>
			<xsl:with-param name="color" select="'rgb(100, 150, 229)'"/>
			<xsl:with-param name="strokeColor" select="'rgb(66, 113, 188)'"/>
			<xsl:with-param name="chartWidth" select="500"/>
			<xsl:with-param name="chartHeight" select="200"/>
		</xsl:call-template>
		
		<text x="{($width div 2)}" y="600" text-anchor="middle" font-family="Verdana" font-size="20">
			Liczba utworów
		</text>
		<xsl:call-template name="drawChart">
			<xsl:with-param name="startingY" select="620"/>
			<xsl:with-param name="valueNode" select="./GenreQuantities/Quantity/NumberOfTracksTotal"/>
			<xsl:with-param name="startingX" select="250"/>
			<xsl:with-param name="color" select="'rgb(100, 150, 229)'"/>
			<xsl:with-param name="strokeColor" select="'rgb(66, 113, 188)'"/>
			<xsl:with-param name="chartWidth" select="500"/>
			<xsl:with-param name="chartHeight" select="200"/>
		</xsl:call-template>
		
		<text x="{($width div 2)}" y="900" text-anchor="middle" font-family="Verdana" font-size="20">
			Średnia liczba utworów na album
		</text>
		<xsl:call-template name="drawChart">
			<xsl:with-param name="startingY" select="920"/>
			<xsl:with-param name="valueNode" select="./GenreQuantities/Quantity/NumberOfTracksAverage"/>
			<xsl:with-param name="startingX" select="250"/>
			<xsl:with-param name="color" select="'rgb(100, 150, 229)'"/>
			<xsl:with-param name="strokeColor" select="'rgb(66, 113, 188)'"/>
			<xsl:with-param name="chartWidth" select="500"/>
			<xsl:with-param name="chartHeight" select="200"/>
		</xsl:call-template>
		
		<text x="{($width div 2)}" y="1200" text-anchor="middle" font-family="Verdana" font-size="20">
			Średnia długość albumu
		</text>
		<xsl:call-template name="drawChartWithTime">
			<xsl:with-param name="startingY" select="1220"/>
			<xsl:with-param name="valueNode" select="./GenreQuantities/Quantity/AverageLengthOfAlbum"/>
			<xsl:with-param name="startingX" select="250"/>
			<xsl:with-param name="color" select="'rgb(100, 150, 229)'"/>
			<xsl:with-param name="strokeColor" select="'rgb(66, 113, 188)'"/>
			<xsl:with-param name="chartWidth" select="500"/>
			<xsl:with-param name="chartHeight" select="200"/>
		</xsl:call-template>
		
		<text x="{($width div 2)}" y="1500" text-anchor="middle" font-family="Verdana" font-size="20">
			średnia długość utworu
		</text>
		<xsl:call-template name="drawChartWithTime">
			<xsl:with-param name="startingY" select="1520"/>
			<xsl:with-param name="valueNode" select="./GenreQuantities/Quantity/AverageLengthOfTrack"/>
			<xsl:with-param name="startingX" select="250"/>
			<xsl:with-param name="color" select="'rgb(100, 150, 229)'"/>
			<xsl:with-param name="strokeColor" select="'rgb(66, 113, 188)'"/>
			<xsl:with-param name="chartWidth" select="500"/>
			<xsl:with-param name="chartHeight" select="200"/>
		</xsl:call-template>
		
		<text x="{($width div 2)}" y="1800" text-anchor="middle" font-family="Verdana" font-size="20">
			Liczba albumów
		</text>
		<xsl:call-template name="drawChart">
			<xsl:with-param name="startingY" select="1820"/>
			<xsl:with-param name="valueNode" select="./ArtistQuantities/Quantity/NumberOfAlbums"/>
			<xsl:with-param name="startingX" select="250"/>
			<xsl:with-param name="color" select="'rgb(221, 93, 93)'"/>
			<xsl:with-param name="strokeColor" select="'rgb(170, 64, 64)'"/>
			<xsl:with-param name="chartWidth" select="500"/>
			<xsl:with-param name="chartHeight" select="200"/>
		</xsl:call-template>
		
		<text x="{($width div 2)}" y="2100" text-anchor="middle" font-family="Verdana" font-size="20">
			Liczba utworów
		</text>
		<xsl:call-template name="drawChart">
			<xsl:with-param name="startingY" select="2120"/>
			<xsl:with-param name="valueNode" select="./ArtistQuantities/Quantity/NumberOfTracksTotal"/>
			<xsl:with-param name="startingX" select="250"/>
			<xsl:with-param name="color" select="'rgb(221, 93, 93)'"/>
			<xsl:with-param name="strokeColor" select="'rgb(170, 64, 64)'"/>
			<xsl:with-param name="chartWidth" select="500"/>
			<xsl:with-param name="chartHeight" select="200"/>
		</xsl:call-template>
		
		<text x="{($width div 2)}" y="2400" text-anchor="middle" font-family="Verdana" font-size="20">
			Średnia liczba utworów na album
		</text>
		<xsl:call-template name="drawChart">
			<xsl:with-param name="startingY" select="2420"/>
			<xsl:with-param name="valueNode" select="./ArtistQuantities/Quantity/NumberOfTracksAverage"/>
			<xsl:with-param name="startingX" select="250"/>
			<xsl:with-param name="color" select="'rgb(221, 93, 93)'"/>
			<xsl:with-param name="strokeColor" select="'rgb(170, 64, 64)'"/>
			<xsl:with-param name="chartWidth" select="500"/>
			<xsl:with-param name="chartHeight" select="200"/>
		</xsl:call-template>
		
		<text x="{($width div 2)}" y="2700" text-anchor="middle" font-family="Verdana" font-size="20">
			Średnia długość albumu
		</text>
		<xsl:call-template name="drawChartWithTime">
			<xsl:with-param name="startingY" select="2720"/>
			<xsl:with-param name="valueNode" select="./ArtistQuantities/Quantity/AverageLengthOfAlbum"/>
			<xsl:with-param name="startingX" select="250"/>
			<xsl:with-param name="color" select="'rgb(221, 93, 93)'"/>
			<xsl:with-param name="strokeColor" select="'rgb(170, 64, 64)'"/>
			<xsl:with-param name="chartWidth" select="500"/>
			<xsl:with-param name="chartHeight" select="200"/>
		</xsl:call-template>
		
		<text x="{($width div 2)}" y="3000" text-anchor="middle" font-family="Verdana" font-size="20">
			Średnia długość utworu
		</text>
		<xsl:call-template name="drawChartWithTime">
			<xsl:with-param name="startingY" select="3020"/>
			<xsl:with-param name="valueNode" select="./ArtistQuantities/Quantity/AverageLengthOfTrack"/>
			<xsl:with-param name="startingX" select="250"/>
			<xsl:with-param name="color" select="'rgb(221, 93, 93)'"/>
			<xsl:with-param name="strokeColor" select="'rgb(170, 64, 64)'"/>
			<xsl:with-param name="chartWidth" select="500"/>
			<xsl:with-param name="chartHeight" select="200"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="drawChart">
		<xsl:param name="startingY"/>
		<xsl:param name="valueNode"/>
		<xsl:param name="startingX"/>
		<xsl:param name="color"/>
		<xsl:param name="strokeColor"/>
		<xsl:param name="chartWidth"/>
		<xsl:param name="chartHeight"/>
		
		<xsl:variable name="numberOfGenres" select="count($valueNode/..)"/>
		<xsl:variable name="maxValue" select="max($valueNode)"/>
		<xsl:variable name="horizontalPadding" select="10"/>
		<xsl:variable name="barWidth" select="(($chartWidth - $horizontalPadding) div $numberOfGenres) - $horizontalPadding"/>
		
		<g>
			<xsl:for-each select="$valueNode">
					<xsl:variable name="barHeight" select="(. div $maxValue) * $chartHeight"/>
					<rect
						fill="{$color}"
						x="{$startingX + ($horizontalPadding + $barWidth) * (position() - 1)}"
						y="{$startingY + ($chartHeight - $barHeight)}"
						width="{$barWidth}"
						height="0"
						stroke="{$strokeColor}"
						strokeWidth="1"
						onmouseover="barMouseOver(evt)"
						onmouseout="barMouseOut(evt)">
						<animate attributeName="height" attributeType="XML" begin="{position()*0.2}s" dur="2s" from="0" to="{$barHeight}" fill="freeze"/>
						<animate attributeName="y" attributeType="XML" begin="{position()*0.2}s" dur="2s" from="{$startingY + $chartHeight}" 
							to="{$startingY + ($chartHeight - $barHeight)}" fill="freeze"/>
						<value>
							<xsl:value-of select="."/>
						</value>
						<objectName>
							<xsl:value-of select="./../Name"/>
						</objectName>
					</rect>
			</xsl:for-each>
			<text x="{($width div 2)}" y="{$startingY + $chartHeight + 20}" text-anchor="middle" font-family="Verdana" font-size="10"/>
		</g>
	</xsl:template>
	
	<xsl:template name="drawChartWithTime">
		<xsl:param name="startingY"/>
		<xsl:param name="valueNode"/>
		<xsl:param name="startingX"/>
		<xsl:param name="color"/>
		<xsl:param name="strokeColor"/>
		<xsl:param name="chartWidth"/>
		<xsl:param name="chartHeight"/>
		
		<xsl:variable name="numberOfGenres" select="count($valueNode/..)"/>
		
		<xsl:variable name="intTime" as="element()*">
			<xsl:for-each select="$valueNode">
				<xsl:element name="item">
					<xsl:call-template name="timeToInteger">
						<xsl:with-param name="time" select="."/>
					</xsl:call-template>
				</xsl:element>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="maxValue" select="max($intTime)"/>
		<xsl:variable name="horizontalPadding" select="10"/>
		<xsl:variable name="barWidth" select="(($chartWidth - $horizontalPadding) div $numberOfGenres) - $horizontalPadding"/>
		
		<g>
			<xsl:for-each select="$valueNode">
					<xsl:variable name="currentValue">
						<xsl:call-template name="timeToInteger">
							<xsl:with-param name="time" select="."/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="barHeight" select="($currentValue div $maxValue) * $chartHeight"/>
					<rect
						fill="{$color}"
						x="{$startingX + ($horizontalPadding + $barWidth) * (position() - 1)}"
						y="{$startingY + ($chartHeight - $barHeight)}"
						width="{$barWidth}"
						height="0"
						stroke="{$strokeColor}"
						strokeWidth="1"
						onmouseover="barMouseOver(evt)"
						onmouseout="barMouseOut(evt)">
						<animate attributeName="height" attributeType="XML" begin="{position()*0.2}s" dur="2s" from="0" to="{$barHeight}" fill="freeze"/>
						<animate attributeName="y" attributeType="XML" begin="{position()*0.2}s" dur="2s" from="{$startingY + $chartHeight}" 
							to="{$startingY + ($chartHeight - $barHeight)}" fill="freeze"/>
						<value>
							<xsl:value-of select="."/>
						</value>
						<objectName>
							<xsl:value-of select="./../Name"/>
						</objectName>
					</rect>
			</xsl:for-each>
			<text x="{($width div 2)}" y="{$startingY + $chartHeight + 20}" text-anchor="middle" font-family="Verdana" font-size="10"/>
		</g>
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
