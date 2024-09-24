libname test 'C:\sas';

data new_C; set test.C;
rename sex=gender;
run;

data all; set test.A test.B test.C;
BMI=(weight)/((height/100)**2);
BMi=INT(BMI*1000+0.5)/1000;

if bmi<19 then body='ÀúÃ¼Áß';
else if bmi<25 then body='Á¤»óÃ¼Áß';
else body='°úÃ¼Áß';
run;

data sp; set test.sports;
if 4<=x1 then G1='high';
if 1<=x1<=3 then G1='low';
if x2 in (4,5) then G2='HIGH';
if x2 in (1,3) then G2='LOW';
run;

proc sort data=sp; by gender;
proc print data=sp;
by gender; var x1 x2;
where age<30; run;

proc freq data=sp;
tables G1 G2 G1*G2/nocol;
run;

data sp_freq;
input G1$ G2$ freq;
cards;
high high 4
high low 3
low high 0
low low 2
; run;

proc freq data=sp_freq;
tables g1 g2 g1*g2; weight freq;
run;

proc means data=sp;
class gender; var age x1 x2; run;

proc means data= sp maxdec=3 max min;
class gender; var age x1 x2;
output out=sp_out;
run;

proc univariate data=sp ;run;

proc univariate data=sp FREQ plot; var x1 x2;
proc univariate data=sp normal mu0=3.5; var x1 x2;
proc univariate data=sp cibasic alpha=0.1; var mean;
run;

proc univariate data=sp FREQ plot normal mu0=3.5 cibasic alpha=0.1; var x1 x2;
run;


proc univariate data= sp noprint;
class gender; var x1 x2; output out=OO MEAN=M1 M2 STD= s1 s2;

data standard; merge SP OO; by gender;
Z1=(x1-m1)/s1;
Z2=(x2-m2)/s2;
drop m1 m2 s1 s2;
run; 

proc univariate data= sp; var x1 x2; histogram;
run;

proc univariate data=sp noprint;
histogram age /midpoints=17.5 to 42.5 by 5;
run;




data new_score; set test.score;
run;
proc sort data=new_score;
by joy descending diff;
proc means data=new_score max;
class joy; var DIFF; run;

proc means data=new_score;
var DIFF; 
output out=NS mean=m std=s;
run;

data s; set test.score; A=1;
data NS; set NS; A=1;
DATA s; merge s NS; BY A;
zdiff=(diff-m)/s; drop _type_ _freq_ A m s;
if math_joy=. then zdiff=.;
run;




proc univariate data=s normal alpha=0.1 mu0=65 plot;
var mean;
histogram mean/midporints=40 to 95 by 5;
run;



proc freq data=s;
tables sex_MF*joy; run;
