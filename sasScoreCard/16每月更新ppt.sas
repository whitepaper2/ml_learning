/*����hive201610-201708*/
proc contents data=lf.dz0201_data_import;run;
proc contents data=lf.m2_poscash_cs_base_v1_process;run;
/*���е����ݣ�Oracleȫ������ lf.dz0201_data_import */
proc sql ;
	 create table lf.dz0201_data_import_part
	as select acct_loan_no,contract_no,customerid,actualpayfinecnt,kptp,city,max_seq_duedays,incm_times,recent_contact_day,target,state_date_cha,putout_date_cha,state_month_cha,putout_month_cha,sub_product_type,person_app_age,person_sex,credit_amount,rej_count,province,day_diff
 from lf.dz0201_data_import where state_month_cha in ('1610','1611','1612','1701','1702','1702','1703','1704','1705','1706','1707');
run;
data lf.dz0201_data_import_part2;
set lf.dz0201_data_import_part;
  putout_date_pk=input(putout_date_cha,yymmdd10.);
format putout_date_pk yymmdd10.;
  state_date_pk=input(state_date_cha,yymmdd10.);
format state_date_pk yymmdd10.;

run;
/*1������ÿ������*/
proc sql;                                                                                                                               
create table lf.m2_poscash_cs_base_v1  as                                                                                                              
select acct_loan_no,contract_no,customerid,actualpayfinecnt,kptp,city,max_seq_duedays,incm_times,recent_contact_day,target,state_date,putout_date,sub_product_type,person_app_age,person_sex,credit_amount,rej_count,province
from tmp_dcc.zdy_m2_cs_BASE_V1_target910
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

data lf.m2_poscash_cs_base_v1_process;
set lf.m2_poscash_cs_base_v1(rename=(putout_date=putout_date_cha state_date=state_date_cha ));
  ** ���ڴ��� **;
  putout_month_cha=substr(putout_date_cha,3,2)||substr(putout_date_cha,6,2);
  state_month_cha=substr(state_date_cha,3,2)||substr(state_date_cha,6,2);
  putout_date_pk=input(putout_date_cha,yymmdd10.);
format putout_date_pk yymmdd10.;
  state_date_pk=input(state_date_cha,yymmdd10.);
format state_date_pk yymmdd10.;
day_diff=state_date_pk-putout_date_pk;

  ** Data Subset **;
  if sub_product_type = 1; ** POS��=0, �ֽ��=1;
  if target >=0;
  if day_diff > 61;
run;
/*1709���ݿ��ã�1710������*/
proc sql ;
create table lf.m2_poscash_cs_base_v1_910 as 
select * from lf.m2_poscash_cs_base_v1_process where state_month_cha in ('1709','1710');
run;

/*1708���ݣ�lf.m2_poscash_cs_base_v1_1708*/
/*����1709,�´θ���ʹ��*/
proc sql ;
create table lf.m2_poscash_cs_base_v1_1709 as 
select * from lf.m2_poscash_cs_base_v1_process where state_month_cha='1709';
run;

data lf.dz0201_data_import_part3;
set lf.dz0201_data_import_part2 lf.m2_poscash_cs_base_v1_1708
lf.m2_poscash_cs_base_v1_910;
run;
/*1\ͳ�������ſ�*/
proc sql;
	select state_month_cha,count(1) as total,sum(target) as bad,sum(target)/count(1) as bad_rate from lf.dz0201_data_import_part3 group by state_month_cha;
quit;
/*�������ݼ���ֻ�����test����ͬ*/
data lf.dz0300_train lf.dz0300_valid lf.dz0300_test;
  set lf.dz0201_data_import_part3;
  if state_month_cha in('1610','1611','1612','1701','1702') then output lf.dz0300_train;
  else if state_month_cha in('1703','1704') then output lf.dz0300_valid;
  else output lf.dz0300_test;
run;

