******************************************************************************;                                                                                                                                
*** 07计算IV值                                                             ***;                                                                                                                                 
******************************************************************************; 

/*将数值型分组转化为字符型*/
data lf.a0701_train_bin_ch;
  set lf.a0701_train_woe;
KPTP_b_ch=put(KPTP_b,8.);
ACTUALPAYFINECNT_b_ch=put(ACTUALPAYFINECNT_b,8.);
MAX_ROLL_SEQ_b_ch=put(MAX_ROLL_SEQ_b,8.);
INCM_TIMES_b_ch=put(INCM_TIMES_b,8.);
CERT_4_INITAL_b_ch=put(CERT_4_INITAL_b,8.);
CITY_b_ch=put(CITY_b,8.);
CON1_DUE_TIMES_b_ch=put(CON1_DUE_TIMES_b,8.);
AVG_DAYS_b_ch=put(AVG_DAYS_b,8.);
PERSON_APP_AGE_b_ch=put(PERSON_APP_AGE_b,8.);
INSURE_TYPE_b_ch=put(INSURE_TYPE_b,8.);
FAMILY_STATE_b_ch=put(FAMILY_STATE_b,8.);
IS_SUIXINHUAN_b_ch=put(IS_SUIXINHUAN_b,8.);
RECENT_CONTACT_DAY_b_ch=put(RECENT_CONTACT_DAY_b,8.);
APP_COUNT_b_ch=put(APP_COUNT_b,8.);
REJ_COUNT_b_ch=put(REJ_COUNT_b,8.);
IS_SSI_b_ch=put(IS_SSI_b,8.);
INTER3_COUNT_b_ch=put(INTER3_COUNT_b,8.);
MAX_SEQ_DUEDAYS_b_ch=put(MAX_SEQ_DUEDAYS_b,8.);
flag_tqww_b_ch=put(flag_tqww_b,8.);
CREDIT_AMOUNT_b_ch=put(CREDIT_AMOUNT_b,8.);
run;


%let IVList=
KPTP_b_ch
ACTUALPAYFINECNT_b_ch
MAX_ROLL_SEQ_b_ch
INCM_TIMES_b_ch
CERT_4_INITAL_b_ch
CITY_b_ch
CON1_DUE_TIMES_b_ch
AVG_DAYS_b_ch
PERSON_APP_AGE_b_ch
INSURE_TYPE_b_ch
FAMILY_STATE_b_ch
IS_SUIXINHUAN_b_ch
RECENT_CONTACT_DAY_b_ch
APP_COUNT_b_ch
REJ_COUNT_b_ch
IS_SSI_b_ch
INTER3_COUNT_b_ch
MAX_SEQ_DUEDAYS_b_ch
flag_tqww_b_ch
CREDIT_AMOUNT_b_ch
;
%let DSin=lf.a0701_train_bin_ch;
%let DV=target;
%let DSOut=lf.a0702_Cal_IV;
%PowerIV(&DSin, &DV, &IVList, &DSout);
data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp;
	if intime_pay=. then intime_pay_b2=5; 
	else if 0<=intime_pay<3.15 then intime_pay_b2=1;
	else if intime_pay<6.3 then intime_pay_b2=2;
	else if intime_pay<10.05 then intime_pay_b2=3;
	else if intime_pay<15.75 then intime_pay_b2=4;
	else if intime_pay<63.0001 then intime_pay_b2=5;
	else intime_pay_b2=5;
run;

proc sql;
	select intime_pay_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by intime_pay_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
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
) then city_b2=1;
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
) then city_b2=2;
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
) then city_b2=3;
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
) then city_b2=4;
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
) then city_b2=5;
else city_b2=1;
run;

proc sql;
	select city_b,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by city_b;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if 17<=person_app_age<21.7 then person_app_age_b2=1;
	else if person_app_age<25.4 then person_app_age_b2=2;
	else if person_app_age<27.25 then person_app_age_b2=3;
	else if person_app_age<34.65 then person_app_age_b2=4;
	else if person_app_age<55.001 or person_app_age=. then person_app_age_b2=5;
	else person_app_age_b2=5;
run;
proc sql;
	select person_app_age_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by person_app_age_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if ptp_ratio=. or 0<=ptp_ratio<0.05 then ptp_ratio_b2=1;
	else if ptp_ratio<0.2 then ptp_ratio_b2=2;
	else if ptp_ratio<0.35 then ptp_ratio_b2=3;
	else if ptp_ratio<0.55 then ptp_ratio_b2=4;
	else if ptp_ratio<1.0001 then ptp_ratio_b2=5;
	else ptp_ratio_b2=1;
run;
proc sql;
	select ptp_ratio_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by ptp_ratio_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if dk_ratio=. or 0<=dk_ratio<0.7 then dk_ratio_b2=1;
	else if dk_ratio<0.8 then dk_ratio_b2=2;
	else if dk_ratio<1.0001 then dk_ratio_b2=3;
	else dk_ratio_b2=1;
run;
proc sql;
	select dk_ratio_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by dk_ratio_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if finish_periods_ratio=. or 0<=finish_periods_ratio<0.2 then finish_periods_ratio_b2=1;
	else if finish_periods_ratio<0.35 then finish_periods_ratio_b2=2;
	else if finish_periods_ratio<0.4 then finish_periods_ratio_b2=3;
	else if finish_periods_ratio<0.6 then finish_periods_ratio_b2=4;
	else if finish_periods_ratio<1.0001 then finish_periods_ratio_b2=5;
	else finish_periods_ratio_b2=1;
run;
proc sql;
	select finish_periods_ratio_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by finish_periods_ratio_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if bptp=. then bptp_b2=1;
	else if 0<=bptp<5.3 then bptp_b2=2;
	else if bptp<10.6 then bptp_b2=3;
	else if bptp<15.9 then bptp_b2=4;
	else if bptp<106.0001 then bptp_b2=5;
	else bptp_b2=1;
run;
proc sql;
	select bptp_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by bptp_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if ptp=. or 0<=ptp<5.75 then ptp_b2=1;
	else if ptp<11.5 then ptp_b2=2;
	else if ptp<23 then ptp_b2=3;
	else if ptp<34.5 then ptp_b2=4;
	else if ptp<115.0001 then ptp_b2=5;
	else ptp_b2=1;
run;
proc sql;
	select ptp_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by ptp_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if ACTUALPAYFEE=. or 0<=ACTUALPAYFEE<706.956 then ACTUALPAYFEE_b2=1;
	else if ACTUALPAYFEE<1413.912 then ACTUALPAYFEE_b2=2;
	else if ACTUALPAYFEE<2120.868 then ACTUALPAYFEE_b2=3;
	else if ACTUALPAYFEE<2827.824 then ACTUALPAYFEE_b2=4;
	else if ACTUALPAYFEE<14139.12 then ACTUALPAYFEE_b2=5;
	else ACTUALPAYFEE_b2=1;
