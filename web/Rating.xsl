<?xml version="1.0"?>
<xsl:transform  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:include href="nav.xsl"/>
    <xsl:param name="name"></xsl:param>
    <xsl:template match="//app">
        <xsl:if test="./name=$name">  
            <div class="container">
                <div class = "jumbotron">
                    <div class = "content">  
                        <p>
                            <h2>
                                <xsl:value-of select="./name"/>
                            </h2>
                        </p>
                        <p>
                            The current rating for the <xsl:value-of select="./name"/> app is shown below. To modify this rating, change the rating and click update.
                        </p>
                        <xsl:element name="form">
                            <xsl:attribute name="action">InfoServlet</xsl:attribute>
                            <xsl:attribute name="method">post</xsl:attribute>            
                            <xsl:element name="input">
                                <xsl:attribute name="value">
                                    <xsl:value-of select="./name"/>
                                </xsl:attribute>
                                <xsl:attribute name="type">hidden</xsl:attribute>
                                <xsl:attribute name="name">name</xsl:attribute>
                            </xsl:element>
                            <p>
                                Current Rating:
                                <xsl:element name="input">
                                    <xsl:attribute name="value">
                                        <xsl:value-of select="./rating"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="type">integer</xsl:attribute>
                                    <xsl:attribute name="size">10</xsl:attribute>
                                    <xsl:attribute name="name">rating</xsl:attribute>
                                </xsl:element>
                            </p>
                            <input id="updateForm" class = "btn btn-default btn-sm" type="submit" value="Update" />
                            <a class="anchor">
                                <xsl:attribute name="href">InfoServlet?name=<xsl:value-of select="$name"/></xsl:attribute>
                                <input type="button" class = "btn btn-default btn-sm" value="Cancel"/>
                            </a>            
                        </xsl:element>
                    </div>
                </div>
            </div>
        </xsl:if>
    </xsl:template>
</xsl:transform>

  
        



