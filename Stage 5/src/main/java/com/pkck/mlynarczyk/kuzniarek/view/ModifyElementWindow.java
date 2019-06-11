package com.pkck.mlynarczyk.kuzniarek.view;

import com.pkck.mlynarczyk.kuzniarek.view.controllers.ModifyElementController;
import com.pkck.mlynarczyk.kuzniarek.view.controllers.ParentController;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

public class ModifyElementWindow {

    public static final String GENRE_WINDOW_TYPE = "/fxml/modifyGenreWindow.fxml";
    public static final String ARTIST_WINDOW_TYPE = "/fxml/modifyArtistWindow.fxml";
    public static final String ALBUM_WINDOW_TYPE = "/fxml/modifyAlbumWindow.fxml";
    public static final String MEMBER_WINDOW_TYPE = "/fxml/modifyMemberWindow.fxml";

    public ModifyElementWindow(String title, String windowType, ParentController parentController)
            throws IOException, CloneNotSupportedException {
        Stage stage = new Stage();
        FXMLLoader loader = new FXMLLoader();
        Parent parent = loader.load(getClass().getResourceAsStream(windowType));
        ModifyElementController controller = loader.getController();
        controller.setParentController(parentController);
        controller.refresh();
        Scene scene = new Scene(parent);
        stage.setTitle(title);
        stage.setScene(scene);
        stage.showAndWait();
    }
}
