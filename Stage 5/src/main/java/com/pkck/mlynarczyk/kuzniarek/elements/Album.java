package com.pkck.mlynarczyk.kuzniarek.elements;

import com.pkck.mlynarczyk.kuzniarek.elements.adapters.LocalDateAdapter;
import com.pkck.mlynarczyk.kuzniarek.elements.adapters.LocalTimeAdapter;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlIDREF;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@XmlRootElement(name = "Album")
@XmlAccessorType(XmlAccessType.FIELD)
@Getter
@Setter
@NoArgsConstructor
public class Album implements Serializable {

    @XmlElement(name = "Title")
    private String title;

    @XmlAttribute(name = "idArtist")
    @XmlIDREF
    private Artist artist;

    @XmlElement(name = "NumberOfTracks")
    private Long numberOfTrucks;

    @XmlElement(name = "Length")
    @XmlJavaTypeAdapter(value = LocalTimeAdapter.class)
    private LocalTime length;

    @XmlElement(name = "ReleaseDate")
    @XmlJavaTypeAdapter(value = LocalDateAdapter.class)
    private LocalDate releaseDate;

    @XmlAttribute(name = "idGenre")
    @XmlIDREF
    private List<Genre> genres;
}
