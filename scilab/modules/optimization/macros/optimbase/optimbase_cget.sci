// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008-2009 - INRIA - Michael Baudin
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt


//
// optimbase_cget --
//   Get the value for the given key.
//   If the key is unknown, generates an error.
//
function value = optimbase_cget (this,key)
  select key
  case "-verbose" then
    value = this.verbose;
  case "-verbosetermination" then
    value = this.verbosetermination;
  case "-function" then
    value = this.fun;
  case "-method" then
    value = this.method;
  case "-x0" then
    value = this.x0;
  case "-maxfunevals" then
    value = this.maxfunevals;
  case "-maxiter" then
    value = this.maxiter;
  case "-tolfunabsolute" then
    value = this.tolfunabsolute;
  case "-tolfunrelative" then
    value = this.tolfunrelative;
  case "-tolxabsolute" then
    value = this.tolxabsolute;
  case "-tolxrelative" then
    value = this.tolxrelative;
  case "-tolxmethod" then
    value = this.tolxmethod;
  case "-tolfunmethod" then
    value = this.tolfunmethod;
  case "-outputcommand" then
    value = this.outputcommand;
  case "-outputcommandarg" then
    value = this.outputcommandarg;
  case "-numberofvariables" then
    value = this.numberofvariables;
  case "-storehistory" then
    value = this.storehistory;
  case "-costfargument" then
    value = this.costfargument;
  case "-boundsmin" then
    value = this.boundsmin;
  case "-boundsmax" then
    value = this.boundsmax;
  case "-nbineqconst" then
    value = this.nbineqconst;
  else
    errmsg = sprintf("Unknown key %s",key)
    error(errmsg)
  end
endfunction