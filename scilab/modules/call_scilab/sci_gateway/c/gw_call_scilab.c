/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2009 - DIGITEO - Sylvestre LEDRU
 * 
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at    
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */
#include <string.h>
#include "gw_call_scilab.h"
#include "stack-c.h"
#include "callFunctionFromGateway.h"
/*--------------------------------------------------------------------------*/
#define CALL_SCILAB_TAB_SIZE 2
static gw_generic_table Tab[CALL_SCILAB_TAB_SIZE]=
{
{C2F(sci_fromjava),"fromjava"},
{C2F(sci_fromc),"fromc"}
};
/*--------------------------------------------------------------------------*/
int gw_call_scilab(void)
{  
	callFunctionFromGateway(Tab,CALL_SCILAB_TAB_SIZE);
	return 0;
}
/*--------------------------------------------------------------------------*/