%let runData=test;
data lf.a0701_&&runData._group;
	set lf.dz0300_&&runData.;
	if city in('������',
'��Ҵ��',
'˫Ѽɽ��',
'��ͨ��',
'ʮ����',
'������',
'�γ���',
'��ƽ��',
'��ˮ��',
'������',
'�׳���',
'�ػʵ���',
'ʡֱϽ�ؼ���������',
'������',
'������',
'ͭ����',
'������',
'������',
'������',
'������',
'¦����',
'������',
'������',
'������',
'������',
'פ�����',
'��Ӫ��',
'�żҽ���',
'������',
'��Ϫ��',
'������',
'��ˮ��',
'�żҿ���',
'¤����',
'������',
'�˲���',
'���ױ�����',
'�ϳ���',
'������',
'������',
'������',
'������',
'������',
'�������������',
'����Ͽ��',
'�����׶���',
'������',
'������',
'ʡֱϽ������λ',
'�����'
) then city_b=1;
	else if city in ('������',
'��˳��',
'�人��',
'������',
'������',
'��β��',
'Т����',
'տ����',
'������',
'�Ͻ���',
'�ٷ���',
'üɽ��',
'������',
'������',
'������',
'��ɽ��',
'��ɽ��',
'������',
'����',
'������',
'������',
'������',
'������',
'Ϋ����',
'ï����',
'���Ƹ���',
'�Ϻ���',
'������',
'�����첼��',
'�����',
'�Ž���',
'ǭ���ϲ���������������',
'ĵ������',
'������',
'ǭ�������嶱��������',
'������',
'μ����',
'������',
'������',
'�ع���',
'����ˮ��',
'������',
'������',
'��ʩ����������������',
'������',
'�ٲ���',
'������',
'̩����',
'�˳���',
'������',
'Ȫ����',
'������',
'��˳��',
'��ӹ���������������',
'��Դ��',
'������',
'����',
'�е���',
'�ܿ���',
'������',
'�ں���',
'�ױ���',
'��ɽ��',
'�ӱ߳�����������',
'������',
'�Թ���',
'������',
'������',
'��Ϫ��',
'̨����',
'�������������',
'������',
'�����',
'������',
'������',
'�˰���',
'������',
'������',
'������',
'������',
'��ʯ��',
'������',
'������',
'������',
'��Ԫ��',
'��̨����',
'��ͷ��',
'�Ӱ���',
'��Ǩ��',
'������',
'�Ƹ���',
'������',
'������',
'������',
'�Ƹ���',
'��������������������',
'̩����'
) then city_b=2;
else if city in('������',
'������',
'�º���徰����������',
'ƽ����',
'ͭ����',
'������',
'������',
'�ն���',
'������',
'������',
'������',
'��̨��',
'˷����',
'���Ǹ���',
'������',
'������',
'�Ͳ���',
'������',
'������',
'������',
'������',
'�ڽ���',
'������',
'��ԭ��',
'������',
'÷����',
'������',
'������',
'Ƽ����',
'��ƽ��',
'������',
'������',
'�麣��',
'�ϲ���',
'���������',
'�ȷ���',
'ͨ����',
'������',
'������',
'ͨ����',
'������',
'������',
'��ݸ��',
'��������������',
'̫ԭ��',
'�ൺ��',
'������',
'�˴���',
'������',
'������',
'��˫���ɴ���������',
'������',
'������',
'ʯ��ׯ��',
'������',
'������',
'������',
'������',
'�ߺ���',
'��ɳ��',
'������',
'��ɽ��',
'��ɽ��',
'�����',
'������',
'��ɽ��',
'������',
'��Զ��',
'������',
'�׸���',
'������',
'������',
'��������',
'������',
'������',
'ƽ��ɽ��',
'������',
'��֦����',
'������',
'ǭ�ϲ���������������',
'������',
'�㰲��',
'������',
'��ͬ��',
'�绯��',
'�Ű���',
'��ɽ����������',
'��«����',
'���ֹ�����',
'������',
'Ӫ����',
'������',
'������',
'�����',
'֣����',
'������',
'�˱���',
'������˹��',
'��ľ˹��',
'������',
'��Դ��',
'��������',
'��̶��'
) then city_b=3;
else if city in ('������',
'������',
'�����',
'������',
'������',
'�ĳ���',
'������',
'������',
'��ɽ��',
'������',
'������',
'���ͺ�����',
'������',
'ʡֱϽ�ؼ�������λ',
'��ɽ��',
'������',
'�ɶ���',
'�Ͼ���',
'��Ȫ��',
'ӥ̶��',
'������',
'��ɽ��',
'������',
'������',
'��ɫ��',
'������',
'������',
'�Ϸ���'
) then city_b=4;
else if city in ('ͭ����',
'��ɽ��',
'��Ȫ��',
'��ͨ��',
'������',
'������',
'������',
'��ɽ׳������������',
'�����',
'�ӳ���',
'������',
'������',
'������',
'��ͷ��',
'������',
'��ˮ��',
'�̽���',
'������',
'��ׯ��',
'������',
'��̨��'
) then city_b=5;
else city_b=1;
if 17<=person_app_age<21.7 then person_app_age_b=1;
	else if person_app_age<25.4 then person_app_age_b=2;
	else if person_app_age<27.25 then person_app_age_b=3;
	else if person_app_age<34.65 then person_app_age_b=4;
	else if person_app_age<55.001 or person_app_age=. then person_app_age_b=5;
	else person_app_age_b=5;
	if ACTUALPAYFINECNT=. or 0<=ACTUALPAYFINECNT<2 then ACTUALPAYFINECNT_b=1;
	else if ACTUALPAYFINECNT<4 then ACTUALPAYFINECNT_b=2;
	else if ACTUALPAYFINECNT<6 then ACTUALPAYFINECNT_b=3;
	else if ACTUALPAYFINECNT<12 then ACTUALPAYFINECNT_b=4;
	else if ACTUALPAYFINECNT<40.0001 then ACTUALPAYFINECNT_b=5;
	else ACTUALPAYFINECNT_b=1;		
		if 30.9999<=MAX_SEQ_DUEDAYS<70.5 then MAX_SEQ_DUEDAYS_b=1;
	else if MAX_SEQ_DUEDAYS=. or MAX_SEQ_DUEDAYS<821.0001 then MAX_SEQ_DUEDAYS_b=2;
	else MAX_SEQ_DUEDAYS_b=2;
		if kptp=. then kptp_b=1;
	else if 0<=kptp<1.2 then kptp_b=2;
	else if kptp<3.6 then kptp_b=3;
	else if kptp<7.2 then kptp_b=4;
	else if kptp<24.0001 then kptp_b=5;
	else kptp_b=5;
		if INCM_TIMES=. or 0<=INCM_TIMES<1 then INCM_TIMES_b=1;
	else if INCM_TIMES<2.75 then INCM_TIMES_b=2;
	else if INCM_TIMES<3.5 then INCM_TIMES_b=3;
	else if INCM_TIMES<6.25 then INCM_TIMES_b=4;
	else if INCM_TIMES<95.0001 then INCM_TIMES_b=5;
	else INCM_TIMES_b=1;
		if CREDIT_AMOUNT=. then CREDIT_AMOUNT_b=3;
	else if 2999.9999<=CREDIT_AMOUNT<5700 then CREDIT_AMOUNT_b=1;
	else if CREDIT_AMOUNT<7050 then CREDIT_AMOUNT_b=2;
	else if CREDIT_AMOUNT<30000.0001 then CREDIT_AMOUNT_b=3;
	else CREDIT_AMOUNT_b=3;
