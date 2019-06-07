package com.pkck.mlynarczyk.kuzniarek.elements.util;

import com.sun.xml.bind.marshaller.NamespacePrefixMapper;

public class CustomNamespacePrefixMapper extends NamespacePrefixMapper {

    private static final String MC_PREFIX = "mc";
    private static final String MC_URI = "urn:musicCollection";

    @Override
    public String getPreferredPrefix(String namespaceUri, String suggestion, boolean requirePrefix) {
        if(namespaceUri.equals(MC_URI)) {
            return  MC_PREFIX;
        }
        return suggestion;
    }
}
