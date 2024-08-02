/* $Header: dbjava/demo/samples/generic/ListRecoverableSQLExceptions.java /main/1 2013/06/28 12:03:53 ashivaru Exp $ */

/* Copyright (c) 2013, Oracle and/or its affiliates. All rights reserved.*/

/*
 DESCRIPTION
 List all the recoverable exceptions

 PRIVATE CLASSES
 NONE

 NOTES

 MODIFIED    (MM/DD/YY)
 ashivaru    06/21/13 - Creation
 */

/**
 *  @version $Header: dbjava/demo/samples/generic/ListRecoverableSQLExceptions.java /main/1 2013/06/28 12:03:53 ashivaru Exp $
 *  @author  ashivaru
 *  @since   12.1
 */
import java.io.IOException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.NamedNodeMap;
import org.xml.sax.SAXException;


public class ListRecoverableSQLExceptions {

  public static void main(String[] args) throws ParserConfigurationException, SAXException, IOException {
    DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();

    // Using factory get an instance of document builder
    DocumentBuilder db = dbf.newDocumentBuilder();

    String file = oracle.jdbc.driver.OracleDriver.class.getResource("")
        + "errorMap.xml";

    System.out.println("Parsing: " + file);
    // parse using builder to get DOM representation of the XML file
    Document dom = db.parse(file);
      
    // get the root elememt
    Element docEle = dom.getDocumentElement();

    // get a nodelist of error elements
    NodeList nl = docEle.getElementsByTagName("error");

    System.out.println("Listing SQLRecoverableException error numbers:");
    if (nl != null && nl.getLength() > 0) {
      for (int i = 0; i < nl.getLength(); i++) {
        if ("SQLRECOVERABLEEXCEPTION".equalsIgnoreCase(nl.item(i)
            .getAttributes().getNamedItem("sqlException") .getNodeValue())) {
          System.out.println(nl.item(i).getAttributes()
            .getNamedItem("oraErrorFrom").getNodeValue());
        }
        /*
        Node node = nl.item(i);
        NamedNodeMap attributes = node.getAttributes();
        Node errorNumber = attributes.getNamedItem("oraErrorFrom");
        Node exceptionType = attributes.getNamedItem("sqlException");
        if ("SQLRECOVERABLEEXCEPTION".equals(exceptionType.getNodeValue())){
          System.out.println(errorNumber.getNodeValue());
        }
        */
      }
    }// if(nl!=null...
  }// end of main

}// end of class