/*		if recent_contact_day=. then recent_contact_day_b=4;*/
/*	else if 0<=recent_contact_day<1.15 then recent_contact_day_b=1;*/
/*	else if recent_contact_day<5.15 then recent_contact_day_b=2;*/
/*	else if recent_contact_day<10.15 then recent_contact_day_b=3;*/
/*	else if recent_contact_day<603.0001 then recent_contact_day_b=4;*/
/*	else recent_contact_day_b=4;*/
		if recent_contact_day=. then recent_contact_day_b=2;
	else if 0<=recent_contact_day<1.15 then recent_contact_day_b=1;
	else if recent_contact_day<603.0001 then recent_contact_day_b=2;
	else recent_contact_day_b=2;	
		if rej_count=. then rej_count_b=2;
	else if rej_count<0.35 then rej_count_b=1;
	else if rej_count<7.0001 then rej_count_b=2;
	else rej_count_b=2;
		if person_sex=. or person_sex=1 then person_sex_b=1;
	else if person_sex=0 then person_sex_b=2;
	else person_sex_b=1;
run;

data lf.a0701_&&runData._woe;  
	set lf.a0701_&&runData._group;
	if city in('������',
'��Ҵ��',
'˫Ѽɽ��',
'��ͨ��',
'ʮ����',
'������',
'�γ���',
'��ƽ��',
'��ˮ��',
'������',
'�׳���',
'�ػʵ���',
'ʡֱϽ�ؼ���������',
'������',
'������',
'ͭ����',
'������',
'������',
'������',
'������',
'¦����',
'������',
'������',
'������',
'������',
'פ�����',
'��Ӫ��',
'�żҽ���',
'������',
'��Ϫ��',
'������',
'��ˮ��',
'�żҿ���',
'¤����',
'������',
'�˲���',
'���ױ�����',
'�ϳ���',
'������',
'������',
'������',
'������',
'������',
'�������������',
'����Ͽ��',
'�����׶���',
'������',
'������',
'ʡֱϽ������λ',
'�����'
) then city_woe=0.447749416;
	else if city in ('������',
'��˳��',
'�人��',
'������',
'������',
'��β��',
'Т����',
'տ����',
'������',
'�Ͻ���',
'�ٷ���',
'üɽ��',
'������',
'������',
'������',
'��ɽ��',
'��ɽ��',
'������',
'����',
'������',
'������',
'������',
'������',
'Ϋ����',
'ï����',
'���Ƹ���',
'�Ϻ���',
'������',
'�����첼��',
'�����',
'�Ž���',
'ǭ���ϲ���������������',
'ĵ������',
'������',
'ǭ�������嶱��������',
'������',
'μ����',
'������',
'������',
'�ع���',
'����ˮ��',
'������',
'������',
'��ʩ����������������',
'������',
'�ٲ���',
'������',
'̩����',
'�˳���',
'������',
'Ȫ����',
'������',
'��˳��',
'��ӹ���������������',
'��Դ��',
'������',
'����',
'�е���',
'�ܿ���',
'������',
'�ں���',
'�ױ���',
'��ɽ��',
'�ӱ߳�����������',
'������',
'�Թ���',
'������',
'������',
'��Ϫ��',
'̨����',
'�������������',
'������',
'�����',
'������',
'������',
'�˰���',
'������',
'������',
'������',
'������',
'��ʯ��',
'������',
'������',
'������',
'��Ԫ��',
'��̨����',
'��ͷ��',
'�Ӱ���',
'��Ǩ��',
'������',
'�Ƹ���',
'������',
'������',
'������',
'�Ƹ���',
'��������������������',
'̩����'
) then city_woe=0.149143692;
else if city in('������',
'������',
'�º���徰����������',
'ƽ����',
'ͭ����',
'������',
'������',
'�ն���',
'������',
'������',
'������',
'��̨��',
'˷����',
'���Ǹ���',
'������',
'������',
'�Ͳ���',
'������',
'������',
'������',
'������',
'�ڽ���',
'������',
'��ԭ��',
'������',
'÷����',
'������',
'������',
'Ƽ����',
'��ƽ��',
'������',
'������',
'�麣��',
'�ϲ���',
'���������',
'�ȷ���',
'ͨ����',
'������',
'������',
'ͨ����',
'������',
'������',
'��ݸ��',
'��������������',
'̫ԭ��',
'�ൺ��',
'������',
'�˴���',
'������',
'������',
'��˫���ɴ���������',
'������',
'������',
'ʯ��ׯ��',
'������',
'������',
'������',
'������',
'�ߺ���',
'��ɳ��',
'������',
'��ɽ��',
'��ɽ��',
'�����',
'������',
'��ɽ��',
'������',
'��Զ��',
'������',
'�׸���',
'������',
'������',
'��������',
'������',
'������',
'ƽ��ɽ��',
'������',
'��֦����',
'������',
'ǭ�ϲ���������������',
'������',
'�㰲��',
'������',
'��ͬ��',
'�绯��',
'�Ű���',
'��ɽ����������',
'��«����',
'���ֹ�����',
'������',
'Ӫ����',
'������',
'������',
'�����',
'֣����',
'������',
'�˱���',
'������˹��',
'��ľ˹��',
'������',
'��Դ��',
'��������',
'��̶��'
) then city_woe=-0.054788556;
else if city in ('������',
'������',
'�����',
'������',
'������',
'�ĳ���',
'������',
'������',
'��ɽ��',
'������',
'������',
'���ͺ�����',
'������',
'ʡֱϽ�ؼ�������λ',
'��ɽ��',
'������',
'�ɶ���',
'�Ͼ���',
'��Ȫ��',
'ӥ̶��',
'������',
'��ɽ��',
'������',
'������',
'��ɫ��',
'������',
'������',
'�Ϸ���'
) then city_woe=-0.202900924;
else if city in ('ͭ����',
'��ɽ��',
'��Ȫ��',
'��ͨ��',
'������',
'������',
'������',
'��ɽ׳������������',
'�����',
'�ӳ���',
'������',
'������',
'������',
'��ͷ��',
'������',
'��ˮ��',
'�̽���',
'������',
'��ׯ��',
'������',
'��̨��'
) then city_woe=-0.350923861;
else city_woe=0.447749416;
if 17<=person_app_age<21.7 then person_app_age_woe=-0.170202933;
	else if person_app_age<25.4 then person_app_age_woe=-0.110210016;
	else if person_app_age<27.25 then person_app_age_woe=0.014397915;
	else if person_app_age<34.65 then person_app_age_woe=0.112398906;
	else if person_app_age<55.001 or person_app_age=. then person_app_age_woe=0.327559809;
	else person_app_age_woe=0.327559809;		
		if ACTUALPAYFINECNT=. or 0<=ACTUALPAYFINECNT<2 then ACTUALPAYFINECNT_woe=0.391593645;
	else if ACTUALPAYFINECNT<4 then ACTUALPAYFINECNT_woe=-0.028042442;
	else if ACTUALPAYFINECNT<6 then ACTUALPAYFINECNT_woe=-0.196347283;
	else if ACTUALPAYFINECNT<12 then ACTUALPAYFINECNT_woe=-0.328095633;
	else if ACTUALPAYFINECNT<40.0001 then ACTUALPAYFINECNT_woe=-0.592797317;
	else ACTUALPAYFINECNT_woe=0.391593645;
		if 30.9999<=MAX_SEQ_DUEDAYS<70.5 then MAX_SEQ_DUEDAYS_woe=-0.011077908;
	else if MAX_SEQ_DUEDAYS=. or MAX_SEQ_DUEDAYS<821.0001 then MAX_SEQ_DUEDAYS_woe=0.177037013;
	else MAX_SEQ_DUEDAYS_woe=0.177037013;
		if kptp=. then kptp_woe=0.944378442;
	else if 0<=kptp<1.2 then kptp_woe=0.407030711;
	else if kptp<3.6 then kptp_woe=0.110648287;
	else if kptp<7.2 then kptp_woe=-0.252273305;
	else if kptp<24.0001 then kptp_woe=-0.766535798;
	else kptp_woe=-0.766535798;
		if INCM_TIMES=. or 0<=INCM_TIMES<1 then INCM_TIMES_woe=0.309879125;
	else if INCM_TIMES<2.75 then INCM_TIMES_woe=-0.017726109;
	else if INCM_TIMES<3.5 then INCM_TIMES_woe=-0.215970296;
	else if INCM_TIMES<6.25 then INCM_TIMES_woe=-0.383717971;
	else if INCM_TIMES<95.0001 then INCM_TIMES_woe=-0.666789708;
	else INCM_TIMES_woe=0.309879125;
		if CREDIT_AMOUNT=. then CREDIT_AMOUNT_woe=0.028388823;
	else if 2999.9999<=CREDIT_AMOUNT<5700 then CREDIT_AMOUNT_woe=-0.090562463;
	else if CREDIT_AMOUNT<7050 then CREDIT_AMOUNT_woe=-0.002490369;
	else if CREDIT_AMOUNT<30000.0001 then CREDIT_AMOUNT_woe=0.028388823;
	else CREDIT_AMOUNT_woe=0.028388823;
