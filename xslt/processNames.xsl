<?xml version="1.0" encoding="UTF-8"?>


<!-- This was used to convert the list of names into a more manageable format. -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/">
        <nameList>
            <xsl:apply-templates select="//tr"/>
        </nameList>
    </xsl:template>
    
    <xsl:template match="tr">
        <name>
            <xsl:value-of select="./td[2]"/>
        </name> 
        
    </xsl:template>
    
</xsl:stylesheet>