run;
proc sql;
	select ACTUALPAYFEE_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by ACTUALPAYFEE_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if MOST_CONTACT_3M='' or MOST_CONTACT_3M in('ORLM','PWTR','FNBM') then MOST_CONTACT_3M_b2=1;
	else if MOST_CONTACT_3M in('APPO','CMLM') then MOST_CONTACT_3M_b2=2;
	else if MOST_CONTACT_3M in('CWOC','FOUP') then MOST_CONTACT_3M_b2=3;
	else if MOST_CONTACT_3M in('INCM') then MOST_CONTACT_3M_b2=4;
	else if MOST_CONTACT_3M in('PTP') then MOST_CONTACT_3M_b2=5;
	else MOST_CONTACT_3M_b2=1;
run;
proc sql;
	select MOST_CONTACT_3M_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by MOST_CONTACT_3M_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if ACTUALPAYFINECNT=. or 0<=ACTUALPAYFINECNT<2 then ACTUALPAYFINECNT_b2=1;
	else if ACTUALPAYFINECNT<4 then ACTUALPAYFINECNT_b2=2;
	else if ACTUALPAYFINECNT<6 then ACTUALPAYFINECNT_b2=3;
	else if ACTUALPAYFINECNT<12 then ACTUALPAYFINECNT_b2=4;
	else if ACTUALPAYFINECNT<40.0001 then ACTUALPAYFINECNT_b2=5;
	else ACTUALPAYFINECNT_b2=1;
run;
proc sql;
	select ACTUALPAYFINECNT_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by ACTUALPAYFINECNT_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if pay_periods=. or 1.9999<=PAY_PERIODS<6.35 then PAY_PERIODS_b2=1;
	else if PAY_PERIODS<10.7 then PAY_PERIODS_b2=2;
	else if PAY_PERIODS<15.05 then PAY_PERIODS_b2=3;
	else if PAY_PERIODS<23.75 then PAY_PERIODS_b2=4;
	else if PAY_PERIODS<89.0001 then PAY_PERIODS_b2=5;
	else PAY_PERIODS_b2=1;
run;
proc sql;
	select PAY_PERIODS_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by PAY_PERIODS_b2;
run;
data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if person_sex=. or person_sex=1 then person_sex_b2=1;
	else if person_sex=0 then person_sex_b2=2;
	else person_sex_b2=1;
run;
proc sql;
	select person_sex_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by person_sex_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if education=. or education in(1,2) then education_b2=1;
	else if education=3 then education_b2=2;
	else if education=4 then education_b2=3;
	else if education in(5,7) then education_b2=4;
	else if education=6 then education_b2=5;
	else education_b2=1;
run;
proc sql;
	select education_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by education_b2;
run;
data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if flag_applyloan=1 then flag_applyloan_b2=1;
	else if flag_applyloan=0 then flag_applyloan_b2=2;
	else if flag_applyloan=. then flag_applyloan_b2=3;
	else flag_applyloan_b2=1;
run;
proc sql;
	select flag_applyloan_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by flag_applyloan_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if flag_tqww=1 then flag_tqww_b2=1;
	else if flag_tqww=. then flag_tqww_b2=2;
	else flag_tqww_b2=1;
run;
proc sql;
	select flag_tqww_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by flag_tqww_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if 0<=value_balance_ratio<1.704325 then value_balance_ratio_b2=1;
	else if value_balance_ratio<2.643425 then value_balance_ratio_b2=2;
	else if value_balance_ratio<3.582525 then value_balance_ratio_b2=3;
	else if value_balance_ratio<5.22595 then value_balance_ratio_b2=4;
	else if value_balance_ratio<5.6956 or value_balance_ratio=. then value_balance_ratio_b2=5;
	else value_balance_ratio_b2=5;
run;
proc sql;
	select value_balance_ratio_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by value_balance_ratio_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if INCM_TIMES=. or 0<=INCM_TIMES<1 then INCM_TIMES_b2=1;
	else if INCM_TIMES<2.75 then INCM_TIMES_b2=2;
	else if INCM_TIMES<3.5 then INCM_TIMES_b2=3;
	else if INCM_TIMES<6.25 then INCM_TIMES_b2=4;
	else if INCM_TIMES<95.0001 then INCM_TIMES_b2=5;
	else INCM_TIMES_b2=1;
run;
proc sql;
	select INCM_TIMES_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by INCM_TIMES_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if contact=. or 0<=contact<12.85 then contact_b2=1;
	else if contact<19.5 then contact_b2=2;
	else if contact<28.7 then contact_b2=3;
	else if contact<47.4 then contact_b2=4;
	else if contact<237.0001 then contact_b2=5;
	else contact_b2=1;
run;
proc sql;
	select contact_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by contact_b2;
