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
function y = rosenbrock (x)
  y = 100*(x(2)-x(1)^2)^2 + (1-x(1))^2;
endfunction


//
// Test with a scalar length
//
myobj = tlist(["T_MYSTUFF","nb"]);
myobj.nb = 0;
function [ y , myobj ] = mycostf ( x , myobj )
  y = rosenbrock(x);
  myobj.nb = myobj.nb + 1
endfunction
s1 = optimsimplex_new ();
[ s1 , myobj ] = optimsimplex_axes ( s1 , x0 = [-1.2 1.0] , fun = mycostf , len = 1.0, data=myobj );
computed = optimsimplex_getall ( s1 );
expected = [
24.2 -1.2 1.0
93.6 -0.2 1.0
36.2 -1.2 2.0
];
assert_close ( computed , expected , %eps );
assert_equal ( myobj.nb , 3 );
nbve = optimsimplex_getnbve ( s1 );
assert_equal ( nbve , 3 );
s1 = optimsimplex_destroy ( s1 );
//
// Test with a vector length
//
s1 = optimsimplex_new ();
s1 = optimsimplex_axes ( s1 , x0 = [-1.2 1.0] , fun = rosenbrock , len = [1.0 2.0] );
computed = optimsimplex_getall ( s1 );
expected = [
24.2 -1.2 1.
93.6 -0.2 1.
248.2 -1.2 3.
];
assert_close ( computed , expected , %eps );
s1 = optimsimplex_destroy ( s1 );
