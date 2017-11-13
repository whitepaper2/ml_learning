******************************************************************************;                                                                                                                                
*** 02随机抽样                                                             ***;                                                                                                                                 
******************************************************************************; 

/*
Train: 1610-1702
Validation: 1703-1704
Test: 1705-1707
*/
data lf.dz0300_train lf.dz0300_valid lf.dz0300_test;
  set lf.dz0201_data_import_part3;
  if substr(state_date_cha,1,7) in('2016-10','2016-11','2016-12','2017-01','2017-02') then output lf.dz0300_train;
  else if substr(state_date_cha,1,7) in('2017-03','2017-04') then output lf.dz0300_valid;
  else output lf.dz0300_test;
run;
data lf.dz0201_data_import_part4;
set lf.dz0201_data_import_part3;
state_month_cha = substr(state_date_cha,1,7);
run;



/*你可以放到sas上面跑 速度是一样的。tmp_dcc.tm1m3_lf_xj_base_m1_dcc替换成你的打分数据集 ，putout_date限定在>=2017-04*/
ods HTML file="&output_file./EDA_mean_011.xls";/*2模型变量均值过程--mean_01.xls*/
proc means data =  lf.dz0201_data_import  n nmiss mean median min max p5 p10 p25 p50 p75 p90 p95;/*QMETHOD=P2*/ 
class state_month_cha; 
var 
kptp
ptp
ptp_ratio
bptp
bptp_ratio
dk_ratio
;
run;
ods html close;


/*验证数据集是否分对*/
proc sql;
select state_month_cha, count(1) as n from lf.dz0300_train group by state_month_cha;
select state_month_cha, count(1) as n from lf.dz0300_valid group by state_month_cha;
select state_month_cha, count(1) as n from lf.dz0300_test group by state_month_cha;
select sum(target)/count(1) as bad_rate from lf.dz0300_train;
select sum(target)/count(1) as bad_rate from lf.dz0300_valid;
select sum(target)/count(1) as bad_rate from lf.dz0300_test;
quit;


****随机抽样******************************************************************;
/*Train*/
proc sort data=lf.a0201_Train_Valid; by target;run;

proc surveyselect data=lf.a0201_Train_Valid
     method=srs rate=0.7 out=lf.a0203_train(drop=SelectionProb SamplingWeight) seed= 12345;
	 strata target;
run;
proc sort data =lf.a0201_Train_Valid; by CONTRACT_NO STATE_DATE; run;
proc sort data =lf.a0203_train out=lf.a0204_tag(keep= CONTRACT_NO STATE_DATE); by CONTRACT_NO STATE_DATE; run;

/*Validation*/
data lf.a0205_valid;
	merge lf.a0201_Train_Valid lf.a0204_tag(in=a);
	by CONTRACT_NO STATE_DATE;
	if ^a then output;
run;
ods HTML file="&output_file./a0203_train.csv";
proc sql;
	select * from lf.a0203_train; /*离散变量才行*/
run;
ods html close;

****Bad Rate Consistency Check************************************************;
proc sql;
select sum(target)/count(1) as bad_rate into : train_bad_rate from lf.a0203_train;
select sum(target)/count(1) as bad_rate into : valid_bad_rate from lf.a0205_valid;
select sum(target)/count(1) as bad_rate into : test_bad_rate  from lf.a0202_Test;
quit;
%put &=train_bad_rate &=valid_bad_rate &=test_bad_rate;
/*TRAIN_BAD_RATE=0.112443 VALID_BAD_RATE=0.112436 TEST_BAD_RATE=0.110961*/

/*发现test的数据集不大稳定,尤其5月以后*/
proc sql;
select substr(state_date,1,7) as month, sum(target)/count(1) as bad_rate
from lf.a0202_Test
group by month;
quit;

proc sql;
select sum(target)/count(1) as bad_rate from lf.a0202_Test where state_date < '2017-06-01';
quit;

/*test数据集只取1701-1705*/
/*data lf.a0202_Test_part;*/
/*  set lf.a0202_Test;*/
/*  if state_date < '2017-06-01';*/
/*run;*/