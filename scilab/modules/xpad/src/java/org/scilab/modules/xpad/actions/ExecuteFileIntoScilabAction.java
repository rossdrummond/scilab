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

import java.awt.Toolkit;
import java.awt.event.KeyEvent;

import javax.swing.JTextPane;
import javax.swing.KeyStroke;

import org.scilab.modules.gui.console.ScilabConsole;
import org.scilab.modules.gui.menuitem.MenuItem;
import org.scilab.modules.gui.messagebox.ScilabModalDialog;
import org.scilab.modules.gui.messagebox.ScilabModalDialog.AnswerOption;
import org.scilab.modules.gui.messagebox.ScilabModalDialog.ButtonType;
import org.scilab.modules.gui.messagebox.ScilabModalDialog.IconType;
import org.scilab.modules.xpad.Xpad;
import org.scilab.modules.xpad.style.ScilabStyleDocument;
import org.scilab.modules.xpad.utils.XpadMessages;

public class ExecuteFileIntoScilabAction extends DefaultAction {
	
	private static int CANCEL = 1;
	private static int SAVE_AND_EXECUTE = 2;

	private ExecuteFileIntoScilabAction(Xpad editor) {
		super(XpadMessages.EXECUTE_FILE_INTO_SCILAB, editor);
	}
	
	/**
	 * Execute the file into Scilab
	 * @param editor the Scilab editor
	 */
	private void executeFile(Xpad editor) {
		String filePath = editor.getFileFullPath();
		String cmdToExec = "exec('" + filePath + "', -1)";
		try {
			ScilabConsole.getConsole().getAsSimpleConsole().sendCommandsToScilab(cmdToExec, true, false);
		} catch (NoClassDefFoundError e) {
			/* This happens when Xpad is launch as standalone (ie without
			 * Scilab) */
			ScilabModalDialog.show(editor, "Could not find the console nor the InterpreterManagement");
		}
	}

	public void doAction() {
	    /* Will execute the document file (file sould be saved)*/

	    Xpad editor = getEditor();

	    if (((ScilabStyleDocument) getEditor().getTextPane().getStyledDocument()).isContentModified()) {
		if (ScilabModalDialog.show(Xpad.getEditor(), XpadMessages.EXECUTE_WARNING, XpadMessages.EXECUTE_FILE_INTO_SCILAB, 
			IconType.WARNING_ICON, ButtonType.CANCEL_OR_SAVE_AND_EXECUTE) == AnswerOption.SAVE_EXECUTE_OPTION) {
		    if (editor.save(getEditor().getTabPane().getSelectedIndex(), false)) {
				this.executeFile(editor);
		    }
		} 
	    } else {
			this.executeFile(editor);
	    }
	}
	
	public static MenuItem createMenu(Xpad editor) {
		return createMenu(XpadMessages.EXECUTE_FILE_INTO_SCILAB, null, new ExecuteFileIntoScilabAction(editor), KeyStroke.getKeyStroke(KeyEvent.VK_E, Toolkit.getDefaultToolkit().getMenuShortcutKeyMask()));
	 }
}