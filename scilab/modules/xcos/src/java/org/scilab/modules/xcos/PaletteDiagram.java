package org.scilab.modules.xcos;

import java.io.File;

import org.scilab.modules.xcos.block.BasicBlock;
import org.scilab.modules.xcos.block.SplitBlock;
import org.scilab.modules.xcos.block.TextBlock;
import org.scilab.modules.xcos.link.BasicLink;
import org.scilab.modules.xcos.utils.BlockPositioning;
import org.scilab.modules.xcos.utils.XcosConstants;

import com.mxgraph.model.mxGeometry;


public class PaletteDiagram extends XcosDiagram {

    private static int BLOCK_MAX_WIDTH  = (int) (XcosConstants.PALETTE_BLOCK_WIDTH * 0.8); //80% of the max size
    private static int BLOCK_MAX_HEIGHT = (int) (XcosConstants.PALETTE_BLOCK_HEIGHT * 0.8); //80% of the max size
    private String name = "";
    private double windowWidth = 0;

    public PaletteDiagram() {
	super();
	
	setCellsLocked(true);
	setGridVisible(false);
	setCellsDeletable(false);
	setCellsEditable(false);
    }

    public boolean openDiagramAsPal(String diagramFileName) {
	File theFile = new File(diagramFileName);

	//int windowHeight = getAsComponent().getHeight();
	
	if (theFile.exists()) {
	    transformAndLoadFile(theFile);
	    name = theFile.getName();
	    getRubberBand().setEnabled(false);

	    /*change some diagram parameters*/
	    /*delete all links*/
	    for(int i = 0 ; i < getModel().getChildCount(getDefaultParent()) ; i++) {
		Object obj = getModel().getChildAt(getDefaultParent(), i); 
		if(obj instanceof BasicLink || obj instanceof SplitBlock || obj instanceof TextBlock) {
		    getModel().remove(obj);
		    i--;
		}
	    }
	    return true;
	}
	return false;
    }

    public void updateDiagram(double newWidth) {
	
	if(newWidth == windowWidth) {
	    return;
	}

	int oldRowItem = (int) (newWidth / (XcosConstants.PALETTE_BLOCK_WIDTH + XcosConstants.PALETTE_HMARGIN));
	int maxRowItem = (int) (windowWidth / (XcosConstants.PALETTE_BLOCK_WIDTH + XcosConstants.PALETTE_HMARGIN));
	
	//only compute for signifiant changes
	if(oldRowItem == maxRowItem) {
	    return;
	}

	windowWidth = newWidth;
	int blockCount = 0;

	for(int i = 0 ; i < getModel().getChildCount(getDefaultParent()) ; i++) {
	    Object obj = getModel().getChildAt(getDefaultParent(), i); 
	    if(obj instanceof BasicBlock){
		BasicBlock block = (BasicBlock)obj;
		block.setGeometry(getNewBlockPosition(block.getGeometry(), blockCount));
		BlockPositioning.updateBlockView(block);
		blockCount++;
	    }
	}
	refresh();
	undoManager.reset();
	setModified(false);
    }
    
    private mxGeometry getNewBlockPosition(mxGeometry geom, int blockCount) {
	
	int maxRowItem = (int) (windowWidth / (XcosConstants.PALETTE_BLOCK_WIDTH + XcosConstants.PALETTE_HMARGIN));
	int row = blockCount % maxRowItem;
	int col = blockCount / maxRowItem;
	double x = geom.getX();
	double y = geom.getY();
	double w = geom.getWidth();
	double h = geom.getHeight();
	
	if(geom.getWidth() > BLOCK_MAX_WIDTH || geom.getHeight() > BLOCK_MAX_HEIGHT) {
	    //update block size to fill "block area"
	    double ratio = Math.min(BLOCK_MAX_HEIGHT / h, BLOCK_MAX_WIDTH / w);
	    w *= ratio;
	    h *= ratio;
	}
	
	x = row * (XcosConstants.PALETTE_BLOCK_WIDTH + XcosConstants.PALETTE_HMARGIN);
	x += (XcosConstants.PALETTE_BLOCK_WIDTH - w) / 2;
	y = col * (XcosConstants.PALETTE_BLOCK_HEIGHT + XcosConstants.PALETTE_VMARGIN);
	y += (XcosConstants.PALETTE_BLOCK_HEIGHT - h) / 2;
	
	return new mxGeometry(x,y,w,h); 
    }

    public String getName() {
	return name;
    }

    public boolean isCellConnectable(Object cell) {
	return false;
    }

}