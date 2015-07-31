<?xml version="1.0"?>
<xsl:transform  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:include href="nav.xsl"/>  
 
    <!--
        Document   : Review.xsl
        Created on : 13 November 2014, 16:14
        Author     : Adam
        Description:
            Purpose of transformation follows.
    -->
 
  
 
    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="//root">
        <xsl:for-each select="//app">  
            <div class="container">
                <div class = "jumbotron">
                    <div class="content">
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
                                <xsl:attribute name="href">InfoServlet?name=<xsl:value-of select="./name"/></xsl:attribute>
                            
                                View in slideshow format.
                            </xsl:element>
                        </p>
                    </div>
                </div>
            </div>
        </xsl:for-each>
        <div class="container">
            <div class="jumbotron">
                <div class="content">
                    <p> 
                        <a class="learn-more" role="button">
                            Click here for project details.
                        </a>
                    </p>
                    <p class="first">
                            
                    </p>
                </div>
            </div>
        </div>   
    </xsl:template>
</xsl:transform>

