package com.pkck.mlynarczyk.kuzniarek.view.controllers;

import javafx.scene.control.Button;
import javafx.stage.Stage;
import lombok.Setter;

public abstract class ModifyElementController extends ParentController {

    @Setter
    protected ParentController parentController;

    public Button commitButton;

    public Button cancelButton;

    public void closeWindow() {
        Stage stage = (Stage) cancelButton.getScene().getWindow();
        stage.close();
    }

    public void cancelChanges() {
        parentController.setReturnedGenre(null);
        parentController.setReturnedArtist(null);
        parentController.setReturnedAlbum(null);
        parentController.setReturnedBandMember(null);
        closeWindow();
    }

    public abstract void commitChanges();

    public abstract void refresh() throws CloneNotSupportedException;
}
