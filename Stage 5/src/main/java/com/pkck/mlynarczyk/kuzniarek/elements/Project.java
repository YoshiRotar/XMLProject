package com.pkck.mlynarczyk.kuzniarek.elements;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "Project", namespace = "urn:musicCollection")
@XmlAccessorType(XmlAccessType.FIELD)
@Getter
@Setter
@NoArgsConstructor
@ToString
public class Project {

    @XmlElement(name = "Head")
    private Header header;

    @XmlElement(name = "Collection")
    private MusicCollection musicCollection;
}
