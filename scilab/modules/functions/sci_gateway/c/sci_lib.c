/*
* Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
* Copyright (C) 2006 - INRIA - Allan CORNET
* Copyright (C) 2009 - DIGITEO - Allan CORNET
* 
* This file must be used under the terms of the CeCILL.
* This source file is licensed as described in the file COPYING, which
* you should have received as part of this distribution.  The terms
* are also available at    
* http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
*
*/
/*--------------------------------------------------------------------------*/
#include "stack-c.h"
#include "gw_functions.h"
#include "api_common.h"
#include "api_string.h"
#include "localization.h"
#include "Scierror.h"
#include "MALLOC.h"
#include "machine.h"
/*--------------------------------------------------------------------------*/
extern int C2F(intlib)();
/*--------------------------------------------------------------------------*/
int C2F(sci_lib)(char *fname,unsigned long fname_len)
{
	int m1 = 0, n1 = 0;
	int *piAddressVarOne = NULL;
	char *pStVarOne = NULL;
	int lenStVarOne = 0;

	int len = 0;

	/* Check the number of input argument */
	CheckRhs(1,1); 

	/* Check the number of output argument */
	CheckLhs(1,1);

	/* get Address of inputs */
	getVarAddressFromPosition(1, &piAddressVarOne);

	if ( getVarType(piAddressVarOne) != sci_strings )
	{
		Scierror(999,_("%s: Wrong type for input argument #%d: A string expected.\n"),fname,1);
		return 0;
	}

	getMatrixOfString(piAddressVarOne,&m1,&n1,&lenStVarOne,&pStVarOne);
	/* check size */
	if ( (m1 != n1) && (n1 != 1) ) 
	{
		Scierror(999,"%s: Wrong size for input argument #%d: A string expected.\n",fname,1);
		return 0;
	}

	pStVarOne = (char*)MALLOC(sizeof(char)*(lenStVarOne + 1));
	/* get string One */
	getMatrixOfString(piAddressVarOne,&m1,&n1,&lenStVarOne,&pStVarOne);

	if ( (pStVarOne[strlen(pStVarOne)-1] != '/') && 
		(pStVarOne[strlen(pStVarOne)-1] != '\\') )
	{
		pStVarOne = (char*)REALLOC(pStVarOne, (strlen(pStVarOne) + 1) * sizeof(char));
		if (pStVarOne)
		{
			strcat(pStVarOne, DIR_SEPARATOR);
		}
		else
		{
			Scierror(999,"%s : Memory allocation error.\n",fname);
			return 0;
		}
	}

	len = (int)strlen(pStVarOne);
	C2F(intlib)(&len, pStVarOne,&len);

	if (pStVarOne)
	{
		FREE(pStVarOne);
		pStVarOne = NULL;
	}

	return 0;
}
/*--------------------------------------------------------------------------*/