<?xml version="1.0" encoding="utf-8"?>
<!-- Keelan Matthews u21549967 -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:variable name="max">
        <xsl:for-each select="character/class/skills/skill | character/class/items/item">
            <xsl:sort select="requirements/level" data-type="number" order="descending"/>
            <xsl:if test="position() = 1"><xsl:value-of select="requirements/level"/></xsl:if>
        </xsl:for-each>
    </xsl:variable>

    <xsl:template match="/">
        <html>
            <head></head>
            <body>
                <style>
                    body {
                        font-family: "Helvetica";
                    }

                    td {
                        vertical-align: top;
                    }

                    .grid {
                        display: grid;  
                        grid-template-columns: repeat(auto-fill, 400px);
                        grid-column-gap: 6px;
                        grid-row-gap:6px;
                        width: 1300px;
                        margin: 0 auto;
                    }
                </style>
                <div style="text-align: center">
                    <a href="{character/@source}">
                        <img src="images/diablo3-logo.png"/>
                    </a>
                </div>
                
                <h1 style="text-transform: uppercase; text-align: center">
                    <xsl:value-of select="character/class/basic/name"/>
                </h1>
                <p style="text-align: center">
                    Last updated on <xsl:value-of select="character/class/basic/update"/> by <xsl:value-of select="character/class/basic/creator"/>
                </p>
                <p style="text-align: center">
                    Tags: 
                    <xsl:for-each select="character/class/basic/tags/tag[not(@status='outdated')]">
                        <xsl:value-of select="."/>
                        <xsl:if test="position() !=last()">, </xsl:if>
                    </xsl:for-each>
                </p>
                <p style="font-weight: bold; text-align: center">
                    Level required for this build: <xsl:value-of select="$max"/> Average item level: <xsl:value-of select="ceiling(sum(/character/class/items/item/requirements/level) div count(/character/class/items/item/requirements/level))"/>
                </p>

                <h2 style="font-weight: bold; text-align: center; margin-top: 100px;">Paragon Priorities</h2>

                <table style="margin: 0 auto">
                    <tr style="background-color: #d99e9a">
                      <xsl:for-each select="character/class/paragon">
                        <th style="padding: 10px">
                          <xsl:value-of select ="@set"/>
                        </th>
                      </xsl:for-each>
                    </tr>
                    <tr>
                        <xsl:for-each select="character/class/paragon">
                            <td style="padding: 10px; border: 2px solid grey">
                                <ol>
                                    <xsl:for-each select="priority">
                                        <xsl:sort select="@weight"/>
                                        <li style="padding: 5px">
                                            <xsl:value-of select="."/>
                                        </li>
                                    </xsl:for-each>
                                </ol>
                            </td>
                        </xsl:for-each>
                    </tr>
                </table>

                <h2 style="font-weight: bold; text-align: center; margin-top: 100px;">Skills</h2>
                <table style="width: 900px; margin: 0 auto">
                    <tr style="background-color: #d99e9a"><th colspan="100%" style="padding: 10px">Active</th></tr>
                    <tr>
                        <xsl:apply-templates select="/character/class/skills/skill[@type='active' and not(position() mod 2 = 0)]"/>
                    </tr>
                    <tr>
                        <xsl:apply-templates select="/character/class/skills/skill[@type='active' and position() mod 2 = 0]"/>
                    </tr> 
                </table>
                <table style="width: 900px; margin: 0 auto">
                    <tr style="background-color: #d99e9a"><th colspan="100%" style="padding: 10px">Passive</th></tr>
                    <tr>
                        <xsl:apply-templates select="/character/class/skills/skill[@type='passive']">
                            <xsl:sort select="requirements/level" data-type="number" order="descending" />
                        </xsl:apply-templates>
                    </tr> 
                </table>

                <h2 style="font-weight: bold; text-align: center; margin-top: 100px">Gear</h2>
                <div class="grid">
                    <xsl:apply-templates select="/character/class/items/item[position() != 13]">
                        <xsl:sort select="set"/>
                    </xsl:apply-templates>
                </div>

                <h2 style="font-weight: bold; text-align: center; margin-top: 100px;">Kanai's Cube</h2>
                <div class="grid">
                        <xsl:apply-templates select="/character/class/cubes/item">
                            <xsl:sort select="/character/class/cubes/item/name"/>
                        </xsl:apply-templates>
                </div>
                <p style="text-align: center; padding: 40px">
                    Created by Keelan Matthews (21549967) 09 May 2022
                </p>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="/character/class/skills/skill">
        <xsl:if test="@type='active'">
            <td style="width: 300px; height: 500px; border: 2px solid grey; padding: 10px">
                <img src="images/skills/{@image}" alt=""/>
                <h3><xsl:value-of select="name"/></h3>
                <p><xsl:value-of select="cost/@unit"/> - <xsl:value-of select="cost"/></p>
                <p><xsl:value-of select="description"/></p>
                <div style="display: flex">
                    <img src="images/skills/{rune/@image}" alt=""/>
                    <p><xsl:value-of select="rune/name"/></p>
                </div>
                <p><xsl:value-of select="rune/description"/></p>
            </td>
        </xsl:if>
        <xsl:if test="@type='passive'">
            <td style="width: 300px; border: 2px solid grey; padding: 10px">
                <img src="images/skills/{@image}" alt=""/>
                <h3><xsl:value-of select="name"/></h3>
                <p><xsl:value-of select="description"/></p>
            </td>
        </xsl:if>
    </xsl:template>

    <xsl:template match="item">
        <div style="border: 2px solid grey; padding: 10px">
            <div style="height: 400px; display: flex; flex-direction: column; align-items: center; margin-bottom: 10px">
                <h3 style="color: {rarity}; background-color: #292828; width: 100%; margin-top: 0; padding: 10px; text-align: center;"><xsl:value-of select="name"/> (<xsl:value-of select="set/@type"/>)</h3>
                <p style="color: {rarity}"><xsl:value-of select="rarity/@set"/>&#160;<xsl:value-of select="set"/></p>
                <img style="background-color: {rarity}; width: 100px" src="images/gear/{@image}"/>
                <p>Level requirement: <xsl:value-of select="requirements/level"/></p>
                <p>
                    <xsl:if test="stats/defense">
                        <b>Armor </b><xsl:value-of select="stats/defense/armor"/>
                    </xsl:if> 
                    <xsl:if test="stats/attack">
                        <b>DPS </b><xsl:value-of select="stats/attack/dps"/>&#160;
                        <b>DMG </b><xsl:value-of select="stats/attack/damage"/>&#160;
                        <b>APS </b><xsl:value-of select="stats/attack/aps"/>
                    </xsl:if> 
                </p>
            </div>
            
            <xsl:if test="stats/primary">
                <b>========Primary Stats========</b><br/>
                <ul>
                    <xsl:for-each select="stats/primary/stat">
                        <li><xsl:value-of select="."/></li>
                    </xsl:for-each>
                </ul>
            </xsl:if> 
            <xsl:if test="stats/secondary">
                <b>========Secondary Stats========</b><br/>
                <ul>
                    <xsl:for-each select="stats/secondary/stat">
                        <li><xsl:value-of select="."/></li>
                    </xsl:for-each>
                </ul>
            </xsl:if> 
        </div>
    </xsl:template>

</xsl:stylesheet>      