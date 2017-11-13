******************************************************************************;                                                                                                                                
*** 06变量woe计算与映射                                                    ***;                                                                                                                                 
******************************************************************************;   

****WOE Calculation on Train*************************************************;
data lf.a0601_train_woe; set lf.a0501_train_group_temp; run;

/*调用宏程序*/
%let dvvar=target;
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=OPERATEMODE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=PROVINCE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=CITY; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=POS_TYPE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=INSURE_STATUS; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=INSURE_TYPE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=CERT_4_INITAL; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=TOTAL_WK_EXP; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=RELATIVETYPE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=MOST_CONTACT_3M; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=flag_applyloan; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=flag_tqww; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=IS_WORK_HR; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=IS_SUIXINHUAN; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=PERSON_SEX; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=FAMILY_STATE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=EDUCATION; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=IS_SSI; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=HOUSE_TYPE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=EMAIL; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=F_SAME_REG; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=IS_CERTID_PROVINCE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=OTHER_PERSON_TYPE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=F_SAME_COM; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);

%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=INTER3_COUNT; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=CHEXIAO_COUNT; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=REJ_COUNT; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=APR_COUNT; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=APP_COUNT; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=APR_CREDIT_AMOUNT; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=APR_PAYMENT_NUM; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=CREDIT_AMOUNT; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=PERIODS; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=MANAGEMENTFEESRATE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=CUSTOMERSERVICERATES; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=EFFECTIVEANNUALRATE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=PERSON_APP_AGE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=CERTF_INTERVAL_YEARS; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=JOBTIME; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=EXPENSE_MONTH; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=OTHER_INCOME; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=SELF_INCOME; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=FAMILY_INCOME; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=CHILDRENTOTAL; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=QQNO_INIT; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=QQ_LENGTH; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=PAYPRINCIPLE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=PAYFEE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=PAYPRINCIPALNFEE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=PAYINTEAMT; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=PAYFINE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=PAYFINECNT; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=DUE_PERIODS; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=ACTUALPAYPRINCIPLE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=ACTUALPAYFEE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=ACTUALPAYINTEAMT; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=ACTUALPAYFINE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=ACTUALPAYFINECNT; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=FINISH_PERIODS; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=PAY_PERIODS; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=SEQ_DELAY_DAYS; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=ONTIME_PAY; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=INTIME_PAY; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=TOT_CREDIT_AMOUNT; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=DELAY_TIMES; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=DELAY_DAYS; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=MAX_CPD; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=MAX_OVERDUE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=ROLL_BACK; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=MAX_ROLL_SEQ; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=ROLL_BACK_SEQ; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=MAX_CONDUE1; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=CON1_DUE_TIMES; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=MAX_CONDUE5; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=CON5_DUE_TIMES; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=MAX_CONDUE10; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=CON10_DUE_TIMES; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=HIS_DUESEQ; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=IS10FINE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=SEQ_DUEDAYS; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=MAX_SEQ_DUEDAYS; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=OVER_DUE_VALUE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=N_CUR_BALANCE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=avg_rollseq; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=fine10_seq_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=value_income_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=value_balance_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=overdue_periods_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=finish_periods_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=due_periods_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=CS_TIMES; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=CONTACT; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=PTP; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=FNBM_TIMES; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=INCM_TIMES; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=HIS_PTPDAYS; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=CONLOST; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=LOST; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=RECENT_CONTACT_DAY; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=KPTP; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=BPTP; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=KPTP_RATIO; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=BPTP_RATIO; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=CSFQ; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=DUE_DELAY_RATIO; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=DUE_CSTIME_RATIO; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=DUE_CONTACT_RATIO; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=DUE_PTP_RATIO; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=PTP_RATIO; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=DK_RATIO; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=AVG_DAYS; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe_temp; %let DSout=lf.a0601_train_woe     ;%let var=LAST3YEAR_WORKCHANGE; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_train_woe     ; %let DSout=lf.a0601_train_woe_temp;%let var=ACTUALPAYPRINCIPALN; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);

