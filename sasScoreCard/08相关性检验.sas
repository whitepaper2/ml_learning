******************************************************************************;                                                                                                                                
*** 08相关性检验                                                           ***;                                                                                                                                 
******************************************************************************; 
%let varlist= 
KPTP_woe
ACTUALPAYFINECNT_woe
INCM_TIMES_woe
MAX_ROLL_SEQ_woe
CERT_4_INITAL_woe
CITY_woe
CON1_DUE_TIMES_woe
INSURE_TYPE_woe
PERSON_APP_AGE_woe
AVG_DAYS_woe
flag_tqww_woe
FAMILY_STATE_woe
IS_SUIXINHUAN_woe
RECENT_CONTACT_DAY_woe
APP_COUNT_woe
REJ_COUNT_woe
IS_SSI_woe
CREDIT_AMOUNT_woe
MAX_SEQ_DUEDAYS_woe
person_sex_woe
;

proc corr data=lf.a0701_train_woe outp=lf.a0801_corr_short;
var &varlist;
run;
PROC EXPORT DATA= lf.a0801_corr_short
            OUTFILE= "&output_file./a0801_corr_short.xlsx" 
            DBMS=xlsx REPLACE;
     SHEET="var_corr"; 
RUN;

