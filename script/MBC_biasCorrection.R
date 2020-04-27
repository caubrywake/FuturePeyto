## Bias correcting the WRF dataswet
# Code from logan
# April 24, 2020
setwd("D:/FuturePeyto/WRFdataset")
## Load packages
library(CRHMr)
#install.packages('MBC')
library(MBC)
## Import data: Obs, WRF current and WRF PGW

Peyto_obs<-readObsFile('ObsPeyto_24042020.obs','etc/GMT+7')
Peyto_wrf<-readObsFile('WRFCUR_24042020.obs','etc/GMT+7')
Peyto_wrf_pgw<-readObsFile('WRFPGW_24042020.obs','etc/GMT+7')

plotObs(Peyto_obs)
plotObs(Peyto_wrf)
plotObs(Peyto_wrf_pgw)
## Apply bias correction
t_QDM<-QDM(Peyto_obs[,2],Peyto_wrf[,2],Peyto_wrf_pgw[,2],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
t_QDM_out<-write.table(t_QDM,"t_QDM.txt",sep="\t")
ea_QDM<-QDM(Peyto_obs[,3],Peyto_wrf[,3],Peyto_wrf_pgw[,3],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
ea_QDM_out<-write.table(ea_QDM,"ea_QDM.txt",sep="\t")
u_QDM<-QDM(Peyto_obs[,4],Peyto_wrf[,4],Peyto_wrf_pgw[,4],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
u_QDM_out<-write.table(u_QDM,"u_QDM.txt",sep="\t")
Qsi_QDM<-QDM(Peyto_obs[,5],Peyto_wrf[,5],Peyto_wrf_pgw[,5],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
Qsi_QDM_out<-write.table(Qsi_QDM,"Qsi_QDM.txt",sep="\t")
Qli_QDM<-QDM(Peyto_obs[,6],Peyto_wrf[,6],Peyto_wrf_pgw[,6],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
Qli_QDM_out<-write.table(Qli_QDM,"Qli_QDM.txt",sep="\t")
p_QDM<-QDM(Peyto_obs[,7],Peyto_wrf[,7],Peyto_wrf_pgw[,7],ratio=FALSE,trace=0.05,trace.calc = 0.5*trace,jitter.factor = 0,n.tau=NULL,ratio.max = 2,ratio.max.trace = 10*trace,ECBC=FALSE,ties='first',subsample = NULL,pp.type = 7)
p_QDM_out<-write.table(p_QDM,"p_QDM.txt",sep="\t")
