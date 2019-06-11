package com.pkck.mlynarczyk.kuzniarek.view.controllers;

import com.pkck.mlynarczyk.kuzniarek.elements.Artist;
import com.pkck.mlynarczyk.kuzniarek.elements.BandMember;
import com.pkck.mlynarczyk.kuzniarek.elements.util.Nationality;
import com.pkck.mlynarczyk.kuzniarek.view.AlertHandler;
import com.pkck.mlynarczyk.kuzniarek.view.ModifyElementWindow;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TableCell;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.ComboBoxTableCell;
import javafx.scene.control.cell.PropertyValueFactory;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;
import java.util.stream.Collectors;

@SuppressWarnings("Duplicates")
public class ModifyArtistWindowController extends ModifyElementController implements Initializable {

    private Artist artist;

    private List<BandMember> snapshot;

    public TextField bandNameTextField;

    public ComboBox<Nationality> nationalityComboBox;

    public TableView<BandMember> membersTable;

    public TableColumn columnMemberNames;

    public TableColumn columnMemberSurname;

    public TableColumn columnMemberFrontman;

    public TableColumn columnMemberStageNames;

    public ObservableList<BandMember> memberObservableList;

    public Button addMemberButton;

    public Button editMemberButton;

    public Button deleteMemberButton;

    @Override
    public void commitChanges() {
        try {
            artist.setName(bandNameTextField.getText());
            artist.setNationality(nationalityComboBox.getValue());
            parentController.setReturnedArtist(artist);
            closeWindow();
        } catch (Exception e) {
            AlertHandler.alert("Błąd","", "Napotkano błąd, spróbuj jeszcze raz");
        }
    }

    @Override
    public void refresh() throws CloneNotSupportedException {
        if (parentController.getReturnedArtist() != null) {
            artist = parentController.getReturnedArtist();
            bandNameTextField.setText(parentController.getReturnedArtist().getName());
            nationalityComboBox.setValue(parentController.getReturnedArtist().getNationality());
            memberObservableList = FXCollections.observableArrayList(parentController.getReturnedArtist().getMembers());
            membersTable.setItems(memberObservableList);
            snapshot = new ArrayList<>();
            for ( BandMember member : artist.getMembers() ) {
                snapshot.add((BandMember) member.clone());
            }
        } else {
           artist = new Artist();
           artist.setMembers(new ArrayList<>());
        }
    }

    @Override
    public void cancelChanges() {
        artist.setMembers(snapshot);
        parentController.returnedArtist.setMembers(snapshot);
        super.cancelChanges();
    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        nationalityComboBox.setItems(FXCollections.observableArrayList(Nationality.values()));
        columnMemberNames.setCellValueFactory(new PropertyValueFactory<>("names"));
        columnMemberNames.setCellFactory((col) -> new TableCell<BandMember, List<String>>() {
            @Override
            public void updateItem(List<String> names, boolean empty) {
                super.updateItem(names, empty);
                if (empty || names == null) {
                    setText(null);
                } else {
                    setText(names.stream().collect(Collectors.joining(", ")));
                }
            }
        });
        columnMemberSurname.setCellValueFactory(new PropertyValueFactory<>("surname"));
        columnMemberFrontman.setCellValueFactory(new PropertyValueFactory<>("isFrontman"));
        columnMemberFrontman.setCellFactory((col) -> new ComboBoxTableCell<BandMember, Boolean>() {
            @Override
            public void updateItem(Boolean item, boolean empty) {
                super.updateItem(item, empty);
                if (empty) {
                    setText(null);
                } else if (item == null) {
                    setText("NIE");
                } else {
                    if (item) {setText("TAK");} else {setText("NIE");}
                }
            }
        });
        columnMemberStageNames.setCellValueFactory(new PropertyValueFactory<>("stageNames"));
        columnMemberStageNames.setCellFactory((col) -> new TableCell<BandMember, List<String>>() {
            @Override
            public void updateItem(List<String> names, boolean empty) {
                super.updateItem(names, empty);
                if (empty || names == null) {
                    setText(null);
                } else {
                    setText(names.stream().collect(Collectors.joining(", ")));
                }
            }
        });
    }

    public void addMember() throws IOException, CloneNotSupportedException {
        ModifyElementWindow window = new ModifyElementWindow("Dodaj Członka",
                ModifyElementWindow.MEMBER_WINDOW_TYPE, this);
        if(returnedBandMember != null) {
            artist.getMembers().add(returnedBandMember);
            returnedBandMember = null;
            memberObservableList = FXCollections.observableArrayList(artist.getMembers());
            membersTable.setItems(memberObservableList);
        }
    }

    public void editMember() throws IOException, CloneNotSupportedException {
        if (!membersTable.getSelectionModel().isEmpty()) {
            int index = membersTable.getSelectionModel().getSelectedIndex();
            returnedBandMember = membersTable.getSelectionModel().getSelectedItem();
            ModifyElementWindow window = new ModifyElementWindow("Edytuj Członka",
                    ModifyElementWindow.MEMBER_WINDOW_TYPE, this);
            if(returnedBandMember != null) {
                artist.getMembers().set(index, returnedBandMember);
                returnedBandMember = null;
                memberObservableList = FXCollections.observableArrayList(artist.getMembers());
                membersTable.setItems(memberObservableList);
                membersTable.refresh();
            }
        }
    }

    public void deleteMember() {
        BandMember bandMember = membersTable.getSelectionModel().getSelectedItem();
        artist.getMembers().remove(bandMember);
        memberObservableList = FXCollections.observableArrayList(artist.getMembers());
        membersTable.setItems(memberObservableList);
    }
}
