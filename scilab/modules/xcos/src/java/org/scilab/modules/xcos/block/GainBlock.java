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

package org.scilab.modules.xcos.block;

import org.scilab.modules.hdf5.scilabTypes.ScilabString;
import org.scilab.modules.hdf5.scilabTypes.ScilabType;

public class GainBlock extends BasicBlock {

    public GainBlock() {
	super();
	setVertex(false);
	setVisible(false);
    }
    
    protected GainBlock(String label) {
	super(label);
	setInterfaceFunctionName("GAINBLK_f");
    }
    
    public void setExprs(ScilabType exprs) {
	super.setExprs(exprs);
	setValue(((ScilabString) getExprs()).getData()[0][0]);
    }

}