/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2007 - INRIA - Sylvestre LEDRU
 * 
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at    
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

#ifndef __GETENVB_H__
#define __GETENVB_H__

/**
 * getenv + squash trailing white spaces 
 *
 * @param name  
 * @param env   
 * @param len   
 */
void GetenvB(char *name, char *env, int len);

#endif /* __GETENVB_H__ */