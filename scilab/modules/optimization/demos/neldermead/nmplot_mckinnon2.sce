// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008-2009 - INRIA - Michael Baudin
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt


//dirname = get_absolute_file_path('nmplot_mckinnon.sce');

//% MCKINNON computes the McKinnon function.
//
//  Discussion:
//
//    This function has a global minimizer:
//
//      X* = ( 0.0, -0.5 ), F(X*) = -0.25
//
//    There are three parameters, TAU, THETA and PHI.
//
//    1 < TAU, then F is strictly convex.
//             and F has continuous first derivatives.
//    2 < TAU, then F has continuous second derivatives.
//    3 < TAU, then F has continuous third derivatives.
//
//    However, this function can cause the Nelder-Mead optimization
//    algorithm to "converge" to a point which is not the minimizer
//    of the function F.
//
//    Sample parameter values which cause problems for Nelder-Mead 
//    include:
//
//      TAU = 1, THETA = 15, PHI =  10;
//      TAU = 2, THETA =  6, PHI =  60;
//      TAU = 3, THETA =  6, PHI = 400;
//
//    To get the bad behavior, we also assume the initial simplex has the form
//
//      X1 = (0,0),
//      X2 = (1,1),
//      X3 = (A,B), 
//
//    where 
//
//      A = (1+sqrt(33))/8 =  0.84307...
//      B = (1-sqrt(33))/8 = -0.59307...
//
//  Licensing:
//
//    This code is distributed under the GNU LGPL license.
//
//  Modified:
//
//    09 February 2008
//
//  Author:
//
//    John Burkardt
//
//  Reference:
//
//    Ken McKinnon,
//    Convergence of the Nelder-Mead simplex method to a nonstationary point,
//    SIAM Journal on Optimization,
//    Volume 9, Number 1, 1998, pages 148-158.
//
//  Parameters:
//
//    Input, real X(2), the argument of the function.
//
//    Output, real F, the value of the function at X.
//
// Copyright (C) 2009 - INRIA - Michael Baudin, Scilab port

function f = mckinnon3 ( x )

  if ( length ( x ) ~= 2 )
    error ( 'Error: function expects a two dimensional input\n' );
  end

  tau = 3.0;
  theta = 6.0;
  phi = 400.0;

  if ( x(1) <= 0.0 )
    f = theta * phi * abs ( x(1) ).^tau + x(2) * ( 1.0 + x(2) );
  else
    f = theta       *       x(1).^tau   + x(2) * ( 1.0 + x(2) );
  end
endfunction

lambda1 = (1.0 + sqrt(33.0))/8.0
lambda2 = (1.0 - sqrt(33.0))/8.0
coords0 = [
1.0 0.0 lambda1
1.0 0.0 lambda2
]


nm = nmplot_new ();
nm = nmplot_configure(nm,"-numberofvariables",2);
nm = nmplot_configure(nm,"-function",mckinnon3);
nm = nmplot_configure(nm,"-x0",[1.0 1.0]');
nm = nmplot_configure(nm,"-maxiter",200);
nm = nmplot_configure(nm,"-maxfunevals",300);
nm = nmplot_configure(nm,"-tolsimplexizerelative",1.e-6);
nm = nmplot_configure(nm,"-simplex0method","given");
nm = nmplot_configure(nm,"-coords0",coords0);
nm = nmplot_configure(nm,"-simplex0length",1.0);
nm = nmplot_configure(nm,"-method","variable");
nm = nmplot_configure(nm,"-verbose",0);
nm = nmplot_configure(nm,"-verbosetermination",0);
nm = nmplot_configure(nm,"-kelleystagnationflag",1);
nm = nmplot_configure(nm,"-restartflag",1);
nm = nmplot_configure(nm,"-restartdetection","kelley");
//
// Setup output files
//
nm = nmplot_configure(nm,"-simplexfn","mckinnon.history.restart.simplex.txt");
nm = nmplot_configure(nm,"-fbarfn","mckinnon.history.restart.fbar.txt");
nm = nmplot_configure(nm,"-foptfn","mckinnon.history.restart.fopt.txt");
nm = nmplot_configure(nm,"-sigmafn","mckinnon.history.restart.sigma.txt");
//
// Perform optimization
//
nm = nmplot_search(nm);
//
// Plot
//
[nm , xdata , ydata , zdata ] = nmplot_contour ( nm , xmin = -0.2 , xmax = 2.0 , ymin = -2.0 , ymax = 2.0 , nx = 100 , ny = 100 );
f = scf();
xset("fpf"," ")
contour ( xdata , ydata , zdata , 40 )
nmplot_simplexhistory ( nm );
xs2png(0,"mckinnon.history.restart.simplex.png");
f = scf();
nmplot_historyplot ( nm , "mckinnon.history.restart.fbar.txt" , ...
  mytitle = "Function Value Average" , myxlabel = "Iterations" );
xs2png(1,"mckinnon.history.restart.fbar.png");
f = scf();
nmplot_historyplot ( nm , "mckinnon.history.restart.fopt.txt" , ...
  mytitle = "Minimum Function Value" , myxlabel = "Iterations" );
xs2png(2,"mckinnon.history.restart.fopt.png");
f = scf();
nmplot_historyplot ( nm , "mckinnon.history.restart.sigma.txt" , ...
  mytitle = "Maximum Oriented length" , myxlabel = "Iterations" );
xs2png(3,"mckinnon.history.restart.sigma.png");
deletefile("mckinnon.history.restart.simplex.txt");
deletefile("mckinnon.history.restart.fbar.txt");
deletefile("mckinnon.history.restart.fopt.txt");
deletefile("mckinnon.history.restart.sigma.txt");
nm = nmplot_destroy(nm);

