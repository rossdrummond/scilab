mode(-1)
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) INRIA, Serge Steer
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

// Maple code used to create reference

// Digits := 40:
// writeto("cscd.ref"); interface(prettyprint = 0):
// for i from 0 to 360 do if ((i<>0) and (i~=180) and (i~=360)) then print(-180+i, evalf[30](csc(-Pi+i*Pi/180), 30)) end end do; 
// writeto(terminal);
ieee(2);
pi=%pi;eps=%eps;Inf=%inf;NaN=%nan; //used to make following code runnable under Matlab

ref=[-179, -57.2986884985501834766126837351
-178, -28.6537083478438211365216382162
-177, -19.1073226092973979922961125616
-176, -14.3355870262036756406284559734
-175, -11.4737132456698551291492250358
-174, -9.56677223350562613372277727945
-173, -8.20550904812507833001991867581
-172, -7.18529653432771916189748720396
-171, -6.39245322149966154704221573407
-170, -5.75877048314363353621643710929
-169, -5.24084306416784875135543656705
-168, -4.80973434474413069609773691753
-167, -4.44541148258580103920857343490
-166, -4.13356549443874930747994626551
-165, -3.86370330515627314699897279892
-164, -3.62795527854330009753434191853
-163, -3.42030361983326865551180347723
-162, -3.23606797749978969640917366873
-161, -3.07155348675724235674832103818
-160, -2.92380440016308725223275441337
-159, -2.79042810962533591050431439049
-158, -2.66946716255401430948320747106
-157, -2.55930466524745219706802494981
-156, -2.45859333557423817942291309899
-155, -2.36620158315249851793367832620
-154, -2.28117203270485932864715668402
-153, -2.20268926458526662156295617055
-152, -2.13005446818951270398487753363
-151, -2.06266533962731421925878556929
-150, -2.
-149, -1.94160402641035637581583356145
-148, -1.88707991479985829536949114391
-147, -1.83607845877666314907100667726
-146, -1.78829164997140061052169910815
-145, -1.74344679562109801983768341673
-144, -1.70130161670407986436308099413
-143, -1.66164014112248320311482464970
-142, -1.62426924548274402226829568696
-141, -1.58901572906574944232778021955
-140, -1.55572382686041232005635595464
-139, -1.52425308670581424232102105808
-138, -1.49447654986460866611493037227
-137, -1.46627918563962492471078000564
-136, -1.43955653962572631828118069483
-135, -1.41421356237309504880168872421
-134, -1.39016359101667878798155936264
-133, -1.36732746109859529527321386803
-132, -1.34563272960637610904284423453
-131, -1.32501299334881135094544743202
-130, -1.30540728933227860459313349292
-129, -1.28675956589316733108672315286
-128, -1.26901821507257881983606109858
-127, -1.25213565815622566143108442816
-126, -1.23606797749978969640917366873
-125, -1.22077458876145606833458806426
-124, -1.20621794850390538021837673384
-123, -1.19236329283594745598731818292
-122, -1.17917840336209642760127392029
-121, -1.16663339721533049248125312741
-120, -1.15470053837925152901829756101
-119, -1.14335406787331999220559917761
-118, -1.13257005068903916295458029820
-117, -1.12232623763436080715678354235
-116, -1.11260194047518893255362195457
-115, -1.10337791896249175648689470334
-114, -1.09463627850604674090442994196
-113, -1.08636037740529625993805993245
-112, -1.07853474267758344346480900558
-111, -1.07114499363702901344007037528
-110, -1.06417777247591214080957060222
-109, -1.05762068118667065508786396731
-108, -1.05146222423826721205133816970
-107, -1.04569175648714800749844664425
-106, -1.04029943586160209711671451135
-105, -1.03527618041008304939559535050
-104, -1.03061362934989808868698990977
-103, -1.02630410779339158696241402430
-102, -1.02234059486502927329658303481
-101, -1.01871669495521423110738754753
-100, -1.01542661188574498523421768499
-99, -1.01246512578800293136174398299
-98, -1.00982757251861810903821333214
-97, -1.00750982545884835986263847367
-96, -1.00550827956351640763197958403
-95, -1.00381983754334738958457569145
-94, -1.00244189808117211927910668775
-93, -1.00137234599792097654873089884
-92, -1.00060954429882177645842992547
-91, -1.00015232804390766542842643421
-90, -1.
-89, -1.00015232804390766542842643421
-88, -1.00060954429882177645842992547
-87, -1.00137234599792097654873089884
-86, -1.00244189808117211927910668775
-85, -1.00381983754334738958457569145
-84, -1.00550827956351640763197958403
-83, -1.00750982545884835986263847367
-82, -1.00982757251861810903821333214
-81, -1.01246512578800293136174398299
-80, -1.01542661188574498523421768499
-79, -1.01871669495521423110738754753
-78, -1.02234059486502927329658303481
-77, -1.02630410779339158696241402430
-76, -1.03061362934989808868698990977
-75, -1.03527618041008304939559535050
-74, -1.04029943586160209711671451135
-73, -1.04569175648714800749844664425
-72, -1.05146222423826721205133816970
-71, -1.05762068118667065508786396731
-70, -1.06417777247591214080957060222
-69, -1.07114499363702901344007037528
-68, -1.07853474267758344346480900558
-67, -1.08636037740529625993805993245
-66, -1.09463627850604674090442994196
-65, -1.10337791896249175648689470334
-64, -1.11260194047518893255362195457
-63, -1.12232623763436080715678354235
-62, -1.13257005068903916295458029820
-61, -1.14335406787331999220559917761
-60, -1.15470053837925152901829756101
-59, -1.16663339721533049248125312741
-58, -1.17917840336209642760127392029
-57, -1.19236329283594745598731818292
-56, -1.20621794850390538021837673384
-55, -1.22077458876145606833458806426
-54, -1.23606797749978969640917366873
-53, -1.25213565815622566143108442816
-52, -1.26901821507257881983606109858
-51, -1.28675956589316733108672315286
-50, -1.30540728933227860459313349292
-49, -1.32501299334881135094544743202
-48, -1.34563272960637610904284423453
-47, -1.36732746109859529527321386803
-46, -1.39016359101667878798155936264
-45, -1.41421356237309504880168872421
-44, -1.43955653962572631828118069483
-43, -1.46627918563962492471078000564
-42, -1.49447654986460866611493037227
-41, -1.52425308670581424232102105808
-40, -1.55572382686041232005635595464
-39, -1.58901572906574944232778021955
-38, -1.62426924548274402226829568696
-37, -1.66164014112248320311482464970
-36, -1.70130161670407986436308099413
-35, -1.74344679562109801983768341673
-34, -1.78829164997140061052169910815
-33, -1.83607845877666314907100667726
-32, -1.88707991479985829536949114391
-31, -1.94160402641035637581583356145
-30, -2.
-29, -2.06266533962731421925878556929
-28, -2.13005446818951270398487753363
-27, -2.20268926458526662156295617055
-26, -2.28117203270485932864715668402
-25, -2.36620158315249851793367832620
-24, -2.45859333557423817942291309899
-23, -2.55930466524745219706802494981
-22, -2.66946716255401430948320747106
-21, -2.79042810962533591050431439049
-20, -2.92380440016308725223275441337
-19, -3.07155348675724235674832103818
-18, -3.23606797749978969640917366873
-17, -3.42030361983326865551180347723
-16, -3.62795527854330009753434191853
-15, -3.86370330515627314699897279892
-14, -4.13356549443874930747994626551
-13, -4.44541148258580103920857343490
-12, -4.80973434474413069609773691753
-11, -5.24084306416784875135543656705
-10, -5.75877048314363353621643710929
-9, -6.39245322149966154704221573407
-8, -7.18529653432771916189748720396
-7, -8.20550904812507833001991867581
-6, -9.56677223350562613372277727945
-5, -11.4737132456698551291492250358
-4, -14.3355870262036756406284559734
-3, -19.1073226092973979922961125616
-2, -28.6537083478438211365216382162
-1, -57.2986884985501834766126837351
1, 57.2986884985501834766126837351
2, 28.6537083478438211365216382162
3, 19.1073226092973979922961125616
4, 14.3355870262036756406284559734
5, 11.4737132456698551291492250358
6, 9.56677223350562613372277727945
7, 8.20550904812507833001991867581
8, 7.18529653432771916189748720396
9, 6.39245322149966154704221573407
10, 5.75877048314363353621643710929
11, 5.24084306416784875135543656705
12, 4.80973434474413069609773691753
13, 4.44541148258580103920857343490
14, 4.13356549443874930747994626551
15, 3.86370330515627314699897279892
16, 3.62795527854330009753434191853
17, 3.42030361983326865551180347723
18, 3.23606797749978969640917366873
19, 3.07155348675724235674832103818
20, 2.92380440016308725223275441337
21, 2.79042810962533591050431439049
22, 2.66946716255401430948320747106
23, 2.55930466524745219706802494981
24, 2.45859333557423817942291309899
25, 2.36620158315249851793367832620
26, 2.28117203270485932864715668402
27, 2.20268926458526662156295617055
28, 2.13005446818951270398487753363
29, 2.06266533962731421925878556929
30, 2.
31, 1.94160402641035637581583356145
32, 1.88707991479985829536949114391
33, 1.83607845877666314907100667726
34, 1.78829164997140061052169910815
35, 1.74344679562109801983768341673
36, 1.70130161670407986436308099413
37, 1.66164014112248320311482464970
38, 1.62426924548274402226829568696
39, 1.58901572906574944232778021955
40, 1.55572382686041232005635595464
41, 1.52425308670581424232102105808
42, 1.49447654986460866611493037227
43, 1.46627918563962492471078000564
44, 1.43955653962572631828118069483
45, 1.41421356237309504880168872421
46, 1.39016359101667878798155936264
47, 1.36732746109859529527321386803
48, 1.34563272960637610904284423453
49, 1.32501299334881135094544743202
50, 1.30540728933227860459313349292
51, 1.28675956589316733108672315286
52, 1.26901821507257881983606109858
53, 1.25213565815622566143108442816
54, 1.23606797749978969640917366873
55, 1.22077458876145606833458806426
56, 1.20621794850390538021837673384
57, 1.19236329283594745598731818292
58, 1.17917840336209642760127392029
59, 1.16663339721533049248125312741
60, 1.15470053837925152901829756101
61, 1.14335406787331999220559917761
62, 1.13257005068903916295458029820
63, 1.12232623763436080715678354235
64, 1.11260194047518893255362195457
65, 1.10337791896249175648689470334
66, 1.09463627850604674090442994196
67, 1.08636037740529625993805993245
68, 1.07853474267758344346480900558
69, 1.07114499363702901344007037528
70, 1.06417777247591214080957060222
71, 1.05762068118667065508786396731
72, 1.05146222423826721205133816970
73, 1.04569175648714800749844664425
74, 1.04029943586160209711671451135
75, 1.03527618041008304939559535050
76, 1.03061362934989808868698990977
77, 1.02630410779339158696241402430
78, 1.02234059486502927329658303481
79, 1.01871669495521423110738754753
80, 1.01542661188574498523421768499
81, 1.01246512578800293136174398299
82, 1.00982757251861810903821333214
83, 1.00750982545884835986263847367
84, 1.00550827956351640763197958403
85, 1.00381983754334738958457569145
86, 1.00244189808117211927910668775
87, 1.00137234599792097654873089884
88, 1.00060954429882177645842992547
89, 1.00015232804390766542842643421
90, 1.
91, 1.00015232804390766542842643421
92, 1.00060954429882177645842992547
93, 1.00137234599792097654873089884
94, 1.00244189808117211927910668775
95, 1.00381983754334738958457569145
96, 1.00550827956351640763197958403
97, 1.00750982545884835986263847367
98, 1.00982757251861810903821333214
99, 1.01246512578800293136174398299
100, 1.01542661188574498523421768499
101, 1.01871669495521423110738754753
102, 1.02234059486502927329658303481
103, 1.02630410779339158696241402430
104, 1.03061362934989808868698990977
105, 1.03527618041008304939559535050
106, 1.04029943586160209711671451135
107, 1.04569175648714800749844664425
108, 1.05146222423826721205133816970
109, 1.05762068118667065508786396731
110, 1.06417777247591214080957060222
111, 1.07114499363702901344007037528
112, 1.07853474267758344346480900558
113, 1.08636037740529625993805993245
114, 1.09463627850604674090442994196
115, 1.10337791896249175648689470334
116, 1.11260194047518893255362195457
117, 1.12232623763436080715678354235
118, 1.13257005068903916295458029820
119, 1.14335406787331999220559917761
120, 1.15470053837925152901829756101
121, 1.16663339721533049248125312741
122, 1.17917840336209642760127392029
123, 1.19236329283594745598731818292
124, 1.20621794850390538021837673384
125, 1.22077458876145606833458806426
126, 1.23606797749978969640917366873
127, 1.25213565815622566143108442816
128, 1.26901821507257881983606109858
129, 1.28675956589316733108672315286
130, 1.30540728933227860459313349292
131, 1.32501299334881135094544743202
132, 1.34563272960637610904284423453
133, 1.36732746109859529527321386803
134, 1.39016359101667878798155936264
135, 1.41421356237309504880168872421
136, 1.43955653962572631828118069483
137, 1.46627918563962492471078000564
138, 1.49447654986460866611493037227
139, 1.52425308670581424232102105808
140, 1.55572382686041232005635595464
141, 1.58901572906574944232778021955
142, 1.62426924548274402226829568696
143, 1.66164014112248320311482464970
144, 1.70130161670407986436308099413
145, 1.74344679562109801983768341673
146, 1.78829164997140061052169910815
147, 1.83607845877666314907100667726
148, 1.88707991479985829536949114391
149, 1.94160402641035637581583356145
150, 2.
151, 2.06266533962731421925878556929
152, 2.13005446818951270398487753363
153, 2.20268926458526662156295617055
154, 2.28117203270485932864715668402
155, 2.36620158315249851793367832620
156, 2.45859333557423817942291309899
157, 2.55930466524745219706802494981
158, 2.66946716255401430948320747106
159, 2.79042810962533591050431439049
160, 2.92380440016308725223275441337
161, 3.07155348675724235674832103818
162, 3.23606797749978969640917366873
163, 3.42030361983326865551180347723
164, 3.62795527854330009753434191853
165, 3.86370330515627314699897279892
166, 4.13356549443874930747994626551
167, 4.44541148258580103920857343490
168, 4.80973434474413069609773691753
169, 5.24084306416784875135543656705
170, 5.75877048314363353621643710929
171, 6.39245322149966154704221573407
172, 7.18529653432771916189748720396
173, 8.20550904812507833001991867581
174, 9.56677223350562613372277727945
175, 11.4737132456698551291492250358
176, 14.3355870262036756406284559734
177, 19.1073226092973979922961125616
178, 28.6537083478438211365216382162
179, 57.2986884985501834766126837351
];
//diff(csc(x*(1+e)), e) = -csc(x*(1+e))*cot(x*(1+e))*x
x=ref(:,1);
if max(abs((cscd(x)-ref(:,2))./(cotg(x*%pi/180).*x.*cscd(x))))*180/pi>20*eps then pause,end
if max(abs((ref(:,2)-cscd(x))./ref(:,2)))>10*eps then pause,end

x=ref(:,1)+2^6*360;
if max(abs((cscd(x)-ref(:,2))./(cotg(x*%pi/180).*x.*cscd(x))))*180/pi>20*eps then pause,end
if max(abs((ref(:,2)-cscd(x))./ref(:,2)))>10*eps then pause,end


x=ref(:,1)+2^10*360; 
if max(abs((cscd(x)-ref(:,2))./(cotg(x*%pi/180).*x.*cscd(x))))*180/pi>20*eps then pause,end
if max(abs((ref(:,2)-cscd(x))./ref(:,2)))>10*eps then pause,end

if cscd(0)<>Inf then pause,end
if cscd(-180)<>-Inf then pause,end

if ~isnan(cscd(-Inf)) then pause,end
if ~isnan(cscd(Inf)) then pause,end
if ~isnan(cscd(NaN)) then pause,end

if cscd([])<>[] then pause,end
