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

public class UnCommentAction extends DefaultAction {

	public UnCommentAction(Xpad editor) {
		super("Uncomment Selection", editor);
		setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_T, ActionEvent.CTRL_MASK));
	}
	
	public void doAction() {
		int start_position = getEditor().getTextPane().getSelectionStart();
		int end_position = getEditor().getTextPane().getSelectionEnd();
		
		((ScilabStyleDocument) getEditor().getTextPane().getStyledDocument()).commentText(start_position, end_position);
	}
}