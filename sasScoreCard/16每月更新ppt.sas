/*导入hive201610-201708*/
proc contents data=lf.dz0201_data_import;run;
proc contents data=lf.m2_poscash_cs_base_v1_process;run;
/*已有的数据，Oracle全部数据 lf.dz0201_data_import */
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
/*1、导入每月数据*/
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
/*1709数据可用，1710不可以*/
proc sql ;
create table lf.m2_poscash_cs_base_v1_910 as 
select * from lf.m2_poscash_cs_base_v1_process where state_month_cha in ('1709','1710');
run;

/*1708数据：lf.m2_poscash_cs_base_v1_1708*/
/*生成1709,下次更新使用*/
proc sql ;
create table lf.m2_poscash_cs_base_v1_1709 as 
select * from lf.m2_poscash_cs_base_v1_process where state_month_cha='1709';
run;

data lf.dz0201_data_import_part3;
set lf.dz0201_data_import_part2 lf.m2_poscash_cs_base_v1_1708
lf.m2_poscash_cs_base_v1_910;
run;
/*1\统计样本概况*/
proc sql;
	select state_month_cha,count(1) as total,sum(target) as bad,sum(target)/count(1) as bad_rate from lf.dz0201_data_import_part3 group by state_month_cha;
quit;
/*划分数据集，只需更新test，下同*/
data lf.dz0300_train lf.dz0300_valid lf.dz0300_test;
  set lf.dz0201_data_import_part3;
  if state_month_cha in('1610','1611','1612','1701','1702') then output lf.dz0300_train;
  else if state_month_cha in('1703','1704') then output lf.dz0300_valid;
  else output lf.dz0300_test;
run;

