******************************************************************************;                                                                                                                                
*** 10变量稳定性计算                                                       ***;                                                                                                                                 
******************************************************************************; 

****SSI Calculation**********************************************************;
/*Test分月数据*/

/*变量表*/
proc transpose data= lf.a0901_model1_params out=para_in;
run;

data lf.a1002_vardic;
  set para_in(keep= _NAME_);
  if _NAME_ not in ('Intercept','_LNLIKE_');
  format variable $32.;
  variable = tranwrd(_NAME_,'_woe','_b');
  drop _NAME_;
run;

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

data lf.a1001_train_probs;
  set lf.a0901_model1_pred_probs;
run;

/*SSI计算*/
%let train_data = lf.a1001_train_probs;
/*独立构造变量集合,求出所有变量的ssi*/
%let model_coef = lf.a1002_udfvardic; 
%let test_data = lf.a1001_test_1701;%totalssi(&train_data.,&test_data.,&model_coef.);

%let test_data = lf.a1001_test_1702;%totalssi(&train_data.,&test_data.,&model_coef.);

%let test_data = lf.a1001_test_1703;%totalssi(&train_data.,&test_data.,&model_coef.);

%let test_data = lf.a1001_test_1704;%totalssi(&train_data.,&test_data.,&model_coef.);

%let test_data = lf.a1001_test_1705;%totalssi(&train_data.,&test_data.,&model_coef.);

%let test_data = lf.a1001_test_1706;%totalssi(&train_data.,&test_data.,&model_coef.);

/*没做模型之前,使用该数据集计算变量稳定性,两者相同*/
%let model_coef = lf.a1002_udfvardic; 
%let train_data = lf.a0701_train_woe;
%let test_data = lf.a0701_valid_woe_1703;%totalssi(&train_data.,&test_data.,&model_coef.);

%let test_data = lf.a0701_valid_woe_1704;%totalssi(&train_data.,&test_data.,&model_coef.);

%let test_data = lf.a0701_test_woe_1705;%totalssi(&train_data.,&test_data.,&model_coef.);

%let test_data = lf.a0701_test_woe_1706;%totalssi(&train_data.,&test_data.,&model_coef.);

%let test_data = lf.a0701_test_woe_1707;%totalssi(&train_data.,&test_data.,&model_coef.);

%let test_data = lf.a0701_test_woe_1708;%totalssi(&train_data.,&test_data.,&model_coef.);
data lf.alltotalssi;
set lf.a0701_valid_woe_1703_var_SSI
	lf.a0701_valid_woe_1704_var_SSI
	lf.a0701_test_woe_1705_var_SSI
	lf.a0701_test_woe_1706_var_SSI 
	lf.a0701_test_woe_1707_var_SSI
	lf.a0701_test_woe_1708_var_SSI;
run;
proc sql;
	create table lf.allssi_summary as 
	select substr(id,length(id)-3,4) as month,column,max(ssi) as totalssi from lf.alltotalssi group by id,column order by id,column;
run;

proc delete data= para_in lf.a1001_train_probs; run;

proc sql;
	select max(pred_target),min(pred_target),(max(pred_target)-min(pred_target))/10 from lf.a0901_predict_train;
run;


****PSI Calculation**********************************************************;
/*等最后确定模型再做*/
/*入模变量表*/
%macro model_psi(modelname);
%let train_data = lf.a0901_&modelname._predict_train;
data lf.a0901_&modelname._valid_1703;set lf.a0901_&modelname._predict_valid_1703;run;
%let test_data = lf.a0901_&modelname._valid_1703;%totalpsi(&train_data.,&test_data.,pred_target,10);
data lf.a0901_&modelname._valid_1704;set lf.a0901_&modelname._predict_valid_1704;run;
%let test_data = lf.a0901_&modelname._valid_1704;%totalpsi(&train_data.,&test_data.,pred_target,10);
data lf.a0901_&modelname._test_1705;set lf.a0901_&modelname._predict_test_1705;run;
%let test_data = lf.a0901_&modelname._test_1705;%totalpsi(&train_data.,&test_data.,pred_target,10);
data lf.a0901_&modelname._test_1706;set lf.a0901_&modelname._predict_test_1706;run;
%let test_data = lf.a0901_&modelname._test_1706;%totalpsi(&train_data.,&test_data.,pred_target,10);
data lf.a0901_&modelname._test_1707;set lf.a0901_&modelname._predict_test_1707;run;
%let test_data = lf.a0901_&modelname._test_1707;%totalpsi(&train_data.,&test_data.,pred_target,10);
data lf.a0901_&modelname._test_1708;set lf.a0901_&modelname._predict_test_1708;run;
%let test_data = lf.a0901_&modelname._test_1708;%totalpsi(&train_data.,&test_data.,pred_target,10);
data lf.alltotalpsi_&modelname.;
set lf.a0901_&modelname._valid_1703_psi
lf.a0901_&modelname._valid_1704_psi
lf.a0901_&modelname._test_1705_psi
lf.a0901_&modelname._test_1706_psi
lf.a0901_&modelname._test_1707_psi
lf.a0901_&modelname._test_1708_psi
;
run;
%mend;

%let modelname=model1;%model_psi(&modelname);
%let modelname=model2;%model_psi(&modelname);
%let modelname=model3;%model_psi(&modelname);