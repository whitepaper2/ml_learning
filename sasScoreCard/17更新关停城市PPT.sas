/*验证集、测试集与关停城市匹配*/
proc contents data=f15.city_still_run_1030;run;
data lf.city_still_run_1030;
	set f15.city_still_run_1030;
	length city $ 60;
	city = city_on;
run;


%macro updateWoeBySample(runData,newmonth, newmonth2);
data lf.a0702_&runData._woe;
	set lf.a0701_test_woe_&newmonth. lf.a0701_test_woe_&newmonth2. ;
run;
proc sort data=lf.city_still_run_1030;by city;run;
proc sort data=lf.a0702_&runData._woe;by city;run;
data lf.a0702_&runData._in_woe lf.a0702_&runData._out_woe;
	merge lf.a0702_&runData._woe(in=a) lf.city_still_run_1030(in=b);
	by city;
	if a=1 and b=1 then output lf.a0702_&runData._in_woe;
	if a=1 and b=0 then output lf.a0702_&runData._out_woe;
run;
proc sql;
	select state_month_cha,sum(target) as bad,count(1) as total,sum(target)/count(1) as badrate 
	from lf.a0702_&runData._in_woe group by state_month_cha;
	select state_month_cha,sum(target) as bad,count(1) as total,sum(target)/count(1) as badrate 
	from lf.a0702_&runData._out_woe group by state_month_cha;
run;
%mend;
%let newmonth=1709;%let newmonth2=1710;
%let runData=update; %updateWoeBySample(&runData,&newmonth,&newmonth2);

%macro updateWoeByCity(iscity);
	/*拆分update集,对test分月份打分*/
	data lf.a0702_test_&iscity._woe_1709 lf.a0702_test_&iscity._woe_1710;
	  set lf.a0702_update_&iscity._woe;
	  if state_month_cha = '1709' then output lf.a0702_test_&iscity._woe_1709;
	  if state_month_cha = '1710' then output lf.a0702_test_&iscity._woe_1710;
	run;
%mend;
%let iscity=in;%updateWoeByCity(&iscity);
%let iscity=out;%updateWoeByCity(&iscity);

data lf.a1002_udfvardic;
	format variable $32.;
	input variable;
	datalines;
KPTP_b
ACTUALPAYFINECNT_b
INCM_TIMES_b
CITY_b
PERSON_APP_AGE_b
RECENT_CONTACT_DAY_b
REJ_COUNT_b
CREDIT_AMOUNT_b
MAX_SEQ_DUEDAYS_b
person_sex_b
;
run;
/*没做模型之前,使用该数据集计算变量稳定性,两者相同*/
%macro update_ssi(iscity,newmonth,newmonth2);
%let model_coef = lf.a1002_udfvardic; 
%let train_data = lf.a0702_train_woe;

data lf.a0702_&iscity._woe_&newmonth.;set lf.a0702_test_&iscity._woe_&newmonth.;run;
%let test_data = lf.a0702_&iscity._woe_&newmonth.;
%totalssi(&train_data.,&test_data.,&model_coef.);

data lf.a0702_&iscity._woe_&newmonth2.;set lf.a0702_test_&iscity._woe_&newmonth2.;run;
%let test_data = lf.a0702_&iscity._woe_&newmonth2.;
%totalssi(&train_data.,&test_data.,&model_coef.);
data lf.updatessi_&iscity.;
set 
	lf.a0702_&iscity._woe_&newmonth._var_SSI
	lf.a0702_&iscity._woe_&newmonth2._var_SSI;
run;
%mend;
%let newmonth=1709;%let newmonth2=1710;
%let iscity=in;%update_ssi(&iscity,&newmonth,&newmonth2);
%let iscity=out;%update_ssi(&iscity,&newmonth,&newmonth2);

%macro scoreAll(inmodel,outdata,out);
	proc logistic inmodel=&inmodel;
	  score data=&outdata out=&out;
	run;
	proc freq data=&out;
	  tables F_target*I_target ;
	run;
	data &out(rename=(P_1=pred_target));
	  set &out;
	  I_target2 = I_target*1;
	  target = F_target*1;
	run;
%mend;
/****************************计算评估指标**************************************/
%macro measurement(DSin, ProbVar, DVVar, DSKS, KS,DSROC, cStat,Cutoff, DSCM,id,MeasureTab,DSLorenz,Gini);
	%KSStat(&DSin, &ProbVar, &DVVar, &DSKS, KS);
	%ROC(&DSin, &ProbVar, &DVVar, &DSROC, cStat);
	%ConfMat(&DSin, &ProbVar, &DVVar, &Cutoff, &DSCM);
	%GiniStat(&DSin, &ProbVar, &DVVar, &DSLorenz, Gini);
	data &MeasureTab;
		id=&id;
		set &DSCM;/*p166 2*2混淆矩阵*/
		Accuracy =(TN+TP)/Ntotal;/*准确率*/
		Precision=TP/(TP+FP)    ;/*精度*/
		Recall   =TP/(TP+FN)    ;/*召回率*/
		F_value  =2*Precision*Recall/(Precision+Recall);/*F值*/		
		roc=&cStat;
		ks=&KS;
		gini=&Gini;
	run;
%mend;

