******************************************************************************;                                                                                                                                
*** 01导入数据&数据预处理                                                  ***;                                                                                                                                 
******************************************************************************; 

****导入数据******************************************************************;
/*得到数据字典*/
proc contents data=tmp_dcc.zdy_m2_poscash_cs_BASE_V1 ;run;
proc contents data=f15.m1_poscash_lf_cs_m2_base_v1_ht;run;
%macro numeric_to_character(var,label);
&var._2 = put(&var.,8.);
label &var._2 = &label;
rename &var. = &var._ori &var._2 = &var.;
%mend;

****Data Subset***************************************************************;
data lf.dz0201_data_import;
  set f15.m1_poscash_lf_cs_m2_base_v1_ht(rename=(putout_date=putout_datetime state_date=state_datetime ));
  
  ** 日期处理 **;
  putout_date = datepart(putout_datetime);
  state_date = datepart(state_datetime);
  format putout_date date9. state_date date9.;
  putout_month_cha = put(putout_date,yymmn4.);
  state_month_cha = put(state_date,yymmn4.);

  ** Days Diff Between Putout Month & State Month **;
  day_diff = intck('day',putout_date,state_date);

  ** Data Subset **;
  if sub_product_type = 1; ** POS贷=0, 现金贷=1;
  if target >=0;
  if day_diff > 61;

  ** Formatting **;
  %numeric_to_character(INNER_CODE        ,'内部代码                      ');
  %numeric_to_character(IS_WORK_HR        ,'是否工作日的工作时间申请      ');
  %numeric_to_character(IS_SUIXINHUAN     ,'是否购买随心还                ');
  %numeric_to_character(PERSON_SEX        ,'性别                          ');
  %numeric_to_character(FAMILY_STATE      ,'婚姻状态                      ');
  %numeric_to_character(EDUCATION         ,'教育程度                      ');
  %numeric_to_character(IS_SSI            ,'是否社保                      ');
  %numeric_to_character(HOUSE_TYPE        ,'住房类型                      ');
  %numeric_to_character(EMAIL             ,'电子邮箱类型                  ');
  %numeric_to_character(F_SAME_REG        ,'家庭（居住）地址是否与户籍一致');
  %numeric_to_character(IS_CERTID_PROVINCE,'身份证省份是否与POS一致       ');
  %numeric_to_character(OTHER_PERSON_TYPE ,'其他联系人类型                ');
  %numeric_to_character(F_SAME_COM        ,'公司地址是否在当前城市        ');
  %numeric_to_character(PUTOUT_SAGROUP    ,'SA分组_申请时间               ');
  %numeric_to_character(STATE_SAGROUP     ,'SA分组_评分时间               ');
  %numeric_to_character(isblack           ,'是否黑名单                    ');

  AVG_DAYS_2 = input(AVG_DAYS,8.);
  label AVG_DAYS_2 = '平均每次逾期停留天数';
  rename AVG_DAYS=AVG_DAYS_ori AVG_DAYS_2=AVG_DAYS;
  if target_hive<>. then flag_target = target_hive;
  else flag_target = target;
  target2=target;
	target=flag_target;
	if target2=target_hive then flag_target2_hive=1;else flag_target2_hive=0;
	
run;
/*导入hive201610-201708*/
proc contents data=lf.dz0201_data_import;run;
proc contents data=lf.m2_poscash_cs_base_v1_process;run;
proc sql;                                                                                                                               
create table lf.m2_poscash_cs_base_v1  as                                                                                                              
select acct_loan_no,contract_no,customerid,actualpayfinecnt,kptp,city,max_seq_duedays,incm_times,recent_contact_day,target,state_date,putout_date,sub_product_type,person_app_age,person_sex,credit_amount,rej_count,province
from tmp_dcc.zdy_m2_poscash_cs_BASE_V1_test
       (dbsastype=(
acct_loan_no='char(80)'
contract_no   ='char(30)'
customerid        ='char(20)'
actualpayfinecnt='numeric(8,2)'
kptp='NUMERIC(8,2)'
city='char(60)'
max_seq_duedays='NUMERIC(8,2)'
incm_times='NUMERIC(8,2)'
recent_contact_day='NUMERIC(8,2)'
target='NUMERIC(8,2)'
putout_date  ='char(30)'
province  ='char(60)'
person_sex='char(8)'
state_date   ='char(30)'
sub_product_type='char(20)'
        )) 
