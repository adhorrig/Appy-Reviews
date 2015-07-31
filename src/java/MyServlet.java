import java.io.File;
import javax.xml.transform.dom.DOMSource;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
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

public class MyServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String path = getServletContext().getRealPath("/");
        String XSLFileName = path + "/Review.xsl";
        File XslFile = new File(XSLFileName);

        String URI = "xmldb:exist://localhost:8444/exist/xmlrpc";
        String driver = "org.exist.xmldb.DatabaseImpl";

        XMLResource res = null;
        Node resNode = null;
        Document doc = null;
        
        try {
            Class cl = Class.forName(driver);
            Database database = (Database) cl.newInstance();
            DatabaseManager.registerDatabase(database);

            // get the collection
            Collection col = DatabaseManager.getCollection(URI + "/db/Project", "admin", "password");
           
            col.setProperty(OutputKeys.INDENT, "no");
            res = (XMLResource)col.getResource("Review.xml");

            resNode = res.getContentAsDOM();

            doc = (Document) resNode;
        }catch (Exception e) {
            System.err.println("Error Document: "+e.getMessage());
        }

        DOMSource origDocSource = new DOMSource(doc);



        try {
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            StreamSource stylesheet = new StreamSource(XslFile);

            Transformer transformer = transformerFactory.newTransformer(stylesheet);
            transformer.transform(origDocSource, new StreamResult(out));


        } catch (Exception e) {
            System.err.println("Encountered Exception" + e.getMessage());
            e.printStackTrace(out);
        } finally {
            out.close();
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
