// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2009 - DIGITEO - Allan CORNET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- JVM NOT MANDATORY -->

ierr = execstr("[a,b] = getenv(''SCI'');","errcatch");
if ierr <> 78 then pause,end

ierr = execstr("b = getenv();","errcatch");
if ierr <> 77 then pause,end

ierr = execstr("b = getenv(''SCI'');","errcatch");
if ierr <> 0 then pause,end

ierr = execstr("b = getenv(''SCI'',''NOK'');","errcatch");
if ierr <> 0 then pause,end
if b <> getenv('SCI') then pause,end

ierr = execstr("b = getenv('''',''NOK'');","errcatch");
if ierr <> 0 then pause,end
if b <> 'NOK' then pause,end

ierr = execstr("b = getenv(3,''NOK'');","errcatch");
if ierr <> 999 then pause,end

ierr = execstr("b = getenv(''NOK'',3);","errcatch");
if ierr <> 999 then pause,end

ierr = execstr("b = getenv(4,3);","errcatch");
if ierr <> 999 then pause,end
 
ierr = execstr("b = getenv(''FOO'');","errcatch");
if ierr <> 999 then pause,end
if getenv('FOO','foo')  <> 'foo' then pause,end