/*
* Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
* Copyright (C) DIGITEO - 2008 - Allan CORNET
* 
* This file must be used under the terms of the CeCILL.
* This source file is licensed as described in the file COPYING, which
* you should have received as part of this distribution.  The terms
* are also available at    
* http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
*
*/

/*--------------------------------------------------------------------------*/
#include <windows.h>
#include "FocusOnConsole.h"
#include "scilabmode.h"
/*--------------------------------------------------------------------------*/
void setFocusOnConsole(void)
{
	if ( (getScilabMode() == SCILAB_NW) || (getScilabMode() == SCILAB_NWNI) )
	{
		HWND hWndConsole = GetConsoleWindow();
		if (hWndConsole)
		{
			SetForegroundWindow(hWndConsole);
			SetActiveWindow(hWndConsole);
		}
	}
}
/*--------------------------------------------------------------------------*/