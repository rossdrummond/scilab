/*
* Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
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
#include "gw_fileio.h"
#include "stack-c.h"
#include "MALLOC.h"
#include "localization.h"
#include "api_common.h"
#include "api_string.h"
#include "api_boolean.h"
#include "Scierror.h"
#include "FileExist.h"
#include "isdir.h"
#include "freeArrayOfString.h"
#include "BOOL.h"
/*--------------------------------------------------------------------------*/
int sci_isfile(char *fname,unsigned long fname_len)
{
	int *piAddressVarOne = NULL;
	wchar_t **pStVarOne = NULL;
	int *lenStVarOne = NULL;
	int m1 = 0, n1 = 0;

	BOOL *results = NULL;
	int m_out = 0, n_out = 0;
	int i = 0;

	/* Check Input & Output parameters */
	CheckRhs(1,1);
	CheckLhs(1,1);

	getVarAddressFromPosition(1, &piAddressVarOne);

	if (getVarType(piAddressVarOne) != sci_strings)
	{
		Scierror(999,_("%s: Wrong type for input argument #%d: A string expected.\n"), fname, 1);
		return 0;
	}

	getVarDimension(piAddressVarOne, &m1, &n1);

	lenStVarOne = (int*)MALLOC(sizeof(int) * (m1 * n1));
	if (lenStVarOne == NULL)
	{
		Scierror(999,_("%s : Memory allocation error.\n"),fname);
		return 0;
	}

	pStVarOne = (wchar_t**)MALLOC(sizeof(wchar_t*) * (m1 * n1));
	if (pStVarOne == NULL)
	{
		if (lenStVarOne) {FREE(lenStVarOne); lenStVarOne = NULL;}
		Scierror(999,_("%s : Memory allocation error.\n"),fname);
		return 0;
	}

	results = (BOOL*)MALLOC(sizeof(BOOL) * (m1 * n1));
	if (results == NULL)
	{
		if (lenStVarOne) {FREE(lenStVarOne); lenStVarOne = NULL;}
		freeArrayOfWideString(pStVarOne, m1 * n1);
		Scierror(999,_("%s : Memory allocation error.\n"),fname);
		return 0;
	}

	getMatrixOfWideString(piAddressVarOne, &m1, &n1, lenStVarOne, pStVarOne);

	for (i=0;i< m1 * n1; i++)
	{
		results[i] = !isdirW(pStVarOne[i]) && FileExistW(pStVarOne[i]);
	}

	if (lenStVarOne) {FREE(lenStVarOne); lenStVarOne = NULL;}
	freeArrayOfWideString(pStVarOne, m1 * n1);

	createMatrixOfBoolean(Rhs + 1, m1, n1, results);
	LhsVar(1) = Rhs + 1;

	if (results) {FREE(lenStVarOne); lenStVarOne = NULL;}
	
	C2F(putlhsvar)();
	return 0;
}
/*--------------------------------------------------------------------------*/