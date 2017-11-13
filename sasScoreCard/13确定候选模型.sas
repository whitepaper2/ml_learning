
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

%macro train_model(varlist, modelname);
proc logistic data=lf.a0701_train_woe outmodel=lf.a0901_&modelname.    /*logistic建模文件*/
outest =lf.a0901_&modelname._params alpha=0.05;       /*logistic参数和协方差阵*/
model target (event='1')=&varlist/ stb               /*目标变量、x变量集*/
SELECTION =S  SLE=0.05 SLS=0.05  ;               /*逐步回归调选变量、0.05条件*/
/*建模结果文件 380437*250，增加4个变量：_level_,pred_target,pi_l,pi_u*/
output out=lf.a0901_&modelname._pred_probs p=pred_target lower=pi_l upper=pi_u;   
run;

%mend;

%MACRO score_MODEL(modelname);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0701_train_woe;%let out=lf.a0901_&modelname._predict_train;%scoreAll(&inmodel, &outdata, &out);
/*%let inmodel=lf.a0901_model1;%let outdata=lf.a0701_train_woe_1610;%let out=lf.a0901_predict_train_1610;%scoreAll(&inmodel, &outdata, &out);*/
/*%let inmodel=lf.a0901_model1;%let outdata=lf.a0701_train_woe_1611;%let out=lf.a0901_predict_train_1611;%scoreAll(&inmodel, &outdata, &out);*/
/*%let inmodel=lf.a0901_model1;%let outdata=lf.a0701_train_woe_1612;%let out=lf.a0901_predict_train_1612;%scoreAll(&inmodel, &outdata, &out);*/
/*%let inmodel=lf.a0901_model1;%let outdata=lf.a0701_train_woe_1701;%let out=lf.a0901_predict_train_1701;%scoreAll(&inmodel, &outdata, &out);*/
/*%let inmodel=lf.a0901_model1;%let outdata=lf.a0701_train_woe_1702;%let out=lf.a0901_predict_train_1702;%scoreAll(&inmodel, &outdata, &out);*/
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0701_valid_woe;%let out=lf.a0901_&modelname._predict_valid;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0701_valid_woe_1703;%let out=lf.a0901_&modelname._predict_valid_1703;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0701_valid_woe_1704;%let out=lf.a0901_&modelname._predict_valid_1704;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0701_test_woe;%let out=lf.a0901_&modelname._predict_test;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0701_test_woe_1705;%let out=lf.a0901_&modelname._predict_test_1705;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0701_test_woe_1706;%let out=lf.a0901_&modelname._predict_test_1706;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0701_test_woe_1707;%let out=lf.a0901_&modelname._predict_test_1707;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0701_test_woe_1708;%let out=lf.a0901_&modelname._predict_test_1708;%scoreAll(&inmodel, &outdata, &out);

