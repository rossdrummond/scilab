// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2009 - DIGITEO - Pierre MARECHAL <pierre.marechal@scilab.org>
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- JVM NOT MANDATORY -->
load("SCI/modules/atoms/macros/atoms_internals/lib");

if atomsVersionCompare("5.1"        ,"5.1.0")     <> 0 then pause, end
if atomsVersionCompare("5.1.0"      ,"5.1")       <> 0 then pause, end
if atomsVersionCompare("5.1.00000"  ,"5.1.0.0")   <> 0 then pause, end
if atomsVersionCompare("5.1.0.0"    ,"5.1.00000") <> 0 then pause, end

if atomsVersionCompare("5.1.0","5.1.2") <> -1 then pause, end
if atomsVersionCompare("5.1.2","5.1.0") <>  1 then pause, end

if atomsVersionCompare("10.0","2.6.9") <> 1 then pause, end