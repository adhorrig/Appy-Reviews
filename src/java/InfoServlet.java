import java.io.File;
import javax.xml.transform.dom.DOMSource;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.Transformer;
import java.io.IOException;
import java.io.PrintWriter;
import org.xmldb.api.base.*;
import org.xmldb.api.modules.*;
import org.xmldb.api.*;
import javax.xml.transform.OutputKeys;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class InfoServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String URI = "xmldb:exist://localhost:8444/exist/xmlrpc";
        String driver = "org.exist.xmldb.DatabaseImpl";

        XMLResource res = null;
        Node resNode = null;
        Document doc = null;

        String path = getServletContext().getRealPath("/");
        String XSLFileName = path + "/Slideshow.xsl";
        File XslFile = new File(XSLFileName);

        String name;
        String rating;

        try {
            name = request.getParameter("name");
            rating = request.getParameter("rating");

            if (name == null) {
                name = "";
            }
            if (rating == null) {
                rating = "";
            }

        } catch (Exception e) {
            name = "";
            rating = "";

        }

        try {
            Class cl = Class.forName(driver);
            Database database = (Database) cl.newInstance();
            DatabaseManager.registerDatabase(database);

            // get the collection
            Collection col = DatabaseManager.getCollection(URI + "/db/Project", "admin", "password");
            
            XQueryService service = (XQueryService) col.getService("XQueryService", "1.0");
            XQueryService another = (XQueryService) col.getService("XQueryService", "1.0");
            service.setProperty("indent", "yes");
            another.setProperty("indent", "yes");
            String queryString = "";
            if (!(rating.equals(""))) {
                service.declareVariable("rating", "");
                queryString = "for $rating in //app//name[text()='" +  name + "']/../rating " +
                              "return update replace $rating with <rating>" + rating + "</rating>";
                service.query(queryString);
            }

            col.setProperty(OutputKeys.INDENT, "no");
            
            res = (XMLResource) col.getResource("Review.xml");

            resNode = res.getContentAsDOM();

            doc = (Document) resNode;

        } catch (Exception e) {
            System.err.println("Error Document: " + e.getMessage());
        }
        DOMSource origDocSource = new DOMSource(doc);

        try {
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            StreamSource stylesheet = new StreamSource(XslFile);

            Transformer transformer = transformerFactory.newTransformer(stylesheet);

            NodeList appNodes = doc.getElementsByTagName("name");
            int numEvent = appNodes.getLength();
            String prev;
            String next;

            for (int i = 0; i < numEvent; i++) {

                Node eventNode = appNodes.item(i);

                NodeList eventNodeListChildren = eventNode.getChildNodes();
                Node eventTextNode = eventNodeListChildren.item(0);
                String appname = eventTextNode.getNodeValue();
                if (name.equals(appname)) {

                    if (i != 0) {
                        prev = appNodes.item(i - 1).getChildNodes().item(0).getNodeValue();
                    } else {
                        prev = appNodes.item(numEvent - 1).getChildNodes().item(0).getNodeValue();
                    }

                    if (i != (numEvent - 1)) {
                        next = appNodes.item(i + 1).getChildNodes().item(0).getNodeValue();
                    } else {
                        next = appNodes.item(0).getChildNodes().item(0).getNodeValue();
                    }

                    transformer.setParameter("app_name", appname);
                    transformer.setParameter("prev_name", prev);
                    transformer.setParameter("next_name", next);

                    transformer.transform(origDocSource, new StreamResult(out));
                }
            }
        } catch (Exception e) {
            out.println("Exception transformation :" + e.getMessage());
            e.printStackTrace(out);
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
