package com.pkck.mlynarczyk.kuzniarek.view.controllers;

import com.pkck.mlynarczyk.kuzniarek.elements.Genre;
import com.pkck.mlynarczyk.kuzniarek.view.AlertHandler;
import javafx.scene.control.TextField;

public class ModifyGenreWindowController extends ModifyElementController {

    public TextField nameTextField;

    @Override
    public void commitChanges() {
        try {
            Genre genre;
            if (parentController.getReturnedGenre() == null) {
                genre = new Genre();
            } else {
                genre = parentController.getReturnedGenre();
            }
            genre.setName(nameTextField.getText());
            parentController.setReturnedGenre(genre);
            closeWindow();
        } catch (Exception e) {
            AlertHandler.alert("Błąd","", "Napotkano błąd, spróbuj jeszcze raz");
        }
    }

    @Override
    public void refresh() {
        if(parentController.getReturnedGenre() != null) {
            nameTextField.setText(parentController.getReturnedGenre().getName());
        }
    }
}