run;
data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if CERT_4_INITAL='' or CERT_4_INITAL in('5123',
'4523',
'5322',
'6528',
'1322',
'5308',
'6230',
'3705',
'6422',
'1330',
'3610',
'4513',
'4117',
'3526',
'2223',
'1321',
'1323',
'4116',
'6402',
'1490',
'1506',
'2190',
'2290',
'3417',
'4204',
'5302',
'6202',
'6211',
'6212',
'6323',
'6503',
'6523',
'6540',
'6590') then CERT_4_INITAL_b2=1;
	else if CERT_4_INITAL in('4328',
'6301',
'4206',
'2327',
'4221',
'5204',
'1422',
'3308',
'5125',
'3209',
'3413',
'3212',
'3621',
'4103',
'3507',
'4205',
'1324',
'2310',
'4290',
'1303',
'4106',
'3522',
'4123',
'5102',
'4102',
'2326',
'5324',
'4202',
'4224',
'3723',
'6222',
'4330',
'4112',
'3504',
'4212',
'4308',
'1326',
'1507',
'1529',
'3427',
'4111',
'5203',
'6204',
'6421',
'6522',
'4129',
'3326',
'3521',
'4325',
'4324',
'4329',
'5334',
'1409',
'1421',
'4213',
'3509') then CERT_4_INITAL_b2=2;
	else if CERT_4_INITAL in('4104',
'3305',
'4311',
'1309',
'4405',
'3725',
'2113',
'3622',
'5129',
'4407',
'5222',
'3405',
'4502',
'4310',
'2107',
'1307',
'5110',
'1423',
'4222',
'1504',
'3421',
'4416',
'3310',
'1403',
'3624',
'2202',
'1306',
'3205',
'3426',
'3210',
'5137',
'4210',
'4306',
'1527',
'4331',
'3501',
'3707',
'5330',
'5227',
'4309',
'5139',
'4127',
'6221',
'6105',
'4415',
'6321',
'1525',
'2390',
'4109',
'5221',
'3602',
'5335',
'6401',
'1523',
'2303',
'1426',
'5323',
'2205',
'5201',
'5122',
'6403',
'6124',
'5107',
'3424',
'4108',
'3605',
'1521',
'3201',
'3604',
'3724',
'4228',
'4425',
'5333',
'6126',
'3303',
'5332',
'3304',
'5130',
'4211',
'3503',
'4101',
'1528',
'3411',
'3325',
'3207',
'3102',
'5104',
'5226',
'1407',
'2323',
'4402',
'5304',
'1311',
'2204',
'3302',
'4528',
'5134',
'2311',
'1424',
'3601',
'4114',
'3416',
'4312',
'3623',
'5111',
'1408',
'3505',
'5002',
'5115',
'5202',
'5105',
'3408',
'2114',
'4110',
'1302',
'6123',
'2104',
'3203',
'3506',
'4305',
'5224',
'5135',
'4113',
'3213',
'3211',
'1308',
'5116',
'4451',
'3208',
'5225',
'1325',
'1505',
'1509',
'3425',
'4514',
'6228',
'6328',
'6501',
'6541',
'5303',
'6106',
'2208',
'5331',
'2321',
'5223',
'3708',
'5108',
'3403',
'1522',
'5321',
'3729',
'5103',
'1410',
'4203',
'5329',
'2224',
'3307',
'2305',
'3709',
'4302',
'1427',
'3429',
'4223',
'4307',
'6203',
'4107',
'4128',
'3603',
'3508',
'5325',
'2312',
'3410',
'3502',
'3590',
'4115',
'5113',
'4503',
'6102',
'6127',
'4207',
'2105',
'4105') then CERT_4_INITAL_b2=3;
	else if CERT_4_INITAL in('3401',
'4512',
'3422',
'1501',
'5003',
'1405',
'4303',
'6205',
'3404',
'1329',
'4201',
'2203',
'4418',
'3406',
'5132',
'4208',
'3309',
'2206',
'4524',
'6104',
'3204',
'6223',
'3711',
'2301',
'5109',
'4304',
'2207',
'4412',
'1503',
'1508',
'1526',
'3101',
'3202',
'3423',
'3703',
'4326',
'4419',
'4428',
'2103',
'2106',
'3702',
'4507',
'2110',
'4301',
'2309',
'4408',
'4209',
'1401',
'3306',
'6201',
'3412',
'4506',
'2304',
'5138',
'1305',
'1304',
'3301',
'2112',
'5327',
'5301',
'4409',
'1411',
'1402',
'3606',
'4403',
'2108',
'4505',
'6224',
'3701',
'5001',
'2308',
'2101',
'4417',
'5326',
'3625',
'4313',
'6229',
'1301',
'1406',
'2302',
'6125',
'4130',
'2306',
'4452',
'2201',
'3704',
'5131',
'5305',
'3607') then CERT_4_INITAL_b2=4;
	else if CERT_4_INITAL in('6322',
'3418',
'5120',
'6109',
'6325',
'3608',
'4390',
'5190',
'5401',
'6529',
'6531',
'3728',
'3407',
'4406',
'5136',
'1201',
'3206',
'4404',
'1101',
'6121',
'5119',
'3390',
'3428',
'3611',
'3717',
'4226',
'5112',
'5114',
'6107',
'6542',
'6543',
'4401',
'4690',
'4601',
'4602',
'4527',
'1328',
'6226',
'5306',
'3715',
'5328',
'1502',
'6227',
'2102',
'1202',
'4509',
'4413',
'4510',
'4501',
'1102',
'5101',
'4323',
'5133',
'4508',
'3402',
'4525',
'3710',
'6101',
'2307',
'4521',
'3712',
'4504',
'3714',
'2109',
'4522',
'3790',
'4420',
'4603',
'4600',
'4453',
'1404',
'2111',
'4414',
'3713',
'4526',
'1310',
'5106',
'3706',
'6103') then CERT_4_INITAL_b2=5;
	else CERT_4_INITAL_b2=1;
run;
proc sql;
	select CERT_4_INITAL_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by CERT_4_INITAL_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if rej_count=. then rej_count_b2=3;
	else if  rej_count<0.35 then rej_count_b2=1;
/*	else if rej_count<2.1 then rej_count_b2=2;*/
	else if rej_count<7.0001 then rej_count_b2=3;
	else rej_count_b2=3;
run;
proc sql;
	select rej_count_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by rej_count_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if ontime_pay=. then ontime_pay_b2=5;
	else if  0<=ontime_pay<2.8 then ontime_pay_b2=1;
	else if ontime_pay<5.5 then ontime_pay_b2=2;
	else if ontime_pay<8.5 then ontime_pay_b2=3;
	else if ontime_pay<12.5 then ontime_pay_b2=4;
	else if ontime_pay<50.0001 then ontime_pay_b2=5;
	else ontime_pay_b2=5;
run;
proc sql;
	select ontime_pay_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by ontime_pay_b2;
run;
proc sql;
	select csfq_b,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by csfq_b;
run;
data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if avg_rollseq=. or 0<=avg_rollseq<1 then avg_rollseq_b2=1;
	else if avg_rollseq<1.05 then avg_rollseq_b2=2;
	else if avg_rollseq<1.75 then avg_rollseq_b2=3;
	else if avg_rollseq<4.5 then avg_rollseq_b2=4;
	else avg_rollseq_b2=1;
run;
proc sql;
	select avg_rollseq_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by avg_rollseq_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if SEQ_DELAY_DAYS=. or 30.999<=SEQ_DELAY_DAYS<1445.7 then SEQ_DELAY_DAYS_b2=1;
	else if SEQ_DELAY_DAYS<2860.4 then SEQ_DELAY_DAYS_b2=2;
	else if SEQ_DELAY_DAYS<4982.45 then SEQ_DELAY_DAYS_b2=3;
	else if SEQ_DELAY_DAYS<14178.0001 then SEQ_DELAY_DAYS_b2=4;
	else SEQ_DELAY_DAYS_b2=4;
run;
proc sql;
	select SEQ_DELAY_DAYS_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by SEQ_DELAY_DAYS_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp; 
	if over_due_value=. then over_due_value_b2=5;
	else if 0<=over_due_value<800.5 then over_due_value_b2=1;
	else if over_due_value<1148.5 then over_due_value_b2=2;
	else if over_due_value<1381.5 then over_due_value_b2=3;
	else if over_due_value<2109.5 then over_due_value_b2=4;
	else if over_due_value<34633.5 then over_due_value_b2=5;
	else over_due_value_b2=5;
run;
proc sql;
	select over_due_value_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by over_due_value_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp;
	if MAX_SEQ_DUEDAYS=. then MAX_SEQ_DUEDAYS_b2=5;
	else if 30.9999<=MAX_SEQ_DUEDAYS<39.0001 then MAX_SEQ_DUEDAYS_b2=1;
	else if MAX_SEQ_DUEDAYS<62.0001 then MAX_SEQ_DUEDAYS_b2=3;
	else if MAX_SEQ_DUEDAYS<77.0001 then MAX_SEQ_DUEDAYS_b2=4;
	else if MAX_SEQ_DUEDAYS<821.0001 then MAX_SEQ_DUEDAYS_b2=5;
	else MAX_SEQ_DUEDAYS_b2=5;
run;
proc sql;
	select MAX_SEQ_DUEDAYS_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by MAX_SEQ_DUEDAYS_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp;
	if CREDIT_AMOUNT=. then CREDIT_AMOUNT_b2=4;
	else if 2999.9999<=CREDIT_AMOUNT<5700 then CREDIT_AMOUNT_b2=1;
	else if CREDIT_AMOUNT<7050 then CREDIT_AMOUNT_b2=2;
	else if CREDIT_AMOUNT<30000.0001 then CREDIT_AMOUNT_b2=4;
	else CREDIT_AMOUNT_b2=4;
