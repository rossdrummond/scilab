// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008-2009 - INRIA - Michael Baudin
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt


//
// optimbase_get --
//   Get the value for the given key.
//   If the key is unknown, generates an error.
//   This command corresponds with options which are not 
//   available directly to the user interface, but are computed internally.
//
function value = optimbase_get (this,key)
  select key
  case "-funevals" then
    value = this.funevals;
  case "-iterations" then
    value = this.iterations;
  case "-xopt" then
    value = this.xopt;
  case "-fopt" then
    value = this.fopt;
  case "-historyxopt" then
    if this.storehistory == 0 then
      errmsg = sprintf("History disabled ; turn on -storehistory option.")
      error(errmsg)
    else
      value = this.historyxopt;
    end
  case "-historyfopt" then
    if this.storehistory == 0 then
      errmsg = sprintf("History disabled ; turn on -storehistory option.")
      error(errmsg)
    else
      value = this.historyfopt;
    end
  case "-fx0" then
    value = this.fx0;
  case "-status" then
    value = this.status;
  else
    errmsg = sprintf("Unknown key %s",key)
    error(errmsg)
  end
endfunction
