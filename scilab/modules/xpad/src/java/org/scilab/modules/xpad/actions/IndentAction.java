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

package org.scilab.modules.xpad.actions;

import java.awt.event.ActionEvent;
import java.awt.event.KeyEvent;

import javax.swing.KeyStroke;

import org.scilab.modules.xpad.Xpad;
import org.scilab.modules.xpad.style.ScilabStyleDocument;

public class IndentAction extends DefaultAction {
	
	public IndentAction(Xpad editor) {
		super("Indent", editor);
		setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_I, ActionEvent.CTRL_MASK));
	}
	
	public void doAction() {
		int initial_caret_position = getEditor().getTextPane().getCaretPosition();
		
		((ScilabStyleDocument) getEditor().getTextPane().getStyledDocument()).indent();
		
		getEditor().getTextPane().setCaretPosition(initial_caret_position);
		
	}

}