run;
proc sql;
	select CREDIT_AMOUNT_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by CREDIT_AMOUNT_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp;
	if max_roll_seq=. or 0<=max_roll_seq<0.2 then max_roll_seq_b2=1;
	else if max_roll_seq<1.2 then max_roll_seq_b2=2;
	else if max_roll_seq<4.0001 then max_roll_seq_b2=3;
	else max_roll_seq_b2=3;
run;
proc sql;
	select max_roll_seq_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by max_roll_seq_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp;
	if due_cstime_ratio=. then due_cstime_ratio_b2=4;
	else if 0<=due_cstime_ratio<30 then due_cstime_ratio_b2=1;
	else if due_cstime_ratio<60 then due_cstime_ratio_b2=2;
	else if due_cstime_ratio<115.332645 then due_cstime_ratio_b2=3;
	else if due_cstime_ratio<3033.1351 then due_cstime_ratio_b2=4;
	else due_cstime_ratio_b2=4;
run;
proc sql;
	select due_cstime_ratio_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by due_cstime_ratio_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp;
	if con1_due_times=. or 0<=con1_due_times<0.35 then con1_due_times_b2=1;
	else if con1_due_times<1.05 then con1_due_times_b2=2;
	else if con1_due_times<2.1 then con1_due_times_b2=3;
	else if con1_due_times<3.15 then con1_due_times_b2=4;
	else if con1_due_times<7.0001 then con1_due_times_b2=5;
	else con1_due_times_b2=1;
run;
proc sql;
	select con1_due_times_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by con1_due_times_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp;
	if avg_days=. then avg_days_b2=4;
	else if 0<=avg_days<14.94708 then avg_days_b2=1;
	else if avg_days<20.95002 then avg_days_b2=2;
	else if avg_days<26.95296 then avg_days_b2=3;
	else if avg_days<123.0001 then avg_days_b2=4;
	else avg_days_b2=1;
run;
proc sql;
	select avg_days_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by avg_days_b2;
run;
data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp;
	if insure_type=. then insure_type_b2=3;
	else if insure_type=2 then insure_type_b2=1;
	else if insure_type=4 then insure_type_b2=2;
	else if insure_type=1 then insure_type_b2=4;
	else insure_type_b2=1;
run;
proc sql;
	select insure_type_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by insure_type_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp;
	if due_delay_ratio=. then due_delay_ratio_b2=3;
	else if 0<=due_delay_ratio<36.42805 then due_delay_ratio_b2=1;
	else if due_delay_ratio<99.2571 then due_delay_ratio_b2=2;
	else if due_delay_ratio<1230.18 then due_delay_ratio_b2=3;
	else due_delay_ratio_b2=3;
run;
proc sql;
	select due_delay_ratio_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by due_delay_ratio_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp;
	if family_state=. or family_state=3 then family_state_b2=1;
	else if family_state=2 then family_state_b2=2;
	else if family_state=1 then family_state_b2=3;
	else if family_state=0 then family_state_b2=4;
	else family_state_b2=1;
run;
proc sql;
	select family_state_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by family_state_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp;
	if value_income_ratio=. then value_income_ratio_b2=5;
	else if 0<=value_income_ratio<0.292505 then value_income_ratio_b2=1;
	else if value_income_ratio<0.73281 then value_income_ratio_b2=2;
	else if value_income_ratio<1.173115 then value_income_ratio_b2=3;
	else if value_income_ratio<2.053725 then value_income_ratio_b2=4;
	else if value_income_ratio<8.6584 then value_income_ratio_b2=5;
	else value_income_ratio_b2=5;
run;
proc sql;
	select value_income_ratio_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by value_income_ratio_b2;
run;
data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp;
	if is_suixinhuan=. or is_suixinhuan=0 then is_suixinhuan_b2=1;
	else if is_suixinhuan=3 then is_suixinhuan_b2=2;
	else is_suixinhuan_b2=1;
run;
proc sql;
	select is_suixinhuan_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by is_suixinhuan_b2;
run;
proc sql;
 select state_month_cha,recent_contact_day,count(1) from lf.dz0201_data_import_part4 group by state_month_cha,recent_contact_day;
run;
proc sql;
 select recent_contact_day,count(1) from lf.dz0201_data_import_part3 group by recent_contact_day;
run;	
data lf.a0703_train_woe; 
	set lf.dz0300_train;
	if recent_contact_day=. then recent_contact_day_b2=2;
	else if 0<=recent_contact_day<1.15 then recent_contact_day_b2=1;
	else if recent_contact_day<603.0001 then recent_contact_day_b2=2;
	else recent_contact_day_b2=2;
run;
proc sql;
	select recent_contact_day_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by recent_contact_day_b2;
run;
data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp;
	if apr_payment_num=. then apr_payment_num_b2=5;
	else if 8.9999<=apr_payment_num<33.6 then apr_payment_num_b2=1;
	else if apr_payment_num<39.75 then apr_payment_num_b2=2;
	else if apr_payment_num<52.05 then apr_payment_num_b2=3;
	else if apr_payment_num<64.35 then apr_payment_num_b2=4;
	else if apr_payment_num<132.0001 then apr_payment_num_b2=5;
	else apr_payment_num_b2=5;
run;
proc sql;
	select apr_payment_num_b,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by apr_payment_num_b;
run;
data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp;
	if kptp=. then kptp_b2=1;
	else if 0<=kptp<1.2 then kptp_b2=2;
	else if kptp<3.6 then kptp_b2=3;
	else if kptp<7.2 then kptp_b2=4;
	else if kptp<24.0001 then kptp_b2=5;
	else kptp_b2=5;
run;
proc sql;
	select kptp_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by kptp_b2;
run;
proc sql;
	select kptp_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by kptp_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp;
	if app_count=. then app_count_b2=5;
	else if 1<=app_count<1.4 then app_count_b2=1;
	else if app_count<2.2 then app_count_b2=2;
	else if app_count<3.4 then app_count_b2=3;
	else if app_count<6.2 then app_count_b2=4;
	else if app_count<9.0001 then app_count_b2=5;
	else app_count_b2=5;
run;
proc sql;
	select app_count_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by app_count_b2;
run;

data lf.a0703_train_woe; 
	set lf.a0501_train_group_temp;
	if is_ssi=. then is_ssi_b2=1;
	else if is_ssi=0 then is_ssi_b2=1;
	else if is_ssi=1 then is_ssi_b2=2;
	else is_ssi_b2=1;
run;
proc sql;
	select is_ssi_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by is_ssi_b2;
run;

data lf.a0703_train_woe; 
	set lf.dz0300_train;
	if rpy_cn=. then rpy_cn_b2=1;
	else if 0<=rpy_cn<1.45 then rpy_cn_b2=2;
	else if rpy_cn<4.45 then rpy_cn_b2=3;
	else if rpy_cn<410.0001 then rpy_cn_b2=4;
	else rpy_cn_b2=1;
run;

proc sql;
	select rpy_cn_b2,count(1) as total,count(1)-sum(target) as good,sum(target) as bad,sum(target)/count(1) as badrate from lf.a0703_train_woe group by rpy_cn_b2;
