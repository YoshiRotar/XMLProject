package com.pkck.mlynarczyk.kuzniarek.logic;

import net.sf.saxon.Transform;

import javax.xml.transform.TransformerException;

public class XSLTReportTransformer {

    public static void transform(String xmlPath, String xsltPath, String outputPath) throws TransformerException {

        String[] arglist = {"-o:" + outputPath, xmlPath, xsltPath};

        Transform.main(arglist);
    }
}
