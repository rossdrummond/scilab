// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2009 - DIGITEO - Allan CORNET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
// <-- JVM NOT MANDATORY -->
// <-- NO CHECK ERROR OUTPUT -->
// =============================================================================
fprintf(0,'My error which is going to be displayed on the stderr');
fprintf(6,'My error which is going to be displayed on the stdout');
// =============================================================================
u=file('open',TMPDIR + filesep() + 'Fresults','unknown');
t=0:0.1:2*%pi;
for tk = t
  fprintf(u,'time = %6.3f value = %6.3f',tk,sin(tk));
end
file('close',u);

if fileinfo(TMPDIR + filesep() + 'Fresults') ==  [] then pause,end
// =============================================================================
fd = mopen(TMPDIR + filesep() + 'Cresults','wt');
t=0:0.1:2*%pi;
for tk = t
  fprintf(fd,'time = %6.3f value = %6.3f',tk,sin(tk));
end
mclose(fd);
if fileinfo(TMPDIR + filesep() + 'Fresults') ==  [] then pause,end
// =============================================================================
t=0:0.1:2*%pi;
for tk = t
  fprintf(TMPDIR + filesep() + 'results2','time = %6.3f value = %6.3f',tk,sin(tk));
end
if fileinfo(TMPDIR + filesep() + 'results2') ==  [] then pause,end
// =============================================================================
fprintf(6,"fprintf test 1:%s\n", "simple string");
// =============================================================================
fprintf(6,"fprintf test 2:%d\n", 42);
// =============================================================================
fprintf(6,"fprintf test 3:%f\n", 10.0/3);
// =============================================================================
fprintf(6,"fprintf test 4:%.10f\n", 10.0/3);
// =============================================================================
fprintf(6,"fprintf test 5:%-10.2f\n", 2.5);
// =============================================================================
fprintf(6,"fprintf test 6:%-010.2f\n", 2.5);
// =============================================================================
fprintf(6,"fprintf test 7:%010.2f\n", 2.5);
// =============================================================================
fprintf(6,"fprintf test 8:<%20s>\n", "foo");
// =============================================================================
fprintf(6,"fprintf test 9:<%-20s>\n", "bar");
// =============================================================================
fprintf(6,"fprintf test 10: 123456789012345\n");
// =============================================================================
fprintf(6,"fprintf test 11:<%15s>\n", "høyesterettsjustitiarius");
// =============================================================================
fprintf(6,"fprintf test 12: 123456789012345678901234567890\n");
// =============================================================================
fprintf(6,"fprintf test 13:<%30s>\n", "høyesterettsjustitiarius");
// =============================================================================
fprintf(6,"fprintf test 14:%5.2f\n", -12.34);
// =============================================================================
fprintf(6,"fprintf test 15:%5d\n", -12);
// =============================================================================
fprintf(6,"fprintf test 16:%x\n", 170);
// =============================================================================
fprintf(6,"fprintf test 17:%X\n", 170);
// =============================================================================
fprintf(6,"fprintf test 18:%.5s\n", "abcdefghij");
// =============================================================================
fprintf(6,"fprintf test 195:%-2s\n", "gazonk");
// =============================================================================
ierr = execstr('fprintf(6,5,5)','errcath');
if ierr <> 999 then pause,end
// =============================================================================
ierr = execstr('fprintf(1000,''%d'',5)','errcath');
if ierr <> 999 then pause,end
// =============================================================================
FILENAMES=[TMPDIR + filesep() + 'results1',TMPDIR + filesep() + 'results2'];
ierr = execstr('fprintf(FILENAMES,''%d'',5)','errcath');
if ierr <> 999 then pause,end
// =============================================================================
FMTS=["%s","%s"];
ierr = execstr('fprintf(6,FMTS,5)','errcath');
if ierr <> 999 then pause,end
// =============================================================================