/*		if recent_contact_day=. then recent_contact_day_woe=0.387680535;*/
/*	else if 0<=recent_contact_day<1.15 then recent_contact_day_woe=-0.297895242;*/
/*	else if recent_contact_day<5.15 then recent_contact_day_woe=0.12879766;*/
/*	else if recent_contact_day<10.15 then recent_contact_day_woe=0.328095979;*/
/*	else if recent_contact_day<603.0001 then recent_contact_day_woe=0.387680535;*/
/*	else recent_contact_day_woe=0.387680535;*/
		if recent_contact_day=. then recent_contact_day_woe=0.263906046;
	else if 0<=recent_contact_day<1.15 then recent_contact_day_woe=-0.297895242;
	else if recent_contact_day<603.0001 then recent_contact_day_woe=0.263906046;
	else recent_contact_day_woe=0.263906046;
		if rej_count=. then rej_count_woe=0.165227948;
	else if rej_count<0.35 then rej_count_woe=-0.021665076;
	else if rej_count<7.0001 then rej_count_woe=0.165227948;
	else rej_count_woe=0.165227948;
		if person_sex=. or person_sex=1 then person_sex_woe=0.008887014;
	else if person_sex=0 then person_sex_woe=-0.029863506;
	else person_sex_woe=0.008887014;
