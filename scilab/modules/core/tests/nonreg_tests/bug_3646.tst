// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008 - DIGITEO - Allan CORNET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- Non-regression test for bug 3646 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=3646
//
// <-- Short Description -->
// Scilab 5.0.2 does not start after installation

if MSDOS then

  cd(TMPDIR);
  mkdir('Luk� B��l');
  path_directory = cd('Luk� B��l');
  // backup previous SCIHOME
  prv_SCIHOME = getenv('SCIHOME');
  prv_APPDATA = getenv('APPDATA');
  
  // undefine previous SCIHOME
  setenv('SCIHOME', '');
  
  // set APPDATA to find another SCIHOME
  setenv('APPDATA', path_directory);
  
  res = unix('wscilex -e quit');
  if res <> 0 then pause,end
  
  // restore previous env. variables
  setenv('SCIHOME',prv_SCIHOME);
  setenv('APPDATA',prv_APPDATA);

end