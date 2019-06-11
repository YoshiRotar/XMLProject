package com.pkck.mlynarczyk.kuzniarek.view;

import javafx.scene.control.Alert;

import javax.xml.bind.ValidationEvent;
import javax.xml.bind.ValidationEventHandler;

public class AlertHandler implements ValidationEventHandler {

    public static void alert(String title, String header, String message) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle(title);
        alert.setHeaderText(header);
        alert.setContentText(message);

        alert.showAndWait();
    }

    @Override
    public boolean handleEvent(ValidationEvent event) {
        System.out.println("\nEVENT");
        System.out.println("SEVERITY:  " + event.getSeverity());
        System.out.println("MESSAGE:  " + event.getMessage());
        System.out.println("LINKED EXCEPTION:  " + event.getLinkedException());
        System.out.println("LOCATOR");
        System.out.println("    LINE NUMBER:  " + event.getLocator().getLineNumber());
        System.out.println("    COLUMN NUMBER:  " + event.getLocator().getColumnNumber());
        System.out.println("    OFFSET:  " + event.getLocator().getOffset());
        System.out.println("    OBJECT:  " + event.getLocator().getObject());
        System.out.println("    NODE:  " + event.getLocator().getNode());
        System.out.println("    URL:  " + event.getLocator().getURL());
        alert("Błąd schemy", event.getMessage(), event.getLocator()
                        + " Linia: " + event.getLocator().getLineNumber()
                        + " Kolumna: " + event.getLocator().getColumnNumber());
        return false;
    }
}
