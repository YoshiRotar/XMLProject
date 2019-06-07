package com.pkck.mlynarczyk.kuzniarek.elements;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

@XmlRootElement(name = "Collection")
@XmlAccessorType(XmlAccessType.FIELD)
@Getter
@Setter
@NoArgsConstructor
@ToString
public class MusicCollection {

    @XmlElementWrapper(name = "Albums")
    @XmlElement(name = "Album")
    List<Album> albums;

    @XmlElementWrapper(name = "Artists")
    @XmlElement(name = "Artist")
    List<Artist> artists;

    @XmlElementWrapper(name = "Genres")
    @XmlElement(name = "Genre")
    List<Genre> genres;
}
