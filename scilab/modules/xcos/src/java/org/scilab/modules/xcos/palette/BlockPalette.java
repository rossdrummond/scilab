package org.scilab.modules.xcos.palette;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.MouseInfo;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.ArrayList;
import java.util.List;

import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.SwingUtilities;
import javax.swing.border.Border;

import org.flexdock.plaf.common.border.ShadowBorder;
import org.scilab.modules.action_binding.InterpreterManagement;
import org.scilab.modules.gui.bridge.contextmenu.SwingScilabContextMenu;
import org.scilab.modules.gui.contextmenu.ContextMenu;
import org.scilab.modules.gui.contextmenu.ScilabContextMenu;
import org.scilab.modules.gui.events.callback.CallBack;
import org.scilab.modules.gui.menu.Menu;
import org.scilab.modules.gui.menu.ScilabMenu;
import org.scilab.modules.gui.menuitem.MenuItem;
import org.scilab.modules.gui.menuitem.ScilabMenuItem;
import org.scilab.modules.xcos.Xcos;
import org.scilab.modules.xcos.XcosDiagram;
import org.scilab.modules.xcos.block.BasicBlock;
import org.scilab.modules.xcos.io.BlockReader;
import org.scilab.modules.xcos.utils.XcosMessages;

import com.mxgraph.swing.util.mxGraphTransferable;
import com.mxgraph.util.mxRectangle;

public class BlockPalette extends JLabel {

    private static final long serialVersionUID = 1L;
    public static int BLOCK_WIDTH = 100;
    public static int BLOCK_HEIGHT = 100;

    private BasicBlock block;
    private XcosPalette palette;
    private mxGraphTransferable transferable;

    public BlockPalette(ImageIcon icon) {
	super(icon);

	addMouseListener(new MouseListener()
	{
	    /*
	     * (non-Javadoc)
	     * @see java.awt.event.MouseListener#mousePressed(java.awt.event.MouseEvent)
	     */
	    public void mousePressed(MouseEvent e) {
		getPalette().setSelectionEntry(BlockPalette.this, getTransferable());
	    }

	    /*
	     * (non-Javadoc)
	     * @see java.awt.event.MouseListener#mouseClicked(java.awt.event.MouseEvent)
	     */
	    public void mouseClicked(MouseEvent e) {
		if ((e.getClickCount() == 1 && SwingUtilities.isRightMouseButton(e))
			|| e.isPopupTrigger()
			|| isMacOsPopupTrigger(e)) {

		    ContextMenu menu = ScilabContextMenu.createContextMenu();

		    final List<XcosDiagram> allDiagrams = Xcos.getDiagrams();

		    if (allDiagrams.size() == 0) {
			// No diagram opened: should never happen if Xcos opens an empty diagram when it is launched
			MenuItem addTo = ScilabMenuItem.createMenuItem();

			addTo.setText(XcosMessages.ADDTO_NEW_DIAGRAM);
			addTo.setCallback(new CallBack(BlockPalette.this.getText()) {
			    private static final long serialVersionUID = 1185879440137756636L;

			    public void callBack() {
				Xcos.createEmptyDiagram().addCell(BlockPalette.this.getBlock().createClone());
			    }
			});

			menu.add(addTo);

		    } else if (allDiagrams.size() == 1) {
			// A single diagram opened: add to this diagram
			MenuItem addTo = ScilabMenuItem.createMenuItem();

			addTo.setText(XcosMessages.ADDTO + " " + allDiagrams.get(0).getParentTab().getName());
			final XcosDiagram theDiagram = allDiagrams.get(0);
			addTo.setCallback(new CallBack(BlockPalette.this.getText()) {
			    private static final long serialVersionUID = 1185879440137756636L;

			    public void callBack() {
				theDiagram.addCell(BlockPalette.this.getBlock().createClone());
			    }
			});

			menu.add(addTo);

		    } else {
			// The user has to choose
			Menu addTo = ScilabMenu.createMenu();

			addTo.setText(XcosMessages.ADDTO);

			for (int i = 0; i < allDiagrams.size(); i++) {
			    MenuItem diagram = ScilabMenuItem.createMenuItem();
			    final XcosDiagram theDiagram = allDiagrams.get(i);
			    diagram.setText(allDiagrams.get(i).getParentTab().getName());
			    diagram.setCallback(new CallBack(BlockPalette.this.getText()) {
				private static final long serialVersionUID = -3138430622029406470L;

				public void callBack() {
				    theDiagram.addCell(BlockPalette.this.getBlock().createClone());
				}
			    });
			    addTo.add(diagram);
			}

			menu.add(addTo);
		    }


		    menu.getAsSimpleContextMenu().addSeparator();

		    MenuItem help = ScilabMenuItem.createMenuItem();
		    help.setText("Block help");
		    help.setCallback(new CallBack(BlockPalette.this.getText()) {
			private static final long serialVersionUID = -8720228686621887887L;

			public void callBack() {
			    InterpreterManagement.requestScilabExec("help " + BlockPalette.this.getText());
			}
		    });
		    menu.add(help);

		    menu.setVisible(true);

		    ((SwingScilabContextMenu) menu.getAsSimpleContextMenu()).setLocation(
			    MouseInfo.getPointerInfo().getLocation().x, MouseInfo.getPointerInfo().getLocation().y);
		}
	    }

	    /*
	     * (non-Javadoc)
	     * @see java.awt.event.MouseListener#mouseEntered(java.awt.event.MouseEvent)
	     */
	    public void mouseEntered(MouseEvent e) {
	    }

	    /*
	     * (non-Javadoc)
	     * @see java.awt.event.MouseListener#mouseExited(java.awt.event.MouseEvent)
	     */
	    public void mouseExited(MouseEvent e) {
	    }

	    /*
	     * (non-Javadoc)
	     * @see java.awt.event.MouseListener#mouseReleased(java.awt.event.MouseEvent)
	     */
	    public void mouseReleased(MouseEvent e) {
	    }

	});
    }

