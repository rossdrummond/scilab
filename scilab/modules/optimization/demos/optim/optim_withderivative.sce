// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2009 - Digiteo - Michael Baudin
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

mprintf("Running optimization...\n");

function f = rosenbrock ( x )
  f = 100.0 *(x(2)-x(1)^2)^2 + (1-x(1))^2;
endfunction
function [ f , g , ind ] = rosenbrockCost2 ( x , ind )
  if ((ind == 1) | (ind == 4)) then
    f = rosenbrock ( x );
  end
  if ((ind == 1) | (ind == 4)) then
    g= derivative ( rosenbrock , x.' , order = 4 );
  end
endfunction
x0 = [-1.2 1.0];
[ f , x ] = optim ( rosenbrockCost2 , x0 )
//
// Display results
//
mprintf("x=%s\n",strcat(string(x)," "));
mprintf("f=%e\n",f);
//
// Load this script into the editor
//
filename = 'optim_withderivative.sce';
dname = get_absolute_file_path(filename);
editor ( dname + filename );
