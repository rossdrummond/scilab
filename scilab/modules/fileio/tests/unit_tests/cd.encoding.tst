// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2009 - DIGITEO
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- JVM MANDATORY -->

tmp = cd(TMPDIR);

if MSDOS then
	unix_w(jre_path()+"\bin\java.exe -cp "+SCI+"\modules\localization\tests\unit_tests CreateDir");
else
	unix_w(jre_path()+"/bin/java -classpath "+SCI+"/modules/localization/tests/unit_tests CreateDir");
end

tab_ref = [
"世界您好",
"азеазея",
"ハロー・ワールド",
"เฮลโลเวิลด์",
"حريات وحقوق",
"프로그램",
"프로그램",
"תוכנית"];

for i = 1 : size(tab_ref,'*')
	sz = "dir_" + tab_ref(i);
	a = cd(sz);
	if (a <> (tmp + filesep() + sz)) then pause, end
	cd(TMPDIR);
end