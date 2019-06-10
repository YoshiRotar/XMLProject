package com.pkck.mlynarczyk.kuzniarek.view.controllers;

import com.pkck.mlynarczyk.kuzniarek.elements.Album;
import com.pkck.mlynarczyk.kuzniarek.elements.Artist;
import com.pkck.mlynarczyk.kuzniarek.elements.Genre;
import javafx.collections.FXCollections;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.ListView;
import javafx.scene.control.TextField;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class ModifyAlbumWindowController extends ModifyElementController {

    public TextField nameTextField;

    public TextField numberOfTracksTextField;

    public TextField lengthTextField;

    public TextField releaseDateTextField;

    public ComboBox<Artist> artistComboBox;

    public ListView<ComboBox<Genre>> genresListView;

    public Button addGenreButton;

    public Button deleteGenreButton;

    @Override
    public void commitChanges() {
        Album album;
        if (parentController.getReturnedAlbum() == null) {
            album = new Album();
        } else {
            album = parentController.getReturnedAlbum();
        }
        album.setTitle(nameTextField.getText());
        album.setArtist(artistComboBox.getValue());
        album.setNumberOfTrucks(Long.parseLong(numberOfTracksTextField.getText()));
        String lengthString = lengthTextField.getText();
        album.setLength(LocalTime.of(
                Integer.parseInt(lengthString.substring(0, 2)),
                Integer.parseInt(lengthString.substring(3, 5)),
                Integer.parseInt(lengthString.substring(6, 8))
        ));
        String releaseDateString = releaseDateTextField.getText();
        album.setReleaseDate(LocalDate.of(
                Integer.parseInt(releaseDateString.substring(0, 4)),
                Integer.parseInt(releaseDateString.substring(5, 7)),
                Integer.parseInt(releaseDateString.substring(8, 10))
        ));
        if (album.getGenres() != null) { album.getGenres().clear(); } else { album.setGenres(new ArrayList<>()); }
        for (ComboBox<Genre> comboBox : genresListView.getItems()) {
            album.getGenres().add(comboBox.getValue());
        }
        parentController.setReturnedAlbum(album);
        closeWindow();
    }

    @Override
    public void refresh() {
        artistComboBox.setItems(FXCollections.observableArrayList(parentController.project
                .getMusicCollection().getArtists()));
        if (parentController.getReturnedAlbum() != null) {
            nameTextField.setText(parentController.getReturnedAlbum().getTitle());
            numberOfTracksTextField.setText(parentController.getReturnedAlbum().getNumberOfTrucks().toString());
            lengthTextField.setText(parentController.getReturnedAlbum().getLength().toString());
            releaseDateTextField.setText(parentController.getReturnedAlbum().getReleaseDate().toString());
            artistComboBox.setValue(parentController.returnedAlbum.getArtist());
            for (Genre genre : parentController.returnedAlbum.getGenres()) {
                ComboBox<Genre> genreComboBox = new ComboBox<>();
                genreComboBox.setItems(FXCollections.observableArrayList(parentController.project.getMusicCollection()
                        .getGenres()));
                genreComboBox.setValue(genre);
                genresListView.getItems().add(genreComboBox);
            }
        }
    }

    public void addGenre() {
        ComboBox<Genre> genreComboBox = new ComboBox<>();
        genreComboBox.setItems(FXCollections.observableArrayList(parentController.project.getMusicCollection()
                .getGenres()));
        genresListView.getItems().add(genreComboBox);
        genresListView.refresh();
    }

    public void deleteGenre() {
        ComboBox<Genre> genreComboBox = genresListView.getSelectionModel().getSelectedItem();
        genresListView.getItems().remove(genreComboBox);
        genresListView.refresh();
    }
}
