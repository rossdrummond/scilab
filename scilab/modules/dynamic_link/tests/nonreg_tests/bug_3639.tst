// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008 - DIGITEO - Allan CORNET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- Non-regression test for bug 3639 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=3639
//
// <-- Short Description -->
// link without parameters can crash


test_path = get_absolute_file_path('bug_3639.tst');

currentpath = pwd();

cd TMPDIR;
cd ../;
OS_TMP_DIR = pwd();


mkdir(OS_TMP_DIR,'bug_3639');
TEST_DIR = OS_TMP_DIR + filesep() + 'bug_3639';

copyfile(SCI+'/modules/dynamic_link/tests/nonreg_tests/bug_3639.c' , TEST_DIR + filesep() + 'bug_3639.c');

chdir(TEST_DIR);

files=['bug_3639.o'];
ilib_build('libc_fun1',['c_sum1','c_intsum';'c_sub1','c_intsub'],files,[]);
copyfile('loader.sce','loader1.sce');

ilib_build('libc_fun2',['c_sum2','c_intsum';'c_sub2','c_intsub'],files,[]);


// disable message
warning_mode = warning('query');
warning('off');

// load the shared library 
info_link = link();
if info_link <> [] then pause,end

exec loader1.sce
info_link = link();
if info_link <> 'libc_fun1' then pause,end

exec loader.sce
info_link = link();
if or(info_link <> ['libc_fun2','libc_fun1']) then pause,end

// enable message 
warning(warning_mode);

chdir(currentpath);

// ulink() all libraries
ulink();
clearfun('c_sum1');
clearfun('c_sub1');
clearfun('c_sum2');
clearfun('c_sub2');

//remove TMP_DIR
rmdir(TEST_DIR,'s');
// =============================================================================