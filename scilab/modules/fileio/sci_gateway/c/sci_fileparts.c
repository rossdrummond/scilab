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
#include "Scierror.h"
#include "freeArrayOfString.h"
#include "splitpath.h"
/*--------------------------------------------------------------------------*/
#define FILEPARTS_PATH_SELECTOR L"path"
#define FILEPARTS_FNAME_SELECTOR L"fname"
#define FILEPARTS_EXTENSION_SELECTOR L"extension"
/*--------------------------------------------------------------------------*/
int sci_fileparts(char *fname,unsigned long fname_len)
{
	int m1 = 0, n1 = 0;
	int *piAddressVarOne = NULL;
	wchar_t *pStVarOne = NULL;
	int lenStVarOne = 0;

	int m2 = 0, n2 = 0;
	int *piAddressVarTwo = NULL;
	wchar_t *pStVarTwo = NULL;
	int lenStVarTwo = 0;

	wchar_t* drv = NULL;
	wchar_t* dir = NULL;
	wchar_t* name = NULL;
	wchar_t* ext = NULL;
	wchar_t* path_out = NULL;

	CheckLhs(1,3); 
	CheckRhs(1,2); 

	if ( (Rhs == 2) && (Lhs != 1) )
	{
		Scierror(78,_("%s: Wrong number of output arguments: %d expected.\n"), fname, 1);
		return 0;
	}

	getVarAddressFromPosition(1, &piAddressVarOne);

	if ( getVarType(piAddressVarOne) != sci_strings )
	{
		Scierror(999,_("%s: Wrong type for input argument #%d: A string expected.\n"),fname,1);
		return 0;
	}

	getMatrixOfWideString(piAddressVarOne,&m1,&n1,&lenStVarOne,&pStVarOne);
	if ( (m1 != n1) && (n1 != 1) ) 
	{
		Scierror(999,_("%s: Wrong size for input argument #%d: A string expected.\n"),fname,1);
		return 0;
	}

	pStVarOne = (wchar_t*)MALLOC(sizeof(wchar_t)*(lenStVarOne + 1));
	if (pStVarOne == NULL)
	{
		Scierror(999,_("%s : Memory allocation error.\n"),fname);
		return 0;
	}

	getMatrixOfWideString(piAddressVarOne, &m1, &n1, &lenStVarOne, &pStVarOne);

	if (Rhs == 2)
	{
		getVarAddressFromPosition(2, &piAddressVarTwo);

		if ( getVarType(piAddressVarTwo) != sci_strings )
		{
			Scierror(999,_("%s: Wrong type for input argument #%d: A string expected.\n"),fname,2);
			return 0;
		}

		getMatrixOfWideString(piAddressVarTwo, &m2, &n2, &lenStVarTwo, &pStVarTwo);
		if ( (m2 != n2) && (n2 != 1) ) 
		{
			Scierror(999,_("%s: Wrong size for input argument #%d: A string expected.\n"),fname,2);
			return 0;
		}

		pStVarTwo = (wchar_t*)MALLOC(sizeof(wchar_t)*(lenStVarTwo + 1));
		if (pStVarTwo == NULL)
		{
			Scierror(999,_("%s : Memory allocation error.\n"),fname);
			return 0;
		}
		getMatrixOfWideString(piAddressVarTwo, &m2, &n2, &lenStVarTwo, &pStVarTwo);
	}

	drv = (wchar_t*)MALLOC(sizeof(wchar_t)*(lenStVarOne + 1));
	dir = (wchar_t*)MALLOC(sizeof(wchar_t)*(lenStVarOne + 1));
	name = (wchar_t*)MALLOC(sizeof(wchar_t)*(lenStVarOne + 1));
	ext = (wchar_t*)MALLOC(sizeof(wchar_t)*(lenStVarOne + 1));
	path_out = (wchar_t*)MALLOC(sizeof(wchar_t)*(lenStVarOne + 1));

	if ( (drv == NULL) || (dir == NULL) || (name == NULL) || (ext == NULL) || (path_out == NULL) )
	{
		if (pStVarOne) {FREE(pStVarOne); pStVarOne = NULL;}
		if (pStVarTwo) {FREE(pStVarTwo); pStVarTwo = NULL;}
		if (drv) {FREE(drv); drv = NULL;}
		if (dir) {FREE(dir); dir = NULL;}
		if (name) {FREE(name); name = NULL;}
		if (ext) {FREE(ext); ext = NULL;}
		if (path_out) {FREE(path_out); path_out = NULL;}

		Scierror(999,_("%s : Memory allocation error.\n"), fname);
		return 0;
	}

	splitpathW(pStVarOne, drv, dir, name, ext);

	if (pStVarTwo) /* Rhs == 2 */
	{
		wchar_t *output_value = NULL;
		int m_out = 0, n_out = 0;

		if (wcscmp(pStVarTwo, FILEPARTS_PATH_SELECTOR) == 0)
		{
			output_value = path_out;
			wcscpy(output_value, drv);
			wcscat(output_value, dir);
		}
		else if (wcscmp(pStVarTwo, FILEPARTS_FNAME_SELECTOR) == 0)
		{
			output_value = name;
		}
		else if (wcscmp(pStVarTwo, FILEPARTS_EXTENSION_SELECTOR) == 0)
		{
			output_value = ext;
		}
		else
		{
			if (pStVarOne) {FREE(pStVarOne); pStVarOne = NULL;}
			if (pStVarTwo) {FREE(pStVarTwo); pStVarTwo = NULL;}
			if (drv) {FREE(drv); drv = NULL;}
			if (dir) {FREE(dir); dir = NULL;}
			if (name) {FREE(name); name = NULL;}
			if (ext) {FREE(ext); ext = NULL;}
			if (path_out) {FREE(path_out); path_out = NULL;}

			Scierror(999,_("%s: Wrong value for input argument #%d.\n"), fname, 2);
			return 0;
		}

		m_out = 1; n_out = 1;
		createMatrixOfWideString(Rhs + 1, m_out, n_out, &output_value);
		LhsVar(1) = Rhs + 1;
		C2F(putlhsvar)();
	}
	else
	{
		int m_out = 1, n_out = 1;

		wcscpy(path_out, drv);
		wcscat(path_out, dir);

		createMatrixOfWideString(Rhs + 1, m_out, n_out, &path_out);
		LhsVar(1) = Rhs + 1;

		createMatrixOfWideString(Rhs + 2, m_out, n_out, &name);
		LhsVar(2) = Rhs + 2;

		createMatrixOfWideString(Rhs + 3, m_out, n_out, &ext);
		LhsVar(3) = Rhs + 3;

		C2F(putlhsvar)();
	}


	if (pStVarOne) {FREE(pStVarOne); pStVarOne = NULL;}
	if (pStVarTwo) {FREE(pStVarTwo); pStVarTwo = NULL;}
	if (drv) {FREE(drv); drv = NULL;}
	if (dir) {FREE(dir); dir = NULL;}
	if (name) {FREE(name); name = NULL;}
	if (ext) {FREE(ext); ext = NULL;}
	if (path_out) {FREE(path_out); path_out = NULL;}

	return 0;
}
/*--------------------------------------------------------------------------*/