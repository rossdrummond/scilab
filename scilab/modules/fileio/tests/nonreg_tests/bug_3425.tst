// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2007-2008 - INRIA - Serge STEER <serge.steer@inria.fr>
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- Non-regression test for bug 2453 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=2453
//
// <-- Short Description -->
//     -->mgetstr()
//               !--error 77
//     mgetstr: Mauvais nombre d'argument(s) d'entrée: 1 à 3 attendu.
//
//     and in the doc:
//         str=mgetstr(n [,fd] )
//
//     what is the third ?

if execstr("mgetstr()","errcatch") == 0 then pause,end
if lasterror() <> gettext("mgetstr: Wrong number of input argument(s): 1 to 2 expected.") then pause,end