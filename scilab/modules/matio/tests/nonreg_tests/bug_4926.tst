// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2009 - DIGITEO - Vincent COUVERT <vincent.couvert@scilab.org>
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- Non-regression test for bug 4926 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=4926
//
// <-- Short Description -->
// Can not save a structure in a MAT-file using savematfile.

s.name = "NAME";
s.firstname = "FIRSTNAME";
s.age = 25;
s.address = "TOWN";
ierr = execstr("savematfile(TMPDIR + filesep() + ""bug_4926.tst"", ""s"")", "errcatch");
if ierr <> 0 then pause,end