run;

/*��test�ļ����*/
/*���test��,��test���·ݴ��*/
data lf.a0701_test_woe_1709 lf.a0701_test_woe_1710;
  set lf.a0701_test_woe;
  if state_month_cha = '1709' then output lf.a0701_test_woe_1709;
  if state_month_cha = '1710' then output lf.a0701_test_woe_1710;
run;

data lf.a0701_test_woe2;
set lf.a0701_test_woe;
if state_month_cha='1710' then delete;
run;
/*�����ȶ���*/
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
%let model_coef = lf.a1002_udfvardic; 
%let train_data = lf.a0701_train_woe;
%let newmonth=1709;%let newmonth2=1710;
%let test_data = lf.a0701_test_woe_&newmonth.;%totalssi(&train_data.,&test_data.,&model_coef.);
%let test_data = lf.a0701_test_woe_&newmonth2.;%totalssi(&train_data.,&test_data.,&model_coef.);

data lf.updatetotalssi;
set lf.a0701_test_woe_&newmonth._var_SSI
	lf.a0701_test_woe_&newmonth2._var_SSI;
run;
proc sql;
	create table lf.updatessi_summary as 
	select substr(id,length(id)-3,4) as month,substr(column,1,length(column)-2) as columnname,max(ssi) as totalssi from lf.updatetotalssi group by id,column order by id,column;