%let DSin=lf.a0901_&modelname._predict_train;
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
/**/
/*%let DSin=lf.a0901_predict_train_1610;*/
/*%let ProbVar=pred_target;*/
/*%let DVVar=target;*/
/*%let DSKS=lf.a0802_train_dsks_1610;*/
/*%let KS=;*/
/*%let dsroc=lf.a0802_train_dsroc_1610;*/
/*%let cStat=;*/
/*%let cutoff=0.5;*/
/*%let dscm=lf.a0802_train_confMat_1610;*/
/*%let id="train_1610";*/
/*%let MeasureTab=lf.a0802_train_measureTab_1610;*/
/*%let DSLorenz=LorenzDS;*/
/*%let Gini=;*/
/*%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);*/
/**/
/*%let DSin=lf.a0901_predict_train_1611;*/
/*%let ProbVar=pred_target;*/
/*%let DVVar=target;*/
/*%let DSKS=lf.a0802_train_dsks_1611;*/
/*%let KS=;*/
/*%let dsroc=lf.a0802_train_dsroc_1611;*/
/*%let cStat=;*/
/*%let cutoff=0.5;*/
/*%let dscm=lf.a0802_train_confMat_1611;*/
/*%let id="train_1611";*/
/*%let MeasureTab=lf.a0802_train_measureTab_1611;*/
/*%let DSLorenz=LorenzDS;*/
/*%let Gini=;*/
/*%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);*/
/**/
/*%let DSin=lf.a0901_predict_train_1612;*/
/*%let ProbVar=pred_target;*/
/*%let DVVar=target;*/
/*%let DSKS=lf.a0802_train_dsks_1612;*/
/*%let KS=;*/
/*%let dsroc=lf.a0802_train_dsroc_1612;*/
/*%let cStat=;*/
/*%let cutoff=0.5;*/
/*%let dscm=lf.a0802_train_confMat_1612;*/
/*%let id="train_1612";*/
/*%let MeasureTab=lf.a0802_train_measureTab_1612;*/
/*%let DSLorenz=LorenzDS;*/
/*%let Gini=;*/
/*%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);*/
/**/
/*%let DSin=lf.a0901_predict_train_1701;*/
/*%let ProbVar=pred_target;*/
/*%let DVVar=target;*/
/*%let DSKS=lf.a0802_train_dsks_1701;*/
/*%let KS=;*/
/*%let dsroc=lf.a0802_train_dsroc_1701;*/
/*%let cStat=;*/
/*%let cutoff=0.5;*/
/*%let dscm=lf.a0802_train_confMat_1701;*/
/*%let id="train_1701";*/
/*%let MeasureTab=lf.a0802_train_measureTab_1701;*/
/*%let DSLorenz=LorenzDS;*/
/*%let Gini=;*/
/*%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);*/
/**/
/*%let DSin=lf.a0901_predict_train_1702;*/
/*%let ProbVar=pred_target;*/
/*%let DVVar=target;*/
/*%let DSKS=lf.a0802_train_dsks_1702;*/
/*%let KS=;*/
/*%let dsroc=lf.a0802_train_dsroc_1702;*/
/*%let cStat=;*/
/*%let cutoff=0.5;*/
/*%let dscm=lf.a0802_train_confMat_1702;*/
/*%let id="train_1702";*/
/*%let MeasureTab=lf.a0802_train_measureTab_1702;*/
/*%let DSLorenz=LorenzDS;*/
/*%let Gini=;*/
/*%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);*/

/*valid统计*/
%let DSin=lf.a0901_&modelname._predict_valid;
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

%let DSin=lf.a0901_&modelname._predict_valid_1703;
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

%let DSin=lf.a0901_&modelname._predict_valid_1704;
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
%let DSin=lf.a0901_&modelname._predict_test;
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

%let DSin=lf.a0901_&modelname._predict_test_1705;
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

%let DSin=lf.a0901_&modelname._predict_test_1706;
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

%let DSin=lf.a0901_&modelname._predict_test_1707;
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

%let DSin=lf.a0901_&modelname._predict_test_1708;
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

/*	lf.a0802_train_measureTab_1610*/
/*	lf.a0802_train_measureTab_1611*/
/*	lf.a0802_train_measureTab_1612*/
/*	lf.a0802_train_measureTab_1701*/
/*	lf.a0802_train_measureTab_1702*/
data lf.&modelname._allMeasurement;
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

/*模型排序效果*/
%macro Model_Order_Effect(model_name, DSin, ProbVar, DVVar, DSKS, M_KS, Ngroup);

/* Sort the observations using the predicted Probability */
proc sort data=&DsIn;
by descending &ProbVar;
run;

/* Find the total number of Positives and Negatives */
proc sql noprint;
 select sum(&DVVar) into:P from &DSin;
 select count(*) into :Ntot from &DSin;
 quit;
 %let N=%eval(&Ntot-&P); /* Number of negative */
%put &=P;

 /* The base of calculation is 100 tiles */

/* Count number of positive and negatives per tile, their proportions and 
    cumulative proportions decile */
data &DSKS;
set &DsIn nobs=NN;
by descending &ProbVar;
rank_num = _n_;
retain tile 1  totP  0 totN 0;
/*Tile_size=round(NN/&Ngroup.);*/
Tile_size=NN/&Ngroup.;

if &DVVar=1 then totP=totP+&DVVar;
else totN=totN+1;

Pper=totP/&P;
Nper=totN/&N;

/* end of tile? */
if _N_ = round(Tile*Tile_Size) then 
  do;
  output;
   if Tile <= &Ngroup. then  
       do;
         Tile=Tile+1;
		 SumResp=0;
	   end;
  end;

