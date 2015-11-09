<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns="http://www.w3.org/2000/svg">

    <xsl:output method="xml" indent="yes"/>

    <!-- How wide each bar will be on the chart, in pixels -->
    <xsl:variable name="barWidth" select="20"/>
    <xsl:variable name="barSpacing" select="5"/>
    <!-- How tall the highest bar will be, in pixels -->
    <xsl:variable name="maxBarHeight" select="250"/>
    <xsl:variable name="years"
        select="
            (2011,
            2012,
            2013,
            2014,
            2015)"/>

    <xsl:template match="/">
        
        <!-- Need to capture this for later use -->
        <xsl:variable name="currentElement" select="."/>

        <!-- Automatically find the greatest Y value in the data using recursion and store it in $maxY so we can scale the chart to the data -->
        <xsl:variable name="maxX">
            <xsl:call-template name="getMaxY">
                <xsl:with-param name="count" select="5"/>
                <xsl:with-param name="highestSofar" select="0"/>
                <xsl:with-param name="curElement" select="$currentElement"/>
            </xsl:call-template>
        </xsl:variable>

        <!-- Actually draw the graph -->
        <svg >
            <g transform="translate(50, 350)">

                <!-- First add the grid lines so they don't obscure the bars. Arbitrarily using 5 gridlines -->
                <xsl:for-each select="1 to 5">
                    <line x1="0" y1="{- $maxBarHeight * (. div 5)}"
                        x2="{count($years) * 4 * ($barWidth + $barSpacing)}"
                        y2="{- $maxBarHeight * (. div 5)}" stroke="black" stroke-dasharray="5,5"/>
                    <!-- And labels -->
                    <text x="-40" y="{- $maxBarHeight * (. div 5)}"><xsl:value-of select="$maxBarHeight * (. div 5)"/></text>
                </xsl:for-each>

                <!-- Now plot the data for each year -->
                <xsl:for-each select="$years">

                    <!-- Need to convert the year in question to a string so we can see if each tweet created_at contains it -->
                    <xsl:variable name="currentYear" select="format-number(., '#')"/>

                    <!-- Store the number of tweets for each quarter in a variable -->
                    <xsl:variable name="Q1"
                        select="count($currentElement//tweet[contains(created_at, $currentYear) and (contains(created_at, 'Jan') or contains(created_at, 'Feb') or contains(created_at, 'Mar'))])"/>
                    <xsl:variable name="Q2"
                        select="count($currentElement//tweet[contains(created_at, $currentYear) and (contains(created_at, 'Apr') or contains(created_at, 'May') or contains(created_at, 'Jun'))])"/>
                    <xsl:variable name="Q3"
                        select="count($currentElement//tweet[contains(created_at, $currentYear) and (contains(created_at, 'Jul') or contains(created_at, 'Aug') or contains(created_at, 'Sep'))])"/>
                    <xsl:variable name="Q4"
                        select="count($currentElement//tweet[contains(created_at, $currentYear) and (contains(created_at, 'Oct') or contains(created_at, 'Nov') or contains(created_at, 'Dec'))])"/>

                    <!-- Now draw the bars -->
                    <xsl:variable name="yearStartX"
                        select="(position() - 1) * 4 * ($barWidth + $barSpacing)"/>

                    <rect x="{$yearStartX}" y="{- $maxBarHeight * ($Q1 div $maxX)}"
                        height="{$maxBarHeight * ($Q1 div $maxX )}" width="{$barWidth}px"
                        fill="blue"/>
                    <rect x="{$yearStartX + ($barWidth + $barSpacing)}"
                        y="{- $maxBarHeight * ($Q2 div $maxX)}"
                        height="{$maxBarHeight * ($Q2 div $maxX )}" width="{$barWidth}px"
                        fill="blue"/>
                    <rect x="{$yearStartX + 2 * ($barWidth + $barSpacing)}"
                        y="{- $maxBarHeight * ($Q3 div $maxX)}"
                        height="{$maxBarHeight * ($Q3 div $maxX )}" width="{$barWidth}px"
                        fill="blue"/>
                    <rect x="{$yearStartX + 3 * ($barWidth + $barSpacing)}"
                        y="{- $maxBarHeight * ($Q4 div $maxX)}"
                        height="{$maxBarHeight * ($Q4 div $maxX )}" width="{$barWidth}px"
                        fill="blue"/>
                    
                    <!-- And add text labels -->
                    <text x="{$yearStartX + $barWidth div 2}" y="12" style="writing-mode: tb;">Q1 <xsl:value-of select="."/> </text>
                    <text x="{$yearStartX + ($barWidth + $barSpacing) + $barWidth div 2}"
                        y="12" style="writing-mode: tb;">Q2 <xsl:value-of select="."/></text>
                    <text x="{$yearStartX + 2 * ($barWidth + $barSpacing) + $barWidth div 2}"
                        y="12" style="writing-mode: tb;">Q3 <xsl:value-of select="."/></text>
                    <text x="{$yearStartX + 3 * ($barWidth + $barSpacing) + $barWidth div 2}"
                        y="12" style="writing-mode: tb;">Q4 <xsl:value-of select="."/></text>

                </xsl:for-each>

                <!-- Add in the axes -->
                <line x1="0" y1="0" x2="{count($years) * 4 * ($barWidth + $barSpacing)}" y2="0"
                    stroke="black" stroke-width="2px"/>
                <line x1="0" y1="0" x2="0" y2="{-$maxBarHeight}" stroke="black" stroke-width="2px"/>



            </g>
        </svg>

    </xsl:template>

    <!-- This uses recursion to find the maximum Y value. It's not elegant, but it works.  -->
    <xsl:template name="getMaxY">
        <xsl:param name="count"/>
        <xsl:param name="highestSofar"/>
        <xsl:param name="curElement"/>

        <!-- Note assumption here -->
        <xsl:variable name="currentYear" select="format-number($count + 2010, '#')"/>

        <xsl:variable name="Q1"
            select="count($curElement//tweet[contains(created_at, $currentYear) and (contains(created_at, 'Jan') or contains(created_at, 'Feb') or contains(created_at, 'Mar'))])"/>
        <xsl:variable name="Q2"
            select="count($curElement//tweet[contains(created_at, $currentYear) and (contains(created_at, 'Apr') or contains(created_at, 'May') or contains(created_at, 'Jun'))])"/>
        <xsl:variable name="Q3"
            select="count($curElement//tweet[contains(created_at, $currentYear) and (contains(created_at, 'Jul') or contains(created_at, 'Aug') or contains(created_at, 'Sep'))])"/>
        <xsl:variable name="Q4"
            select="count($curElement//tweet[contains(created_at, $currentYear) and (contains(created_at, 'Oct') or contains(created_at, 'Nov') or contains(created_at, 'Dec'))])"/>

        <!-- See if we've found a new highest value -->
        <xsl:variable name="highestHere"
            select="
                max(($Q1,
                $Q2,
                $Q3,
                $Q4,
                $highestSofar))"/>

        <!-- And do it all again -->
        <xsl:if test="$count > 0">
            <xsl:call-template name="getMaxY">
                <xsl:with-param name="count" select="$count - 1"/>
                <xsl:with-param name="highestSofar" select="$highestHere[1]"/>
                <xsl:with-param name="curElement" select="$curElement"/>
            </xsl:call-template>
        </xsl:if>

        <!-- Or exit and return the highest value found -->
        <xsl:if test="$count = 0">
            <xsl:value-of select="$highestSofar"/>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
