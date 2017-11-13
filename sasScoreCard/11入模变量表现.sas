
%let Dsin = lf.a0601_train_woe;
%let VarList = lf.a1101_var_list;
%let Dvvar = target;
%let Dsout = lf.a1102_invar_performance;
data &VarList;
  input Var_Name $32.;
  cards;
PTP_woe
BPTP_woe
HIS_PTPDAYS_woe
KPTP_woe
PTP_RATIO_woe
KPTP_RATIO_woe
BPTP_RATIO_woe
CONTACT_woe
MOST_CONTACT_3M_woe
DUE_PTP_RATIO_woe
ROLL_BACK_woe
DELAY_TIMES_woe
ROLL_BACK_SEQ_woe
ACTUALPAYFINECNT_woe
overdue_periods_ratio_woe
CON5_DUE_TIMES_woe
MAX_CONDUE5_woe
HIS_DUESEQ_woe
MAX_CONDUE1_woe
CS_TIMES_woe
ACTUALPAYFINE_woe
CON10_DUE_TIMES_woe
PAYFINECNT_woe
DELAY_DAYS_woe
MAX_CONDUE10_woe
finish_periods_ratio_woe
PAY_PERIODS_woe
MAX_ROLL_SEQ_woe
FINISH_PERIODS_woe
due_periods_ratio_woe
DUE_CSTIME_RATIO_woe
INCM_TIMES_woe
ACTUALPAYPRINCIPLE_woe
ACTUALPAYFEE_woe
DUE_PERIODS_woe
PAYFINE_woe
CSFQ_woe
PAYPRINCIPALNFEE_woe
PAYPRINCIPLE_woe
CERT_4_INITAL_woe
CITY_woe
avg_rollseq_woe
fine10_seq_ratio_woe
IS10FINE_woe
PAYFEE_woe
CON1_DUE_TIMES_woe
ACTUALPAYINTEAMT_woe
AVG_DAYS_woe
PERSON_APP_AGE_woe
INSURE_TYPE_woe
OVER_DUE_VALUE_woe
DUE_CONTACT_RATIO_woe
SEQ_DUEDAYS_woe
TOTAL_WK_EXP_woe
CERTF_INTERVAL_YEARS_woe
PAYINTEAMT_woe
DUE_DELAY_RATIO_woe
PROVINCE_woe
DK_RATIO_woe
FAMILY_STATE_woe
EDUCATION_woe
value_income_ratio_woe
IS_SUIXINHUAN_woe
N_CUR_BALANCE_woe
value_balance_ratio_woe
SEQ_DELAY_DAYS_woe
RECENT_CONTACT_DAY_woe
APR_PAYMENT_NUM_woe
MAX_CPD_woe
APP_COUNT_woe
flag_applyloan_woe
RELATIVETYPE_woe
QQNO_INIT_woe
MAX_OVERDUE_woe
QQ_LENGTH_woe
HOUSE_TYPE_woe
OTHER_PERSON_TYPE_woe
POS_TYPE_woe
REJ_COUNT_woe
INTIME_PAY_woe
ONTIME_PAY_woe
CONLOST_woe
CHILDRENTOTAL_woe
IS_SSI_woe
INSURE_STATUS_woe
CREDIT_AMOUNT_woe
LOST_woe
EXPENSE_MONTH_woe
EFFECTIVEANNUALRATE_woe
INTER3_COUNT_woe
PERIODS_woe
CUSTOMERSERVICERATES_woe
MANAGEMENTFEESRATE_woe
MAX_SEQ_DUEDAYS_woe
APR_CREDIT_AMOUNT_woe
TOT_CREDIT_AMOUNT_woe
SELF_INCOME_woe
EMAIL_woe
APR_COUNT_woe
IS_CERTID_PROVINCE_woe
FNBM_TIMES_woe
FAMILY_INCOME_woe
OTHER_INCOME_woe
PERSON_SEX_woe
JOBTIME_woe
F_SAME_REG_woe
IS_WORK_HR_woe
OPERATEMODE_woe
CHEXIAO_COUNT_woe
F_SAME_COM_woe
  ;
run;
data _null_;                                          
  set &VarList;                                          
  call symput('varn'||left(put(_n_,4.)),compress(_n_));                                                   
  call symput('name'||left(put(_n_,4.)),substr(trim(Var_Name),1,length(trim(Var_Name))-4));                                                           
run;  
%put &=varn1 &=name1; 
%put &=varn2 &=name2; 

proc sql; 
select count(Var_Name) into: varnum_count from &VarList; 
quit;
%macro inVarPerformace(Dsin, Dvvar, VarList, Dsout);
	proc sql;  
	create table &Dsout
	(
	  VAR_NAME  CHAR(32),
	  bin       INTEGER,
	  total     INTEGER,
	  good      INTEGER,
      bad       INTEGER,
	  badrate       num,
	  WOE       num 
	  
	);

	%do i= 1 %to &varnum_count.;
		insert into &Dsout
		select "&&name&i." as VAR_NAME
		       ,&&name&i.._b as bin			   
			   ,count(1) as total
			   ,count(1)-sum(&Dvvar) as good
			   ,sum(&Dvvar) as bad 
			   ,sum(&Dvvar)/count(1) as badrate
			   ,&&name&i.._woe as woe
		from  &Dsin
		group by &&name&i.._b 
			   ,&&name&i.._woe;
		%end;
	quit;
%mend;

%inVarPerformace(&Dsin,&Dvvar,&VarList,&Dsout);

proc sort data=lf.a0402_var_num_group;by var_name bin;
proc sort data=lf.a1102_invar_performance;by var_name bin;
data lf.a1103_invar_merge;
	merge lf.a0402_var_num_group(in=f1) lf.a1102_invar_performance(in=f2);
	by var_name bin;
	if f2 ;
run;