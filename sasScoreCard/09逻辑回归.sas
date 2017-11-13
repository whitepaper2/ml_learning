******************************************************************************;                                                                                                                                
*** 08逻辑回归                                                             ***;                                                                                                                                 
******************************************************************************; 

****全变量模型***************************************************************;
/*建模*/
%let varlist= 
CERT_4_INITAL_woe
bptp_woe
person_app_age_woe
avg_days_woe
rej_count_woe
apr_payment_num_woe
MAX_SEQ_DUEDAYS_woe
ACTUALPAYFINECNT_woe
flag_tqww_woe
;

proc logistic data=lf.a0701_train_woe outmodel=lf.a0901_model1    /*logistic建模文件*/
outest =lf.a0901_model1_params alpha=0.05;       /*logistic参数和协方差阵*/
model target (event='1')=&varlist/ stb               /*目标变量、x变量集*/
SELECTION =S  SLE=0.05 SLS=0.05  ;               /*逐步回归调选变量、0.05条件*/
/*建模结果文件 380437*250，增加4个变量：_level_,pred_target,pi_l,pi_u*/
output out=lf.a0901_model1_pred_probs p=pred_target lower=pi_l upper=pi_u;   
run;
/*分月拆分数据集*/
data lf.a0701_train_woe_1610 lf.a0701_train_woe_1611 lf.a0701_train_woe_1612 
	lf.a0701_train_woe_1701 lf.a0701_train_woe_1702;
  set lf.a0701_train_woe;
  if state_month_cha = '1610' then output lf.a0701_train_woe_1610;
  if state_month_cha = '1611' then output lf.a0701_train_woe_1611;
  if state_month_cha = '1612' then output lf.a0701_train_woe_1612;
  if state_month_cha = '1701' then output lf.a0701_train_woe_1701;
  if state_month_cha = '1702' then output lf.a0701_train_woe_1702;
run;

/*对valid文件*/
data lf.a0701_valid_woe_1703 lf.a0701_valid_woe_1704;
  set lf.a0701_valid_woe;
  if substr(state_date_cha,1,7) = '2017-03' then output lf.a0701_valid_woe_1703;
  if substr(state_date_cha,1,7) = '2017-04' then output lf.a0701_valid_woe_1704;
run;
/*对test文件*/
/*拆分test集,对test分月份*/
data lf.a0701_test_woe_1705 lf.a0701_test_woe_1706 lf.a0701_test_woe_1707 lf.a0701_test_woe_1708;
  set lf.a0701_test_woe;
  if substr(state_date_cha,1,7) = '2017-05' then output lf.a0701_test_woe_1705;
  if substr(state_date_cha,1,7) = '2017-06' then output lf.a0701_test_woe_1706;
  if substr(state_date_cha,1,7) = '2017-07' then output lf.a0701_test_woe_1707;
  if substr(state_date_cha,1,7) = '2017-08' then output lf.a0701_test_woe_1708;
run;

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
/*得到输出结果概率值*/
/*%let inmodel=lf.a0901_model1;%let outdata=lf.a0603_test_woe_1701;%let out=lf.a0901_predict_test_1701;%scoreAll(&inmodel, &outdata, &out);*/
%let inmodel=lf.a0901_model1;%let outdata=lf.a0701_train_woe;%let out=lf.a0901_predict_train;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_model1;%let outdata=lf.a0701_valid_woe;%let out=lf.a0901_predict_valid;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_model1;%let outdata=lf.a0701_valid_woe_1703;%let out=lf.a0901_predict_valid_1703;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_model1;%let outdata=lf.a0701_valid_woe_1704;%let out=lf.a0901_predict_valid_1704;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_model1;%let outdata=lf.a0701_test_woe;%let out=lf.a0901_predict_test;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_model1;%let outdata=lf.a0701_test_woe_1705;%let out=lf.a0901_predict_test_1705;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_model1;%let outdata=lf.a0701_test_woe_1706;%let out=lf.a0901_predict_test_1706;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_model1;%let outdata=lf.a0701_test_woe_1707;%let out=lf.a0901_predict_test_1707;%scoreAll(&inmodel, &outdata, &out);
/*评估指标*/
/*训练样本*/
%let DSin=lf.a0901_model1_pred_probs;
%let ProbVar=pred_target;
%let DVVar=target;
%let DSKS=lf.a0802_dsks;
%let KS=;
%KSStat(&DSin, &ProbVar, &DVVar, &DSKS, KS);

