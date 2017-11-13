
/*****************************************************************************************************
��˵����
		�ú��ò��Լ���֤ģ�ͼ��������ȶ��ԣ��ֱ����PSI��SSI����ָ��
�����ĺ꣺
		1����
����˵����
		train_data:
				ѵ������woeֵ��Pֵ
		test_data
				���Լ���woeֵ��Pֵ
		model_coef
				ģ����ѡ������
        P
                Pֵ��ȡ��
        Nb
                �����ֶ���
��������
		���PSI��SSI�����
���ߣ���¶��
���ڣ�2017.5.12
˵��:
        %Preselection(ѵ������woeֵ��Pֵ,���Լ���woeֵ��Pֵ,ģ����ѡ������,Pֵ��ȡ��,�����ֶ���);		 
*****************************************************************************************************/
%macro totalpsi(train_data,test_data,P,Nb);
/*1��PSI����*/
/* �ҳ�ѵ�������������ֵ����Сֵ���ܵ���*/
	proc sql  noprint; 
		 select  max(&P.),min(&P.),count(1) into : Pmax, : Pmin ,:nobs1
          from   &train_data.;/*��߷֡���ͷ�*/
	quit;

	 /*�����ÿ�������εĿ��*/
	%let Bs =%sysevalf((&Pmax-&Pmin)/&Nb);/*sysevalf �����������߼����ʽ�������ʽ*/

	/*����ѵ����ÿ���ֶε��Ͻ缰�½�*/
	data temp_train;
	 set &train_data.;
	  %do i=1 %to &Nb;
		 %let Bin_U&i=%sysevalf(&Pmin+&i*&Bs);
		 %let Bin_L&i=%sysevalf(&&Bin_U&i-&Bs);
		 IF &P. > &&Bin_L&i and &P. <=&&Bin_U&i THEN P1=&i.; 
	  %end;
	  if p1=. then p1=1;
	run;
	/* ����һ������ÿ���ֶε����½�ı� */
	data temp_blimits;
        %do i=1 %to &Nb;
         Bin_LowerLimit=&&Bin_L&i;
         Bin_UpperLimit=&&Bin_U&i;
          Bin=&i;
		  output;
     %end;
    run;

	/*ѵ�����ķֶη�Χ�����ֶεĵ�����ռ��*/
	proc sql noprint;
	create table &train_data._range as
	(select A.bin,A.Bin_LowerLimit,A.Bin_UpperLimit,b.n as train_n,b.percent as train_pct
            from temp_blimits as A,
	(select p1,count(1) as n,count(1)/&nobs1. as percent from temp_train group by p1) AS B
     where A.Bin=B.p1);
	run;

	/*ѵ���������½���е��������Ϸ����ֶη�Χ*/
	data &train_data._range;
	set &train_data._range;
	if _n_=10 then Bin_UpperLimit=999999;
    if _n_=1 then Bin_LowerLimit=-999999;
	range=compress(cats("(",Bin_LowerLimit,",",Bin_UpperLimit,"]"),'');
	run;

	/* �ҳ����Լ����ܵ���*/
	proc sql  noprint; 
		 select count(1) into :nobs2
          from   &test_data.;/*�ܵ���*/
	quit;

	/*����ѵ���������½�Բ��Լ���Pֵ���л���*/
	data temp_test;
	 set &test_data.;
	  %do i=1 %to &Nb-1;
		 IF &P. > &&Bin_L&i and &P. <=&&Bin_U&i THEN P1=&i.; 
	  %end;
       IF &P. > &&Bin_L&Nb THEN P1=&Nb; 
	   if P1=. then p1=1;
	run;

   /*����PSI*/
	proc sql noprint;
	create table &test_data._psi as
	select "%substr(&test_data,10,%length(%trim(&test_data))-9)" as id,* ,test_pct-train_pct as difference,test_pct/train_pct as variance,log(ifn(test_pct=.,0.001,test_pct/train_pct)) as ln,
          (test_pct-train_pct)*log(ifn(test_pct=.,0.001,test_pct/train_pct)) as Stability_Index
        from
	((select A.*,b.n as test_n,ifn(b.percent=.,0.001,b.percent) as test_pct
            from &train_data._range as A
	left join 
	(select p1,count(1) as n,count(1)/&nobs2. as percent from temp_test group by p1) AS B
     on A.Bin=B.p1));
	run;

	data &test_data._psi;
	set &test_data._psi;
	sum+Stability_Index;
	run;

proc delete data=temp_train temp_blimits &train_data._range temp_test;
run;
%mend;



%macro totalssi(train_data,test_data,model_coef);
/*2��SSI����*/
	proc sql  noprint; 
		 select count(1) into :nobs1
          from   &train_data.;
	quit;

	proc sql  noprint; 
		 select count(1) into :nobs2
          from   &test_data.;/*�ܵ���*/
	quit;

	proc sql  noprint; 
	select variable into : varlist separated by ' ' from  &model_coef. where variable<>"Intercept";/*�ҳ�ģ������Ҫ����SSI�ĸ�����*/
       %LET nvar=&SQLOBS;
      QUIT;
     %put &varlist.;

	 proc sql  noprint; 
	 create table &train_data._clus_total
	 (column varchar(100)
	 ,woe numeric
	 ,n numeric
	 ,percent numeric);
	 run;

	  proc sql  noprint; 
	 create table &test_data._clus_total
	 (column varchar(100)
	 ,woe numeric
	 ,n numeric
	 ,percent numeric);
	 run;

  %do i=1 %to &nvar;
       %LET var = %SCAN(&varlist, &i);

	/*ѵ�����������������ռ�����*/
	proc sql noprint;
	create table &train_data._clus as
	(select "&var." as column,&var. as woe,count(1) as n,count(1)/&nobs1. as percent from &train_data. group by &var.);
	run;

	data &train_data._clus_total;
	set  &train_data._clus_total &train_data._clus;
	run;
   /*���Լ��������������ռ�����*/
    proc sql noprint;
	create table &test_data._clus as
	(select "&var." as column,&var. as woe,count(1) as n,count(1)/&nobs2. as percent from &test_data. group by &var.);
	run;

	data &test_data._clus_total;
	set  &test_data._clus_total &test_data._clus ;
	run;
 %end;


   /*����SSI*/
	proc sql noprint;
	create table &test_data._var_SSI as 
	(select "%substr(&test_data,10,%length(%trim(&test_data))-9)" as id,*,test_pct-train_pct as difference,test_pct/train_pct as variance,log(ifn(test_pct=0,0.001,test_pct/train_pct)) as ln,
          (test_pct-train_pct)*log(ifn(test_pct=0,0.001,test_pct/train_pct)) as Stability_Index
		  from
	(select A.column,A.woe as clus,A.n as train_n,A.percent as train_pct,B.n as test_n,ifn(b.percent=.,0.001,b.percent) as test_pct
	from &train_data._clus_total as A
	left join &test_data._clus_total as B
	on A.column=B.column
	and A.woe=B.woe)
      );
	run;
	
	data &test_data._var_SSI;
	set &test_data._var_SSI;
	by column;
	if first.column then ssi=0;
	ssi+Stability_Index;
	run;
	
proc delete data= &train_data._clus_total &test_data._clus_total &train_data._clus &test_data._clus;
run;

%mend;