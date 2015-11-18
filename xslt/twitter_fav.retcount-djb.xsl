<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2000/svg"
    version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="root" select="/" as="document-node()"/>
    <xsl:key name="tweetByDate" match="tweet"
        use="substring(created_at, string-length(created_at) - 4)"/>
    <xsl:template match="/">
        <svg height="100%" width="100%">
            <g transform="translate(75, 600)">
                <line x1="0" y1="0" x2="1100" y2="0" stroke="black" stroke-width="2"/>
                <line x1="0" y1="0" x2="0" y2="-500" stroke="black" stroke-width="2"/>
                <text x="100" y="20" text-anchor="middle">2006</text>
                <text x="200" y="20" text-anchor="middle">2007</text>
                <text x="300" y="20" text-anchor="middle">2008</text>
                <text x="400" y="20" text-anchor="middle">2009</text>
                <text x="500" y="20" text-anchor="middle">2010</text>
                <text x="600" y="20" text-anchor="middle">2011</text>
                <text x="700" y="20" text-anchor="middle">2012</text>
                <text x="800" y="20" text-anchor="middle">2013</text>
                <text x="900" y="20" text-anchor="middle">2014</text>
                <text x="1000" y="20" text-anchor="middle">2015</text>
                <text x="-50" y="-150">0.5</text>
                <text x="-50" y="-300">1.0</text>
                <xsl:for-each select="2006 to 2015">
                    <xsl:variable name="startYearTweets" select="key('tweetByDate',.,$root)" as="element(tweet)*"/>
                    <xsl:variable name="endYearTweets" select="key('tweetByDate',. + 1,$root)" as="element(tweet)*"/>
                    <xsl:value-of select="count($startYearTweets)"/>
                </xsl:for-each>
            </g>
        </svg>
    </xsl:template>
