// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2009 - Digiteo - Michael Baudin
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
// val = optimget ( options , key )
//
op = optimset ();
op = optimset(op,'TolX',1.e-12);
val = optimget(op,'TolX');
assert_equal ( val , 1.e-12 );

// 
// val = optimget ( options , key , value ) with non-empty value
//
op = optimset ();
op = optimset(op,'TolX',1.e-12);
val = optimget(op,'TolX' , 1.e-5);
assert_equal ( val , 1.e-12 );
// 
// val = optimget ( options , key , value ) with empty value
//
op = optimset ();
val = optimget(op,'TolX' , 1.e-5);
assert_equal ( val , 1.e-5 );

// 
// val = optimget ( options , key ) with ambiguous key
//
op = optimset ();
op = optimset(op,'TolX',1.e-12);
cmd = "optimget(op,''Tol'' )";
execstr(cmd,"errcatch");
computed = lasterror();
expected = "optimget: Ambiguous property name Tol matches several fields : TolFun TolX";
assert_equal ( computed , expected );

//
// Test with wrong number of arguments
//
op = optimset ();
cmd = "optimget ( op )";
execstr(cmd,"errcatch");
computed = lasterror();
expected = "optimget: Wrong number of arguments : 2 expected while 1 given";
assert_equal ( computed , expected );

//
// Test with wrong number of arguments
//
op = optimset ();
cmd = "optimget ( op , ""TolX"" , 1.e-12 , 1.e-13)";
execstr(cmd,"errcatch");
computed = lasterror();
expected = "optimget: Wrong number of arguments : 2 expected while 4 given";
assert_equal ( computed , expected );
// 
// val = optimget ( options , key ) with leading characters only
//
op = optimset ();
op = optimset ( op , 'MaxFunEvals' , 1000 );
val = optimget ( op , 'MaxF' );
assert_equal ( val , 1000 );
