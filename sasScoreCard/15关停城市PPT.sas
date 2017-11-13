/*验证集、测试集与关停城市匹配*/
proc contents data=f15.city_still_run_1030;run;
data lf.city_still_run_1030;
	set f15.city_still_run_1030;
	length city $ 60;
	city = city_on;
run;


%macro splitWoeBySample(runData);
data lf.a0702_&runData._woe;
	set lf.a0701_&runData._woe;
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
%let runData=train; %splitWoeBySample(&runData);
%let runData=valid; %splitWoeBySample(&runData);
%let runData=test; %splitWoeBySample(&runData);

/*对valid文件打分*/
%macro splitWoeFile(iscity);
	data lf.a0702_valid_&iscity._woe_1703 lf.a0702_valid_&iscity._woe_1704;
	  set lf.a0702_valid_&iscity._woe;
	  if state_month_cha = '1703' then output lf.a0702_valid_&iscity._woe_1703;
	  if state_month_cha = '1704' then output lf.a0702_valid_&iscity._woe_1704;
	run;
	/*对test文件打分*/
	/*拆分test集,对test分月份打分*/
	data lf.a0702_test_&iscity._woe_1705 lf.a0702_test_&iscity._woe_1706 lf.a0702_test_&iscity._woe_1707 lf.a0702_test_&iscity._woe_1708;
	  set lf.a0702_test_&iscity._woe;
	  if state_month_cha = '1705' then output lf.a0702_test_&iscity._woe_1705;
	  if state_month_cha = '1706' then output lf.a0702_test_&iscity._woe_1706;
	  if state_month_cha = '1707' then output lf.a0702_test_&iscity._woe_1707;
	  if state_month_cha = '1708' then output lf.a0702_test_&iscity._woe_1708;
	run;
%mend;
%let iscity=in;%splitWoeFile(&iscity);
%let iscity=out;%splitWoeFile(&iscity);


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


%MACRO score_MODEL(modelname, iscity);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0702_train_&iscity._woe;%let out=lf.a0901_&modelname._&iscity._pred_train;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0702_valid_&iscity._woe;%let out=lf.a0901_&modelname._&iscity._pred_valid;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0702_valid_&iscity._woe_1703;%let out=lf.a0901_&modelname._&iscity._pred_valid_1703;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0702_valid_&iscity._woe_1704;%let out=lf.a0901_&modelname._&iscity._pred_valid_1704;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0702_test_&iscity._woe;%let out=lf.a0901_&modelname._&iscity._pred_test;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0702_test_&iscity._woe_1705;%let out=lf.a0901_&modelname._&iscity._pred_test_1705;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0702_test_&iscity._woe_1706;%let out=lf.a0901_&modelname._&iscity._pred_test_1706;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0702_test_&iscity._woe_1707;%let out=lf.a0901_&modelname._&iscity._pred_test_1707;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0702_test_&iscity._woe_1708;%let out=lf.a0901_&modelname._&iscity._pred_test_1708;%scoreAll(&inmodel, &outdata, &out);

%let DSin=lf.a0901_&modelname._&iscity._pred_train;
%let ProbVar=pred_target;
%let DVVar=target;
%let DSKS=lf.a0802_train_dsks;
%let KS=;
%let dsroc=lf.a0802_train_dsroc;
%let cStat=;
%let cutoff=0.5;
%let dscm=lf.a0802_train_confMat;
%let id="train";
%let MeasureTab=lf.a0802_train_measureTab;
%let DSLorenz=LorenzDS;
%let Gini=;
%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);

/*valid统计*/
%let DSin=lf.a0901_&modelname._&iscity._pred_valid;
%let ProbVar=pred_target;
%let DVVar=target;
%let DSKS=lf.a0802_valid_dsks;
%let KS=;
%let dsroc=lf.a0802_valid_dsroc;
%let cStat=;
%let cutoff=0.5;
%let dscm=lf.a0802_valid_confMat;
%let id="valid";
%let MeasureTab=lf.a0802_valid_measureTab;
%let DSLorenz=LorenzDS;
%let Gini=;
%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);

%let DSin=lf.a0901_&modelname._&iscity._pred_valid_1703;
%let ProbVar=pred_target;
%let DVVar=target;
%let DSKS=lf.a0802_valid_dsks_1703;
%let KS=;
%let dsroc=lf.a0802_valid_dsroc_1703;
%let cStat=;
%let cutoff=0.5;
%let dscm=lf.a0802_valid_confMat_1703;
%let id="valid_1703";
%let MeasureTab=lf.a0802_valid_measureTab_1703;
%let DSLorenz=LorenzDS;
%let Gini=;
%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);

