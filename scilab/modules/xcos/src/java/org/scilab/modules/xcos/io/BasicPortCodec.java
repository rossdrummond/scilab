/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2009 - DIGITEO - Allan Simon
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */


package org.scilab.modules.xcos.io;

import java.util.Map;

import org.scilab.modules.xcos.port.BasicPort;
import org.w3c.dom.Element;
import org.w3c.dom.Node;

import com.mxgraph.io.mxCodec;

public class BasicPortCodec extends XcosObjectCodec {

    private static final String DATA_TYPE = "dataType";

    public BasicPortCodec(Object template) {
	super(template);
    }

    public BasicPortCodec(Object template, String[] exclude, String[] idrefs, Map mapping)
    {
	super(template, exclude, idrefs, mapping);

    }

    public Object beforeEncode(mxCodec enc, Object obj, Node node) {
	((Element) node).setAttribute(DATA_TYPE,
		String.valueOf(((BasicPort) obj).getDataType()));
	return super.beforeEncode(enc, obj, node);
    }

    public Object afterDecode(mxCodec dec, Node node, Object obj) {
	String attr = ((Element) node).getAttribute(DATA_TYPE);

	if(attr == null || attr.equals("")) {
	    ((BasicPort) obj).setDataType(BasicPort.DataType.REAL_MATRIX);

	} else {
	    ((BasicPort) obj).setDataType(BasicPort.DataType.valueOf(attr));
	}
	return super.afterDecode(dec, node, obj);
    }

}