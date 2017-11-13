******************************************************************************;                                                                                                                                
*** 00连接配置                                                             ***;                                                                                                                                 
******************************************************************************; 
options errors=2 nocenter linesize = max pagesize = MAX macrogen;
options compress=binary mergenoby = error obs = MAX;

%let folder = %str(/sas/data1/rawdata1/f15);

libname lf "&folder./lpy/m2CuiShouCash20170908";
libname cs1 "&folder";
libname xgb "/sas/data1/rawdata1/f15/xgb";
libname f15 "/sas/data1/rawdata1/f15";
libname zdy "&folder./zdy/01_M1_Cash_Loan_Credit_Score";
libname xy "/sas/data1/rawdata1/f15/xy/M1_Pos_ScoreCard_v3";
libname lf_stm1       "/sas/data1/rawdata1/f15/strategy_monitor/m1"; 
libname lf_stm2       "/sas/data1/rawdata1/f15/strategy_monitor/m2";   
libname lf_stm3       "/sas/data1/rawdata1/f15/strategy_monitor/m3"; 
%include "&folder./lpy/m1CuiShouScoreCard/00_Macro_F01.sas";
%include "&folder./lpy/m1CuiShouScoreCard/00_Macro_PSI_SSI_Calculation.sas";


%let output_file = &folder./lpy/m2CuiShouCash20170908;

/*连接Hadoop数仓*/
options set=SAS_HADOOP_JAR_PATH="/sas/data1/Hadoop_Product/lib";
options set=SAS_HADOOP_CONFIG_PATH="/sas/data1/Hadoop_Product/conf";
libname rcas_cdh   hadoop user='pengyuan.li' password='Bqjr124' server='10.31.1.11' port=10000 database='rcas' subprotocol='hive2'
                   properties="hive.fetch.task.conversion.threshold=-1;hive.fetch.task.conversion=more";/*连接hadoop*/
libname tmp_dcc    hadoop user='pengyuan.li' password='Bqjr124' server='10.31.1.11' port=10000 database='tmp_dcc' subprotocol='hive2'
                   properties="hive.fetch.task.conversion.threshold=-1;hive.fetch.task.conversion=more";/*连接hadoop*/

libname s1    hadoop user='pengyuan.li' password='Bqjr124' server='10.31.1.11' port=10000 database='s1' subprotocol='hive2'
                   properties="hive.fetch.task.conversion.threshold=-1;hive.fetch.task.conversion=more";/*连接hadoop*/

libname ora_s1      oracle user=CUTEST pw="DBN1D5ACE3WC" path='10.10.10.17/RCAS' schema=s1;   /*连接oracle风控数仓*/
libname ora_cs1     oracle user=CUTEST pw="DBN1D5ACE3WC" path='10.10.10.17/RCAS' schema=cs1;  /*连接oracle风控数仓*/
libname ora_rcas    oracle user=CUTEST pw="DBN1D5ACE3WC" path='10.10.10.17/RCAS' schema=rcas; /*连接oracle风控数仓*/
libname ora_ods     oracle user=CUTEST pw="DBN1D5ACE3WC" path='10.10.10.17/RCAS' schema=ods; /*连接oracle风控数仓*/
libname ora_sco     oracle user=CUTEST pw="DBN1D5ACE3WC" path='10.10.10.17/RCAS' schema=sco; /*连接oracle风控数仓*/
libname ora_cut     oracle user=CUTEST pw="DBN1D5ACE3WC" path='10.10.10.17/RCAS' schema=cutest; /*连接oracle风控数仓*/