%let runData=test;
data lf.a0701_&&runData._group;
	set lf.dz0300_&&runData.;
	if city in('六安市',
'张掖市',
'双鸭山市',
'昭通市',
'十堰市',
'北海市',
'盐城市',
'南平市',
'丽水市',
'商丘市',
'白城市',
'秦皇岛市',
'省直辖县级行政区划',
'宣城市',
'洛阳市',
'铜川市',
'宁德市',
'咸宁市',
'常德市',
'嘉兴市',
'娄底市',
'随州市',
'亳州市',
'曲靖市',
'滨州市',
'驻马店市',
'东营市',
'张家界市',
'滁州市',
'本溪市',
'三明市',
'衡水市',
'张家口市',
'陇南市',
'忻州市',
'宜昌市',
'呼伦贝尔市',
'南充市',
'武威市',
'桂林市',
'开封市',
'银川市',
'龙岩市',
'迪庆藏族自治州',
'三门峡市',
'巴彦淖尔市',
'永州市',
'白银市',
'省直辖行政单位',
'漯河市'
) then city_b=1;
	else if city in ('淮南市',
'抚顺市',
'武汉市',
'巴中市',
'益阳市',
'汕尾市',
'孝感市',
'湛江市',
'吉林市',
'毕节市',
'临汾市',
'眉山市',
'晋中市',
'泸州市',
'上饶市',
'舟山市',
'唐山市',
'徐州市',
'金华市',
'丽江市',
'郴州市',
'伊春市',
'安康市',
'潍坊市',
'茂名市',
'连云港市',
'上海市',
'庆阳市',
'乌兰察布市',
'许昌市',
'九江市',
'黔西南布依族苗族自治州',
'牡丹江市',
'温州市',
'黔东南苗族侗族自治州',
'怀化市',
'渭南市',
'苏州市',
'蚌埠市',
'韶关市',
'六盘水市',
'绵阳市',
'定西市',
'恩施土家族苗族自治州',
'海东市',
'临沧市',
'邵阳市',
'泰安市',
'运城市',
'济宁市',
'泉州市',
'莆田市',
'安顺市',
'红河哈尼族彝族自治州',
'河源市',
'厦门市',
'镇江市',
'承德市',
'周口市',
'潮州市',
'黑河市',
'鹤壁市',
'马鞍山市',
'延边朝鲜族自治州',
'安阳市',
'自贡市',
'鸡西市',
'淮安市',
'玉溪市',
'台州市',
'大理白族自治州',
'鄂州市',
'濮阳市',
'榆林市',
'漳州市',
'兴安盟',
'资阳市',
'株洲市',
'信阳市',
'宁波市',
'黄石市',
'荆州市',
'西宁市',
'南阳市',
'广元市',
'七台河市',
'汕头市',
'延安市',
'宿迁市',
'新乡市',
'云浮市',
'襄阳市',
'焦作市',
'安庆市',
'黄冈市',
'湘西土家族苗族自治州',
'泰州市'
) then city_b=2;
else if city in('梧州市',
'贺州市',
'德宏傣族景颇族自治州',
'平凉市',
'铜仁市',
'铁岭市',
'达州市',
'普洱市',
'扬州市',
'广州市',
'大庆市',
'烟台市',
'朔州市',
'防城港市',
'辽阳市',
'揭阳市',
'淄博市',
'长春市',
'商洛市',
'常州市',
'德州市',
'内江市',
'柳州市',
'松原市',
'晋城市',
'梅州市',
'吕梁市',
'兰州市',
'萍乡市',
'四平市',
'岳阳市',
'锦州市',
'珠海市',
'南昌市',
'齐齐哈尔市',
'廊坊市',
'通辽市',
'汉中市',
'贵阳市',
'通化市',
'深圳市',
'来宾市',
'东莞市',
'楚雄彝族自治州',
'太原市',
'青岛市',
'沈阳市',
'宜春市',
'昆明市',
'惠州市',
'西双版纳傣族自治州',
'淮北市',
'江门市',
'石家庄市',
'北京市',
'济南市',
'抚州市',
'沧州市',
'芜湖市',
'长沙市',
'无锡市',
'保山市',
'白山市',
'金昌市',
'荆门市',
'乐山市',
'赣州市',
'清远市',
'衡阳市',
'鹤岗市',
'遵义市',
'丹东市',
'哈尔滨市',
'阳江市',
'重庆市',
'平顶山市',
'湖州市',
'攀枝花市',
'菏泽市',
'黔南布依族苗族自治州',
'杭州市',
'广安市',
'保定市',
'大同市',
'绥化市',
'雅安市',
'凉山彝族自治州',
'葫芦岛市',
'锡林郭勒盟',
'邯郸市',
'营口市',
'福州市',
'绍兴市',
'赤峰市',
'郑州市',
'朝阳市',
'宜宾市',
'鄂尔多斯市',
'佳木斯市',
'新余市',
'辽源市',
'景德镇市',
'湘潭市'
) then city_b=3;
else if city in ('衢州市',
'三亚市',
'天津市',
'临沂市',
'西安市',
'聊城市',
'宿州市',
'阜新市',
'鞍山市',
'咸阳市',
'威海市',
'呼和浩特市',
'莱芜市',
'省直辖县级行政单位',
'中山市',
'阜阳市',
'成都市',
'南京市',
'阳泉市',
'鹰潭市',
'大连市',
'佛山市',
'吉安市',
'肇庆市',
'百色市',
'遂宁市',
'宝鸡市',
'合肥市'
) then city_b=4;
else if city in ('铜陵市',
'黄山市',
'酒泉市',
'南通市',
'儋州市',
'玉林市',
'日照市',
'文山壮族苗族自治州',
'贵港市',
'河池市',
'崇左市',
'南宁市',
'钦州市',
'包头市',
'长治市',
'天水市',
'盘锦市',
'德阳市',
'枣庄市',
'海口市',
'邢台市'
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
	if city in('六安市',
'张掖市',
'双鸭山市',
'昭通市',
'十堰市',
'北海市',
'盐城市',
'南平市',
'丽水市',
'商丘市',
'白城市',
'秦皇岛市',
'省直辖县级行政区划',
'宣城市',
'洛阳市',
'铜川市',
'宁德市',
'咸宁市',
'常德市',
'嘉兴市',
'娄底市',
'随州市',
'亳州市',
'曲靖市',
'滨州市',
'驻马店市',
'东营市',
'张家界市',
'滁州市',
'本溪市',
'三明市',
'衡水市',
'张家口市',
'陇南市',
'忻州市',
'宜昌市',
'呼伦贝尔市',
'南充市',
'武威市',
'桂林市',
'开封市',
'银川市',
'龙岩市',
'迪庆藏族自治州',
'三门峡市',
'巴彦淖尔市',
'永州市',
'白银市',
'省直辖行政单位',
'漯河市'
) then city_woe=0.447749416;
	else if city in ('淮南市',
'抚顺市',
'武汉市',
'巴中市',
'益阳市',
'汕尾市',
'孝感市',
'湛江市',
'吉林市',
'毕节市',
'临汾市',
'眉山市',
'晋中市',
'泸州市',
'上饶市',
'舟山市',
'唐山市',
'徐州市',
'金华市',
'丽江市',
'郴州市',
'伊春市',
'安康市',
'潍坊市',
'茂名市',
'连云港市',
'上海市',
'庆阳市',
'乌兰察布市',
'许昌市',
'九江市',
'黔西南布依族苗族自治州',
'牡丹江市',
'温州市',
'黔东南苗族侗族自治州',
'怀化市',
'渭南市',
'苏州市',
'蚌埠市',
'韶关市',
'六盘水市',
'绵阳市',
'定西市',
'恩施土家族苗族自治州',
'海东市',
'临沧市',
'邵阳市',
'泰安市',
'运城市',
'济宁市',
'泉州市',
'莆田市',
'安顺市',
'红河哈尼族彝族自治州',
'河源市',
'厦门市',
'镇江市',
'承德市',
'周口市',
'潮州市',
'黑河市',
'鹤壁市',
'马鞍山市',
'延边朝鲜族自治州',
'安阳市',
'自贡市',
'鸡西市',
'淮安市',
'玉溪市',
'台州市',
'大理白族自治州',
'鄂州市',
'濮阳市',
'榆林市',
'漳州市',
'兴安盟',
'资阳市',
'株洲市',
'信阳市',
'宁波市',
'黄石市',
'荆州市',
'西宁市',
'南阳市',
'广元市',
'七台河市',
'汕头市',
'延安市',
'宿迁市',
'新乡市',
'云浮市',
'襄阳市',
'焦作市',
'安庆市',
'黄冈市',
'湘西土家族苗族自治州',
'泰州市'
) then city_woe=0.149143692;
else if city in('梧州市',
'贺州市',
'德宏傣族景颇族自治州',
'平凉市',
'铜仁市',
'铁岭市',
'达州市',
'普洱市',
'扬州市',
'广州市',
'大庆市',
'烟台市',
'朔州市',
'防城港市',
'辽阳市',
'揭阳市',
'淄博市',
'长春市',
'商洛市',
'常州市',
'德州市',
'内江市',
'柳州市',
'松原市',
'晋城市',
'梅州市',
'吕梁市',
'兰州市',
'萍乡市',
'四平市',
'岳阳市',
'锦州市',
'珠海市',
'南昌市',
'齐齐哈尔市',
'廊坊市',
'通辽市',
'汉中市',
'贵阳市',
'通化市',
'深圳市',
'来宾市',
'东莞市',
'楚雄彝族自治州',
'太原市',
'青岛市',
'沈阳市',
'宜春市',
'昆明市',
'惠州市',
'西双版纳傣族自治州',
'淮北市',
'江门市',
'石家庄市',
'北京市',
'济南市',
'抚州市',
'沧州市',
'芜湖市',
'长沙市',
'无锡市',
'保山市',
'白山市',
'金昌市',
'荆门市',
'乐山市',
'赣州市',
'清远市',
'衡阳市',
'鹤岗市',
'遵义市',
'丹东市',
'哈尔滨市',
'阳江市',
'重庆市',
'平顶山市',
'湖州市',
'攀枝花市',
'菏泽市',
'黔南布依族苗族自治州',
'杭州市',
'广安市',
'保定市',
'大同市',
'绥化市',
'雅安市',
'凉山彝族自治州',
'葫芦岛市',
'锡林郭勒盟',
'邯郸市',
'营口市',
'福州市',
'绍兴市',
'赤峰市',
'郑州市',
'朝阳市',
'宜宾市',
'鄂尔多斯市',
'佳木斯市',
'新余市',
'辽源市',
'景德镇市',
'湘潭市'
) then city_woe=-0.054788556;
else if city in ('衢州市',
'三亚市',
'天津市',
'临沂市',
'西安市',
'聊城市',
'宿州市',
'阜新市',
'鞍山市',
'咸阳市',
'威海市',
'呼和浩特市',
'莱芜市',
'省直辖县级行政单位',
'中山市',
'阜阳市',
'成都市',
'南京市',
'阳泉市',
'鹰潭市',
'大连市',
'佛山市',
'吉安市',
'肇庆市',
'百色市',
'遂宁市',
'宝鸡市',
'合肥市'
) then city_woe=-0.202900924;
else if city in ('铜陵市',
'黄山市',
'酒泉市',
'南通市',
'儋州市',
'玉林市',
'日照市',
'文山壮族苗族自治州',
'贵港市',
'河池市',
'崇左市',
'南宁市',
'钦州市',
'包头市',
'长治市',
'天水市',
'盘锦市',
'德阳市',
'枣庄市',
'海口市',
'邢台市'
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

/*对test文件打分*/
/*拆分test集,对test分月份打分*/
data lf.a0701_test_woe_1709 lf.a0701_test_woe_1710;
  set lf.a0701_test_woe;
  if state_month_cha = '1709' then output lf.a0701_test_woe_1709;
  if state_month_cha = '1710' then output lf.a0701_test_woe_1710;
run;

data lf.a0701_test_woe2;
set lf.a0701_test_woe;
if state_month_cha='1710' then delete;
run;
/*变量稳定性*/
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
/*12变量稳定性分月占比 */
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
/*模型打分*/

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
/****************************计算评估指标**************************************/
%macro measurement(DSin, ProbVar, DVVar, DSKS, KS,DSROC, cStat,Cutoff, DSCM,id,MeasureTab,DSLorenz,Gini);
	%KSStat(&DSin, &ProbVar, &DVVar, &DSKS, KS);
	%ROC(&DSin, &ProbVar, &DVVar, &DSROC, cStat);
	%ConfMat(&DSin, &ProbVar, &DVVar, &Cutoff, &DSCM);
	%GiniStat(&DSin, &ProbVar, &DVVar, &DSLorenz, Gini);
	data &MeasureTab;
		id=&id;
		set &DSCM;/*p166 2*2混淆矩阵*/
		Accuracy =(TN+TP)/Ntotal;/*准确率*/
		Precision=TP/(TP+FP)    ;/*精度*/
		Recall   =TP/(TP+FN)    ;/*召回率*/
		F_value  =2*Precision*Recall/(Precision+Recall);/*F值*/		
		roc=&cStat;
		ks=&KS;
		gini=&Gini;
	run;
%mend;
%MACRO update_newpredict(modelname,newmonth,newmonth2);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0701_test_woe2;%let out=lf.a0901_&modelname._predict_test;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0701_test_woe_&newmonth.;%let out=lf.a0901_&modelname._predict_test_&newmonth.;%scoreAll(&inmodel, &outdata, &out);
%let inmodel=lf.a0901_&modelname.;%let outdata=lf.a0701_test_woe_&newmonth2.;%let out=lf.a0901_&modelname._predict_test_&newmonth2.;%scoreAll(&inmodel, &outdata, &out);

/*test统计*/
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
/*等最后确定模型再做*/
/*入模变量表*/

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
*** 16b现金贷评分卡评分                                                                                                     ***;                                                                                                                                 
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



