package com.pkck.mlynarczyk.kuzniarek.logic;

import com.sun.xml.bind.marshaller.NamespacePrefixMapper;
import org.xml.sax.SAXException;

import javax.xml.XMLConstants;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.bind.ValidationEvent;
import javax.xml.bind.ValidationEventHandler;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringWriter;

public class XMLConverter{

    public static <T>  T convertFromXml(String path, Class<T> tClass) throws JAXBException {
        File file = new File(path);
        JAXBContext context = JAXBContext.newInstance(tClass);
        Unmarshaller unmarshaller = context.createUnmarshaller();
        return (T) unmarshaller.unmarshal(file);
    }

    public static <T> void convertToXml(String path, T object, NamespacePrefixMapper namespacePreferential,
            String schemaPath, ValidationEventHandler eventHandler) throws JAXBException, SAXException, IOException {
        File file = new File(path);
        StringWriter output = new StringWriter ();
        JAXBContext context = JAXBContext.newInstance(object.getClass());
        Marshaller marshaller = context.createMarshaller();
        SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
        Schema schema = sf.newSchema(new File(schemaPath));
        marshaller.setSchema(schema);
        marshaller.setEventHandler(eventHandler);
        marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
        marshaller.setProperty("com.sun.xml.bind.namespacePrefixMapper", namespacePreferential);
        marshaller.marshal(object, output);


        FileWriter fileWriter = new FileWriter (file, false);
        fileWriter.write (output.toString());
        fileWriter.close();
    }
}