keep Tile totP totN Pper Nper rank_num;
run;

 
/* Scale the tile to represent percentage and add labels*/
data &DSKS;
    retain Tile group_num N1 bad_rate totP totN Pper Nper Tile_Pct KS_report LIFT pass_rate rev_bad_rate;
	set &DSKS;
	Tile_Pct=Tile/&Ngroup.;

    /* calculate the KS Curve/Lift */
    /*KS=NPer-PPer;*/
	KS=PPer-NPer;
	KS_report = lag(KS);
	if Tile=1 then KS_report = 0;
    
    /*计算每组别客户数、坏客户数*/
    group_num = rank_num - lag(rank_num);
	if Tile=1 then group_num = rank_num;
	N1 = totP - lag(totP);
	if Tile=1 then N1 = totP;

    /*通过率*/
	pass_rate = 1-(1/&Ngroup.)*(Tile-1);

    /*客户累积比率*/
    bad_rate = N1/group_num;
    LIFT = bad_rate / (&P./&Ntot.);

    /*对应逾期率*/
	denominator = &Ntot.-lag(rank_num);
	if Tile=1 then denominator = &Ntot;
	numerator = &P.-lag(totP);
	if Tile=1 then numerator = &P.;
	rev_bad_rate = numerator / denominator;

	label Tile = '组别';
	label group_num = '总客户数';
	label N1 = '坏客户数';
	label bad_rate = '逾期率';
	label totP = '累积坏客户数';
	label totN = '累积好客户数';
	label Pper='累积坏客户比率';
	label Nper ='累积好客户比率';
    label Tile_Pct = '客户累积比率';
	label pass_rate = '通过率';
	label rev_bad_rate = '对应逾期率';
	label KS_report = 'KS';

	format   bad_rate percent8.2 
                   KS_report percent8.2 
                   LIFT 8.1 
                   pass_rate percent8.2 
                   rev_bad_rate percent8.2;

    keep Tile group_num N1 bad_rate KS_report LIFT pass_rate rev_bad_rate;

run;

/* Clean the workspace */
proc datasets library=work nodetails nolist;
 delete temp ;
run;
quit;

%mend;

/*模型的各省份表现*/
%macro prov_perf(DSin,DSout);
proc sql;
create table &DSout as
select province, count(1) as n,sum(target)/count(1) as badrate, sum(pred_target)/count(1) as p
from &DSin
group by province;
quit;

proc sort data= &DSout; by descending n; run;
%mend;

/*模型1*/
%let varlist= 
recent_contact_day_woe
kptp_woe
city_woe
ACTUALPAYFINECNT_woe
person_app_age_woe
credit_amount_woe
INCM_TIMES_woe
rej_count_woe
;
%let modelname=model1;
%train_model(&varlist, &modelname);
%let modelname=model1;%score_MODEL(&modelname);
%let modelname=model1;%let dsin=lf.a1301_&modelname._dat_all;
data &DSin;
   set  lf.a0901_&modelname._predict_train lf.a0901_&modelname._predict_valid lf.a0901_&modelname._predict_test;
run;
%let probvar=pred_target;
%let dvvar=target;
%let dsks=lf.a1302_order_perf_&modelname.;
%let ks=;
%let Ngroup=20;
%Model_Order_Effect(&modelname, &DSin, &ProbVar, &DVVar, &DSKS, ks, &Ngroup);

%let DSin = lf.a0901_&modelname._predict_test; %let DSout = lf.a1401_prov_perf_&modelname.; %prov_perf(&DSin,&DSout);

/*模型2*/
%let varlist= 
kptp_woe
city_woe
ACTUALPAYFINECNT_woe
person_app_age_woe
MAX_SEQ_DUEDAYS_woe
INCM_TIMES_woe
rej_count_woe
credit_amount_woe
recent_contact_day_woe
;
%let modelname=model2;
%train_model(&varlist, &modelname);
%let modelname=model2;%score_MODEL(&modelname);
%let modelname=model2;%let dsin=lf.a1301_&modelname._dat_all;
data &DSin;
   set lf.a0901_&modelname._predict_train lf.a0901_&modelname._predict_valid lf.a0901_&modelname._predict_test;
run;
%let probvar=pred_target;
%let dvvar=target;
%let dsks=lf.a1302_order_perf_&modelname.;
%let ks=;
%let Ngroup=20;
%Model_Order_Effect(&modelname, &DSin, &ProbVar, &DVVar, &DSKS, ks, &Ngroup);

