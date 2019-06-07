package com.pkck.mlynarczyk.kuzniarek.elements.adapters;

import javax.xml.bind.annotation.adapters.XmlAdapter;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class LocalTimeAdapter extends XmlAdapter<String, LocalTime> {

    @Override
    public LocalTime unmarshal(String s) {
        return LocalTime.parse(s);
    }

    @Override
    public String marshal(LocalTime localTime) {
        String pattern = "HH:mm:ss";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern);
        return formatter.format(localTime);
    }
}