;
quit; 
/**************************************************/

data lf.m2_poscash_cs_base_v1_process;
set lf.m2_poscash_cs_base_v1(rename=(putout_date=putout_date_cha state_date=state_date_cha ));
  ** 日期处理 **;
putout_month_cha=substr(putout_date_cha,3,2)||substr(putout_date_cha,6,2);
  state_month_cha=substr(state_date_cha,3,2)||substr(state_date_cha,6,2);
  putout_date_pk=input(putout_date_cha,yymmdd10.);
format putout_date_pk yymmdd10.;
  state_date_pk=input(state_date_cha,yymmdd10.);
format state_date_pk yymmdd10.;
day_diff=state_date_pk-putout_date_pk;

  ** Data Subset **;
  if sub_product_type = 1; ** POS贷=0, 现金贷=1;
  if target >=0;
  if day_diff > 61;
run;
proc sql ;
	 create table lf.dz0201_data_import_part
	as select acct_loan_no,contract_no,customerid,actualpayfinecnt,kptp,city,max_seq_duedays,incm_times,recent_contact_day,target,state_date_cha,putout_date_cha,sub_product_type,person_app_age,person_sex,credit_amount,rej_count,province,day_diff
 from lf.dz0201_data_import where state_month_cha in ('1610','1611','1612','1701','1702','1702','1703','1704','1705','1706','1707');
run;
data lf.dz0201_data_import_part2;
set lf.dz0201_data_import_part;
  putout_date_pk=input(putout_date_cha,yymmdd10.);
format putout_date_pk yymmdd10.;
  state_date_pk=input(state_date_cha,yymmdd10.);
format state_date_pk yymmdd10.;

run;
proc sql ;
create table lf.m2_poscash_cs_base_v1_1708 as 
select * from lf.m2_poscash_cs_base_v1_process where substr(state_date_cha,1,7)='2017-08';
run;

data lf.dz0201_data_import_part3;
set lf.dz0201_data_import_part2 lf.m2_poscash_cs_base_v1_1708;
run;
proc sql;
select state_month_cha,count(1) as total,sum(target) as bad,sum(target)/count(1) as bad_rate from lf.dz0201_data_import_part4 group by state_month_cha;
quit;
proc sql;
select state_month_cha,sum(flag_target2_hive) from lf.dz0201_data_import group by state_month_cha;
quit;

proc contents data= lf.dz0201_data_import; run;

proc sql;
select state_month_cha, count(*) as n, sum(target)/count(*) as bad_rate  
from lf.dz0201_data_import group by state_month_cha;
quit;
/*统计kptp*/
proc sql;
select state_month_cha,kptp,count(1) from lf.dz0201_data_import group by state_month_cha,kptp;
run;
proc sql outobs=100;
select contract_no,state_date,customerid,acct_loan_no,delay_times,kptp from lf.dz0201_data_import where kptp>7;
run;
proc sql outobs=100;
	select * from f15.daihuankuan_xgb_temp1;
run;
data lf.daihuankuan_xgb_temp1;
	length month1 $4.;
	set f15.daihuankuan_xgb_temp1;
	format month1 $4.;
	informat month1 $4.;
run;
proc sort data=lf.daihuankuan_xgb_temp1;by contract_no month1;run;
proc sort data=lf.dz0201_data_import;by contract_no state_month_cha;run;
data lf.dz0202_data_import;
	merge lf.dz0201_data_import(in=a) lf.daihuankuan_xgb_temp1(in=b rename=(month1=state_month_cha));
	by contract_no state_month_cha;
	if a=1 then output;