    public BasicBlock getBlock() {
	
	if(block == null) {
	    System.err.println("loading : " + getText());
	} else {
	    System.err.println("Already loaded : " + getText());
	}
	
	if(block == null) {
	    String blocksPath = System.getenv("SCI") + "/modules/scicos_blocks/blocks/";

	    // Search the bloc in global hashmap
	    block = BlockReader.readBlockFromFile(blocksPath + getText() + ".h5");

	    if (block.getStyle().compareTo("") == 0) {
		block.setStyle(block.getInterfaceFunctionName());
		block.setValue(block.getInterfaceFunctionName());
	    }
	}
	return block;
    }

    public void setBlock(BasicBlock block) {
	this.block = block;
    }
    public void paint2(Graphics g) {
	boolean opaque = isOpaque();
	Color bg = getBackground();
	Border br = getBorder();

	if (getPalette().getSelectedEntry() == this) {
	    setBackground(getPalette().getBackground().brighter());
	    setBorder(new ShadowBorder());
	    setOpaque(true);
	}

	super.paint(g);

	setBorder(br);
	setBackground(bg);
	setOpaque(opaque);
    }

    public XcosPalette getPalette() {
	return palette;
    }

    public void setPalette(XcosPalette palette) {
	this.palette = palette;
	setPreferredSize(new Dimension(BLOCK_WIDTH, BLOCK_HEIGHT));
	setBackground(palette.getBackground().brighter());
	setFont(new Font(getFont().getFamily(), 0, 12));

	setVerticalTextPosition(JLabel.BOTTOM);
	setHorizontalTextPosition(JLabel.CENTER);
	setIconTextGap(5);
    }

    public mxGraphTransferable getTransferable() {
	if(transferable == null) {
	    transferable = new mxGraphTransferable(new Object[] {BlockPalette.this.getBlock()},
			(mxRectangle) BlockPalette.this.getBlock().getGeometry().clone());	    
	}
	return transferable;
    }

    public void setTransferable(mxGraphTransferable transferable) {
	this.transferable = transferable;
    }

    /**
     * This function checks for the popup menu activation under MacOS with Java version 1.5
     * Related to Scilab bug #5190
     * @return true if Java 1.5 and MacOS and mouse clic and ctrl activated
     */
    private boolean isMacOsPopupTrigger(MouseEvent e) {
	return (SwingUtilities.isLeftMouseButton(e) && e.isControlDown() && (System.getProperty("os.name").toLowerCase().indexOf("mac") != -1) && (System.getProperty("java.specification.version").equals("1.5")));
    }
}