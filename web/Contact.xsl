<?xml version="1.0"?>
<xsl:transform  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:include href="nav.xsl"/>  
    <xsl:template match="root">
        <div class="container">
            <div class="jumbotron"> 
                <div class="content">
                    <p> 
                        <h2>Opening hours:</h2>
                    </p>
                    <p> Monday: <xsl:apply-templates select="//hours//monday"/></p>
                    <p> Tuesday: <xsl:apply-templates select="//hours//tuesday"/></p>
                    <p> Wednesday: <xsl:apply-templates select="//hours//wednesday"/></p>
                    <p> Thursday: <xsl:apply-templates select="//hours//thursday"/></p>
                    <p> Friday: <xsl:apply-templates select="//hours//friday"/></p>
                    <p> Saturday: <xsl:apply-templates select="//hours//saturday"/></p>
                    <p> Sunday: <xsl:apply-templates select="//hours//sunday"/></p>
                </div>
            </div>
            <div class="jumbotron"> 
                <div class="content">
                    <p>
                        <h2> Contact details: </h2>
                    </p>
                    <p> Phone: <xsl:apply-templates select="//contact//phone"/></p>
                    <p> Email: <xsl:apply-templates select="//contact//email"/></p>
                    <p> Address: <xsl:apply-templates select="//contact//address"/></p>
                    <p> Fax: <xsl:apply-templates select="//contact//fax"/></p>
                </div>
            </div>
            <div class="jumbotron">
                <div class="content">
                    <p>
                        <h2>
                            <xsl:apply-templates select="//header//contact"/>
                        </h2>
                    </p>
                    <form id="form" method="post" name="form" onsubmit="return validateForm()">
                        <div class="form-group">
                            <label for="name">
                                <xsl:apply-templates select="//form//name"/>
                            </label> 
                            <input class=
               "form-control" id="name" name="name" placeholder=
               "Please enter your name..." type="text"/>
                        </div>
                        <div class="form-group">
                            <label for="email">
                                <xsl:apply-templates select="//form//email"/>
                            </label> 
                            <input class=
               "form-control" id="email" name="email" placeholder=
               "Please enter your email address..." type="text"/>
                        </div>
                        <div class="form-group">
                            <label for="comment">Comment</label> 
                            <textarea class="form-control" id="comment" name=
               "comment" placeholder="Please leave your comment..."
                                      rows="6">
                            </textarea>
                        </div>
                        <button class="btn btn-default btn-sm" type="submit" onClick="validate()">  
                            <xsl:value-of select="//form//submit"/>
                        </button> 
                        <button class="btn btn-default btn-sm" type="submit" onClick="validate()">  
                            <xsl:value-of select="//form//reset"/>
                        </button> 
                    </form>
                </div>
            </div>
        </div>
    </xsl:template>    
</xsl:transform>
 