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

// 1. Test with a scalar function
function y = myfunction (x)
  y = x*x;
endfunction

x = 1.0;
expected = 2.0;
// 1.1 With default parameters
computed = derivative(myfunction,x);
assert_close ( computed , expected , 1.e-11 );
// 1.2 Test order 1
computed = derivative(myfunction,x,order=1);
assert_close ( computed , expected , 1.e-8 );
// 1.3 Test order 2
computed = derivative(myfunction,x,order=2);
assert_close ( computed , expected , 1.e-11 );
// 1.4 Test order 4
computed = derivative(myfunction,x,order=4);
assert_close ( computed , expected , %eps );

// 1.5 Compute second derivative at the same time
Jexpected = 2.0;
Hexpected = 2.0;
[Jcomputed , Hcomputed] = derivative(myfunction,x);
assert_close ( Jcomputed , Jexpected , 1.e-11 );
assert_close ( Hcomputed , Hexpected , %eps );
// 1.6 Test order 1
[Jcomputed , Hcomputed] = derivative(myfunction,x,order=1);
assert_close ( Jcomputed , Jexpected , 1.e-8 );
assert_close ( Hcomputed , Hexpected , 1.e-6 );
// 1.7 Test order 2
[Jcomputed , Hcomputed] = derivative(myfunction,x,order=2);
assert_close ( Jcomputed , Jexpected , 1.e-11 );
assert_close ( Hcomputed , Hexpected , %eps );
// 1.8 Test order 4
[Jcomputed , Hcomputed] = derivative(myfunction,x,order=4);
assert_close ( Jcomputed , Jexpected , %eps );
assert_close ( Hcomputed , Hexpected , 1.e-11 );

// 2. Test with a vector function
function y = myfunction2 (x)
  y = x(1)*x(1) + x(2)+ x(1)*x(2);
endfunction
x = [1.0 
2.0];
expected = [4.0 2.0];
// 2.1 With default parameters
computed = derivative(myfunction2,x);
assert_close ( computed , expected , 1.e-10 );
// 2.2 Test order 1
computed = derivative(myfunction2,x,order=1);
assert_close ( computed , expected , 1.e-8 );
// 2.3 Test order 2
computed = derivative(myfunction2,x,order=2);
assert_close ( computed , expected , 1.e-10 );
// 2.4 Test order 4
computed = derivative(myfunction2,x,order=4);
assert_close ( computed , expected , %eps );

// 2.5 Compute second derivative at the same time
Jexpected = [4.0 2.0];
Hexpected = [2.0 1.0 1.0 0];
[Jcomputed , Hcomputed] = derivative(myfunction2,x);
assert_close ( Jcomputed , Jexpected , 1.e-10 );
assert_close ( Hcomputed , Hexpected , %eps );
// 2.6 Test order 1
[Jcomputed , Hcomputed] = derivative(myfunction2,x,order=1);
assert_close ( Jcomputed , Jexpected , 1.e-8 );
assert_close ( Hcomputed , Hexpected , 1.e-5 );
// 2.7 Test order 2
[Jcomputed , Hcomputed] = derivative(myfunction2,x,order=2);
assert_close ( Jcomputed , Jexpected , 1.e-10 );
assert_close ( Hcomputed , Hexpected , %eps );
// 2.8 Test order 4
[Jcomputed , Hcomputed] = derivative(myfunction2,x,order=4);
assert_close ( Jcomputed , Jexpected , %eps );
assert_close ( Hcomputed , Hexpected , 1.e-10 );

// 3. Test H_form
// 3.1 Test H_form="default"
Jexpected = [4.0 2.0];
Hexpected = [2.0 1.0 1.0 0.0];
[Jcomputed , Hcomputed] = derivative(myfunction2 , x , H_form="default");
assert_close ( Jcomputed , Jexpected , 1.e-10 );
assert_close ( Hcomputed , Hexpected , %eps );
// 3.2 Test H_form='hypermat'
Jexpected = [4.0 2.0];
Hexpected = [2.0 1.0
1.0 0.0];
[Jcomputed , Hcomputed] = derivative(myfunction2 , x , H_form='hypermat');
assert_close ( Jcomputed , Jexpected , 1.e-10 );
assert_close ( Hcomputed , Hexpected , %eps );
// 3.3 Test H_form='hypermat'
Jexpected = [4.0 2.0];
Hexpected = [2.0 1.0 
1.0 0.0];
[Jcomputed , Hcomputed] = derivative(myfunction2 , x , H_form='hypermat');
assert_close ( Jcomputed , Jexpected , 1.e-10 );
assert_close ( Hcomputed , Hexpected , %eps );

// 4. Test verbose
[Jcomputed , Hcomputed] = derivative(myfunction2 , x , verbose = 1);

// 5. Test h parameter
// Test a case where the default step h is very small ~ 1.e-9,
// but, because the function is very flat in the neighbourhood of the 
// point, a larger step ~ 1.e-4 reduces the error.
// This means that this test cannot pass if the right step is 
// not taken into account, therefore testing the feature "h is used correctly".
myn = 1.e5;
function y = myfunction3 (x)
  y = x^(2/myn);
endfunction
x = 1.0;
h = 6.055454e-006
Jexpected = (2/myn) * x^(2/myn-1);
Hexpected = (2/myn) * (2/myn-1) * x^(2/myn-2);
[Jcomputed , Hcomputed] = derivative(myfunction3 , x , h = 1.e-4 , order = 1 );
assert_close ( Jcomputed , Jexpected , 1.e-4 );
assert_close ( Hcomputed , Hexpected , 1.e-3 );

// 6. Test Q parameter
// TODO !
