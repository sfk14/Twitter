<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2000/svg"
    version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="root" select="/" as="document-node()"/>
    <!-- The key makes it possible to retrieve tweets by year using the key() function -->
    <xsl:key name="tweetByDate" match="tweet"
        use="substring(created_at, string-length(created_at) - 3)"/>
    <xsl:template match="/">
        <svg height="100%" width="100%">
            <g transform="translate(75, 600)">
                <line x1="0" y1="0" x2="1100" y2="0" stroke="black" stroke-width="2"/>
                <line x1="0" y1="0" x2="0" y2="-500" stroke="black" stroke-width="2"/>
                <text x="-50" y="-150">0.5</text>
                <text x="-50" y="-300">1.0</text>
                <xsl:for-each select="2006 to 2015">
                    <!-- find all tweets for the specified year -->
                    <xsl:variable name="tweetYear" select="key('tweetByDate', string(.), $root)"
                        as="element(tweet)*"/>
                    <!-- find all tweets for the next year (will fail for 2015) -->
                    <xsl:variable name="nextTweetYear"
                        select="key('tweetByDate', string(. + 1), $root)" as="element(tweet)*"/>
                    <!-- X and Y coordinates for tweets for year -->
                    <xsl:variable name="xPos" select="position() * 100" as="xs:integer?"/>
                    <xsl:variable name="yPos"
                        select="concat('-', (avg($tweetYear/retweet_count), 0)[1] * 300)"
                        as="xs:string"/>
                    <!-- X and Y coordinates for tweets for next year -->
                    <xsl:variable name="nextXPos" select="(position() + 1) * 100" as="xs:integer"/>
                    <xsl:variable name="nextYPos"
                        select="concat('-', (avg($nextTweetYear/retweet_count), 0)[1] * 300)"
                        as="xs:string"/>
                    <!-- Use the year to label the X axis -->
                    <text x="{$xPos}" y="20" text-anchor="middle">
                        <xsl:value-of select="."/>
                    </text>
                    <!-- Draw a circle for the current year -->
                    <circle cx="{$xPos}" cy="{$yPos}" r="5" fill="blue" opacity="0.4"/>
                    <!-- If there's a following year, draw a line between current and following -->
                    <xsl:if test="not(position() eq last())">
                        <line x1="{$xPos}" y1="{$yPos}" x2="{$nextXPos}" y2="{$nextYPos}"
                            stroke="blue" stroke-width="3" opacity="0.4"/>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="2006 to 2015">
                    <!-- find all tweets for the specified year -->
                    <xsl:variable name="tweetYear" select="key('tweetByDate', string(.), $root)"
                        as="element(tweet)*"/>
                    <!-- find all tweets for the next year (will fail for 2015) -->
                    <xsl:variable name="nextTweetYear"
                        select="key('tweetByDate', string(. + 1), $root)" as="element(tweet)*"/>
                    <!-- X and Y coordinates for tweets for year -->
                    <xsl:variable name="xPos" select="position() * 100" as="xs:integer?"/>
                    <xsl:variable name="yPos"
                        select="concat('-', (avg($tweetYear/favorite_count), 0)[1] * 300)"
                        as="xs:string"/>
                    <!-- X and Y coordinates for tweets for next year -->
                    <xsl:variable name="nextXPos" select="(position() + 1) * 100" as="xs:integer"/>
                    <xsl:variable name="nextYPos"
                        select="concat('-', (avg($nextTweetYear/favorite_count), 0)[1] * 300)"
                        as="xs:string"/>
                    <!-- Use the year to label the X axis -->
                    <text x="{$xPos}" y="20" text-anchor="middle">
                        <xsl:value-of select="."/>
                    </text>
                    <!-- Draw a circle for the current year -->
                    <circle cx="{$xPos}" cy="{$yPos}" r="5" fill="blue" opacity="0.4"/>
                    <!-- If there's a following year, draw a line between current and following -->
                    <xsl:if test="not(position() eq last())">
                        <line x1="{$xPos}" y1="{$yPos}" x2="{$nextXPos}" y2="{$nextYPos}"
                            stroke="blue" stroke-width="3" stroke-dasharray="8 4" opacity="0.4"/>
                    </xsl:if>
                </xsl:for-each>
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>
