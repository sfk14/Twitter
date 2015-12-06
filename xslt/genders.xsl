<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    This file takes a set of tweets as input, classifies the users as male, female, or unknown, and then outputs a new file with only the gender approximation and date. This is an intermediate step in producing graphs of the user gender breakdown over time. By Johne Rzodkiewicz. 
-->




<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- These files include the ~5000 most popular names of each gender in 2011. The original data came from http://names.mongabay.com/baby-names/application/ -->
    <xsl:variable name="maleNames" select="document('maleNames.xml')//name"/>
    <xsl:variable name="femaleNames" select="document('femaleNames.xml')//name"/>
    
    <xsl:template match="/">
        <tweetsByGender>
            <xsl:apply-templates select="//tweet"/>
        </tweetsByGender>
    </xsl:template>
    
    <xsl:template match="tweet">
        
        <!-- Try to get the user's first name -->
        <xsl:variable name="name" select="tokenize(./user/name, ' ')[1]"/>
        <tweet>
        <xsl:choose>
            <xsl:when test="$name = $maleNames and not($name = $femaleNames)">
                    <gender>male</gender>
            </xsl:when>
            <xsl:when test="$name = $femaleNames and not($name = $maleNames)">
                    <gender>female</gender>
            </xsl:when>
            <xsl:otherwise>
                    <gender>unknown</gender>
            </xsl:otherwise>
        </xsl:choose>
        
        <created_at><xsl:value-of select="./created_at"/></created_at>
        </tweet>
    </xsl:template>
    
</xsl:stylesheet>