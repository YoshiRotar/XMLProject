package com.pkck.mlynarczyk.kuzniarek.elements;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

@XmlRootElement(name = "Member")
@XmlAccessorType(XmlAccessType.FIELD)
@Getter
@Setter
@NoArgsConstructor
public class BandMember {

    @XmlElement(name = "Name")
    private List<String> names;

    @XmlElement(name = "Surname")
    private String surname;

    @XmlElement(name = "StageName")
    private List<String> stageNames;

    @XmlAttribute(name = "frontman")
    private Boolean isFrontman;

    @Override
    public String toString() {
        StringBuilder result = new StringBuilder();
        if (names != null) {
            for (String name : names) {
                result.append(name).append(" ");
            }
        }
        if(stageNames != null) {
            for (String stageName : stageNames) {
                result.append("\"").append(stageName).append("\" ");
            }
        }
        if(surname != null) {
            result.append(surname);
        }
        return result.toString();
    }
}
