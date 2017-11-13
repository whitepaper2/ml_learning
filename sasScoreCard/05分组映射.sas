******************************************************************************;                                                                                                                                
*** 05分组映射                                                             ***;                                                                                                                                 
******************************************************************************; 

****Train********************************************************************;
/*名义变量分组映射*/
data lf.a0501_train_group; set lf.dz0300_train; run;

%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=OPERATEMODE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=PROVINCE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=CITY; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=POS_TYPE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=INSURE_STATUS; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=INSURE_TYPE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=CERT_4_INITAL; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=TOTAL_WK_EXP; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=RELATIVETYPE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=MOST_CONTACT_3M; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=flag_applyloan; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=flag_tqww; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=IS_WORK_HR; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=IS_SUIXINHUAN; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=PERSON_SEX; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=FAMILY_STATE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=EDUCATION; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=IS_SSI; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=HOUSE_TYPE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=EMAIL; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=F_SAME_REG; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=IS_CERTID_PROVINCE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=OTHER_PERSON_TYPE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=F_SAME_COM; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0401_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);

proc sql;
	select distinct education,education_b from lf.a0501_train_group;
run;

/*data lf.a0501_train_group;*/
/*  set lf.a0501_train_group_temp;*/
/*run;*/

/*连续变量分组映射*/
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=INTER3_COUNT; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=CHEXIAO_COUNT; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=REJ_COUNT; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=APR_COUNT; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=APP_COUNT; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=APR_CREDIT_AMOUNT; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=APR_PAYMENT_NUM; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=CREDIT_AMOUNT; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=PERIODS; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=MANAGEMENTFEESRATE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=CUSTOMERSERVICERATES; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=EFFECTIVEANNUALRATE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=PERSON_APP_AGE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=CERTF_INTERVAL_YEARS; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=JOBTIME; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=EXPENSE_MONTH; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=OTHER_INCOME; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=SELF_INCOME; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=FAMILY_INCOME; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=CHILDRENTOTAL; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=QQNO_INIT; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=QQ_LENGTH; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=PAYPRINCIPLE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=PAYFEE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=PAYPRINCIPALNFEE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=PAYINTEAMT; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=PAYFINE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=PAYFINECNT; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=DUE_PERIODS; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=ACTUALPAYPRINCIPLE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=ACTUALPAYFEE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=ACTUALPAYINTEAMT; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=ACTUALPAYFINE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=ACTUALPAYFINECNT; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=FINISH_PERIODS; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=PAY_PERIODS; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=SEQ_DELAY_DAYS; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=ONTIME_PAY; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=INTIME_PAY; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=TOT_CREDIT_AMOUNT; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=DELAY_TIMES; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=DELAY_DAYS; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=MAX_CPD; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=MAX_OVERDUE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=ROLL_BACK; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=MAX_ROLL_SEQ; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=ROLL_BACK_SEQ; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=MAX_CONDUE1; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=CON1_DUE_TIMES; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=MAX_CONDUE5; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=CON5_DUE_TIMES; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=MAX_CONDUE10; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=CON10_DUE_TIMES; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=HIS_DUESEQ; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=IS10FINE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=SEQ_DUEDAYS; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=MAX_SEQ_DUEDAYS; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=OVER_DUE_VALUE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=N_CUR_BALANCE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=avg_rollseq; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=fine10_seq_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=value_income_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=value_balance_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=overdue_periods_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=finish_periods_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=due_periods_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=CS_TIMES; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=CONTACT; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=PTP; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=FNBM_TIMES; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=INCM_TIMES; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=HIS_PTPDAYS; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=CONLOST; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=LOST; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=RECENT_CONTACT_DAY; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=KPTP; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=BPTP; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=KPTP_RATIO; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=BPTP_RATIO; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=CSFQ; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=DUE_DELAY_RATIO; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=DUE_CSTIME_RATIO; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=DUE_CONTACT_RATIO; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=DUE_PTP_RATIO; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=PTP_RATIO; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=DK_RATIO; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=AVG_DAYS; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group_temp; %let DSout=lf.a0501_train_group     ;%let VarX=LAST3YEAR_WORKCHANGE; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0501_train_group     ; %let DSout=lf.a0501_train_group_temp;%let VarX=ACTUALPAYPRINCIPALN; %let NewVarX=&VarX._b; %let DSVarMap=lf.dz0501_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);

