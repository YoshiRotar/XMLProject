package com.pkck.mlynarczyk.kuzniarek.elements;

import com.pkck.mlynarczyk.kuzniarek.elements.util.Nationality;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlID;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

@XmlRootElement(name = "Artist")
@XmlAccessorType(XmlAccessType.FIELD)
@Getter
@Setter
@NoArgsConstructor
@ToString
public class Artist {

    @XmlAttribute(name = "idArtist")
    @XmlID
    private String id;

    @XmlElement(name = "BandName")
    private String name;

    @XmlAttribute(name = "nationality")
    private Nationality nationality;

    @XmlElement(name = "Member")
    private List<BandMember> members;
}
