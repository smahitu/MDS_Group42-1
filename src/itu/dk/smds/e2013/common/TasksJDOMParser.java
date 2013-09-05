/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package itu.dk.smds.e2013.common;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.filter.ElementFilter;
import org.jdom2.input.SAXBuilder;
import org.jdom2.xpath.XPathExpression;
import org.jdom2.xpath.XPathFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author rao
 */
public class TasksJDOMParser {

    public static Document getTasksByQuery(InputStream stream, String query) throws JDOMException, IOException {
        SAXBuilder builder = new SAXBuilder();

        //String query = "//task[contains(attendant/@ids,'" + userId + "')]";

        Document doc;
        try {
            doc = builder.build(stream);
        } catch (IOException ex) {
            Logger.getLogger(TasksJDOMParser.class.getName()).log(Level.SEVERE, null, ex);
            throw ex;
        }

        XPathFactory xpfac = XPathFactory.instance();
        XPathExpression<Element> xp = xpfac.compile(query, new ElementFilter());

        List<Element> tasks = xp.evaluate(doc);
        Document xmlDoc = new Document();
        Element root = new Element("tasks");

        for (Element task : tasks) {
            root.addContent(task.clone());
        }
        xmlDoc.addContent(root);

        return xmlDoc;
    }

    public static List<String> getTaskIds(InputStream inputStream) throws JDOMException, IOException {
        SAXBuilder builder = new SAXBuilder();

        Document doc;
        try {
            doc = builder.build(inputStream);
        } catch (IOException ex) {
            Logger.getLogger(TasksJDOMParser.class.getName()).log(Level.SEVERE, null, ex);
            throw ex;
        }

        XPathFactory xpfac = XPathFactory.instance();
        XPathExpression<Element> xp = xpfac.compile("//task", new ElementFilter());

        List<Element> tasks = xp.evaluate(doc);

        List<String> ids = new ArrayList<>();
        for (Element task : tasks) {
            String id = task.getAttribute("id").getValue();
            ids.add(id);
        }

        return ids;
    }
    
    public static List<String> getUsers(InputStream inputStream) throws JDOMException, IOException {
        SAXBuilder builder = new SAXBuilder();

        Document doc;
        try {
            doc = builder.build(inputStream);
        } catch (IOException ex) {
            Logger.getLogger(TasksJDOMParser.class.getName()).log(Level.SEVERE, null, ex);
            throw ex;
        }

        XPathFactory xpfac = XPathFactory.instance();
        XPathExpression<Element> xp = xpfac.compile("//attendants", new ElementFilter());

        List<Element> users = xp.evaluate(doc);

        List<String> attendants = new ArrayList<>();
        for (Element user : users) {
            String attendant = user.getText();
            attendants.add(attendant);
        }

        return attendants;
    }

}