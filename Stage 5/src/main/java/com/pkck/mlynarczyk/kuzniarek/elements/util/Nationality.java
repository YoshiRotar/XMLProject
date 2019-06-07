package com.pkck.mlynarczyk.kuzniarek.elements.util;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
public enum Nationality {
    POL("Poland"),
    SWE("Sweden"),
    USA("United States of America"),
    GBR("Great Brittan"),
    DEU("Germany");

    @Getter
    private String fullName;
}
