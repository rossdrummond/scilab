// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008-2009 - INRIA - Michael Baudin
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt


//
// assert_close --
//   Returns 1 if the two real matrices computed and expected are close,
//   i.e. if the relative distance between computed and expected is lesser than epsilon.
// Arguments
//   computed, expected : the two matrices to compare
//   epsilon : a small number
//
function flag = assert_close ( computed, expected, epsilon )
  if expected==0.0 then
    shift = norm(computed-expected);
  else
    shift = norm(computed-expected)/norm(expected);
  end
  if shift < epsilon then
    flag = 1;
  else
    flag = 0;
  end
  if flag <> 1 then pause,end
endfunction
//
// assert_equal --
//   Returns 1 if the two real matrices computed and expected are equal.
// Arguments
//   computed, expected : the two matrices to compare
//   epsilon : a small number
//
function flag = assert_equal ( computed , expected )
  if computed==expected then
    flag = 1;
  else
    flag = 0;
  end
  if flag <> 1 then pause,end
endfunction
//
// Test proj2bnds method
//
//
// Test with bounds
//
opt = optimbase_new ();
opt = optimbase_configure(opt,"-numberofvariables",2);
opt = optimbase_configure(opt,"-verbose",1);
opt = optimbase_configure ( opt , "-boundsmin" , [-5.0 -5.0] );
opt = optimbase_configure ( opt , "-boundsmax" , [5.0 5.0] );
[ opt , p ] = optimbase_proj2bnds ( opt ,  [0.0 0.0] );
assert_equal ( p , [0.0 0.0] );
[ opt , p ] = optimbase_proj2bnds ( opt ,  [-6.0 6.0] );
assert_equal ( p , [-5.0 5.0] );
opt = optimbase_destroy(opt);
//
// Test without bounds
//
opt = optimbase_new ();
opt = optimbase_configure(opt,"-numberofvariables",2);
opt = optimbase_configure(opt,"-verbose",1);
[ opt , p ] = optimbase_proj2bnds ( opt ,  [0.0 0.0] );
assert_equal ( p , [0.0 0.0] );
opt = optimbase_destroy(opt);
