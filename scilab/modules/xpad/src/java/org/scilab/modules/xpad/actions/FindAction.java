/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2009 - DIGITEO - Sylvestre KOUMAR
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

package org.scilab.modules.xpad.actions;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

import javax.swing.BorderFactory;
import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTextField;
import javax.swing.JTextPane;
import javax.swing.KeyStroke;
import javax.swing.event.CaretListener;
import javax.swing.text.BadLocationException;
import javax.swing.text.DefaultHighlighter;
import javax.swing.text.Highlighter;
import javax.swing.text.Highlighter.Highlight;

import org.scilab.modules.xpad.Xpad;
import org.scilab.modules.xpad.style.ScilabStyleDocument;

public class FindAction extends DefaultAction {

	private JFrame frame;
	private JTextField textfieldFind;
	private JTextField textfieldReplace;
	private JRadioButton buttonForward;
	private JRadioButton buttonBackward;
	private JRadioButton buttonAll;
	private JRadioButton buttonSelection;
	private ButtonGroup groupDirection;
	private ButtonGroup groupScope;
	private JCheckBox caseSensitive;
	private JCheckBox wrap;
	private JCheckBox wholeWord;
	private JCheckBox regularExp;
	private JButton buttonFind;
	private JButton buttonReplaceFind;
	private JButton buttonReplace;
	private JButton buttonReplaceAll;
	private JButton buttonClose;
	private JLabel statusBar ;

	private String oldWord;
	private String newWord;
	private String wordToFind;


	ArrayList<Integer[]> offsets;
	int startFindSelection ;
	int endFindSelection ;


