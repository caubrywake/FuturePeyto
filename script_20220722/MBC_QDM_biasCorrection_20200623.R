## Bias correcting the WRF dataswet
# Code from logan
# editd July 1- to get a bias corrected obs for the 5 cell covering peyto correpsonding to different elevations
setwd("D:/FuturePeyto/WRFdataset")
## Load packages
library(CRHMr)
#install.packages('MBC')
library(MBC)
## Import data: Obs, WRF current and WRF PGW
Peyto_obs <- readObsFile('D:/FuturePeyto/dataproc/met/A0/crhmOBS_metMOH_ERAp_20200819.obs','etc/GMT+7')
Peyto_obs <- changeRHtoEa(Peyto_obs)

###################################################################################################
## Cell 1

Peyto_wrf<-readObsFile('D:/WhichWRFCell/data/wrf/rawWRF_percell/rawWRF_CUR_Cell1.obs','etc/GMT+7')
Peyto_wrf_pgw<-readObsFile('D:/WhichWRFCell/data/wrf/rawWRF_percell/rawWRF_PGW_Cell1.obs','etc/GMT+7')
## Apply bias correction
t_QDM<-QDM(Peyto_obs[,2],Peyto_wrf[,2],Peyto_wrf_pgw[,2],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
t_QDM_out<-write.table(t_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/t_QDM_1.txt",sep="\t")
ea_QDM<-QDM(Peyto_obs[,3],Peyto_wrf[,3],Peyto_wrf_pgw[,3],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
ea_QDM_out<-write.table(ea_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/ea_QDM_1.txt",sep="\t")
u_QDM<-QDM(Peyto_obs[,4],Peyto_wrf[,4],Peyto_wrf_pgw[,4],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
u_QDM_out<-write.table(u_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/u_QDM_1.txt",sep="\t")
Qsi_QDM<-QDM(Peyto_obs[,5],Peyto_wrf[,5],Peyto_wrf_pgw[,5],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
Qsi_QDM_out<-write.table(Qsi_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/Qsi_QDM_1.txt",sep="\t")
Qli_QDM<-QDM(Peyto_obs[,6],Peyto_wrf[,6],Peyto_wrf_pgw[,6],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
Qli_QDM_out<-write.table(Qli_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/Qli_QDM_1.txt",sep="\t")

p_QDM<-QDM(Peyto_p[,2],Peyto_wrf[,7],Peyto_wrf_pgw[,7],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
p_QDM_out<-write.table(p_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/p_QDM_1.txt",sep="\t")

###################################################################################################
## Cell 2
Peyto_wrf<-readObsFile('D:/FuturePeyto/dataproc/wrf/rawWRF_perCell/rawWRF_CUR_Cell2_20200701.obs','etc/GMT+7')
Peyto_wrf_pgw<-readObsFile('D:/FuturePeyto/dataproc/wrf/rawWRF_perCell/rawWRF_PGW_Cell2_20200716.obs','etc/GMT+7')
## Apply bias correction
t_QDM<-QDM(Peyto_obs[,2],Peyto_wrf[,2],Peyto_wrf_pgw[,2],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
t_QDM_out<-write.table(t_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/t_QDM_2.txt",sep="\t")
ea_QDM<-QDM(Peyto_obs[,3],Peyto_wrf[,3],Peyto_wrf_pgw[,3],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
ea_QDM_out<-write.table(ea_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/ea_QDM_2.txt",sep="\t")
u_QDM<-QDM(Peyto_obs[,4],Peyto_wrf[,4],Peyto_wrf_pgw[,4],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
u_QDM_out<-write.table(u_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/u_QDM_2.txt",sep="\t")
Qsi_QDM<-QDM(Peyto_obs[,5],Peyto_wrf[,5],Peyto_wrf_pgw[,5],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
Qsi_QDM_out<-write.table(Qsi_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/Qsi_QDM_2.txt",sep="\t")
Qli_QDM<-QDM(Peyto_obs[,6],Peyto_wrf[,6],Peyto_wrf_pgw[,6],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
Qli_QDM_out<-write.table(Qli_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/Qli_QDM_2.txt",sep="\t")

p_QDM<-QDM(Peyto_p[,2],Peyto_wrf[,7],Peyto_wrf_pgw[,7],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
p_QDM_out<-write.table(p_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/p_QDM_2.txt",sep="\t")

###################################################################################################
## Cell 3
Peyto_wrf<-readObsFile('D:/FuturePeyto/dataproc/wrf/rawWRF_perCell/rawWRF_CUR_Cell3_20200701.obs','etc/GMT+7')
Peyto_wrf_pgw<-readObsFile('D:/FuturePeyto/dataproc/wrf/rawWRF_perCell/rawWRF_PGW_Cell3_20200716.obs','etc/GMT+7')
## Apply bias correction
t_QDM<-QDM(Peyto_obs[,2],Peyto_wrf[,2],Peyto_wrf_pgw[,2],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
t_QDM_out<-write.table(t_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/t_QDM_3.txt",sep="\t")
ea_QDM<-QDM(Peyto_obs[,3],Peyto_wrf[,3],Peyto_wrf_pgw[,3],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
ea_QDM_out<-write.table(ea_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/ea_QDM_3.txt",sep="\t")
u_QDM<-QDM(Peyto_obs[,4],Peyto_wrf[,4],Peyto_wrf_pgw[,4],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
u_QDM_out<-write.table(u_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/u_QDM_3.txt",sep="\t")
Qsi_QDM<-QDM(Peyto_obs[,5],Peyto_wrf[,5],Peyto_wrf_pgw[,5],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
Qsi_QDM_out<-write.table(Qsi_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/Qsi_QDM_3.txt",sep="\t")
Qli_QDM<-QDM(Peyto_obs[,6],Peyto_wrf[,6],Peyto_wrf_pgw[,6],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
Qli_QDM_out<-write.table(Qli_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/Qli_QDM_3.txt",sep="\t")

p_QDM<-QDM(Peyto_p[,2],Peyto_wrf[,7],Peyto_wrf_pgw[,7],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
p_QDM_out<-write.table(p_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/p_QDM_3.txt",sep="\t")

###################################################################################################
## Cell 4
Peyto_wrf<-readObsFile('D:/FuturePeyto/dataproc/wrf/rawWRF_perCell/rawWRF_CUR_Cell4_20200701.obs','etc/GMT+7')
Peyto_wrf_pgw<-readObsFile('D:/FuturePeyto/dataproc/wrf/rawWRF_perCell/rawWRF_PGW_Cell4_20200716.obs','etc/GMT+7')
## Apply bias correction
t_QDM<-QDM(Peyto_obs[,2],Peyto_wrf[,2],Peyto_wrf_pgw[,2],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
t_QDM_out<-write.table(t_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/t_QDM_4.txt",sep="\t")
ea_QDM<-QDM(Peyto_obs[,3],Peyto_wrf[,3],Peyto_wrf_pgw[,3],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
ea_QDM_out<-write.table(ea_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/ea_QDM_4.txt",sep="\t")
u_QDM<-QDM(Peyto_obs[,4],Peyto_wrf[,4],Peyto_wrf_pgw[,4],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
u_QDM_out<-write.table(u_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/u_QDM_4.txt",sep="\t")
Qsi_QDM<-QDM(Peyto_obs[,5],Peyto_wrf[,5],Peyto_wrf_pgw[,5],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
Qsi_QDM_out<-write.table(Qsi_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/Qsi_QDM_4.txt",sep="\t")
Qli_QDM<-QDM(Peyto_obs[,6],Peyto_wrf[,6],Peyto_wrf_pgw[,6],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
Qli_QDM_out<-write.table(Qli_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/Qli_QDM_4.txt",sep="\t")

p_QDM<-QDM(Peyto_obs[,2],Peyto_wrf[,7],Peyto_wrf_pgw[,7],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
p_QDM_out<-write.table(p_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/p_QDM_4.txt",sep="\t")

###################################################################################################
## Cell 5
Peyto_wrf<-readObsFile('D:/FuturePeyto/dataproc/wrf/rawWRF_perCell/rawWRF_CUR_Cell5_20200701.obs','etc/GMT+7')
Peyto_wrf_pgw<-readObsFile('D:/FuturePeyto/dataproc/wrf/rawWRF_perCell/rawWRF_PGW_Cell5_20200716.obs','etc/GMT+7')
## Apply bias correction
t_QDM<-QDM(Peyto_obs[,2],Peyto_wrf[,2],Peyto_wrf_pgw[,2],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
t_QDM_out<-write.table(t_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/t_QDM_5.txt",sep="\t")
ea_QDM<-QDM(Peyto_obs[,3],Peyto_wrf[,3],Peyto_wrf_pgw[,3],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
ea_QDM_out<-write.table(ea_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/ea_QDM_5.txt",sep="\t")
u_QDM<-QDM(Peyto_obs[,4],Peyto_wrf[,4],Peyto_wrf_pgw[,4],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
u_QDM_out<-write.table(u_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/u_QDM_5.txt",sep="\t")
Qsi_QDM<-QDM(Peyto_obs[,5],Peyto_wrf[,5],Peyto_wrf_pgw[,5],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
Qsi_QDM_out<-write.table(Qsi_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/Qsi_QDM_5.txt",sep="\t")
Qli_QDM<-QDM(Peyto_obs[,6],Peyto_wrf[,6],Peyto_wrf_pgw[,6],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
Qli_QDM_out<-write.table(Qli_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/Qli_QDM_5.txt",sep="\t")

p_QDM<-QDM(Peyto_obs[,7],Peyto_wrf[,7],Peyto_wrf_pgw[,7],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
p_QDM_out<-write.table(p_QDM,"D:/FuturePeyto/dataproc/wrf/qdmWRF_perCell/p_QDM_5.txt",sep="\t")




  