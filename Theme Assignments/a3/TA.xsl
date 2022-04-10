<?xml version="1.0"?>
<!-- Keelan Matthews u21549967 -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head></head>
            <body>
                <b>Available Books</b> <br />
                <xsl:apply-templates select="up/library[@name='merensky']/book">
                    <xsl:sort select="@isbn"/>
                </xsl:apply-templates>
                <br />

                <i>Total books available: <xsl:value-of select="count(up/library/book[not(@status='out')])"/></i> <br />
                <i>Total books taken out: <xsl:value-of select="count(up/library/book[@status='out'])"/></i>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="library[@name='merensky']/book">
        <xsl:variable name="isbn" select="@isbn"/>
        Book <xsl:value-of select="$isbn"/> can be found in Merensky 
        <xsl:for-each select="/up/library[@name='klinikala']/book">
            <xsl:if test="$isbn = @isbn">
                <xsl:if test="not(@status)">
                    <xsl:text> ,Klinikala</xsl:text>
                </xsl:if>
            </xsl:if>
        </xsl:for-each>
        <xsl:for-each select="/up/library[@name='music']/book">
            <xsl:if test="$isbn = @isbn">
                <xsl:if test="not(@status)">
                    <xsl:text> ,Music</xsl:text>
                </xsl:if>
            </xsl:if>
        </xsl:for-each>     

        <br/>
    </xsl:template>

</xsl:stylesheet>