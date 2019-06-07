package com.pkck.mlynarczyk.kuzniarek.elements;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

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
@ToString
public class BandMember {

    @XmlElement(name = "Name")
    private List<String> name;

    @XmlElement(name = "Surname")
    private String surname;

    @XmlElement(name = "StageName")
    private List<String> stageName;

    @XmlAttribute(name = "frontman")
    private Boolean isFrontman;
}