data lf.a0601_train_woe;
  set lf.a0601_train_woe_temp;
run;


/*WOE结果汇总*/
proc sql;
create table varlist as
select a.varnum, a.name, a.type, a.length, a.label, a.format, a.npos, b.nobs
from dictionary.columns as a , dictionary.tables as b
where a.libname=%upcase("lf") and 
      b.libname=%upcase("lf") and                                                                                                        
      a.memname=%upcase("a0601_train_woe") and  
      b.memname=%upcase("a0601_train_woe") and 
      substr(a.name,length(a.name)-3,4)="_woe" order by varnum;                                                                                   
quit;                                                                                                                                                                            

data _null_;                                          
  set varlist;                                          
  call symput('varn'||left(put(_n_,4.)),compress(varnum));                                                   
  call symput('name'||left(put(_n_,4.)),substr(trim(name),1,length(trim(name))-4));                                                           
run;  
%put &=varn1 &=name1; 
%put &=varn2 &=name2; 

proc sql; 
select count(varnum) into: varnum_count from varlist; 
quit;   

%macro woe_summary;
proc sql;  
create table lf.a0602_woe_summary
(
  VAR_NAME  CHAR(32),
  bin       INTEGER,
  WOE       num
);

%do i= 1 %to &varnum_count.;
insert into lf.a0602_woe_summary
select distinct "&&name&i." as VAR_NAME
       ,&&name&i.._b as bin
       ,WOE
from  lf.a0601_&&name&i.._woe;
%end;
quit;
%mend;
%woe_summary;


****WOE Application on Validation & Test*************************************;
/*Validation*/
data lf.a0601_valid_woe; set lf.a0502_valid_group; run;

%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=person_sex; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=family_state; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=education; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=is_ssi; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=childrentotal; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=other_person_type; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=city; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=is_insure; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=person_app_age; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=cs_times; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=csfq; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=contact; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=lost; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=ptp; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=his_ptp; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=incm_times; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=kptp; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=bptp; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=avg_days; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=delay_days; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=delay_days_rate; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=max_condue10; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=con10_due_times; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=seq_duedays; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=max_roll_seq; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=value_balance_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=due_cstime_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=due_contact_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=due_ptp_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=avg_rollseq; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=roll_time; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=roll_seq; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=his_delaydays; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=pay_delay_num; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=pay_delay_fee; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=apr_credit_amt; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=credit_amount; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=delay_times; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=max_cpd; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=max_overdue; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=ptp_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=bptp_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe     ; %let DSout=lf.a0601_valid_woe_temp; %let var=finish_periods_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_valid_woe_temp; %let DSout=lf.a0601_valid_woe     ; %let var=dk_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);


/*Test*/
data lf.a0601_test_woe; set lf.a0503_test_group; run;

%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=person_sex; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=family_state; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=education; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=is_ssi; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=childrentotal; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=other_person_type; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=city; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=is_insure; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=person_app_age; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=cs_times; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=csfq; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=contact; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=lost; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=ptp; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=his_ptp; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=incm_times; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=kptp; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=bptp; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=avg_days; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=delay_days; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=delay_days_rate; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=max_condue10; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=con10_due_times; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=seq_duedays; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=max_roll_seq; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=value_balance_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=due_cstime_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=due_contact_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=due_ptp_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=avg_rollseq; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=roll_time; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=roll_seq; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=his_delaydays; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=pay_delay_num; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=pay_delay_fee; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=apr_credit_amt; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=credit_amount; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=delay_times; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=max_cpd; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=max_overdue; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=ptp_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=bptp_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe     ; %let DSout=lf.a0601_test_woe_temp; %let var=finish_periods_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
%let DSin=lf.a0601_test_woe_temp; %let DSout=lf.a0601_test_woe     ; %let var=dk_ratio; %let ivvar=&var._b; %let woeds=lf.a0601_&var._woe; %let WOEVar=&var._woe; %CalcWOE2(&DsIn,&IVVar,&DVVar,&WOEDS,&WOEVar,&DSout);
