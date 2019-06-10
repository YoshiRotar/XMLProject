package com.pkck.mlynarczyk.kuzniarek.view.controllers;

import com.pkck.mlynarczyk.kuzniarek.elements.Album;
import com.pkck.mlynarczyk.kuzniarek.elements.Artist;
import com.pkck.mlynarczyk.kuzniarek.elements.BandMember;
import com.pkck.mlynarczyk.kuzniarek.elements.Genre;
import com.pkck.mlynarczyk.kuzniarek.elements.Project;
import com.pkck.mlynarczyk.kuzniarek.elements.util.CustomNamespacePrefixMapper;
import com.pkck.mlynarczyk.kuzniarek.elements.util.Nationality;
import com.pkck.mlynarczyk.kuzniarek.logic.XMLConverter;
import com.pkck.mlynarczyk.kuzniarek.view.ModifyElementWindow;
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
import java.io.IOException;
import java.net.URL;
import java.util.List;
import java.util.ResourceBundle;
import java.util.stream.Collectors;

public class MainWindowController extends ParentController implements Initializable {

    private String pathToXmlFile;

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

    public Button addArtistButton;

    public Button EditArtistButton;

    public Button deleteArtistButton;

    public Button addAlbumButton;

    public Button editAlbumButton;

    public Button deleteAlbumButton;

    public Button addGenreButton;

    public Button editGenreButton;
    
    public Button deleteGenreButton;

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

    public void addArtist() throws IOException, JAXBException {
        if(project != null) {
            ModifyElementWindow window = new ModifyElementWindow("Dodaj artystę",
                    ModifyElementWindow.ARTIST_WINDOW_TYPE, this);
            if (returnedArtist != null) {
                Long newId = project.getMusicCollection().getArtists().stream()
                        .map((a) -> Long.parseLong(a.getId().substring(1)))
                        .max(Long::compare)
                        .orElse(1L);
                newId++;
                returnedArtist.setId("A"+newId);
                project.getMusicCollection().getArtists().add(returnedArtist);
                returnedArtist = null;
            }
            persist();
            artistsTable.refresh();
        }
    }

    public void editArtist() throws Exception {
        if(project != null && !artistsTable.getSelectionModel().isEmpty()) {
            returnedArtist = artistsTable.getSelectionModel().getSelectedItem();
            ModifyElementWindow window = new ModifyElementWindow("Edytuj artystę",
                    ModifyElementWindow.ARTIST_WINDOW_TYPE, this);
            if(returnedArtist != null) {
                String id = returnedArtist.getId();
                Artist artistToEdit = project.getMusicCollection().getArtists().stream()
                        .filter((a) -> a.getId().equals(id))
                        .findFirst()
                        .orElseThrow(Exception::new);
                artistToEdit = returnedArtist;
                returnedArtist = null;
            }
            persist();
            artistsTable.refresh();
        }
    }

    public void deleteArtist() throws JAXBException {
        if(project != null) {
            Artist artist = artistsTable.getSelectionModel().getSelectedItem();
            project.getMusicCollection().getArtists().remove(artist);
            persist();
            artistsTable.refresh();
        }
    }

    public void addAlbum() throws IOException, JAXBException {
        if(project != null) {
            ModifyElementWindow window = new ModifyElementWindow("Dodaj Album",
                    ModifyElementWindow.ALBUM_WINDOW_TYPE, this);
            if(returnedAlbum != null) {
                project.getMusicCollection().getAlbums().add(returnedAlbum);
                returnedAlbum = null;
            }
            persist();
            albumsTable.refresh();
        }
    }

    public void editAlbum() throws IOException, JAXBException {
        if(project != null && !albumsTable.getSelectionModel().isEmpty()) {
            int index = albumsTable.getSelectionModel().getSelectedIndex();
            returnedAlbum = albumsTable.getSelectionModel().getSelectedItem();
            ModifyElementWindow window = new ModifyElementWindow("Edytuj Album",
                    ModifyElementWindow.ALBUM_WINDOW_TYPE, this);
            if (returnedAlbum != null) {
                project.getMusicCollection().getAlbums().set(index, returnedAlbum);
                returnedAlbum = null;
            }
            persist();
            albumsTable.refresh();
        }
    }

    public void deleteAlbum() throws JAXBException {
        if(project != null) {
            Album album = albumsTable.getSelectionModel().getSelectedItem();
            project.getMusicCollection().getAlbums().remove(album);
            persist();
            albumsTable.refresh();
        }
    }

    public void addGenre() throws IOException, JAXBException {
        if(project != null) {
            ModifyElementWindow window = new ModifyElementWindow("Dodaj Gatunek",
                    ModifyElementWindow.GENRE_WINDOW_TYPE, this);
            if (returnedGenre != null) {
                Long newId = project.getMusicCollection().getGenres().stream()
                        .map((g) -> Long.parseLong(g.getId().substring(1)))
                        .max(Long::compare)
                        .orElse(1L);
                newId++;
                returnedGenre.setId("G"+newId);
                project.getMusicCollection().getGenres().add(returnedGenre);
                returnedGenre = null;
            }
            persist();
            genresTable.refresh();
        }
    }

    public void editGenre() throws Exception {
        if(project != null && !genresTable.getSelectionModel().isEmpty()) {
            returnedGenre = genresTable.getSelectionModel().getSelectedItem();
            ModifyElementWindow window = new ModifyElementWindow("Edytuj Gatunek",
                    ModifyElementWindow.GENRE_WINDOW_TYPE, this);
            if(returnedGenre != null) {
                String id = returnedGenre.getId();
                Genre genreToEdit = project.getMusicCollection().getGenres().stream()
                        .filter((g) -> g.getId() == id)
                        .findFirst()
                        .orElseThrow(Exception::new);
                genreToEdit = returnedGenre;
                returnedGenre = null;
            }
            persist();
            genresTable.refresh();
        }
    }

    public void deleteGenre() throws JAXBException {
        if(project != null) {
            Genre genre = genresTable.getSelectionModel().getSelectedItem();
            project.getMusicCollection().getGenres().remove(genre);
            persist();
            genresTable.refresh();
        }
    }

    public void loadXmlFile() throws JAXBException {
        FileChooser fileChooser = new FileChooser();
        fileChooser.setInitialDirectory(new File("src/main/resources/"));
        fileChooser.getExtensionFilters()
                .add(new FileChooser.ExtensionFilter("XML File", "*.xml"));
        File file = fileChooser.showOpenDialog(null);
        if (file != null) {
            pathToXmlFile = "src/main/resources/xmlCore.xml"; //file.getAbsolutePath();
            pathToFileLabel.setText(pathToXmlFile);
            loadFromPath();
        }
    }

    private void persist() throws JAXBException {
        XMLConverter.convertToXml(pathToXmlFile, project, new CustomNamespacePrefixMapper());
        loadFromPath();
    }

    private void loadFromPath() throws JAXBException {
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
