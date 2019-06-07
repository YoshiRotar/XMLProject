package com.pkck.mlynarczyk.kuzniarek.logic;

import com.sun.xml.bind.marshaller.NamespacePrefixMapper;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import java.io.File;

public class XMLConverter{

    public static <T>  T convertFromXml(String path, Class<T> tClass) throws JAXBException {
        File file = new File(path);
        JAXBContext context = JAXBContext.newInstance(tClass);
        Unmarshaller unmarshaller = context.createUnmarshaller();
        return (T) unmarshaller.unmarshal(file);
    }

    public static <T> void convertToXml(String path, T object, NamespacePrefixMapper namespacePreferential) throws JAXBException {
        File file = new File(path);
        JAXBContext context = JAXBContext.newInstance(object.getClass());
        Marshaller marshaller = context.createMarshaller();
        marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
        marshaller.setProperty("com.sun.xml.bind.namespacePrefixMapper", namespacePreferential);
        marshaller.marshal(object, file);
    }
}