<!--    <xsl:template match="tweet">
        <circle cx="100" cy="{-avg(//created_at[matches(.,'2006$')]/../retweet_count) * 300}" r="5"
            fill="blue"/>
        <line x1="100" y1="{-avg(//created_at[matches(.,'2006$')]/../retweet_count) * 300}" r="5"
            x2="200" y2="{-avg(//created_at[matches(.,'2007$')]/../retweet_count) * 300}"
            stroke="blue" stroke-width="3"/>
        <circle cx="200" cy="{-avg(//created_at[matches(.,'2007$')]/../retweet_count) * 300}" r="5"
            fill="blue"/>
        <line x1="200" y1="{-avg(//created_at[matches(.,'2007$')]/../retweet_count) * 300}" r="5"
            x2="300" y2="{-avg(//created_at[matches(.,'2008$')]/../retweet_count) * 300}"
            stroke="blue" stroke-width="3"/>
        <circle cx="300" cy="{-avg(//created_at[matches(.,'2008$')]/../retweet_count) * 300}" r="5"
            fill="blue"/>
        <line x1="300" y1="{-avg(//created_at[matches(.,'2008$')]/../retweet_count) * 300}" r="5"
            x2="400" y2="{-avg(//created_at[matches(.,'2009$')]/../retweet_count) * 300}"
            stroke="blue" stroke-width="3"/>
        <circle cx="400" cy="{-avg(//created_at[matches(.,'2009$')]/../retweet_count) * 300}" r="5"
            fill="blue"/>
        <line x1="400" y1="{-avg(//created_at[matches(.,'2009$')]/../retweet_count) * 300}" r="5"
            x2="500" y2="{-avg(//created_at[matches(.,'2010$')]/../retweet_count) * 300}"
            stroke="blue" stroke-width="3"/>
        <circle cx="500" cy="{-avg(//created_at[matches(.,'2010$')]/../retweet_count) * 300}" r="5"
            fill="blue"/>
        <line x1="500" y1="{-avg(//created_at[matches(.,'2010$')]/../retweet_count) * 300}" r="5"
            x2="600" y2="{-avg(//created_at[matches(.,'2011$')]/../retweet_count) * 300}"
            stroke="blue" stroke-width="3"/>
        <circle cx="600" cy="{-avg(//created_at[matches(.,'2011$')]/../retweet_count) * 300}" r="5"
            fill="blue"/>
        <line x1="600" y1="{-avg(//created_at[matches(.,'2011$')]/../retweet_count) * 300}" r="5"
            x2="700" y2="{-avg(//created_at[matches(.,'2012$')]/../retweet_count) * 300}"
            stroke="blue" stroke-width="3"/>
        <circle cx="700" cy="{-avg(//created_at[matches(.,'2012$')]/../retweet_count) * 300}" r="5"
            fill="blue"/>
        <line x1="700" y1="{-avg(//created_at[matches(.,'2012$')]/../retweet_count) * 300}" r="5"
            x2="800" y2="{-avg(//created_at[matches(.,'2013$')]/../retweet_count) * 300}"
            stroke="blue" stroke-width="3"/>
        <circle cx="800" cy="{-avg(//created_at[matches(.,'2013$')]/../retweet_count) * 300}" r="5"
            fill="blue"/>
        <line x1="800" y1="{-avg(//created_at[matches(.,'2013$')]/../retweet_count) * 300}" r="5"
            x2="900" y2="{-avg(//created_at[matches(.,'2014$')]/../retweet_count) * 300}"
            stroke="blue" stroke-width="3"/>
        <circle cx="900" cy="{-avg(//created_at[matches(.,'2014$')]/../retweet_count) * 300}" r="5"
            fill="blue"/>
        <line x1="900" y1="{-avg(//created_at[matches(.,'2014$')]/../retweet_count) * 300}" r="5"
            x2="1000" y2="{-avg(//created_at[matches(.,'2015$')]/../retweet_count) * 300}"
            stroke="blue" stroke-width="3"/>
        <circle cx="1000" cy="{-avg(//created_at[matches(.,'2015$')]/../retweet_count) * 300}" r="5"
            fill="blue"/>
        <circle cx="100" cy="{-avg(//created_at[matches(.,'2006$')]/../favorite_count) * 300}" r="5"
            fill="blue"/>
        <line x1="100" y1="{-avg(//created_at[matches(.,'2006$')]/../favorite_count) * 300}" r="5"
            x2="200" y2="{-avg(//created_at[matches(.,'2007$')]/../favorite_count) * 300}"
            stroke="blue" stroke-width="3" stroke-dasharray="8 4"/>
        <circle cx="200" cy="{-avg(//created_at[matches(.,'2007$')]/../favorite_count) * 300}" r="5"
            fill="blue"/>
        <line x1="200" y1="{-avg(//created_at[matches(.,'2007$')]/../favorite_count) * 300}" r="5"
            x2="300" y2="{-avg(//created_at[matches(.,'2008$')]/../favorite_count) * 300}"
            stroke="blue" stroke-width="3" stroke-dasharray="8 4"/>
        <circle cx="300" cy="{-avg(//created_at[matches(.,'2008$')]/../favorite_count) * 300}" r="5"
            fill="blue"/>
        <line x1="300" y1="{-avg(//created_at[matches(.,'2008$')]/../favorite_count) * 300}" r="5"
            x2="400" y2="{-avg(//created_at[matches(.,'2009$')]/../favorite_count) * 300}"
            stroke="blue" stroke-width="3" stroke-dasharray="8 4"/>
        <circle cx="400" cy="{-avg(//created_at[matches(.,'2009$')]/../favorite_count) * 300}" r="5"
            fill="blue"/>
        <line x1="400" y1="{-avg(//created_at[matches(.,'2009$')]/../favorite_count) * 300}" r="5"
            x2="500" y2="{-avg(//created_at[matches(.,'2010$')]/../favorite_count) * 300}"
            stroke="blue" stroke-width="3" stroke-dasharray="8 4"/>
        <circle cx="500" cy="{-avg(//created_at[matches(.,'2010$')]/../favorite_count) * 300}" r="5"
            fill="blue"/>
        <line x1="500" y1="{-avg(//created_at[matches(.,'2010$')]/../favorite_count) * 300}" r="5"
            x2="600" y2="{-avg(//created_at[matches(.,'2011$')]/../favorite_count) * 300}"
            stroke="blue" stroke-width="3" stroke-dasharray="8 4"/>
        <circle cx="600" cy="{-avg(//created_at[matches(.,'2011$')]/../favorite_count) * 300}" r="5"
            fill="blue"/>
        <line x1="600" y1="{-avg(//created_at[matches(.,'2011$')]/../favorite_count) * 300}" r="5"
            x2="700" y2="{-avg(//created_at[matches(.,'2012$')]/../favorite_count) * 300}"
            stroke="blue" stroke-width="3" stroke-dasharray="8 4"/>
        <circle cx="700" cy="{-avg(//created_at[matches(.,'2012$')]/../favorite_count) * 300}" r="5"
            fill="blue"/>
        <line x1="700" y1="{-avg(//created_at[matches(.,'2012$')]/../favorite_count) * 300}" r="5"
            x2="800" y2="{-avg(//created_at[matches(.,'2013$')]/../favorite_count) * 300}"
            stroke="blue" stroke-width="3" stroke-dasharray="8 4"/>
        <circle cx="800" cy="{-avg(//created_at[matches(.,'2013$')]/../favorite_count) * 300}" r="5"
            fill="blue"/>
        <line x1="800" y1="{-avg(//created_at[matches(.,'2013$')]/../favorite_count) * 300}" r="5"
            x2="900" y2="{-avg(//created_at[matches(.,'2014$')]/../favorite_count) * 300}"
            stroke="blue" stroke-width="3" stroke-dasharray="8 4"/>
        <circle cx="900" cy="{-avg(//created_at[matches(.,'2014$')]/../favorite_count) * 300}" r="5"
            fill="blue"/>
        <line x1="900" y1="{-avg(//created_at[matches(.,'2014$')]/../favorite_count) * 300}" r="5"
            x2="1000" y2="{-avg(//created_at[matches(.,'2015$')]/../favorite_count) * 300}"
            stroke="blue" stroke-width="3" stroke-dasharray="8 4"/>
        <circle cx="1000" cy="{-avg(//created_at[matches(.,'2015$')]/../favorite_count) * 300}"
            r="5" fill="blue"/>
    </xsl:template>-->
</xsl:stylesheet>