run;
/*调整后的分组*/
%let runData=test;
data lf.a0701_&&runData._group;
	set lf.dz0300_&&runData.;
		if 0<=intime_pay<3.15 then intime_pay_b=1;
	else if intime_pay<6.3 then intime_pay_b=2;
	else if intime_pay<15.75 then intime_pay_b=3;
	else if intime_pay<22.05 then intime_pay_b=4;
	else if intime_pay<63.0001 or intime_pay=. then intime_pay_b=5;
	else intime_pay_b=5;
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
	if ptp_ratio=. or 0<=ptp_ratio<0.05 then ptp_ratio_b=1;
	else if ptp_ratio<0.2 then ptp_ratio_b=2;
	else if ptp_ratio<0.35 then ptp_ratio_b=3;
	else if ptp_ratio<0.55 then ptp_ratio_b=4;
	else if ptp_ratio<1.0001 then ptp_ratio_b=5;
	else ptp_ratio_b=1;
	if dk_ratio=. or 0<=dk_ratio<0.7 then dk_ratio_b=1;
	else if dk_ratio<0.8 then dk_ratio_b=2;
	else if dk_ratio<1.0001 then dk_ratio_b=3;
	else dk_ratio_b=1;
	if finish_periods_ratio=. or 0<=finish_periods_ratio<0.2 then finish_periods_ratio_b=1;
	else if finish_periods_ratio<0.35 then finish_periods_ratio_b=2;
	else if finish_periods_ratio<0.4 then finish_periods_ratio_b=3;
	else if finish_periods_ratio<0.6 then finish_periods_ratio_b=4;
	else if finish_periods_ratio<1.0001 then finish_periods_ratio_b=5;
	else finish_periods_ratio_b=1;
	if bptp=. then bptp_b=1;
	else if 0<=bptp<5.3 then bptp_b=2;
	else if bptp<10.6 then bptp_b=3;
	else if bptp<15.9 then bptp_b=4;
	else if bptp<106.0001 then bptp_b=5;
	else bptp_b=1;
	if ptp=. or 0<=ptp<5.75 then ptp_b=1;
	else if ptp<11.5 then ptp_b=2;
	else if ptp<23 then ptp_b=3;
	else if ptp<34.5 then ptp_b=4;
	else if ptp<115.0001 then ptp_b=5;
	else ptp_b=1;
	if ACTUALPAYFEE=. or 0<=ACTUALPAYFEE<706.956 then ACTUALPAYFEE_b=1;
	else if ACTUALPAYFEE<1413.912 then ACTUALPAYFEE_b=2;
	else if ACTUALPAYFEE<2120.868 then ACTUALPAYFEE_b=3;
	else if ACTUALPAYFEE<2827.824 then ACTUALPAYFEE_b=4;
	else if ACTUALPAYFEE<14139.12 then ACTUALPAYFEE_b=5;
	else ACTUALPAYFEE_b=1;
	if MOST_CONTACT_3M='' or MOST_CONTACT_3M in('ORLM','PWTR','FNBM') then MOST_CONTACT_3M_b=1;
	else if MOST_CONTACT_3M in('APPO','CMLM') then MOST_CONTACT_3M_b=2;
	else if MOST_CONTACT_3M in('CWOC','FOUP') then MOST_CONTACT_3M_b=3;
	else if MOST_CONTACT_3M in('INCM') then MOST_CONTACT_3M_b=4;
	else if MOST_CONTACT_3M in('PTP') then MOST_CONTACT_3M_b=5;
	else MOST_CONTACT_3M_b=1;
	if ACTUALPAYFINECNT=. or 0<=ACTUALPAYFINECNT<2 then ACTUALPAYFINECNT_b=1;
	else if ACTUALPAYFINECNT<4 then ACTUALPAYFINECNT_b=2;
	else if ACTUALPAYFINECNT<6 then ACTUALPAYFINECNT_b=3;
	else if ACTUALPAYFINECNT<12 then ACTUALPAYFINECNT_b=4;
	else if ACTUALPAYFINECNT<40.0001 then ACTUALPAYFINECNT_b=5;
	else ACTUALPAYFINECNT_b=1;
	if pay_periods=. or 1.9999<=PAY_PERIODS<6.35 then PAY_PERIODS_b=1;
	else if PAY_PERIODS<10.7 then PAY_PERIODS_b=2;
	else if PAY_PERIODS<15.05 then PAY_PERIODS_b=3;
	else if PAY_PERIODS<23.75 then PAY_PERIODS_b=4;
	else if PAY_PERIODS<89.0001 then PAY_PERIODS_b=5;
	else PAY_PERIODS_b=1;
		if person_sex=. or person_sex=1 then person_sex_b=1;
	else if person_sex=0 then person_sex_b=2;
	else person_sex_b=1;
	if education=. or education in(1,2) then education_b=1;
	else if education=3 then education_b=2;
	else if education=4 then education_b=3;
	else if education in(5,7) then education_b=4;
	else if education=6 then education_b=5;
	else education_b=1;
	if flag_applyloan=1 then flag_applyloan_b=1;
	else if flag_applyloan=0 then flag_applyloan_b=2;
	else if flag_applyloan=. then flag_applyloan_b=3;
	else flag_applyloan_b=1;
		if flag_tqww=1 then flag_tqww_b=1;
	else if flag_tqww=. then flag_tqww_b=2;
	else flag_tqww_b=1;
		if 0<=value_balance_ratio<1.704325 then value_balance_ratio_b=1;
	else if value_balance_ratio<2.643425 then value_balance_ratio_b=2;
	else if value_balance_ratio<3.582525 then value_balance_ratio_b=3;
	else if value_balance_ratio<5.22595 then value_balance_ratio_b=4;
	else if value_balance_ratio<5.6956 or value_balance_ratio=. then value_balance_ratio_b=5;
	else value_balance_ratio_b=5;
		if contact=. or 0<=contact<12.85 then contact_b=1;
	else if contact<19.5 then contact_b=2;
	else if contact<28.7 then contact_b=3;
	else if contact<47.4 then contact_b=4;
	else if contact<237.0001 then contact_b=5;
	else contact_b=1;
		if  0<=ontime_pay<3.8 then ontime_pay_b=1;
	else if ontime_pay<7.5 then ontime_pay_b=2;
	else if ontime_pay<12.5 then ontime_pay_b=3;
	else if ontime_pay<20 then ontime_pay_b=4;
	else if ontime_pay=. or ontime_pay<50.0001 then ontime_pay_b=5;
	else ontime_pay_b=5;
		if SEQ_DELAY_DAYS=. or 30.999<=SEQ_DELAY_DAYS<1445.7 then SEQ_DELAY_DAYS_b=1;
	else if SEQ_DELAY_DAYS<2860.4 then SEQ_DELAY_DAYS_b=2;
	else if SEQ_DELAY_DAYS<4982.45 then SEQ_DELAY_DAYS_b=3;
	else if SEQ_DELAY_DAYS<14178.0001 then SEQ_DELAY_DAYS_b=4;
	else SEQ_DELAY_DAYS_b=4;
		if over_due_value=. then over_due_value_b2=5;
	else if 0<=over_due_value<800.5 then over_due_value_b=1;
	else if over_due_value<1148.5 then over_due_value_b=2;
	else if over_due_value<1381.5 then over_due_value_b=3;
	else if over_due_value<2109.5 then over_due_value_b=4;
	else if over_due_value<34633.5 then over_due_value_b=5;
	else over_due_value_b=5;
		if 30.9999<=MAX_SEQ_DUEDAYS<70.5 then MAX_SEQ_DUEDAYS_b=1;
	else if MAX_SEQ_DUEDAYS=. or MAX_SEQ_DUEDAYS<821.0001 then MAX_SEQ_DUEDAYS_b=2;
	else MAX_SEQ_DUEDAYS_b=2;
		if max_roll_seq=. or 0<=max_roll_seq<0.2 then max_roll_seq_b=1;
	else if max_roll_seq<1.2 then max_roll_seq_b=2;
	else if max_roll_seq<4.0001 then max_roll_seq_b=3;
	else max_roll_seq_b=3;
		if due_cstime_ratio=. then due_cstime_ratio_b=4;
	else if 0<=due_cstime_ratio<30 then due_cstime_ratio_b=1;
	else if due_cstime_ratio<60 then due_cstime_ratio_b=2;
	else if due_cstime_ratio<115.332645 then due_cstime_ratio_b=3;
	else if due_cstime_ratio<3033.1351 then due_cstime_ratio_b=4;
	else due_cstime_ratio_b=4;
		if con1_due_times=. or 0<=con1_due_times<0.35 then con1_due_times_b=1;
	else if con1_due_times<1.05 then con1_due_times_b=2;
	else if con1_due_times<2.1 then con1_due_times_b=3;
	else if con1_due_times<3.15 then con1_due_times_b=4;
	else if con1_due_times<7.0001 then con1_due_times_b=5;
	else con1_due_times_b=1;
		if avg_days=. then avg_days_b=4;
	else if 0<=avg_days<14.94708 then avg_days_b=1;
	else if avg_days<20.95002 then avg_days_b=2;
	else if avg_days<26.95296 then avg_days_b=3;
	else if avg_days<123.0001 then avg_days_b=4;
	else avg_days_b=1;
		if insure_type=. then insure_type_b=3;
	else if insure_type=2 then insure_type_b=1;
	else if insure_type=4 then insure_type_b=2;
	else if insure_type=1 then insure_type_b=4;
	else insure_type_b=1;
		if due_delay_ratio=. then due_delay_ratio_b=3;
	else if 0<=due_delay_ratio<36.42805 then due_delay_ratio_b=1;
	else if due_delay_ratio<99.2571 then due_delay_ratio_b=2;
	else if due_delay_ratio<1230.18 then due_delay_ratio_b=3;
	else due_delay_ratio_b=3;
		if family_state=. or family_state=3 then family_state_b=1;
	else if family_state=2 then family_state_b=2;
	else if family_state=1 then family_state_b=3;
	else if family_state=0 then family_state_b=4;
	else family_state_b=1;
		if value_income_ratio=. then value_income_ratio_b=5;
	else if 0<=value_income_ratio<0.292505 then value_income_ratio_b=1;
	else if value_income_ratio<0.73281 then value_income_ratio_b=2;
	else if value_income_ratio<1.173115 then value_income_ratio_b=3;
	else if value_income_ratio<2.053725 then value_income_ratio_b=4;
	else if value_income_ratio<8.6584 then value_income_ratio_b=5;
	else value_income_ratio_b=5;
		if is_suixinhuan=. or is_suixinhuan=0 then is_suixinhuan_b=1;
	else if is_suixinhuan=3 then is_suixinhuan_b=2;
	else is_suixinhuan_b=1;
		if apr_payment_num=. then apr_payment_num_b=5;
	else if 8.9999<=apr_payment_num<33.6 then apr_payment_num_b=1;
	else if apr_payment_num<39.75 then apr_payment_num_b=2;
	else if apr_payment_num<52.05 then apr_payment_num_b=3;
	else if apr_payment_num<64.35 then apr_payment_num_b=4;
	else if apr_payment_num<132.0001 then apr_payment_num_b=5;
	else apr_payment_num_b=5;
	if kptp=. then kptp_b=1;
	else if 0<=kptp<1.2 then kptp_b=2;
	else if kptp<3.6 then kptp_b=3;
	else if kptp<7.2 then kptp_b=4;
	else if kptp<24.0001 then kptp_b=5;
	else kptp_b=5;
	if app_count=. then app_count_b=5;
	else if 1<=app_count<1.4 then app_count_b=1;
	else if app_count<2.2 then app_count_b=2;
	else if app_count<3.4 then app_count_b=3;
	else if app_count<6.2 then app_count_b=4;
	else if app_count<9.0001 then app_count_b=5;
	else app_count_b=5;
	if is_ssi=. then is_ssi_b=1;
	else if is_ssi=0 then is_ssi_b=1;
	else if is_ssi=1 then is_ssi_b=2;
	else is_ssi_b=1;
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
		if recent_contact_day=. then recent_contact_day_b=4;
	else if 0<=recent_contact_day<1.15 then recent_contact_day_b=1;
	else if recent_contact_day<5.15 then recent_contact_day_b=2;
	else if recent_contact_day<10.15 then recent_contact_day_b=3;
	else if recent_contact_day<603.0001 then recent_contact_day_b=4;
	else recent_contact_day_b=4;
		if rej_count=. then rej_count_b=2;
	else if rej_count<0.35 then rej_count_b=1;
	else if rej_count<7.0001 then rej_count_b=2;
	else rej_count_b=2;
		if rpy_cn=. then rpy_cn_b=1;
	else if 0<=rpy_cn<1.45 then rpy_cn_b=2;
	else if rpy_cn<4.45 then rpy_cn_b=3;
	else if rpy_cn<410.0001 then rpy_cn_b=4;
	else rpy_cn_b=1;
