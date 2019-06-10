package com.pkck.mlynarczyk.kuzniarek.view.controllers;

import com.pkck.mlynarczyk.kuzniarek.elements.Album;
import com.pkck.mlynarczyk.kuzniarek.elements.Artist;
import com.pkck.mlynarczyk.kuzniarek.elements.BandMember;
import com.pkck.mlynarczyk.kuzniarek.elements.Genre;
import lombok.Getter;
import lombok.Setter;

public abstract class ParentController {

    @Setter
    @Getter
    protected Genre returnedGenre;

    @Setter
    @Getter
    protected Artist returnedArtist;

    @Setter
    @Getter
    protected Album returnedAlbum;

    @Setter
    @Getter
    protected BandMember returnedBandMember;
}
