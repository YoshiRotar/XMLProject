package com.pkck.mlynarczyk.kuzniarek.view;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class MainWindow extends Application {

    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage stage) throws Exception {
        String fxmlPath = "/fxml/mainWindow.fxml";
        FXMLLoader loader = new FXMLLoader();
        Parent rootNode = loader.load(getClass().getResourceAsStream(fxmlPath));

        Scene scene = new Scene(rootNode);
        stage.setTitle("XML Project");
        stage.setScene(scene);
        stage.show();
    }
}
