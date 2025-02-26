<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ext="http://exslt.org/common"
    exclude-result-prefixes="xs"
    version="2.0">

    <xsl:key name="types" match="seg-value" use="@type"/>
    
    <xsl:variable name="type-list">
        <xsl:for-each select="distinct-values(//seg/@type)">
            <seg-value>
                <xsl:attribute name="type">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </seg-value>
        </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="subtype-list">
        <xsl:for-each select="//seg[@type][@subtype]">
            <seg-value>
                <xsl:attribute name="type">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
                <xsl:attribute name="subtype">
                    <xsl:value-of select="@subtype"/>
                </xsl:attribute>
                <xsl:attribute name="combined">
                    <xsl:value-of select="@type"/>
                    <xsl:text>-</xsl:text>
                    <xsl:value-of select="@subtype"/>
                </xsl:attribute>
            </seg-value>
        </xsl:for-each>
    </xsl:variable>
    
    
    <xsl:template match="/">
        
        <html lang="ca">
            <head>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
                <link href="sample.css" rel="stylesheet" type="text/css" />
                <script type="text/javascript" src="sample.js"></script>
            </head>
            <body onload="addHandlers();">
            <input type="hidden" id="subtype-values">
                <xsl:attribute name="value">
                    <xsl:for-each select="distinct-values($subtype-list/seg-value/@combined)">
                        <xsl:value-of select="."/>
                        <xsl:text>|</xsl:text>
                    </xsl:for-each>
                </xsl:attribute>
            </input>
            <div id="selection">
                <label for="expansions">Display Text: </label>
                <select id="expansions">
                    <option value="am">Show abbreviated text</option>
                    <option value="ex">Show expanded text</option>
                </select>
                <label for="type">Type: </label>
                <select id="type">
                    <option value="none">Select</option>
                    <xsl:for-each select="$type-list/seg-value">
                        <xsl:variable name="type">
                            <xsl:value-of select="@type"/>
                        </xsl:variable>
                        <option>
                            <xsl:attribute name="value">
                                <xsl:value-of select="$type"/>
                            </xsl:attribute>
                            <xsl:value-of select="$type"/>
                        </option>
                        
                    </xsl:for-each>
                </select>
                <label for="subtype">Subtype: </label>
                <select id="subtype">
                    <option value="none">
                        <xsl:text>Select type first</xsl:text>
                    </option>
                </select>
            </div>
            <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="teiHeader">
        
    </xsl:template>
    
    <xsl:template match="respStmt">
        <xsl:value-of select="./resp/text()"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./name/text()"/>
        <br/>
    </xsl:template>
    
    <xsl:template match="funder">
        
    </xsl:template>
    
    <xsl:template match="principal">
        
    </xsl:template>
    
    <xsl:template match="sourceDesc">
        
    </xsl:template>
    
    <xsl:template match="encodingDesc">
        
    </xsl:template>
    
    <xsl:template match="publicationStmt">
        
    </xsl:template>
    
    <xsl:template match="title">
        <h1>
            <xsl:apply-templates/>
        </h1>
    </xsl:template>

    <xsl:template match="pb[@n]">
        <xsl:choose>
            <xsl:when test="@break='no' and @rend='hyphen'">
                <xsl:text>-</xsl:text><br/>
            </xsl:when>
            <xsl:otherwise>
                <br/>
            </xsl:otherwise>
        </xsl:choose>
        <br/>
        <span class="page-break">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:value-of select="@n"/>
        </span>
        <br/>
    </xsl:template>
    
    <xsl:template match="lb">
        <xsl:choose>
            <xsl:when test="@break='no' and @rend='hyphen'">
                <xsl:text>-</xsl:text><br/>
            </xsl:when>
            <xsl:otherwise>
                <br/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template match="div[not(@type='book')]">
        <span class="chapter">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:value-of select="@n"/>
        </span>
        <xsl:apply-templates/>  
    </xsl:template>

    <xsl:template match="ab">
        <span class="sentence">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <sub>
                <xsl:value-of select="@n div 100"/>
            </sub>
        </span>
        <xsl:apply-templates/>  
    </xsl:template>

    <xsl:template match="note">
        <span class="note"><xsl:attribute name="title"><xsl:apply-templates/></xsl:attribute>
            <sup>*</sup>
        </span>
    </xsl:template>

    <xsl:template match="am[not(ancestor::choice)]">
        <span class="am">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="ex[not(ancestor::choice)]">
        <span class="ex">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="abbr">
        <span class="am">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="expan">
        <span class="ex">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="person">
        <span class="person-tag">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="name">
        <span class="name-tag">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="place">
        <span class="place-tag">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="seg">
        <span>
            <xsl:attribute name="class">
                <xsl:value-of select="@type"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="@subtype"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
</xsl:stylesheet>