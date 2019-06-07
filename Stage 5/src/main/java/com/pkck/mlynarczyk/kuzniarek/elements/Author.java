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

@XmlRootElement(name = "Author")
@XmlAccessorType(XmlAccessType.FIELD)
@Getter
@Setter
@NoArgsConstructor
@ToString
public class Author {

    @XmlElement(name = "Name")
    private String name;

    @XmlElement(name = "Surname")
    private String surname;

    @XmlAttribute(name = "index")
    private Long index;
}
