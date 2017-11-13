%let DSin   = lf.dz0300_train; /*输入数据集*/
%let DVVar  = target;           /*因变量*/
%let Method = 4;                /*1.基尼方差；2.熵方差；3.皮尔森卡方统计量；4.信息值*/
%let Mmax   = 5;                /*最大分组数量*/

%let IVVar=PRODUCTCATEGORYNAME; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=GOODS_TYPE; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=OPERATEMODE; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=PROVINCE; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=CITY; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=POS_TYPE; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=INSURE_STATUS; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=INSURE_TYPE; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=CERT_4_INITAL; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=TOTAL_WK_EXP; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=RELATIVETYPE; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=MOST_CONTACT_3M; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=flag_applyloan; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=flag_tqww; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=INNER_CODE; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=IS_WORK_HR; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=IS_SUIXINHUAN; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=PERSON_SEX; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=FAMILY_STATE; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=EDUCATION; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=IS_SSI; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=HOUSE_TYPE; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=EMAIL; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=F_SAME_REG; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=IS_CERTID_PROVINCE; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=OTHER_PERSON_TYPE; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=F_SAME_COM; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=PUTOUT_SAGROUP; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=STATE_SAGROUP; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);
%let IVVar=isblack; %let DSVarMap=lf.dz0401_&IVVar._map; %ReduceCats(&DSin,&IVVar,&DVVar,&Method,&Mmax,&DSVarMap);


/*查看名义变量分组结果*/
data var_list_char;
  input Var_Name $32.;
  cards;
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
  ;
run;

data _null_;                                          
  set var_list_char;                                          
  call symput('varn'||left(put(_n_,4.)),compress(_n_));                                                   
  call symput('name'||left(put(_n_,4.)),trim(Var_Name));                                                           
run;  
%put &=varn1 &=name1; 
%put &=varn2 &=name2; 

proc sql; 
select count(Var_Name) into: varnum_count from var_list_char; 
quit;   

%macro var_char_group;
proc sql;  
create table lf.dz0402_var_char_group
(
  Var_Name  CHAR(32),
  Var_Value CHAR(400),
  total     INTEGER,
  Bin       INTEGER,
  Category  CHAR(400)
);

%do i= 1 %to &varnum_count.;
insert into lf.dz0402_var_char_group
select distinct "&&name&i." as VAR_NAME
       ,strip(&&name&i.) as Var_Value
       ,total
       ,Bin
       ,strip(Category) as Category
from  lf.dz0401_&&name&i.._map
;
%end;
quit;

proc sort data= lf.dz0402_var_char_group; by Var_Name Bin; run;
proc delete data= var_list_char; run;
%mend;
%var_char_group;