%let DSin=lf.a0901_&modelname._&iscity._pred_valid_1704;
%let ProbVar=pred_target;
%let DVVar=target;
%let DSKS=lf.a0802_valid_dsks_1704;
%let KS=;
%let dsroc=lf.a0802_valid_dsroc_1704;
%let cStat=;
%let cutoff=0.5;
%let dscm=lf.a0802_valid_confMat_1704;
%let id="valid_1704";
%let MeasureTab=lf.a0802_valid_measureTab_1704;
%let DSLorenz=LorenzDS;
%let Gini=;
%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);

/*test统计*/
%let DSin=lf.a0901_&modelname._&iscity._pred_test;
%let ProbVar=pred_target;
%let DVVar=target;
%let DSKS=lf.a0802_test_dsks;
%let KS=;
%let dsroc=lf.a0802_test_dsroc;
%let cStat=;
%let cutoff=0.5;
%let dscm=lf.a0802_test_confMat;
%let id="test";
%let MeasureTab=lf.a0802_test_measureTab;
%let DSLorenz=LorenzDS;
%let Gini=;
%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);

%let DSin=lf.a0901_&modelname._&iscity._pred_test_1705;
%let ProbVar=pred_target;
%let DVVar=target;
%let DSKS=lf.a0802_test_dsks_1705;
%let KS=;
%let dsroc=lf.a0802_test_dsroc_1705;
%let cStat=;
%let cutoff=0.5;
%let dscm=lf.a0802_test_confMat_1705;
%let id="test_1705";
%let MeasureTab=lf.a0802_test_measureTab_1705;
%let DSLorenz=LorenzDS;
%let Gini=;
%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);

%let DSin=lf.a0901_&modelname._&iscity._pred_test_1706;
%let ProbVar=pred_target;
%let DVVar=target;
%let DSKS=lf.a0802_test_dsks_1706;
%let KS=;
%let dsroc=lf.a0802_test_dsroc_1706;
%let cStat=;
%let cutoff=0.5;
%let dscm=lf.a0802_test_confMat_1706;
%let id="test_1706";
%let MeasureTab=lf.a0802_test_measureTab_1706;
%let DSLorenz=LorenzDS;
%let Gini=;
%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);

%let DSin=lf.a0901_&modelname._&iscity._pred_test_1707;
%let ProbVar=pred_target;
%let DVVar=target;
%let DSKS=lf.a0802_test_dsks_1707;
%let KS=;
%let dsroc=lf.a0802_test_dsroc_1707;
%let cStat=;
%let cutoff=0.5;
%let dscm=lf.a0802_test_confMat_1707;
%let id="test_1707";
%let MeasureTab=lf.a0802_test_measureTab_1707;
%let DSLorenz=LorenzDS;
%let Gini=;
%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);

%let DSin=lf.a0901_&modelname._&iscity._pred_test_1708;
%let ProbVar=pred_target;
%let DVVar=target;
%let DSKS=lf.a0802_test_dsks_1708;
%let KS=;
%let dsroc=lf.a0802_test_dsroc_1708;
%let cStat=;
%let cutoff=0.5;
%let dscm=lf.a0802_test_confMat_1708;
%let id="test_1708";
%let MeasureTab=lf.a0802_test_measureTab_1708;
%let DSLorenz=LorenzDS;
%let Gini=;
%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);

data lf.&modelname._&iscity._allMeasurement;
	length id $12;
	set	
	lf.a0802_train_measureTab
	lf.a0802_valid_measureTab
	lf.a0802_valid_measureTab_1703
	lf.a0802_valid_measureTab_1704
	lf.a0802_test_measureTab 
	lf.a0802_test_measureTab_1705 
	lf.a0802_test_measureTab_1706
	lf.a0802_test_measureTab_1707
	lf.a0802_test_measureTab_1708;
run;
%mend;

%let modelname=model3;%let iscity=in;%score_MODEL(&modelname, &iscity);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0702_train_&iscity._woe;%let out=lf.a0901_&modelname._&iscity._pred_train;%scoreAll(&inmodel, &outdata, &out);

