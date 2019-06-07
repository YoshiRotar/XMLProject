package com.pkck.mlynarczyk.kuzniarek.view;

import com.pkck.mlynarczyk.kuzniarek.logic.XMLConverter;
import com.pkck.mlynarczyk.kuzniarek.elements.Project;
import com.pkck.mlynarczyk.kuzniarek.elements.util.CustomNamespacePrefixMapper;

import javax.xml.bind.JAXBException;

public class MainWindow {

    public static void main(String[] args) {
        try {
            Project project = XMLConverter.convertFromXml("src/main/resources/xmlCore.xml", Project.class);
            XMLConverter.convertToXml("src/main/resources/generated.xml", project, new CustomNamespacePrefixMapper());
        } catch (JAXBException e) {
            System.out.println("Error occurred during casting.");
            e.printStackTrace();
            System.exit(1);
        }
    }
}