run;
proc means data=lf.dz0202_data_import n nmiss mean median min max p5 p10 p25 p50 p75 p90 p95;
var rpy_cn;
run;
proc sql;
select rpy_cn,sum(target) as bad,sum(target)/count(1) as badrate,count(1) as N from lf.dz0202_data_import group by rpy_cn;
run;
****描述统计******************************************************************;
%let var_cont_list =
Target
INTER3_COUNT
CHEXIAO_COUNT
REJ_COUNT
APR_COUNT
APP_COUNT
APR_CREDIT_AMOUNT
APR_PAYMENT_NUM
CREDIT_AMOUNT
INIT_PAY
PAYMENT_RATE
PERIODS
MIN_INIT_RATE
EXTRA_INIT_RATE
MONTHLYINTERESTRATE
MANAGEMENTFEESRATE
CUSTOMERSERVICERATES
SALESCOMMISSION
EFFECTIVEANNUALRATE
PRICE
F_SCORE
PERSON_APP_AGE
CERTF_INTERVAL_YEARS
JOBTIME
LAST3YEAR_WORKCHANGE_NUM
EXPENSE_MONTH
OTHER_INCOME
SELF_INCOME
FAMILY_INCOME
CHILDRENTOTAL
QQNO_INIT
QQ_LENGTH
PAYPRINCIPLE
PAYFEE
PAYPRINCIPALNFEE
PAYINTEAMT
PAYFINE
PAYFINECNT
DUE_PERIODS
ACTUALPAYPRINCIPLE
ACTUALPAYFEE
ACTUALPAYPRINCIPALNFEE
ACTUALPAYINTEAMT
ACTUALPAYFINE
ACTUALPAYFINECNT
FINISH_PERIODS
PAY_PERIODS
SEQ_DELAY_DAYS
ONTIME_PAY
INTIME_PAY
TOT_CREDIT_AMOUNT
DELAY_TIMES
DELAY_DAYS
MAX_CPD
MAX_OVERDUE
ROLL_BACK
MAX_ROLL_SEQ
ROLL_BACK_SEQ
MAX_CONDUE1
CON1_DUE_TIMES
MAX_CONDUE5
CON5_DUE_TIMES
MAX_CONDUE10
CON10_DUE_TIMES
HIS_DUESEQ
IS10FINE
SEQ_DUEDAYS
MAX_SEQ_DUEDAYS
OVER_DUE_VALUE
N_CUR_BALANCE
avg_rollseq
fine10_seq_ratio
value_income_ratio
value_balance_ratio
overdue_periods_ratio
finish_periods_ratio
due_periods_ratio
CS_TIMES
CONTACT
PTP
FNBM_TIMES
INCM_TIMES
HIS_PTPDAYS
CONLOST
LOST
RECENT_CONTACT_DAY
KPTP
BPTP
KPTP_RATIO
BPTP_RATIO
CSFQ
DUE_DELAY_RATIO
DUE_CSTIME_RATIO
DUE_CONTACT_RATIO
DUE_PTP_RATIO
PTP_RATIO
DK_RATIO
totalscore1
AVG_DAYS
f_score_new
f_score_new2
;

%let var_disc_list =
Target
PRODUCTCATEGORYNAME
GOODS_TYPE
OPERATEMODE
PROVINCE
CITY
POS_TYPE
INSURE_STATUS
INSURE_TYPE
CERT_4_INITAL
TOTAL_WK_EXP
RELATIVETYPE
MOST_CONTACT_3M
flag_applyloan
flag_tqww
INNER_CODE
IS_WORK_HR
IS_SUIXINHUAN
PERSON_SEX
FAMILY_STATE
EDUCATION
IS_SSI
HOUSE_TYPE
EMAIL
F_SAME_REG
IS_CERTID_PROVINCE
OTHER_PERSON_TYPE
F_SAME_COM
PUTOUT_SAGROUP
STATE_SAGROUP
isblack
;

/*2.1 对于连续数据变量进行一般的分布统计----means过程*/
ods HTML file="&output_file./02_1_EDA_mean.xls";/*2模型变量均值过程--1_2_EDA_mean.xls*/
proc means data =  lf.dz0201_data_import   /*QMETHOD=P2*/  n nmiss mean median min max p5 p10 p25 p50 p75 p90 p95;
var &var_cont_list.;   
run;
ods html close;

/*1.2、对于离散变量进行一般的分布统计----freq过程*/
ods HTML file="&output_file./02_2_EDA_freq.xls";/*3模型分类变量频数过程--1_3_EDA_freq.xls*/
proc freq data =  lf.dz0201_data_import;
tables &var_disc_list.; /*离散变量才行*/
run;
ods html close;

/*1.5 对于所有数值型连续变量进行一般的分布统计----univariate过程*/
ods HTML file="&output_file./01_&&runDate._EDA_univ.xls";/*1模型单变量分析--1_1_EDA_univ.xlsx*/
proc univariate data =  lf.a0100_mst_ds_&&runDate.;
var &var_cont_list;   
run;
ods html close; 