%put &KS;
%PlotKS (&DSKS);

%let dsin=lf.a0901_model1_pred_probs;
%let probvar=pred_target;
%let dvvar=target;
%let dsroc=lf.a0802_dsroc;
%let cStat=;

%ROC(&DSin, &ProbVar, &DVVar, &DSROC, cStat);
%put >>>>>>>>>>>>>>  c-Stat=&cStat   <<<<<<<<<<<<<;
%PlotROC(&DSROC);

/*validation*/
%let DSin=lf.a0901_predict_valid;
%let ProbVar=pred_target;
%let DVVar=target;
%let DSKS=lf.a0802_dsks_valid;
%let KS=;
%KSStat(&DSin, &ProbVar, &DVVar, &DSKS, KS);

%put &KS;
%PlotKS (&DSKS);

%let dsin=lf.a0901_predict_valid;
%let probvar=pred_target;
%let dvvar=target;
%let dsroc=lf.a0802_dsroc_valid;
%let cStat=;

%ROC(&DSin, &ProbVar, &DVVar, &DSROC, cStat);
%put >>>>>>>>>>>>>>  c-Stat=&cStat   <<<<<<<<<<<<<;
%PlotROC(&DSROC);

/*test*/
%let DSin=lf.a0901_predict_test;
%let ProbVar=pred_target;
%let DVVar=target;
%let DSKS=lf.a0802_dsks_test;
%let KS=;
%KSStat(&DSin, &ProbVar, &DVVar, &DSKS, KS);

%put &KS;
%PlotKS (&DSKS);

%let dsin=lf.a0901_predict_test;
%let probvar=pred_target;
%let dvvar=target;
%let dsroc=lf.a0802_dsroc_test;
%let cStat=;

%ROC(&DSin, &ProbVar, &DVVar, &DSROC, cStat);
%put >>>>>>>>>>>>>>  c-Stat=&cStat   <<<<<<<<<<<<<;
%PlotROC(&DSROC);

/*gini统计量*/
/* Calculate the Gini statistic */
%let DSin=lf.a0901_model1_pred_probs;
%let ProbVar=Pred_target;
%let DVVar=target;
%let DSLorenz=LorenzDS;
%let Gini=;
%GiniStat(&DSin, &ProbVar, &DVVar, &DSLorenz, Gini);
%put>>>>>>>>>>>>>>>   Gini=&Gini  <<<<<<<<<<<<<<<<<<<  ;
/* Plor the Lorenz curve */
%PlotLorenz(&DSLorenz);

/* use the macro */
%let DSin=lf.a0901_model1_pred_probs;
%let ProbVar=Pred_target;
%let DVVar=target;
%let DSLift=LiftChartDS;
/* Calculate the data of the Lift chart */
%LiftChart(&DSin, &ProbVar, &DVVar, &DSLift);
/* Display the content of the lift chart dataset */
proc print data=&DSLift;
run;
/* Plot the lift chart using PROC GPLOT */
%PlotLift(&DSLift);

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

%let DSin=lf.a0901_model1_pred_probs;
%let ProbVar=pred_target;
%let DVVar=target;
%let DSKS=lf.a0802_dsks;
%let KS=;
%let dsroc=lf.a0802_dsroc;
%let cStat=;
%let cutoff=0.5;
%let dscm=lf.a0802_confMat;
%let id="train";
%let MeasureTab=lf.a0802_train_measureTab;
%let DSLorenz=LorenzDS;
%let Gini=;
%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);

/*valid统计*/
%let DSin=lf.a0901_predict_valid;
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

%let DSin=lf.a0901_predict_valid_1703;
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

%let DSin=lf.a0901_predict_valid_1704;
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
%let DSin=lf.a0901_predict_test;
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

%let DSin=lf.a0901_predict_test_1705;
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

%let DSin=lf.a0901_predict_test_1706;
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

%let DSin=lf.a0901_predict_test_1707;
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

data lf.allMeasurement;
	length id $12;
	set	
	lf.a0802_train_measureTab
	lf.a0802_valid_measureTab
	lf.a0802_valid_measureTab_1703
	lf.a0802_valid_measureTab_1704
	lf.a0802_test_measureTab 
	lf.a0802_test_measureTab_1705 
	lf.a0802_test_measureTab_1706
	lf.a0802_test_measureTab_1707;
run;
