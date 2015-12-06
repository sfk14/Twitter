<?xml version="1.0" encoding="UTF-8"?>


<!-- 
    This file takes a custom XML document (produced by genders.xsl) and produces SVG charts depicting the gender breakdown of users over time. By Johne Rzodkiewicz.
-->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns="http://www.w3.org/2000/svg">
    
    <xsl:output method="xml" indent="yes"/>
    
    <!-- How wide each bar will be on the chart, in pixels -->
    <xsl:variable name="barWidth" select="20"/>
    <xsl:variable name="barSpacing" select="5"/>
    <!-- How tall the bars will be, in pixels -->
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
        
        
        <!-- Actually draw the graph -->
        <svg >
            <g transform="translate(50, 350)">
                
                <!-- First add the grid lines so they don't obscure the bars. Arbitrarily using 5 gridlines -->
                <xsl:for-each select="1 to 5">
                    <line x1="0" y1="{- $maxBarHeight * (. div 5)}"
                        x2="{count($years) * 4 * ($barWidth + $barSpacing)}"
                        y2="{- $maxBarHeight * (. div 5)}" stroke="black" stroke-dasharray="5,5"/>
                    <!-- And labels -->
                    <text x="-40" y="{- $maxBarHeight * (. div 5)}"><xsl:value-of select="round(100 * (. div 5))"/></text>
                </xsl:for-each>
                
                <!-- Now plot the data for each year -->
                <xsl:for-each select="$years">
                    
                    <!-- Need to convert the year in question to a string so we can see if each tweet created_at contains it -->
                    <xsl:variable name="currentYear" select="format-number(., '#')"/>
                    
                    <!-- Store the number of tweets for each quarter in a variable -->
                    <xsl:variable name="Q1"
                        select="$currentElement//tweet[contains(created_at, $currentYear) and (contains(created_at, 'Jan') or contains(created_at, 'Feb') or contains(created_at, 'Mar'))]"/>
                    <xsl:variable name="Q2"
                        select="$currentElement//tweet[contains(created_at, $currentYear) and (contains(created_at, 'Apr') or contains(created_at, 'May') or contains(created_at, 'Jun'))]"/>
                    <xsl:variable name="Q3"
                        select="$currentElement//tweet[contains(created_at, $currentYear) and (contains(created_at, 'Jul') or contains(created_at, 'Aug') or contains(created_at, 'Sep'))]"/>
                    <xsl:variable name="Q4"
                        select="$currentElement//tweet[contains(created_at, $currentYear) and (contains(created_at, 'Oct') or contains(created_at, 'Nov') or contains(created_at, 'Dec'))]"/>
                    
                    
                    
                    <!-- Get the percentages -->
                    <xsl:variable name="Q1MalePercentage" select="(count($Q1[gender='male']) div count($Q1))"/>
                    <xsl:variable name="Q1FemalePercentage" select="(count($Q1[gender='female']) div count($Q1))"/>
                    
                    <xsl:variable name="Q2MalePercentage" select="(count($Q2[gender='male']) div count($Q2))"/>
                    <xsl:variable name="Q2FemalePercentage" select="(count($Q2[gender='female']) div count($Q2))"/>
                    
                    <xsl:variable name="Q3MalePercentage" select="(count($Q3[gender='male']) div count($Q3))"/>
                    <xsl:variable name="Q3FemalePercentage" select="(count($Q3[gender='female']) div count($Q3))"/>
                    <!-- Adding a small fraction here prevents a divide by zero error (no data for Q4 2015) without misrepresenting the data too badly -->
                    <xsl:variable name="Q4MalePercentage" select="count($Q4[gender='male']) div (count($Q4)+0.01)"/>
                    <xsl:variable name="Q4FemalePercentage" select="count($Q4[gender='female']) div (count($Q4)+0.01)"/>
                    

                    <!-- Now draw the bars -->
                  
                    <xsl:variable name="yearStartX"
                        select="(position() - 1) * 4 * ($barWidth + $barSpacing)"/>
                    
                    <!-- First make a background bar to represent tweets of indeterminate gender -->
                    <xsl:for-each select="1 to 4">
                        <rect x="{$yearStartX + (position()-1) * ($barWidth + $barSpacing)}" y="{-$maxBarHeight}" height="{$maxBarHeight}" width="{$barWidth}px"
                            fill="#B8B8B8"/>
                    </xsl:for-each>
                    
                    <!-- Then do the male and female bars for each quarter in the year -->
                    <rect x="{$yearStartX}" y="{- $maxBarHeight * $Q1MalePercentage}"
                        height="{$maxBarHeight * $Q1MalePercentage}" width="{$barWidth}px"
                        fill="blue"/>
                    <rect x="{$yearStartX}" y="{-$maxBarHeight}"
                        height="{$maxBarHeight * $Q1FemalePercentage}" width="{$barWidth}px"
                        fill="#33CCFF"/>
                    
                    <rect x="{$yearStartX + ($barWidth + $barSpacing)}" y="{- $maxBarHeight * $Q2MalePercentage}"
                        height="{$maxBarHeight * $Q2MalePercentage}" width="{$barWidth}px"
                        fill="blue"/>
                    <rect x="{$yearStartX +  ($barWidth + $barSpacing)}" y="{-$maxBarHeight}"
                        height="{$maxBarHeight * $Q2FemalePercentage}" width="{$barWidth}px"
                        fill="#33CCFF"/>
                    
                    <rect x="{$yearStartX + 2 * ($barWidth + $barSpacing)}" y="{- $maxBarHeight * $Q3MalePercentage}"
                        height="{$maxBarHeight * $Q3MalePercentage}" width="{$barWidth}px"
                        fill="blue"/>
                    <rect x="{$yearStartX + 2 * ($barWidth + $barSpacing)}" y="{-$maxBarHeight}"
                        height="{$maxBarHeight * $Q3FemalePercentage}" width="{$barWidth}px"
                        fill="#33CCFF"/>
                    
                    <rect x="{$yearStartX + 3 * ($barWidth + $barSpacing)}" y="{- $maxBarHeight * $Q4MalePercentage}"
                        height="{$maxBarHeight * $Q4MalePercentage}" width="{$barWidth}px"
                        fill="blue"/>
                    <rect x="{$yearStartX + 3 * ($barWidth + $barSpacing)}" y="{-$maxBarHeight}"
                        height="{$maxBarHeight * $Q4FemalePercentage}" width="{$barWidth}px"
                        fill="#33CCFF"/>

                    
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
    

    
</xsl:stylesheet>
