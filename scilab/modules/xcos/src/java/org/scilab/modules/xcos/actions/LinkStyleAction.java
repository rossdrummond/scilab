/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2009 - DIGITEO - Bruno JOFRET
 * 
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at    
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

package org.scilab.modules.xcos.actions;

import java.util.ArrayList;
import java.util.List;

import org.scilab.modules.graph.ScilabGraph;
import org.scilab.modules.graph.actions.DefaultAction;
import org.scilab.modules.gui.menuitem.MenuItem;
import org.scilab.modules.xcos.XcosDiagram;
import org.scilab.modules.xcos.link.BasicLink;

import com.mxgraph.util.mxConstants;

public class LinkStyleAction extends DefaultAction {

    private String value = null;
    
    private LinkStyleAction(ScilabGraph scilabGraph, String title, String value) {
	super(title, scilabGraph);
	this.value = value;
    }

    public static MenuItem createMenu(ScilabGraph scilabGraph, String title, String value) {
	return createMenu(title, null, new LinkStyleAction(scilabGraph, title, value), null);
    }

    public void doAction() {
	XcosDiagram graph = (XcosDiagram) getGraph(null);
	List<Object> links = new ArrayList<Object>();
	Object[] selectedCells = graph.getSelectionCells();
	
	for (int i = 0 ; i < selectedCells.length ; ++i) {
	    if(selectedCells[i] instanceof BasicLink) {
		links.add(selectedCells[i]);
	    }
	}
	
	//if no cells are selected : Do nothing
	if (links.size() == 0) { return; }

	if (value.compareToIgnoreCase(mxConstants.ELBOW_VERTICAL) == 0) {
	    graph.setCellStyles(mxConstants.STYLE_EDGE, mxConstants.EDGESTYLE_ELBOW, links.toArray());
	    graph.setCellStyles(mxConstants.STYLE_ELBOW, mxConstants.ELBOW_VERTICAL, links.toArray());
	}
	if (value.compareToIgnoreCase(mxConstants.ELBOW_HORIZONTAL) == 0) {
	    graph.setCellStyles(mxConstants.STYLE_EDGE, mxConstants.EDGESTYLE_ELBOW, links.toArray());
	    graph.setCellStyles(mxConstants.STYLE_ELBOW, mxConstants.ELBOW_HORIZONTAL, links.toArray());
	}
	if (value.compareToIgnoreCase(mxConstants.SHAPE_CONNECTOR) == 0) {
	    graph.setCellStyles(mxConstants.STYLE_EDGE, "", links.toArray());
	}
    }
}