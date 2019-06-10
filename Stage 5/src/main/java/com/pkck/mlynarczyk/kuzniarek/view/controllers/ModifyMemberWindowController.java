package com.pkck.mlynarczyk.kuzniarek.view.controllers;

import com.pkck.mlynarczyk.kuzniarek.elements.BandMember;
import javafx.scene.control.CheckBox;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;

import java.util.Arrays;
import java.util.List;

public class ModifyMemberWindowController extends ModifyElementController {

    public TextField surnameTextBox;

    public TextArea namesTextArea;

    public TextArea bandNamesTextArea;

    public CheckBox isFrontmanCheckBox;

    @Override
    public void commitChanges() {
        BandMember bandMember;
        if (parentController.getReturnedBandMember() == null) {
            bandMember = new BandMember();
        } else {
            bandMember = parentController.getReturnedBandMember();
        }
        bandMember.setSurname(surnameTextBox.getText());
        String names = namesTextArea.getText();
        List<String> namesAsList = Arrays.asList(names.split("\\r?\\n"));
        bandMember.setNames(namesAsList);
        String bandNames = bandNamesTextArea.getText();
        List<String> bandNamesAsList = Arrays.asList(bandNames.split("\\r?\\n"));
        bandMember.setStageNames(bandNamesAsList);
        if (isFrontmanCheckBox.isSelected()) {
            bandMember.setIsFrontman(true);
        }
        parentController.setReturnedBandMember(bandMember);
        closeWindow();
    }

    @Override
    public void refresh() {
        if (parentController.getReturnedBandMember() != null) {
            surnameTextBox.setText(parentController.getReturnedBandMember().getSurname());
            if(parentController.getReturnedBandMember().getNames() != null) {
                StringBuilder names = new StringBuilder();
                for (String name : parentController.getReturnedBandMember().getNames()) {
                    names.append(name).append("\n");
                }
                namesTextArea.setText(names.toString());
            }
            if(parentController.getReturnedBandMember().getStageNames() != null) {
                StringBuilder bandNames = new StringBuilder();
                for (String name : parentController.getReturnedBandMember().getStageNames()) {
                    bandNames.append(name).append("\n");
                }
                bandNamesTextArea.setText(bandNames.toString());
            }
            if (parentController.getReturnedBandMember().getIsFrontman() != null) {
                isFrontmanCheckBox.setSelected(parentController.getReturnedBandMember().getIsFrontman());
            }
        }
    }
}