%let DSin = lf.a0901_&modelname._predict_test; %let DSout = lf.a1401_prov_perf_&modelname.; %prov_perf(&DSin,&DSout);

/*模型3*/
%let varlist= 
kptp_woe
city_woe
ACTUALPAYFINECNT_woe
person_app_age_woe
MAX_SEQ_DUEDAYS_woe
INCM_TIMES_woe
rej_count_woe
recent_contact_day_woe
;
%let modelname=model3;
%train_model(&varlist, &modelname);
%let modelname=model3;%score_MODEL(&modelname);
%let modelname=model3;%let dsin=lf.a1301_&modelname._dat_all;
data &DSin;
   set  lf.a0901_&modelname._predict_train lf.a0901_&modelname._predict_valid lf.a0901_&modelname._predict_test;
run;
%let probvar=pred_target;
%let dvvar=target;
%let dsks=lf.a1302_order_perf_&modelname.;
%let ks=;
%let Ngroup=20;
%Model_Order_Effect(&modelname, &DSin, &ProbVar, &DVVar, &DSKS, ks, &Ngroup);

%let DSin = lf.a0901_&modelname._predict_test; %let DSout = lf.a1401_prov_perf_&modelname.; %prov_perf(&DSin,&DSout);


******************************************************************************;                                                                                                                                
*** 16b现金贷评分卡评分                                                                                                     ***;                                                                                                                                 
******************************************************************************;   
%macro score_cal1_model1(Dsin, model_name);
data lf.a1601_&model_name._score;
set &Dsin;
RAW_SCORE = 0.5528
+recent_contact_day_woe*0.9273
+kptp_woe*0.6706
+city_woe*0.8766
+person_app_age_woe*0.84
+ACTUALPAYFINECNT_woe*0.4024
+INCM_TIMES_woe*0.322
+rej_count_woe*1.3087
+CREDIT_AMOUNT_woe*0.9364
;     
F_SCORE = EXP(RAW_SCORE)/(1+EXP(RAW_SCORE));
SCORE =  450 - 72.1347520444482 * LOG(F_SCORE/(1-F_SCORE));
run;
%mend;

%macro score_cal1_model2(Dsin, model_name);
data lf.a1601_&model_name._score;
set &Dsin;
RAW_SCORE = 0.552
+recent_contact_day_woe*0.9032
+kptp_woe*0.6238
+city_woe*0.8822
+ACTUALPAYFINECNT_woe*0.5313
+person_app_age_woe*0.8552
+MAX_SEQ_DUEDAYS_woe*2.6867
+INCM_TIMES_woe*0.3445
+rej_count_woe*1.3147
+CREDIT_AMOUNT_woe*0.9241
;     
F_SCORE = EXP(RAW_SCORE)/(1+EXP(RAW_SCORE));
SCORE =  450 - 72.1347520444482 * LOG(F_SCORE/(1-F_SCORE));
run;
%mend;

%macro score_cal1_model3(Dsin, model_name);
data lf.a1601_&model_name._score;
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
%let model_name=model1;
%let Dsin=lf.a1301_&model_name._dat_all;%score_cal1_model1(&Dsin,&model_name);
%let model_name=model2;
%let Dsin=lf.a1301_&model_name._dat_all;%score_cal1_model2(&Dsin,&model_name);
%let model_name=model3;
%let Dsin=lf.a1301_&model_name._dat_all;%score_cal1_model3(&Dsin,&model_name);

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


%let model_name=model1;data lf.a1601_&model_name._score2;set lf.a1601_&model_name._score;state_month_cha=substr(state_date_cha,1,7);run;
%let Dsin=lf.a1601_&model_name._score2;%MonthScore(&Dsin,&model_name);
%let model_name=model2;data lf.a1601_&model_name._score2;set lf.a1601_&model_name._score;state_month_cha=substr(state_date_cha,1,7);run;
%let Dsin=lf.a1601_&model_name._score2;%MonthScore(&Dsin,&model_name);
%let model_name=model3;data lf.a1601_&model_name._score2;set lf.a1601_&model_name._score;state_month_cha=substr(state_date_cha,1,7);run;
%let Dsin=lf.a1601_&model_name._score2;%MonthScore(&Dsin,&model_name);
