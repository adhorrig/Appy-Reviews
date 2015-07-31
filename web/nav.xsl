<?xml version="1.0" encoding="UTF-8"?>
 
<!--
    Document   : nav.xsl
    Created on : 07 December 2014, 16:14
    Author     : Adam
    Description:
        Purpose of transformation follows.
-->
 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Reviews</title>
                <script src="js/jquery.min.js"></script>
                <script src="js/bootstrap.min.js"></script>
                <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
                <script type="text/javascript">
                    //<![CDATA[
 
                    var first_content_added = false;
                    $(function() {
                        $(".learn-more").on("click", function() {
                            $.getJSON("projectinfo.json", function(data) {
                                appendContentToFirstP(data.project[0].about.info);
                            });
                        });
                    });
  
                    function appendContentToFirstP(content) {
                        if (first_content_added) {
                            return;
                        }
                        var after_first_p = $('<p class="more-info" />');
                        after_first_p.text(content);
                        $(".first").append(after_first_p);
                        first_content_added = true;
                    }
                        
                    function getValidationErrors() {
                        var erroredFields = [];
                        if(document.form.name.value.length == 0) {
                            erroredFields.push("Your name.\n");
                        }
                        if(document.form.email.value.length == 0) {
                            erroredFields.push("Your email address.\n");
                        }
                        return erroredFields;
                    }
                    function validate() {
                        var erroredFields = getValidationErrors();
                        if (erroredFields.length > 0) {
                            var errMsg = "The following fields are missing:\n"
                            for (var i=0; i<erroredFields.length; i++){
                                errMsg += "     * " + erroredFields[i];
                            }
                            window.alert(errMsg);
                            return false;
                        } else {
                                window.alert("Thank you for your email. We will reply as soon as possible.");
                            }
                        }

                    //]]>         
                </script>
                <style>
                    @import url(css/bootstrap.min.css);
                    body{
                    background-color: #E8E8E8;
                    }
                </style>
            </head>
            <body>
                <!-- Static navbar -->
                <nav class="navbar navbar-default" role="navigation">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                            <a class="navbar-brand" href="">Appy Reviews</a>
                        </div>
                        <div id="navbar" class="navbar-collapse collapse">
                            <ul class="nav navbar-nav">
                                <li class="active">
                                    <a href="index.html">Home</a>
                                </li>
                                <li>
                                    <a href="review">Reviews</a>
                                </li>
                                <li>
                                    <a href="contact">Contact</a>
                                </li>
                            </ul>
                        </div><!--/.nav-collapse -->
                    </div><!--/.container-fluid -->
                </nav>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>