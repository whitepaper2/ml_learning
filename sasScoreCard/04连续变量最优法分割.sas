******************************************************************************;                                                                                                                                
*** 05连续变量最优法分割                                                   ***;                                                                                                                                 
******************************************************************************; 
/*调用宏程序*/
%let DSin   = lf.dz0300_train;
%let DVVar  = target;
%let Method = 4;
%let MMax   = 5;
%let Acc    = 0.05;

%let IVVar=rpy_cn; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=INTER3_COUNT; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=CHEXIAO_COUNT; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=REJ_COUNT; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=APR_COUNT; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=APP_COUNT; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=APR_CREDIT_AMOUNT; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=APR_PAYMENT_NUM; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=CREDIT_AMOUNT; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=INIT_PAY; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=PAYMENT_RATE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=PERIODS; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=MIN_INIT_RATE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=EXTRA_INIT_RATE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=MONTHLYINTERESTRATE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=MANAGEMENTFEESRATE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=CUSTOMERSERVICERATES; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=SALESCOMMISSION; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=EFFECTIVEANNUALRATE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=PRICE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=F_SCORE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=PERSON_APP_AGE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=CERTF_INTERVAL_YEARS; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=JOBTIME; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=LAST3YEAR_WORKCHANGE_NUM; %let DSVarMap=lf.dz0501_LAST3YEAR_WORKCHANGE_map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=EXPENSE_MONTH; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=OTHER_INCOME; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=SELF_INCOME; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=FAMILY_INCOME; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=CHILDRENTOTAL; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=QQNO_INIT; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=QQ_LENGTH; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=PAYPRINCIPLE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=PAYFEE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=PAYPRINCIPALNFEE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=PAYINTEAMT; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=PAYFINE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=PAYFINECNT; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=DUE_PERIODS; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=ACTUALPAYPRINCIPLE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=ACTUALPAYFEE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=ACTUALPAYPRINCIPALNFEE; %let DSVarMap=lf.dz0501_ACTUALPAYPRINCIPALN_map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=ACTUALPAYINTEAMT; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=ACTUALPAYFINE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=ACTUALPAYFINECNT; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=FINISH_PERIODS; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=PAY_PERIODS; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=SEQ_DELAY_DAYS; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=ONTIME_PAY; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=INTIME_PAY; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=TOT_CREDIT_AMOUNT; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=DELAY_TIMES; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=DELAY_DAYS; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=MAX_CPD; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=MAX_OVERDUE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=ROLL_BACK; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=MAX_ROLL_SEQ; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=ROLL_BACK_SEQ; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=MAX_CONDUE1; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=CON1_DUE_TIMES; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=MAX_CONDUE5; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=CON5_DUE_TIMES; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=MAX_CONDUE10; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=CON10_DUE_TIMES; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=HIS_DUESEQ; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=IS10FINE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=SEQ_DUEDAYS; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=MAX_SEQ_DUEDAYS; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=OVER_DUE_VALUE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=N_CUR_BALANCE; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=avg_rollseq; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=fine10_seq_ratio; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=value_income_ratio; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=value_balance_ratio; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=overdue_periods_ratio; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=finish_periods_ratio; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=due_periods_ratio; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=CS_TIMES; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=CONTACT; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=PTP; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=FNBM_TIMES; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=INCM_TIMES; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=HIS_PTPDAYS; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=CONLOST; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=LOST; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=RECENT_CONTACT_DAY; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=KPTP; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=BPTP; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=KPTP_RATIO; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=BPTP_RATIO; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=CSFQ; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=DUE_DELAY_RATIO; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=DUE_CSTIME_RATIO; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=DUE_CONTACT_RATIO; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=DUE_PTP_RATIO; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=PTP_RATIO; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=DK_RATIO; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=totalscore1; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);
%let IVVar=AVG_DAYS; %let DSVarMap=lf.dz0501_&IVVar._map; %BinContVar(&DSin,&IVVar,&DVVar,&Method,&MMax,&Acc,&DSVarMap);


/*查看连续变量分组结果*/
data var_list_cont;
  input Var_Name $32.;
  cards;
INTER3_COUNT
CHEXIAO_COUNT
REJ_COUNT
APR_COUNT
APP_COUNT
APR_CREDIT_AMOUNT
APR_PAYMENT_NUM
CREDIT_AMOUNT
PERIODS
MANAGEMENTFEESRATE
CUSTOMERSERVICERATES
EFFECTIVEANNUALRATE
PERSON_APP_AGE
CERTF_INTERVAL_YEARS
JOBTIME
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
AVG_DAYS
LAST3YEAR_WORKCHANGE
ACTUALPAYPRINCIPALN
  ;
run;

data _null_;                                          
  set var_list_cont;                                          
  call symput('varn'||left(put(_n_,4.)),compress(_n_));                                                   
  call symput('name'||left(put(_n_,4.)),trim(Var_Name));                                                           
run;  
%put &=varn1 &=name1; 
%put &=varn2 &=name2; 

proc sql; 
select count(Var_Name) into: varnum_count from var_list_cont; 
quit;   

%macro var_num_group;
proc sql;  
create table lf.a0402_var_num_group
(
  Var_Name  CHAR(32),
  LL        DECIMAL(8,4),
  UL        DECIMAL(8,4),
  BinTotal  INTEGER,
  Bin       INTEGER
);

%do i= 1 %to &varnum_count.;
insert into lf.a0402_var_num_group
select distinct "&&name&i." as VAR_NAME, *
from  lf.dz0501_&&name&i.._map
;
%end;
quit;

proc delete data= var_list_cont; run;
%mend;
%var_num_group;


/*连续变量映射上下界修改:使上下界连续*/
%macro Bound_Replace(BinDS);
proc sql;
select max(bin) into: Bmax from &BinDS;
quit;

%do i=1 %to &Bmax;
  %local temp_ll&i temp_ul&i;
%end;

lfa _null_;
  set &BinDS;
  call symput ("temp_ll"||left(_N_),LL);
  call symput ("temp_ul"||left(_N_),UL);
run;
%put &=Bmax &=temp_ll1 &=temp_ul2;

lfa &BinDS._b;
  set &BinDS;
run;

lfa &BinDS;
  set &BinDS;
  n=_N_;
  %do i=1 %to (&Bmax-1);
    if n=(&i.+1) then LL = &&temp_ul&i;
  %end;
  drop n;
run;
%mend;

