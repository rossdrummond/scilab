// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008-2009 - INRIA - Michael Baudin
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

//
// optimsimplex_gradientfv --
//   Returns the simplex gradient of the function.
// Arguments
//   fun : the function to use
//   method : the method to use, "forward" or "centered"
//   data : user-defined data, added to the the function if provided
//
function [ g , data ] = optimsimplex_gradientfv ( this , fun , method , data )
  if ( this.nbve <> this.n+1 ) then
    errmsg = sprintf("The gradient can be applied only with a simplex made of n+1 points, but the dimension is %d and the number of vertices is %d", this.n , this.nbve)
    error(errmsg)
  end
  if (~isdef('method','local')) then
    method = "forward";
  end
  select method
  case "forward" then
    g = optimsimplex_gradforward ( this )
  case "centered" then
    if (~isdef('data','local')) then
      g = optimsimplex_gradcentered ( this , fun )
    else
      [ g , data ] = optimsimplex_gradcentered ( this , fun , data )
    end
  else
    errmsg = sprintf("Unknown method %s",method)
    error(errmsg)
  end
endfunction
//
// optimsimplex_gradforward --
//   Returns the simplex forward gradient of the function.
// Arguments
//   <no arg>
//
function g = optimsimplex_gradforward ( this )
  v = optimsimplex_dirmat ( this )
  d = optimsimplex_deltafv ( this )
  g = v'\d
endfunction
//
// optimsimplex_gradcentered --
//   Returns the simplex centered gradient of the function.
// Arguments
//   fun : name of the function
//   data : user-defined data
//
function [ g , data ] = optimsimplex_gradcentered ( this , fun , data )
  g1 = optimsimplex_gradforward ( this )
  if (~isdef('data','local')) then
    r = optimsimplex_reflect ( this , fun )
  else
    [ r , data ] = optimsimplex_reflect ( this , fun , data )
  end
  g2 = optimsimplex_gradforward ( r )
  g = (g1 + g2)/2
  r = optimsimplex_destroy ( r )
endfunction