/*Double check if all the vars generate _b*/
proc sql;
select a.varnum, a.name, a.type, a.length, a.label, a.format, a.npos, b.nobs                                                                                                     
from dictionary.columns as a , dictionary.tables as b                                                                                                                            
where a.libname=%upcase("lf") and 
      b.libname=%upcase("lf") and                                                                                                        
      a.memname=%upcase("a0501_train_group") and  
      b.memname=%upcase("a0501_train_group") and 
      substr(a.name,length(a.name)-1,2)="_b" order by varnum;                                                                                   
quit;
 
proc sql;
	select distinct education,education_b from lf.a0601_train_woe;
run;

****Validation***************************************************************;
/*名义变量分组映射*/
data lf.a0502_valid_group; set lf.a0205_valid; run;

%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=person_sex; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0301_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=family_state; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0301_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=education; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0301_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=is_ssi; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0301_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=childrentotal; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0301_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=other_person_type; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0301_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=city; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0301_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=is_insure; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0301_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);

/*data lf.a0502_valid_group;*/
/*  set lf.a0502_valid_group_temp;*/
/*run;*/

/*连续变量分组映射*/
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=person_app_age; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=cs_times; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=csfq; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=contact; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=lost; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=ptp; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=his_ptp; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=incm_times; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=kptp; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=bptp; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=avg_days; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=delay_days; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=delay_days_rate; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=max_condue10; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=con10_due_times; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=seq_duedays; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=max_roll_seq; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=value_balance_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=due_cstime_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=due_contact_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=due_ptp_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=avg_rollseq; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=roll_time; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=roll_seq; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=his_delaydays; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=pay_delay_num; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=pay_delay_fee; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=apr_credit_amt; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=credit_amount; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=delay_times; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=max_cpd; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=max_overdue; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=ptp_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=bptp_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group     ; %let DSout=lf.a0502_valid_group_temp; %let VarX=finish_periods_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0502_valid_group_temp; %let DSout=lf.a0502_valid_group     ; %let VarX=dk_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);




****Test*********************************************************************;
/*名义变量分组映射*/
data lf.a0503_test_group; set lf.a0202_Test; run;

%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=person_sex; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0301_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=family_state; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0301_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=education; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0301_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=is_ssi; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0301_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=childrentotal; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0301_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=other_person_type; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0301_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=city; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0301_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=is_insure; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0301_&VarX._map; %ApplyMap1(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);

/*data lf.a0503_test_group;*/
/*  set lf.a0503_test_group_temp;*/
/*run;*/

/*连续变量分组映射*/
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=person_app_age; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=cs_times; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=csfq; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=contact; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=lost; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=ptp; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=his_ptp; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=incm_times; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=kptp; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=bptp; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=avg_days; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=delay_days; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=delay_days_rate; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=max_condue10; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=con10_due_times; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=seq_duedays; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=max_roll_seq; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=value_balance_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=due_cstime_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=due_contact_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=due_ptp_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=avg_rollseq; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=roll_time; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=roll_seq; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=his_delaydays; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=pay_delay_num; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=pay_delay_fee; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=apr_credit_amt; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=credit_amount; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=delay_times; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=max_cpd; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=max_overdue; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=ptp_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=bptp_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group     ; %let DSout=lf.a0503_test_group_temp; %let VarX=finish_periods_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);
%let DSin=lf.a0503_test_group_temp; %let DSout=lf.a0503_test_group     ; %let VarX=dk_ratio; %let NewVarX=&VarX._b; %let DSVarMap=lf.a0401_&VarX._map; %ApplyMap2(&DSin,&VarX,&NewVarX,&DSVarMap,&DSout);