run;

data lf.a0701_&&runData._woe;                                                                                    
	set lf.a0701_&&runData._group;
	if 0<=intime_pay<3.15 then intime_pay_woe=-0.12451474;
	else if intime_pay<6.3 then intime_pay_woe=-0.041812993;
	else if intime_pay<15.75 then intime_pay_woe=0.010292938;
	else if intime_pay<22.05 then intime_pay_woe=0.067817722;
	else if intime_pay<63.0001 or intime_pay=. then intime_pay_woe=0.179171564;
	else intime_pay_woe=0.179171564;
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
		if ptp_ratio=. or 0<=ptp_ratio<0.05 then ptp_ratio_woe=0.833698765;
	else if ptp_ratio<0.2 then ptp_ratio_woe=0.348114014;
	else if ptp_ratio<0.35 then ptp_ratio_woe=0.107519484;
	else if ptp_ratio<0.55 then ptp_ratio_woe=-0.262597784;
	else if ptp_ratio<1.0001 then ptp_ratio_woe=-0.669829141;
	else ptp_ratio_woe=0.833698765;
		if dk_ratio=. or 0<=dk_ratio<0.7 then dk_ratio_woe=0.235195542;
	else if dk_ratio<0.8 then dk_ratio_woe=-0.005353843;
	else if dk_ratio<1.0001 then dk_ratio_woe=-0.052944933;
	else dk_ratio_woe=0.235195542;
		if finish_periods_ratio=. or 0<=finish_periods_ratio<0.2 then finish_periods_ratio_woe=0.448685684;
	else if finish_periods_ratio<0.35 then finish_periods_ratio_woe=0.145539126;
	else if finish_periods_ratio<0.4 then finish_periods_ratio_woe=-0.047922192;
	else if finish_periods_ratio<0.6 then finish_periods_ratio_woe=-0.194476609;
	else if finish_periods_ratio<1.0001 then finish_periods_ratio_woe=-0.372986103;
	else finish_periods_ratio_woe=0.448685684;
		if bptp=. then bptp_woe=0.944378442;
	else if 0<=bptp<5.3 then bptp_woe=0.295229055;
	else if bptp<10.6 then bptp_woe=-0.209963158;
	else if bptp<15.9 then bptp_woe=-0.522084755;
	else if bptp<106.0001 then bptp_woe=-0.9477653;
	else bptp_woe=0.944378442;
		if ptp=. or 0<=ptp<5.75 then ptp_woe=0.513619209;
	else if ptp<11.5 then ptp_woe=0.02616078;
	else if ptp<23 then ptp_woe=-0.43440411;
	else if ptp<34.5 then ptp_woe=-0.844491983;
	else if ptp<115.0001 then ptp_woe=-1.318347873;
	else ptp_woe=0.513619209;
		if ACTUALPAYFEE=. or 0<=ACTUALPAYFEE<706.956 then ACTUALPAYFEE_woe=0.379340886;
	else if ACTUALPAYFEE<1413.912 then ACTUALPAYFEE_woe=0.166077437;
	else if ACTUALPAYFEE<2120.868 then ACTUALPAYFEE_woe=-0.001656879;
	else if ACTUALPAYFEE<2827.824 then ACTUALPAYFEE_woe=-0.147083547;
	else if ACTUALPAYFEE<14139.12 then ACTUALPAYFEE_woe=-0.296892559;
	else ACTUALPAYFEE_woe=0.379340886;
		if MOST_CONTACT_3M='' or MOST_CONTACT_3M in('ORLM','PWTR','FNBM') then MOST_CONTACT_3M_woe=0.42422144;
	else if MOST_CONTACT_3M in('APPO','CMLM') then MOST_CONTACT_3M_woe=0.266409089;
	else if MOST_CONTACT_3M in('CWOC','FOUP') then MOST_CONTACT_3M_woe=0.092893399;
	else if MOST_CONTACT_3M in('INCM') then MOST_CONTACT_3M_woe=-0.310664131;
	else if MOST_CONTACT_3M in('PTP') then MOST_CONTACT_3M_woe=-0.436686525;
	else MOST_CONTACT_3M_woe=0.42422144;
		if ACTUALPAYFINECNT=. or 0<=ACTUALPAYFINECNT<2 then ACTUALPAYFINECNT_woe=0.391593645;
	else if ACTUALPAYFINECNT<4 then ACTUALPAYFINECNT_woe=-0.028042442;
	else if ACTUALPAYFINECNT<6 then ACTUALPAYFINECNT_woe=-0.196347283;
	else if ACTUALPAYFINECNT<12 then ACTUALPAYFINECNT_woe=-0.328095633;
	else if ACTUALPAYFINECNT<40.0001 then ACTUALPAYFINECNT_woe=-0.592797317;
	else ACTUALPAYFINECNT_woe=0.391593645;
		if pay_periods=. or 1.9999<=PAY_PERIODS<6.35 then PAY_PERIODS_woe=0.611387616;
	else if PAY_PERIODS<10.7 then PAY_PERIODS_woe=0.318152143;
	else if PAY_PERIODS<15.05 then PAY_PERIODS_woe=0.061875396;
	else if PAY_PERIODS<23.75 then PAY_PERIODS_woe=-0.163829541;
	else if PAY_PERIODS<89.0001 then PAY_PERIODS_woe=-0.316407722;
	else PAY_PERIODS_woe=0.611387616;
		if person_sex=. or person_sex=1 then person_sex_woe=0.008887014;
	else if person_sex=0 then person_sex_woe=-0.029863506;
	else person_sex_woe=0.008887014;
		if education=. or education in(1,2) then education_woe=0.098154715;
	else if education=3 then education_woe=0.045561988;
	else if education=4 then education_woe=-0.057923243;
	else if education in(5,7) then education_woe=-0.171245474;
	else if education=6 then education_woe=-0.354054095;
	else education_woe=0.098154715;
	if flag_applyloan=1 then flag_applyloan_woe=0.353679274;
	else if flag_applyloan=0 then flag_applyloan_woe=0.092923536;
	else if flag_applyloan=. then flag_applyloan_woe=-0.017072504;
	else flag_applyloan_woe=-0.017072504;
		if flag_tqww=1 then flag_tqww_woe=0.119584844;
	else if flag_tqww=. then flag_tqww_woe=-0.153748023;
	else flag_tqww_woe=-0.153748023;
		if 0<=value_balance_ratio<1.704325 then value_balance_ratio_woe=-0.233097478;
	else if value_balance_ratio<2.643425 then value_balance_ratio_woe=-0.043965548;
	else if value_balance_ratio<3.582525 then value_balance_ratio_woe=0.059500343;
	else if value_balance_ratio<5.22595 then value_balance_ratio_woe=0.166110293;
	else if value_balance_ratio<5.6956 or value_balance_ratio=. then value_balance_ratio_woe=1.439834569;
	else value_balance_ratio_woe=1.439834569;
		if contact=. or 0<=contact<12.85 then contact_woe=0.575643698;
	else if contact<19.5 then contact_woe=2.276510061;
	else if contact<28.7 then contact_woe=3.049835941;
	else if contact<47.4 then contact_woe=-0.184099352;
	else if contact<237.0001 then contact_woe=-0.511429908;
	else contact_woe=0.575643698;
		if 0<=ontime_pay<3.8 then ontime_pay_woe=-0.059754903;
	else if ontime_pay<7.5 then ontime_pay_woe=0.00367469;
	else if ontime_pay<12.5 then ontime_pay_woe=0.025982938;
	else if ontime_pay<20 then ontime_pay_woe=0.114137957;
	else if ontime_pay=. or ontime_pay<50.0001 then ontime_pay_woe=0.247877603;
	else ontime_pay_woe=0.247877603;
		if  SEQ_DELAY_DAYS=. or 30.999<=SEQ_DELAY_DAYS<1445.7 then SEQ_DELAY_DAYS_woe=0.006290742;
	else if SEQ_DELAY_DAYS<2860.4 then SEQ_DELAY_DAYS_woe=0.001098383;
	else if SEQ_DELAY_DAYS<4982.45 then SEQ_DELAY_DAYS_woe=-0.138101081;
	else if SEQ_DELAY_DAYS<14178.0001 then SEQ_DELAY_DAYS_woe=-0.289206216;
	else SEQ_DELAY_DAYS_woe=0.006290742;
		if over_due_value=. then over_due_value_woe=0.291327668;
	else if 0<=over_due_value<800.5 then over_due_value_woe=-0.354814241;
	else if over_due_value<1148.5 then over_due_value_woe=-0.155118632;
	else if over_due_value<1381.5 then over_due_value_woe=0.076345361;
	else if over_due_value<2109.5 then over_due_value_woe=0.081275295;
	else if over_due_value<34633.5 then over_due_value_woe=0.291327668;
	else over_due_value_woe=0.291327668;
		if 30.9999<=MAX_SEQ_DUEDAYS<70.5 then MAX_SEQ_DUEDAYS_woe=-0.011077908;
	else if MAX_SEQ_DUEDAYS=. or MAX_SEQ_DUEDAYS<821.0001 then MAX_SEQ_DUEDAYS_woe=0.177037013;
	else MAX_SEQ_DUEDAYS_woe=0.177037013;
		if max_roll_seq=. or 0<=max_roll_seq<0.2 then max_roll_seq_woe=0.70424517;
	else if max_roll_seq<1.2 then max_roll_seq_woe=0.029064787;
	else if max_roll_seq<4.0001 then max_roll_seq_woe=-0.25022178;
	else max_roll_seq_woe=-0.25022178;
		if due_cstime_ratio=. then due_cstime_ratio_woe=0.611030698;
	else if 0<=due_cstime_ratio<30 then due_cstime_ratio_woe=-0.406339105;
	else if due_cstime_ratio<60 then due_cstime_ratio_woe=0.012674337;
	else if due_cstime_ratio<115.332645 then due_cstime_ratio_woe=0.298087963;
	else if due_cstime_ratio<3033.1351 then due_cstime_ratio_woe=0.611030698;
	else due_cstime_ratio_woe=0.611030698;
		if con1_due_times=. or 0<=con1_due_times<0.35 then con1_due_times_woe=0.610087735;
	else if con1_due_times<1.05 then con1_due_times_woe=0.065446927;
	else if con1_due_times<2.1 then con1_due_times_woe=-0.12257356;
	else if con1_due_times<3.15 then con1_due_times_woe=-0.238056178;
	else if con1_due_times<7.0001 then con1_due_times_woe=-0.415972142;
	else con1_due_times_woe=0.610087735;
		if avg_days=. then avg_days_woe=0.406198617;
	else if 0<=avg_days<14.94708 then avg_days_woe=-0.099858925;
	else if avg_days<20.95002 then avg_days_woe=-0.03487204;
	else if avg_days<26.95296 then avg_days_woe=0.137815605;
	else if avg_days<123.0001 then avg_days_woe=0.406198617;
	else avg_days_woe=-0.099858925;
		if insure_type=. then insure_type_woe=-0.15464031;
	else if insure_type=2 then insure_type_woe=0.153112468;
	else if insure_type=4 then insure_type_woe=-0.037495157;
	else if insure_type=1 then insure_type_woe=-0.19955122;
	else insure_type_woe=0.153112468;
		if due_delay_ratio=. then due_delay_ratio_woe=0.942898057;
	else if 0<=due_delay_ratio<36.42805 then due_delay_ratio_woe=-0.024911484;
	else if due_delay_ratio<99.2571 then due_delay_ratio_woe=0.545280587;
	else if due_delay_ratio<1230.18 then due_delay_ratio_woe=0.942898057;
	else due_delay_ratio_woe=0.942898057;
		if family_state=. or family_state=3 then family_state_woe=0.351143575;
	else if family_state=2 then family_state_woe=0.075652975;
	else if family_state=1 then family_state_woe=-0.080373891;
	else if family_state=0 then family_state_woe=-0.147130488;
	else family_state_woe=0.351143575;
		if value_income_ratio=. then value_income_ratio_woe=1.188344625;
	else if 0<=value_income_ratio<0.292505 then value_income_ratio_woe=-0.042559156;
	else if value_income_ratio<0.73281 then value_income_ratio_woe=0.122811242;
	else if value_income_ratio<1.173115 then value_income_ratio_woe=0.40846115;
	else if value_income_ratio<2.053725 then value_income_ratio_woe=0.953363269;
	else if value_income_ratio<8.6584 then value_income_ratio_woe=1.188344625;
	else value_income_ratio_woe=1.188344625;
		if is_suixinhuan=. or is_suixinhuan=0 then is_suixinhuan_woe=0.116075173;
	else if is_suixinhuan=3 then is_suixinhuan_woe=-0.076683893;
	else is_suixinhuan_woe=0.116075173;
		if apr_payment_num=. then apr_payment_num_woe=0.219613332;
	else if 8.9999<=apr_payment_num<33.6 then apr_payment_num_woe=-0.112701514;
	else if apr_payment_num<39.75 then apr_payment_num_woe=-0.039173507;
	else if apr_payment_num<52.05 then apr_payment_num_woe=-0.000937262;
	else if apr_payment_num<64.35 then apr_payment_num_woe=0.086222698;
	else if apr_payment_num<132.0001 then apr_payment_num_woe=0.219613332;
	else apr_payment_num_woe=0.219613332;
		if kptp=. then kptp_woe=0.944378442;
	else if 0<=kptp<1.2 then kptp_woe=0.407030711;
	else if kptp<3.6 then kptp_woe=0.110648287;
	else if kptp<7.2 then kptp_woe=-0.252273305;
	else if kptp<24.0001 then kptp_woe=-0.766535798;
	else kptp_woe=-0.766535798;
		if app_count=. then app_count_woe=1.196604259;
	else if 1<=app_count<1.4 then app_count_woe=-0.398444916;
	else if app_count<2.2 then app_count_woe=-0.031115343;
	else if app_count<3.4 then app_count_woe=0.138821559;
	else if app_count<6.2 then app_count_woe=0.253389361;
	else if app_count<9.0001 then app_count_woe=1.196604259;
	else app_count_woe=1.196604259;
	if is_ssi=. then is_ssi_woe=0.023704328;
	else if is_ssi=0 then is_ssi_woe=0.023704328;
	else if is_ssi=1 then is_ssi_woe=-0.130260896;
	else is_ssi_woe=0.023704328;
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
		if recent_contact_day=. then recent_contact_day_woe=0.387680535;
	else if 0<=recent_contact_day<1.15 then recent_contact_day_woe=-0.297895242;
	else if recent_contact_day<5.15 then recent_contact_day_woe=0.12879766;
	else if recent_contact_day<10.15 then recent_contact_day_woe=0.328095979;
	else if recent_contact_day<603.0001 then recent_contact_day_woe=0.387680535;
	else recent_contact_day_woe=0.387680535;
		if rej_count=. then rej_count_woe=0.165227948;
	else if rej_count<0.35 then rej_count_woe=-0.021665076;
	else if rej_count<7.0001 then rej_count_woe=0.165227948;
	else rej_count_woe=0.165227948;
		if rpy_cn=. then rpy_cn_woe=0.047199209;
	else if 0<=rpy_cn<1.45 then rpy_cn_woe=-0.108690304;
	else if rpy_cn<4.45 then rpy_cn_woe=-0.124524529;
	else if rpy_cn<410.0001 then rpy_cn_woe=-0.268407994;
	else rpy_cn_woe=0.047199209;

run;