	public FindAction(Xpad editor) {
		super("Find/Replace...", editor);
		//setMnemonic('F');
		setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F, ActionEvent.CTRL_MASK));
	}

	public void doAction() {

		findReplaceBox();
	}

	public void findReplaceBox() {

		//Find & Replace Frame
		frame = new JFrame();
		frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		frame.setPreferredSize(new Dimension(300, 650));
		frame.setTitle("Find/Replace");
		frame.pack();
		frame.setLocationRelativeTo(null);
		frame.setVisible(true);		
		JPanel panel = new JPanel();
		panel.setLayout(new GridBagLayout());
		frame.setContentPane(panel);

		JPanel direction = new JPanel();
		direction.setLayout(new GridBagLayout());
		JPanel scope = new JPanel();
		scope.setLayout(new GridBagLayout());
		JPanel options = new JPanel();
		options.setLayout(new GridBagLayout());

		GridBagConstraints gbc = new GridBagConstraints();
		gbc.anchor = GridBagConstraints.WEST;		
		gbc.insets = new Insets(10,5,10,5);

		//Find & Replace label, text field
		JLabel labelFind = new JLabel("Find :");
		JLabel labelReplace = new JLabel("Replace with :");
		textfieldFind = new JTextField();
		textfieldFind.setPreferredSize(new Dimension(150, 20));
		textfieldReplace = new JTextField();
		textfieldReplace.setPreferredSize(new Dimension(150, 20));

		panel.add(labelFind, gbc);
		gbc.gridwidth = GridBagConstraints.REMAINDER;
		panel.add(textfieldFind, gbc);
		gbc.gridwidth = 1;

		panel.add(labelReplace, gbc);
		gbc.gridwidth = GridBagConstraints.REMAINDER;
		panel.add(textfieldReplace, gbc);
		gbc.gridwidth = 1;

		panel.add(direction, gbc);
		gbc.gridwidth = GridBagConstraints.REMAINDER;
		panel.add(scope, gbc);
		gbc.gridwidth = 1;
		gbc.gridwidth = GridBagConstraints.REMAINDER;
		panel.add(options, gbc);

		//Find & Replace direction
		direction.setBorder(BorderFactory.createTitledBorder("Direction"));

		buttonForward = new JRadioButton("Forward");
		buttonBackward = new JRadioButton("Backward");

		groupDirection = new ButtonGroup();
		groupDirection.add(buttonForward);
		groupDirection.add(buttonBackward);
		buttonForward.setSelected(true);

		gbc.gridwidth = GridBagConstraints.REMAINDER;
		direction.add(buttonForward, gbc);
		gbc.gridwidth = 1;

		gbc.gridwidth = GridBagConstraints.REMAINDER;
		direction.add(buttonBackward, gbc);
		gbc.gridwidth = 1;

		//Find & Replace scope
		scope.setBorder(BorderFactory.createTitledBorder("Scope"));

		buttonAll = new JRadioButton("All");
		buttonSelection = new JRadioButton("Selected lines");

		groupScope = new ButtonGroup();
		groupScope.add(buttonAll);
		groupScope.add(buttonSelection);
		buttonAll.setSelected(true);

		gbc.gridwidth = GridBagConstraints.REMAINDER;
		scope.add(buttonAll, gbc);
		gbc.gridwidth = 1;

		gbc.gridwidth = GridBagConstraints.REMAINDER;
		scope.add(buttonSelection, gbc);
		gbc.gridwidth = 1;

		//Find & Replace options
		options.setBorder(BorderFactory.createTitledBorder("Options"));

		caseSensitive = new JCheckBox("Case sensitive");
		wrap = new JCheckBox("Wrap search");
		wholeWord = new JCheckBox("Whole word");
		regularExp = new JCheckBox("Regular expressions");

		gbc.anchor = GridBagConstraints.WEST;

		gbc.gridwidth = GridBagConstraints.REMAINDER;
		options.add(caseSensitive, gbc);
		options.add(wrap, gbc);
		gbc.gridwidth = GridBagConstraints.REMAINDER;
		options.add(wholeWord, gbc);
		options.add(regularExp, gbc);

		//Find & Replace buttons
		buttonFind = new JButton("Find");
		buttonReplaceFind = new JButton("Replace/Find");
		buttonReplace = new JButton("Replace");
		buttonReplaceAll = new JButton("Replace All");
		buttonClose = new JButton("Close");

		buttonFind.setPreferredSize(buttonReplaceFind.getPreferredSize());
		buttonReplace.setPreferredSize(buttonReplaceFind.getPreferredSize());
		buttonReplaceAll.setPreferredSize(buttonReplaceFind.getPreferredSize());
		buttonClose.setPreferredSize(buttonReplaceFind.getPreferredSize());

		gbc.gridwidth = 1;
		panel.add(buttonFind, gbc);
		gbc.gridwidth = GridBagConstraints.REMAINDER;
		buttonReplaceFind.setEnabled(false) ;
		panel.add(buttonReplaceFind, gbc);
		gbc.gridwidth = 1;

		buttonReplace.setEnabled(false) ;
		panel.add(buttonReplace, gbc);
		gbc.gridwidth = GridBagConstraints.REMAINDER;
		panel.add(buttonReplaceAll, gbc);
		gbc.gridwidth = 1;

		gbc.anchor = GridBagConstraints.EAST;

		gbc.gridwidth = GridBagConstraints.REMAINDER;
		panel.add(buttonClose, gbc);

		// status bar
		 statusBar = new JLabel("");
		gbc.anchor = GridBagConstraints.SOUTHWEST;
		panel.add(statusBar, gbc);

		
		buttonFind.addActionListener(new ActionListener() {


			public void actionPerformed(ActionEvent e) {
				findText();
			}
		});

		
		buttonReplace .addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				replaceOnlyText();
			}	
			
		});
		
		
		buttonReplaceFind.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				replaceText() ;
				findText() ;
				
			}
		});
		
		
		buttonReplaceAll.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				JTextPane xpadTextPane =  getEditor().getTextPane() ;
				
				boolean wrapSearchSelected = wrap.isSelected() ;
				boolean backwardSearch = buttonBackward.isSelected();
				boolean caseSensitiveSelected  = caseSensitive.isSelected();
				boolean wholeWordSelected  = wholeWord.isSelected() &&  wholeWord.isEnabled();
				boolean regexpSelected  = regularExp.isSelected();
				
				int currentPosStart = 0;
				
				int[] nextFindArray = new int[] {-1,-1} ;
				Pattern pattern = null ;
				
				oldWord = textfieldFind.getText();
				newWord = textfieldReplace.getText();
				
				
				if (regexpSelected){
			        pattern = Pattern.compile(oldWord);


				}else{
					if (wholeWordSelected){
						oldWord = "\\b" + oldWord + "\\b";
						pattern = Pattern.compile(oldWord);
						
					}else {
					
			        pattern = Pattern.compile(oldWord , Pattern.LITERAL);
					}
				}
				
	            Matcher matcher = pattern.matcher(xpadTextPane.getText());
	            xpadTextPane.setText(matcher.replaceAll(newWord));
					
				
				
			}
		});

		buttonClose.addActionListener(new ActionListener() {


			public void actionPerformed(ActionEvent e) {

				frame.dispose();
			}
		});
		
		
		textfieldFind.addCaretListener(new CaretListener() {
            public void caretUpdate(javax.swing.event.CaretEvent e) {
                String text = ((JTextField)e.getSource()).getText();
                

                // permit to choose "whole word" only if the input is a single word
                
                Pattern patternWholeWord = Pattern.compile("\\w*");
                Matcher matcherWholeWord = patternWholeWord.matcher(text);
                
                wholeWord.setEnabled(false);
                
                if ( matcherWholeWord.find() ){
                	if ( (matcherWholeWord.end() - matcherWholeWord.start()) == text.length() ){
                		wholeWord.setEnabled(true);
                	}
                	
                }

                // if we search a regexp , we first need to know if the regexp is valid or not
                if (regularExp.isSelected()){
                	try{
                		Pattern pattern =  Pattern.compile(text) ;
                		statusBar.setText("");
                    	buttonFind.setEnabled(true);
                    	buttonReplaceAll.setEnabled(true);
                    }
                    catch(PatternSyntaxException pse){
                    	
                    	statusBar.setText("unvalid regular expression");
                    	
                    	buttonFind.setEnabled(false);
                    	buttonReplaceAll.setEnabled(false);

                    }
                    

                }
                
                if (buttonReplace.isEnabled() && oldWord.compareTo(text) != 0){

					buttonReplace.setEnabled(false);
					buttonReplaceFind.setEnabled(false);
                }
                
                
            }
		});
		
				

	}
	private void findText(){
		
		
		boolean wrapSearchSelected = wrap.isSelected() ;
		boolean backwardSearch = buttonBackward.isSelected();
		boolean caseSensitiveSelected  = caseSensitive.isSelected();
		boolean wholeWordSelected  = wholeWord.isSelected() &&  wholeWord.isEnabled() ;
		boolean regexpSelected  = regularExp.isSelected();
		
		boolean onlySelectedLines = buttonSelection.isSelected();
		
		JTextPane xpadTextPane =  getEditor().getTextPane() ;

		int[] nextFindArray ;
		/*mainly used in case of selected text, otherwise currentPosStart =  currentPosEnd*/
		int currentPosStart = 0 ;
		int currentPosEnd = 0 ;

		//Get the word we have to find
		wordToFind = textfieldFind.getText();
		oldWord = wordToFind ;
		
		/*case we want to search only into the selected lines*/
		/*
		if (onlySelectedLines){
			currentPosStart = xpadTextPane.getSelectionStart();
			currentPosEnd = xpadTextPane.getSelectionEnd();
		}else{
			
			currentPosEnd = currentPosStart;
		}*/
		currentPosStart =  xpadTextPane.getCaretPosition() ;

		//Find all matching words and return their starting position into a vector
		offsets = ((ScilabStyleDocument) getEditor().getTextPane().getStyledDocument()).findWord(wordToFind, caseSensitiveSelected , wholeWordSelected , regexpSelected);

		statusBar.setText("");
		Highlighter highlight = getEditor().getTextPane().getHighlighter();
		highlight.removeAllHighlights();
		
		// if nothing has been found all this things are not needed
		if (offsets.size() > 0){
			


			//Here we highlight all the matching words
			for (int i = 0; i < offsets.size(); i++) {
				try {
					
					highlight.addHighlight(offsets.get(i)[0], offsets.get(i)[1], new DefaultHighlighter.DefaultHighlightPainter(Color.green));
					//TODO add a mechanism to change the foreground color too, if not if the text matched is in green too ...
				} catch (BadLocationException e1) {
					e1.printStackTrace();
				}
			}
			



			
			// get the position of the next expression to find
			if (backwardSearch){
				nextFindArray = ((ScilabStyleDocument) xpadTextPane.getStyledDocument()).findPreviousWord(wordToFind, currentPosStart, caseSensitiveSelected , wholeWordSelected , regexpSelected);
			}else{
				nextFindArray = ((ScilabStyleDocument) xpadTextPane.getStyledDocument()).findNextWord(wordToFind, currentPosStart,caseSensitiveSelected , wholeWordSelected , regexpSelected);
			}
			
			//Here we highlight differently the match next after the caret position
			if ( nextFindArray[0] == -1) {
				statusBar.setText("You have reached the end of the document");
				
				if (wrapSearchSelected){
					// return to the end or the beginning of the document
					if (backwardSearch){
						
						xpadTextPane.setCaretPosition(xpadTextPane.getDocument().getLength());
						currentPosStart =  xpadTextPane.getCaretPosition() ;
						nextFindArray = ((ScilabStyleDocument) xpadTextPane.getStyledDocument()).findPreviousWord(wordToFind, currentPosStart, caseSensitiveSelected , wholeWordSelected , regexpSelected);
						
					}else{
						xpadTextPane.setCaretPosition(0);
						currentPosStart =  xpadTextPane.getCaretPosition() ;
						nextFindArray = ((ScilabStyleDocument) xpadTextPane.getStyledDocument()).findNextWord(wordToFind, currentPosStart,caseSensitiveSelected , wholeWordSelected , regexpSelected);
					}
					
				}
			}
			if ( nextFindArray[0] != -1){
				
				Highlighter hl = xpadTextPane.getHighlighter(); 
				
				Highlight myHighlight = null;
				Highlight[] highlights =hl.getHighlights();

				for(int i=0; i < highlights.length; i++) {
					myHighlight = highlights[i];
					//Should equal zero
					if(myHighlight.getStartOffset() == nextFindArray[0] )
						break;
				}

				try {
					xpadTextPane.setCaretPosition(nextFindArray[0]);
					xpadTextPane.select(nextFindArray[0], nextFindArray[1]);
					
					// used by replace and replace/find
					startFindSelection = nextFindArray[0];
					endFindSelection = nextFindArray[1];

					
					buttonReplace.setEnabled(true);
					buttonReplaceFind.setEnabled(true);
					
					highlight.addHighlight(nextFindArray[0], nextFindArray[1], DefaultHighlighter.DefaultPainter);
					hl.changeHighlight(myHighlight, myHighlight.getStartOffset()+(nextFindArray[1] - nextFindArray[0]), myHighlight.getEndOffset());
				} catch (BadLocationException e1) {
					e1.printStackTrace();
				}
				
				if (backwardSearch)
				{
					xpadTextPane.setCaretPosition(nextFindArray[0]);

				}
				
			}


			
			/*if we typed on the textPanel all hilights will disappear*/
			
			if ( getEditor().getTextPane().getKeyListeners().length == 0 ){

				getEditor().getTextPane().addKeyListener(new KeyListener(){

					public void keyReleased(KeyEvent e){}
					public void keyTyped(KeyEvent e){}
					
					public void keyPressed(KeyEvent e){ 
						
						getEditor().getTextPane().getHighlighter().removeAllHighlights();
						getEditor().getTextPane().removeKeyListener(this);
					}
						
				});
			}
		}else{ // nothing has been found
			statusBar.setText("String not found");
			
			startFindSelection = -1;
			endFindSelection = -1;
		
		}
	}
	

	
	private void replaceOnlyText(){
		
		boolean wrapSearchSelected = wrap.isSelected() ;
		boolean backwardSearch = buttonBackward.isSelected();
		boolean caseSensitiveSelected  = caseSensitive.isSelected();
		boolean wholeWordSelected  =  wholeWord.isSelected() &&  wholeWord.isEnabled();
		boolean regexpSelected  = regularExp.isSelected();
		
		oldWord = textfieldFind.getText();
		newWord = textfieldReplace.getText();
		JTextPane xpadTextPane =  getEditor().getTextPane() ;
		int currentPosStart = startFindSelection ;
		int currentPosEnd = endFindSelection ;

		//currentPosStart = ((ScilabStyleDocument) xpadTextPane.getStyledDocument()).findPreviousWord(wordToFind, currentPosStart, caseSensitiveSelected , wholeWordSelected , regexpSelected)[0];
		

		
		/*
		 * we replace only the current result and then disable replace and replace find button
		 * same behaviour as find and replace in eclipse
		 */

		if (regexpSelected){
			Pattern patternOldWord = Pattern.compile(oldWord);
			 Matcher matcher;
			try{
				matcher = patternOldWord.matcher(xpadTextPane.getText(currentPosStart ,currentPosEnd- currentPosStart ));
				newWord = matcher.replaceAll(newWord);
			}catch (BadLocationException ex){
				System.out.println("Bad location");
				ex.printStackTrace();

			}
		}

	
		try{
			((ScilabStyleDocument) getEditor().getTextPane().getStyledDocument()).replace(currentPosStart ,currentPosEnd- currentPosStart, newWord,null);
		
		}catch (BadLocationException ex){
			System.out.println("Bad location");
			ex.printStackTrace();

		}
		getEditor().getTextPane().getHighlighter().removeAllHighlights();
		offsets.clear() ;
		buttonReplace.setEnabled(false);
		buttonReplaceFind.setEnabled(false);
			
	
		
	}
	

	private void replaceText(){
		
		boolean wrapSearchSelected = wrap.isSelected() ;
		boolean backwardSearch = buttonBackward.isSelected();
		boolean caseSensitiveSelected  = caseSensitive.isSelected();
		boolean wholeWordSelected  =  wholeWord.isSelected() &&  wholeWord.isEnabled();
		boolean regexpSelected  = regularExp.isSelected();
		
		oldWord = textfieldFind.getText();
		newWord = textfieldReplace.getText();
		JTextPane xpadTextPane =  getEditor().getTextPane() ;
		int currentPosStart = startFindSelection ;
		int currentPosEnd = endFindSelection ;

		//currentPosStart = ((ScilabStyleDocument) xpadTextPane.getStyledDocument()).findPreviousWord(wordToFind, currentPosStart, caseSensitiveSelected , wholeWordSelected , regexpSelected)[0];
		

		
		/*
		 * we replace only the current result and then disable replace and replace find button
		 * same behaviour as find and replace in eclipse
		 */

		if (regexpSelected){
			Pattern patternOldWord = Pattern.compile(oldWord);
			 Matcher matcher;
			try{
				matcher = patternOldWord.matcher(xpadTextPane.getText(currentPosStart ,currentPosEnd- currentPosStart ));
				newWord = matcher.replaceAll(newWord);
			}catch (BadLocationException ex){
				System.out.println("Bad location");
				ex.printStackTrace();

			}
		}

	
		try{
			((ScilabStyleDocument) getEditor().getTextPane().getStyledDocument()).replace(currentPosStart ,currentPosEnd- currentPosStart, newWord,null);
		
		}catch (BadLocationException ex){
			System.out.println("Bad location");
			ex.printStackTrace();

		}

	
		
	}


}