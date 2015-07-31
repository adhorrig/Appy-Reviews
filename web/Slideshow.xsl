<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:include href="nav.xsl"/>
    <xsl:param name="app_name"></xsl:param>
    <xsl:param name="prev_name"></xsl:param>
    <xsl:param name="next_name"></xsl:param>
    <xsl:template match="//app">
        <div class = "info">
            <xsl:if test="./name=$app_name">	
                <div class = "container">
                    <div class = "jumbotron">
                        <div class = "content">
                            <p>
                                <h2>
                                    <xsl:apply-templates select="./name"/>
                                </h2>
                            </p>
                            <p>                    
                                <strong>Information: </strong> 
                                <xsl:apply-templates select="./information"/>
                            </p>
                            <p>
                                <strong>Price:</strong>
                                <xsl:value-of select="./price"/>
                            </p>
                            <p>
                                <strong>Opinion:</strong>
                                <xsl:value-of select="./opinion"/>
                            </p>
                            <p>
                                <strong>Rating:</strong>
                                <xsl:value-of select="./rating"/>
                            </p>                    
                            <p>
                                <xsl:element name="a">
                                    <xsl:attribute name="href">InfoServlet?name=<xsl:value-of select="$prev_name"/></xsl:attribute>Previous Event
                                </xsl:element>
                            </p>
                            <p>
                                <xsl:element name="a">
                                    <xsl:attribute name="href">InfoServlet?name=<xsl:value-of select="$next_name"/></xsl:attribute>Next Event
                                </xsl:element>
                            </p>
                            <p>
                                <xsl:element name="a">
                                    <xsl:attribute name="href">UpdateServlet?name=<xsl:value-of select="$app_name"/></xsl:attribute>Update
                                </xsl:element>
                            </p>
                        </div>
                    </div>
                </div>
            </xsl:if>
        </div>
    </xsl:template>
</xsl:stylesheet>