%MACRO update_newpredict(modelname, iscity,newmonth,newmonth2);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0702_test_&iscity._woe_&newmonth.;%let out=lf.a0901_&modelname._&iscity._pred_test_&newmonth.;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0702_test_&iscity._woe_&newmonth2.;%let out=lf.a0901_&modelname._&iscity._pred_test_&newmonth2.;%scoreAll(&inmodel, &outdata, &out);

%let DSin=lf.a0901_&modelname._&iscity._pred_test_&newmonth.;
%let ProbVar=pred_target;
%let DVVar=target;
%let DSKS=lf.a0802_test_dsks_&newmonth.;
%let KS=;
%let dsroc=lf.a0802_test_dsroc_&newmonth.;
%let cStat=;
%let cutoff=0.5;
%let dscm=lf.a0802_test_confMat_&newmonth.;
%let id="test_&newmonth.";
%let MeasureTab=lf.a0802_test_measureTab_&newmonth.;
%let DSLorenz=LorenzDS;
%let Gini=;
%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);

data lf.&modelname._&iscity._updateMeasure;
	length id $12;
	set	
	lf.a0802_test_measureTab_&newmonth.;
run;
%mend;

%let modelname=model3;%let iscity=in;%update_newpredict(&modelname, &iscity,&newmonth,&newmonth2);
%let modelname=model3;%let iscity=out;%update_newpredict(&modelname, &iscity,&newmonth,&newmonth2);

****PSI Calculation**********************************************************;
/*等最后确定模型再做*/
/*入模变量表*/

%macro update_psi(modelname,Nb,newmonth,newmonth2);
%let train_data = lf.a0901_&modelname._predict_train;
data lf.a0901_&modelname._test_&newmonth.;set lf.a0901_&modelname._&iscity._pred_test_&newmonth.;run;
%let test_data = lf.a0901_&modelname._test_&newmonth.;%totalpsi(&train_data.,&test_data.,pred_target,&Nb.);
data lf.a0901_&modelname._test_&newmonth2.;set lf.a0901_&modelname._&iscity._pred_test_&newmonth2.;run;
%let test_data = lf.a0901_&modelname._test_&newmonth2.;%totalpsi(&train_data.,&test_data.,pred_target,&Nb.);

data lf.updatepsi_&modelname._&iscity.;
retain model month sum;
set 
	lf.a0901_&modelname._test_&newmonth._psi(in=a1)
	lf.a0901_&modelname._test_&newmonth2._psi(in=a2)
;
  if a1=1 then month = &newmonth.;
  if a2=1 then month = &newmonth2.;
  if Bin = &Nb;
model = "&modelname._&iscity.";
  keep model month sum;
  rename sum=PSI;
run;
%mend;
%let modelname=model3;%let Nb=10;%let newmonth = 1709;%let newmonth2 = 1710;
%let iscity=in;%update_psi(&modelname,&Nb,&newmonth,&newmonth2);
%let iscity=out;%update_psi(&modelname,&Nb,&newmonth,&newmonth2);


%macro update_score_model3(Dsin, modelname,iscity, newmonth, newmonth2);
data &DSin;
   set lf.a0901_&modelname._&iscity._pred_test_&newmonth. lf.a0901_&modelname._&iscity._pred_test_&newmonth2.;
run;

data lf.a1601_&model_name._&iscity._score;
set &Dsin;
RAW_SCORE = 0.5519
+recent_contact_day_woe*0.9014
+kptp_woe*0.6191
+city_woe*0.8877
+person_app_age_woe*0.8912
+ACTUALPAYFINECNT_woe*0.5277
+MAX_SEQ_DUEDAYS_woe*2.6918
+INCM_TIMES_woe*0.3479
+rej_count_woe*1.3206
;     
F_SCORE = EXP(RAW_SCORE)/(1+EXP(RAW_SCORE));
SCORE =  450 - 72.1347520444482 * LOG(F_SCORE/(1-F_SCORE));
run;
%mend;
%let modelname=model3;%let newmonth=1709;%let newmonth2=1710;
%let iscity=in;
%let dsin=lf.a1301_&modelname._&iscity._pred_all;
%update_score_model3(&Dsin,&modelname,&iscity,&newmonth,&newmonth2);

%let iscity=out;
%let dsin=lf.a1301_&modelname._&iscity._pred_all;
%update_score_model3(&Dsin,&modelname,&iscity,&newmonth,&newmonth2);

%macro MonthScore(Dsin,model_name);
data &Dsin._n;
set &Dsin;

if score <300 then do;score_b=1;end;
else if score <350 then do;score_b=2;end;
else if score <375 then do;score_b=3;end;
else if score <400 then do;score_b=4;end;
else if score <425 then do;score_b=5;end;
else if score <450 then do;score_b=6;end;
else if score >=450 then do;score_b=7;end;

run;
proc sql;  
create table lf.a1601_temp_score
(
	month       char(20),
  clus      	INTEGER
  ,total         INTEGER
);


insert into lf.a1601_temp_score
select 
		state_month_cha as month,
         score_b as clus,
		count(1) as total 	   
from  &dsin._n group by state_month_cha,score_b;

quit;
proc print data=lf.a1601_temp_score;run;
%mend;


%let model_name=model3;%let iscity=in;%let Dsin=lf.a1601_&model_name._&iscity._score;%MonthScore(&Dsin,&model_name);
%let model_name=model3;%let iscity=out;%let Dsin=lf.a1601_&model_name._&iscity._score;%MonthScore(&Dsin,&model_name);

