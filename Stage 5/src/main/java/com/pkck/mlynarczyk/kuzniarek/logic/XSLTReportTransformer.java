package com.pkck.mlynarczyk.kuzniarek.logic;

import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;

public class XSLTReportTransformer {

    public static void transform(String xmlPath, String xsltPath, String outputPath) throws TransformerException {
        TransformerFactory factory = TransformerFactory.newInstance();
        Source xslt = new StreamSource(new File(xsltPath));
        Transformer transformer = factory.newTransformer(xslt);
        Source xml = new StreamSource(xmlPath);
        transformer.transform(xml, new StreamResult(new File(outputPath)));
    }
}
