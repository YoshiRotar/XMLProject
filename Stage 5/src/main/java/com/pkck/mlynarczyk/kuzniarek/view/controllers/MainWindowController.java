package com.pkck.mlynarczyk.kuzniarek.view.controllers;

import com.pkck.mlynarczyk.kuzniarek.elements.Album;
import com.pkck.mlynarczyk.kuzniarek.elements.Artist;
import com.pkck.mlynarczyk.kuzniarek.elements.BandMember;
import com.pkck.mlynarczyk.kuzniarek.elements.Genre;
import com.pkck.mlynarczyk.kuzniarek.elements.Project;
import com.pkck.mlynarczyk.kuzniarek.elements.util.Nationality;
import com.pkck.mlynarczyk.kuzniarek.logic.XMLConverter;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableCell;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.FileChooser;

import javax.xml.bind.JAXBException;
import java.io.File;
import java.net.URL;
import java.util.List;
import java.util.ResourceBundle;
import java.util.stream.Collectors;

public class MainWindowController implements Initializable {

    private String pathToXmlFile;

    private Project project;

    public Button fileFinderButton;

    public Label pathToFileLabel;

    public TableView<Genre> genresTable;

    public TableColumn columnGenreName;

    public TableView<Artist> artistsTable;

    public TableColumn columnArtistName;

    public TableColumn columnArtistNationality;

    public TableColumn columnArtistMembers;

    public TableView<Album> albumsTable;

    public TableColumn columnAlbumTitle;

    public TableColumn columnAlbumArtist;

    public TableColumn columnAlbumNumberOfTrucks;

    public TableColumn columnAlbumLength;

    public TableColumn columnAlbumReleaseDate;

    public TableColumn columnAlbumGenres;

    private ObservableList<Genre> genreObservableList;

    private ObservableList<Artist> artistObservableList;

    private ObservableList<Album> albumObservableList;

    public void loadXmlFile() throws JAXBException {
        FileChooser fileChooser = new FileChooser();
        fileChooser.setInitialDirectory(new File("src/main/resources/"));
        fileChooser.getExtensionFilters()
                .add(new FileChooser.ExtensionFilter("XML File", "*.xml"));
        File file = fileChooser.showOpenDialog(null);
        if (file != null) {
            pathToXmlFile = "src/main/resources/xmlCore.xml"; //file.getAbsolutePath();
            pathToFileLabel.setText(pathToXmlFile);
            project = XMLConverter.convertFromXml(pathToXmlFile, Project.class);
            try {
                genreObservableList = FXCollections.observableArrayList(project.getMusicCollection().getGenres());
                genresTable.setItems(genreObservableList);
                albumObservableList = FXCollections.observableArrayList(project.getMusicCollection().getAlbums());
                albumsTable.setItems(albumObservableList);
                artistObservableList = FXCollections.observableArrayList(project.getMusicCollection().getArtists());
                artistsTable.setItems(artistObservableList);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }




    @Override
    public void initialize(URL location, ResourceBundle resources) {
        columnGenreName.setCellValueFactory(new PropertyValueFactory<>("name"));
        columnAlbumTitle.setCellValueFactory(new PropertyValueFactory<>("title"));
        columnAlbumArtist.setCellValueFactory(new PropertyValueFactory<>("artist"));
        columnAlbumNumberOfTrucks.setCellValueFactory(new PropertyValueFactory<>("numberOfTrucks"));
        columnAlbumLength.setCellValueFactory(new PropertyValueFactory<>("length"));
        columnAlbumReleaseDate.setCellValueFactory(new PropertyValueFactory<>("releaseDate"));
        columnAlbumGenres.setCellValueFactory(new PropertyValueFactory<>("genres"));
        columnAlbumGenres.setCellFactory(col -> new TableCell<Album, List<Genre>>() {
            @Override
            public void updateItem(List<Genre> genres, boolean empty) {
                super.updateItem(genres, empty);
                if (empty) {
                    setText(null);
                } else {
                    setText(genres.stream().map(Genre::getName)
                            .collect(Collectors.joining(", ")));
                }
            }
        });
        columnArtistName.setCellValueFactory(new PropertyValueFactory<>("name"));
        columnArtistNationality.setCellValueFactory(new PropertyValueFactory<>("nationality"));
        columnArtistNationality.setCellFactory(col -> new TableCell<Artist, Nationality>() {
            @Override
            public void updateItem(Nationality nationality, boolean empty) {
                super.updateItem(nationality, empty);
                if (empty) {
                    setText(null);
                } else {
                    setText(nationality.getFullName());
                }
            }
        });
        columnArtistMembers.setCellValueFactory(new PropertyValueFactory<>("members"));
        columnArtistMembers.setCellFactory(col -> new TableCell<Artist, List<BandMember>>() {
            @Override
            public void updateItem(List<BandMember> members, boolean empty) {
                super.updateItem(members, empty);
                if (empty) {
                    setText(null);
                } else {
                    setText(members.stream().map(BandMember::toString)
                            .collect(Collectors.joining(", ")));
                }
            }
        });
    }
}