run;
/*12�����ȶ��Է���ռ�� */
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
       ,substr("&&name&i.",1,length("&&name&i.")-2) as VAR_NAME
       ,&&name&i. as clus
       ,count(1) as N 
       ,sum(target) as N1
       ,sum(target)/count(1) as bad_rate
from  &dsin. 
group by state_month_cha, &&name&i.;
%end;
quit;

%mend;
%Let newmonth=1709;
%let dsin=lf.a0701_test_woe_&newmonth.;
%let dsout=lf.a1702_stable_pct_&newmonth.;%var_stable(&dsin,&dsout);
/*ģ�ʹ��*/

%macro scoreAll(inmodel,outdata,out);
	proc logistic inmodel=&inmodel;
	  score data=&outdata out=&out;
	run;
	proc freq data=&out;
	  tables F_target*I_target ;
	run;
	data &out(rename=(P_1=pred_target));
	  set &out;
	  I_target2 = I_target*1;
	  target = F_target*1;
	run;
%mend;
/****************************��������ָ��**************************************/
%macro measurement(DSin, ProbVar, DVVar, DSKS, KS,DSROC, cStat,Cutoff, DSCM,id,MeasureTab,DSLorenz,Gini);
	%KSStat(&DSin, &ProbVar, &DVVar, &DSKS, KS);
	%ROC(&DSin, &ProbVar, &DVVar, &DSROC, cStat);
	%ConfMat(&DSin, &ProbVar, &DVVar, &Cutoff, &DSCM);
	%GiniStat(&DSin, &ProbVar, &DVVar, &DSLorenz, Gini);
	data &MeasureTab;
		id=&id;
		set &DSCM;/*p166 2*2��������*/
		Accuracy =(TN+TP)/Ntotal;/*׼ȷ��*/
		Precision=TP/(TP+FP)    ;/*����*/
		Recall   =TP/(TP+FN)    ;/*�ٻ���*/
		F_value  =2*Precision*Recall/(Precision+Recall);/*Fֵ*/		
		roc=&cStat;
		ks=&KS;
		gini=&Gini;
	run;