%let modelname=model3;%let iscity=out;%score_MODEL(&modelname, &iscity);
%macro model_psi(modelname, iscity);
%let train_data = lf.a0901_&modelname._predict_train;
data lf.a0901_&modelname._valid_1703;set lf.a0901_&modelname._&iscity._pred_valid_1703;run;
%let test_data = lf.a0901_&modelname._valid_1703;%totalpsi(&train_data.,&test_data.,pred_target,10);
data lf.a0901_&modelname._valid_1704;set lf.a0901_&modelname._&iscity._pred_valid_1704;run;
%let test_data = lf.a0901_&modelname._valid_1704;%totalpsi(&train_data.,&test_data.,pred_target,10);
data lf.a0901_&modelname._test_1705;set lf.a0901_&modelname._&iscity._pred_test_1705;run;
%let test_data = lf.a0901_&modelname._test_1705;%totalpsi(&train_data.,&test_data.,pred_target,10);
data lf.a0901_&modelname._test_1706;set lf.a0901_&modelname._&iscity._pred_test_1706;run;
%let test_data = lf.a0901_&modelname._test_1706;%totalpsi(&train_data.,&test_data.,pred_target,10);
data lf.a0901_&modelname._test_1707;set lf.a0901_&modelname._&iscity._pred_test_1707;run;
%let test_data = lf.a0901_&modelname._test_1707;%totalpsi(&train_data.,&test_data.,pred_target,10);
data lf.a0901_&modelname._test_1708;set lf.a0901_&modelname._&iscity._pred_test_1708;run;
%let test_data = lf.a0901_&modelname._test_1708;%totalpsi(&train_data.,&test_data.,pred_target,10);
data lf.alltotalpsi_&modelname._&iscity.;
set lf.a0901_&modelname._valid_1703_psi
lf.a0901_&modelname._valid_1704_psi
lf.a0901_&modelname._test_1705_psi
lf.a0901_&modelname._test_1706_psi
lf.a0901_&modelname._test_1707_psi
lf.a0901_&modelname._test_1708_psi
;
run;
%mend;

%let modelname=model3;%let iscity=in;%model_psi(&modelname, &iscity);
%let modelname=model3;%let iscity=out;%model_psi(&modelname, &iscity);

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
%macro model_ssi(iscity);
%let model_coef = lf.a1002_udfvardic; 
%let train_data = lf.a0702_train_woe;
data lf.a0702_&iscity._woe_1703;
set lf.a0702_valid_&iscity._woe_1703;
run;
%let test_data = lf.a0702_&iscity._woe_1703;
%totalssi(&train_data.,&test_data.,&model_coef.);
data lf.a0702_&iscity._woe_1704;
set lf.a0702_valid_&iscity._woe_1704;
run;
%let test_data = lf.a0702_&iscity._woe_1704;
%totalssi(&train_data.,&test_data.,&model_coef.);
data lf.a0702_&iscity._woe_1705;
set lf.a0702_test_&iscity._woe_1705;
run;
%let test_data = lf.a0702_&iscity._woe_1705;
%totalssi(&train_data.,&test_data.,&model_coef.);
data lf.a0702_&iscity._woe_1706;
set lf.a0702_test_&iscity._woe_1706;
run;
%let test_data = lf.a0702_&iscity._woe_1706;
%totalssi(&train_data.,&test_data.,&model_coef.);
data lf.a0702_&iscity._woe_1707;
set lf.a0702_test_&iscity._woe_1707;
run;
%let test_data = lf.a0702_&iscity._woe_1707;
%totalssi(&train_data.,&test_data.,&model_coef.);
data lf.a0702_&iscity._woe_1708;
set lf.a0702_test_&iscity._woe_1708;
run;
%let test_data = lf.a0702_&iscity._woe_1708;
%totalssi(&train_data.,&test_data.,&model_coef.);
data lf.alltotalssi_&iscity.;
set lf.a0702_&iscity._woe_1703_var_SSI
	lf.a0702_&iscity._woe_1704_var_SSI
	lf.a0702_&iscity._woe_1705_var_SSI
	lf.a0702_&iscity._woe_1706_var_SSI 
	lf.a0702_&iscity._woe_1707_var_SSI
	lf.a0702_&iscity._woe_1708_var_SSI;
run;
%mend;
%let iscity=in;%model_ssi(&iscity);
%let iscity=out;%model_ssi(&iscity);


%macro score_cal1_model3(Dsin, model_name,iscity);
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
%let model_name=model3;
%let iscity=in;
%let dsin=lf.a1301_&modelname._&iscity._pred_all;
data &DSin;
   set lf.a0901_&modelname._&iscity._pred_train lf.a0901_&modelname._&iscity._pred_valid lf.a0901_&modelname._&iscity._pred_test;
run;
%score_cal1_model3(&Dsin,&model_name,&iscity);

%let model_name=model3;
%let iscity=out;
%let dsin=lf.a1301_&modelname._&iscity._pred_all;
data &DSin;
   set lf.a0901_&modelname._&iscity._pred_train lf.a0901_&modelname._&iscity._pred_valid lf.a0901_&modelname._&iscity._pred_test;
run;
%score_cal1_model3(&Dsin,&model_name,&iscity);

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

