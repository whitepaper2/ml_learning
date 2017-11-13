******************************************************************************;                                                                                                                                
*** 12变量稳定性分月占比                                                   ***;                                                                                                                                 
******************************************************************************; 

data varlist;
  input name $32.;
  cards;
KPTP_b
ACTUALPAYFINECNT_b
INCM_TIMES_b
CITY_b
PERSON_APP_AGE_b
RECENT_CONTACT_DAY_b
REJ_COUNT_b
CREDIT_AMOUNT_b
MAX_SEQ_DUEDAYS_b
  ;
run; 

data _null_;                                          
  set varlist;                                          
  call symput('varn'||left(put(_n_,4.)),compress(_n_));                                                   
  call symput('name'||left(put(_n_,4.)),trim(name));                                                           
run;  
%put &=varn1 &=name1; 
%put &=varn2 &=name2; 

proc sql; 
select count(name) into: varnum_count from varlist; 
quit;   

%macro var_stable(dsin,dsout);
proc sql;  
create table &dsout.
(
  month     CHAR(10),
  VAR_NAME  CHAR(32),
  clus      INTEGER,
  N         INTEGER,
  N1        INTEGER,
  bad_rate  DECIMAL(8,4)

);

%do i= 1 %to &varnum_count.;
insert into &dsout.
select state_month_cha as month 
       ,"&&name&i." as VAR_NAME
       ,&&name&i. as clus
       ,count(1) as N 
       ,sum(target) as N1
       ,sum(target)/count(1) as bad_rate
from  &dsin. 
group by state_month_cha, &&name&i.;
%end;
quit;

%mend;
%let dsin=lf.a1601_&model_name._score2;
%let dsout=lf.a1702_stable_perf_pct;%var_stable(&dsin,&dsout);


/*test集合 */
data lf_xy.dz1101_varlist;
  input name $32.;
  cards;
bptp_ratio_b		 
roll_seq_b		   
ptp_ratio_b		   
delay_days_rate_b
city_b         
education_b		   
person_sex_b		 
max_cpd_b		     

;
run; 

%macro var_perf(varlist,var_num_group,dsin,dsout);
data _null_;                                          
  set &varlist.;                                          
  call symput('varn'||left(put(_n_,4.)),compress(_n_));                                                   
  call symput('name'||left(put(_n_,4.)),trim(name));                                                           
run;  
%put &=varn1 &=name1; 
%put &=varn2 &=name2; 

proc sql; 
select count(name) into: varnum_count from &varlist.; 
quit;   

proc sql;  
create table &dsout.
(
  month1    CHAR(10),
  VAR_NAME  CHAR(32),
  clus      INTEGER,
  N         INTEGER,
  N1        INTEGER,
  N0        INTEGER
);

%do i= 1 %to &varnum_count.;
insert into &dsout.
select distinct substr(state_date,1,7) as month1, substr("&&name&i.",1,length("&&name&i.")-2) as VAR_NAME
       ,&&name&i. as clus
       ,count(1) as N 
       ,sum(target) as N1
	   ,count(1)-sum(target) as N0
from  &dsin. 
group by month1,&&name&i.;
%end;
quit;

proc sort data= &dsout.;          by Var_Name clus; run;
proc sort data= &var_num_group.;  by Var_Name Bin;  run;

data &dsout.;
  retain month1 VAR_NAME LL UL 
         N N0 N1 clus
  ;
  merge &dsout.          (in=a)
		&var_num_group   (in=c keep=Var_Name Bin LL UL rename=(bin=clus))
  ;
  by Var_Name clus;
  if a;
  keep month1 VAR_NAME LL UL 
       N N0 N1 clus
  ;
run;

data lf_xy.model_stability_01(keep=month1 VAR_NAME clus N N0 N1 badrate VAR_NAME1);
set &dsout.;
badrate=N1/N;
VAR_NAME1=tranwrd(VAR_NAME,'_b','') ;
run;

proc sql;
select month1,VAR_NAME1,sum(n1) as n1_total,sum(n0) as n0_total
from lf_xy.model_stability_01
group by month1,VAR_NAME1
;
run;

proc sql;
create table lf_xy.model_stability_02 as
select substr(month1,3,2)||substr(month1,6,2) as month1,VAR_NAME1,clus,N,badrate,
       log((case when n1=0 then 0.001 else n1/n1_total end)/((case when n0=0 then 0.1 else n0 end)/n0_total)) as woe,
       (n1/n1_total-n0/n0_total)*log((case when n1=0 then 0.001 else n1/n1_total end)/((case when n0=0 then 0.1 else n0 end)/n0_total)) as iv,
       '2017-11-02' as create_date
from
(select t1.* from lf_xy.model_stability_01 t1
  left join  
(select month1,VAR_NAME1,sum(n1) as n1_total,sum(n0) as n0_total
from lf_xy.model_stability_01
group by month1,VAR_NAME1) t2
on t1.month1=t2.month1 and t1.VAR_NAME1=t2.VAR_NAME1
) t0
where substr(month1,3,2)||substr(month1,6,2)<>'1710'
order by  month1,VAR_NAME1,clus
;
run;

%mend;
%let varlist = lf_xy.dz1101_varlist;
%let var_num_group = lf_zdy.a0402_var_num_group;
%let dsin    = lf_xy.lf.a0701_test_woe;/*样本外test输入数据集*/
%let dsout   = lf_xy.dz0303_test_var_perf;
%var_perf(&varlist,&var_num_group,&dsin,&dsout);