%mend;
%MACRO update_newpredict(modelname,newmonth,newmonth2);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0701_test_woe2;%let out=lf.a0901_&modelname._predict_test;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0701_test_woe_&newmonth.;%let out=lf.a0901_&modelname._predict_test_&newmonth.;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0701_test_woe_&newmonth2.;%let out=lf.a0901_&modelname._predict_test_&newmonth2.;%scoreAll(&inmodel, &outdata, &out);

/*testͳ��*/
%let DSin=lf.a0901_&modelname._predict_test;
%let ProbVar=pred_target;
%let DVVar=target;
%let DSKS=lf.a0802_test_dsks;
%let KS=;
%let dsroc=lf.a0802_test_dsroc;
%let cStat=;
%let cutoff=0.5;
%let dscm=lf.a0802_test_confMat;
%let id="test";
%let MeasureTab=lf.a0802_test_measureTab;
%let DSLorenz=LorenzDS;
%let Gini=;
%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);

%let DSin=lf.a0901_&modelname._predict_test_&newmonth.;
%let ProbVar=pred_target;
%let DVVar=target;
%let DSKS=lf.a0802_test_dsks_&newmonth.;
%let KS=;
%let dsroc=lf.a0802_test_dsroc_&newmonth.;
%let cStat=;
%let cutoff=0.5;
%let dscm=lf.a0802_test_confMat_&newmonth.;
%let id="test_&newmonth.";
%let MeasureTab=lf.a0802_test_measureTab_&newmonth.;
%let DSLorenz=LorenzDS;
%let Gini=;
%measurement(&DSin, &ProbVar, &DVVar, &DSKS, KS, &DSROC, cStat, &Cutoff, &DSCM, &id, &MeasureTab,&DSLorenz,&Gini);
data lf.&modelname._updateMeasurement;
	length id $12;
	set	
	lf.a0802_test_measureTab 
	lf.a0802_test_measureTab_&newmonth.;
run;
%mend;
%let newmonth=1709;%let newmonth2=1710;
%let modelname=model1;%update_newpredict(&modelname,&newmonth,&newmonth2);
%let modelname=model2;%update_newpredict(&modelname,&newmonth,&newmonth2);
%let modelname=model3;%update_newpredict(&modelname,&newmonth,&newmonth2);
****PSI Calculation**********************************************************;
/*�����ȷ��ģ������*/
/*��ģ������*/

%macro update_psi(modelname,Nb,newmonth,newmonth2);
%let train_data = lf.a0901_&modelname._predict_train;
data lf.a0901_&modelname._test_&newmonth.;set lf.a0901_&modelname._predict_test_&newmonth.;run;
%let test_data = lf.a0901_&modelname._test_&newmonth.;%totalpsi(&train_data.,&test_data.,pred_target,&Nb.);
data lf.a0901_&modelname._test_&newmonth2.;set lf.a0901_&modelname._predict_test_&newmonth2.;run;
%let test_data = lf.a0901_&modelname._test_&newmonth2.;%totalpsi(&train_data.,&test_data.,pred_target,&Nb.);
data lf.updatepsi_&modelname.;
retain model month sum;
set 
	lf.a0901_&modelname._test_&newmonth._psi(in=a1)
	lf.a0901_&modelname._test_&newmonth2._psi(in=a2)
;
  if a1=1 then month = &newmonth.;
  if a2=1 then month = &newmonth2.;
  if Bin = &Nb;
model = "&modelname.";
  keep model month sum;
  rename sum=PSI;
run;
%mend;
%let Nb=10;%let newmonth = 1709;%let newmonth2 = 1710;
%let modelname=model1;%update_psi(&modelname,&Nb,&newmonth,&newmonth2);
%let modelname=model2;%update_psi(&modelname,&Nb,&newmonth,&newmonth2);
%let modelname=model3;%update_psi(&modelname,&Nb,&newmonth,&newmonth2);

******************************************************************************;                                                                                                                                
*** 16b�ֽ�����ֿ�����                                                                                                     ***;                                                                                                                                 
******************************************************************************;   
%macro update_score_model1(Dsin, modelname, newmonth, newmonth2);
data &DSin;
   set lf.a0901_&modelname._predict_test_&newmonth. lf.a0901_&modelname._predict_test_&newmonth2.;
