// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008 - INRIA
// Copyright (C) 2009 - DIGITEO
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- ENGLISH IMPOSED -->
ilib_verbose(0);

exec(fullfile(SCI,'modules','xcos','tests','unit_tests','PENDULUM_ANIM.sci'));
exec(fullfile(SCI,'modules','xcos','tests','unit_tests','anim_pen.sci'));
importXcosDiagram(fullfile(SCI,'modules','xcos','tests','unit_tests','pendulum_anim45.xcos'));
M=10;
m=3;
l=3;
ph=0.1;
for i=1:length(scs_m.objs)
  if typeof(scs_m.objs(i))=='Block' then
    if scs_m.objs(i).gui=='SUPER_f' then
      scs_m = scs_m.objs(i).model.rpar;
      break;
    end
  end
end 
//scs_m = scs_m.objs(5).model.rpar;
[X,U,Y,XP] = steadycos(scs_m,[],[],[],[],1,1:$);
sys = lincos(scs_m,X,U);
