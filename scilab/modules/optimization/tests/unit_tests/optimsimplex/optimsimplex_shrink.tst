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
// Test optimsimplex_shrink
//
//
// Test with 3 vertices
//
s1 = optimsimplex_new ();
s1 = optimsimplex_setn(s1,2);
s1 = optimsimplex_setnbve(s1,3);
newsimplex = [
0.0 1.0 0.0
0.0 0.0 1.0
];
s1 = optimsimplex_setallx ( s1 , newsimplex );
s1 = optimsimplex_setallfv ( s1 , [-12.0 0.0 0.0]' );
s1 = optimsimplex_shrink ( s1 , rosenbrock );
computed = optimsimplex_getall ( s1 );
// The function value at vertex #1 is not re-computed, as expected.
expected = [
  -12.    0.     0.   
    6.5    0.5    0.   
    26.    0.     0.5  
];
assert_equal ( computed , expected );
s1 = optimsimplex_destroy ( s1 );
//
// Test with an additional argument
//
myobj = tlist(["T_MYSTUFF","nb"]);
myobj.nb = 0;
function [ y , myobj ] = mycostf ( x , myobj )
  y = rosenbrock(x);
  myobj.nb = myobj.nb + 1
endfunction
s1 = optimsimplex_new ();
newsimplex = [
-12.0 0.0 0.0
6.0 1.0 0.0
7.0 0.0 1.0
];
s1 = optimsimplex_setall ( s1 , newsimplex );
[ s1 , myobj ] = optimsimplex_shrink ( s1 , mycostf , data=myobj );
computed = optimsimplex_getall ( s1 );
// The function value at vertex #1 is not re-computed, as expected.
expected = [
   -12.    0.     0.   
    6.5    0.5    0.   
    26.    0.     0.5  
];
assert_equal ( computed , expected );
assert_equal ( myobj.nb , 2 );
s1 = optimsimplex_destroy ( s1 );


//
// Test with 5 vertices
//
s1 = optimsimplex_new ();
newsimplex = [
12.0 0.0 0.0
12.0 1.0 0.0
12.0 0.0 1.0
12.0 1.0 1.0
12.0 2.0 2.0
];
s1 = optimsimplex_setall ( s1 , newsimplex );
s1 = optimsimplex_shrink ( s1 , rosenbrock );
computed = optimsimplex_getall ( s1 );
// The function value at vertex #1 is not re-computed, as expected.
expected = [
    12.    0.     0.   
    6.5    0.5    0.   
    26.    0.     0.5  
    6.5    0.5    0.5  
    0.     1.     1.   
];
assert_equal ( computed , expected );
s1 = optimsimplex_destroy ( s1 );