run;
data lf.a1601_&modelname._score;
set &Dsin;
RAW_SCORE = 0.5528
+recent_contact_day_woe*0.9273
+kptp_woe*0.6706
+city_woe*0.8766
+person_app_age_woe*0.84
+ACTUALPAYFINECNT_woe*0.4024
+INCM_TIMES_woe*0.322
+rej_count_woe*1.3087
+CREDIT_AMOUNT_woe*0.9364
;     
F_SCORE = EXP(RAW_SCORE)/(1+EXP(RAW_SCORE));
SCORE =  450 - 72.1347520444482 * LOG(F_SCORE/(1-F_SCORE));
run;
%mend;

%macro update_score_model2(Dsin, modelname, newmonth, newmonth2);
data &DSin;
   set lf.a0901_&modelname._predict_test_&newmonth. lf.a0901_&modelname._predict_test_&newmonth2.;
run;
data lf.a1601_&modelname._score;
set &Dsin;
RAW_SCORE = 0.552
+recent_contact_day_woe*0.9032
+kptp_woe*0.6238
+city_woe*0.8822
+ACTUALPAYFINECNT_woe*0.5313
+person_app_age_woe*0.8552
+MAX_SEQ_DUEDAYS_woe*2.6867
+INCM_TIMES_woe*0.3445
+rej_count_woe*1.3147
+CREDIT_AMOUNT_woe*0.9241
;     
F_SCORE = EXP(RAW_SCORE)/(1+EXP(RAW_SCORE));
SCORE =  450 - 72.1347520444482 * LOG(F_SCORE/(1-F_SCORE));
run;
%mend;

%macro update_score_model3(Dsin, modelname, newmonth, newmonth2);
data &DSin;
   set lf.a0901_&modelname._predict_test_&newmonth. lf.a0901_&modelname._predict_test_&newmonth2.;
run;
data lf.a1601_&modelname._score;
set &Dsin;
RAW_SCORE = 0.5519
+recent_contact_day_woe*0.9014
+kptp_woe*0.6191
+city_woe*0.8877
+person_app_age_woe*0.8912
+ACTUALPAYFINECNT_woe*0.5277
+MAX_SEQ_DUEDAYS_woe*2.6918
+INCM_TIMES_woe*0.3479
+rej_count_woe*1.3206
;     
F_SCORE = EXP(RAW_SCORE)/(1+EXP(RAW_SCORE));
SCORE =  450 - 72.1347520444482 * LOG(F_SCORE/(1-F_SCORE));
run;
%mend;
%let newmonth=1709;%let newmonth2 = 1710;
%let modelname=model1;
%let Dsin=lf.a1301_&modelname._dat_all;%update_score_model1(&Dsin,&modelname,&newmonth,&newmonth2);
%let modelname=model2;
%let Dsin=lf.a1301_&modelname._dat_all;%update_score_model2(&Dsin,&modelname,&newmonth,&newmonth2);
%let model_name=model3;
%let Dsin=lf.a1301_&modelname._dat_all;%update_score_model3(&Dsin,&modelname,&newmonth,&newmonth2);
/*proc sql;*/
/*	select state_month_cha, count(1) from lf.a1301_model1_dat_all group by state_month_cha;*/
/*run;*/
%macro MonthScore(Dsin,modelname);
data &Dsin._n;
set &Dsin;

if score <300 then do;score_b=1;end;
else if score <350 then do;score_b=2;end;
else if score <375 then do;score_b=3;end;
else if score <400 then do;score_b=4;end;
else if score <425 then do;score_b=5;end;
else if score <450 then do;score_b=6;end;
else if score >=450 then do;score_b=7;end;

run;
proc sql;  
create table lf.a1601_temp_score
(
	month       char(20),
  clus      	INTEGER
  ,total         INTEGER
);


insert into lf.a1601_temp_score
select 
		state_month_cha as month,
         score_b as clus,
		count(1) as total 	   
from  &dsin._n group by state_month_cha,score_b;

quit;
proc print data=lf.a1601_temp_score;run;
%mend;


%let modelname=model1;%let Dsin=lf.a1601_&modelname._score;%MonthScore(&Dsin,&modelname);
%let modelname=model2;%let Dsin=lf.a1601_&modelname._score;%MonthScore(&Dsin,&modelname);
%let modelname=model3;%let Dsin=lf.a1601_&modelname._score;%MonthScore(&Dsin,&modelname);



