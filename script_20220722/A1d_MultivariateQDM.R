## Bias correcting the WRF dataswet
# Code from logan
# April 24, 2020
setwd("D:/FuturePeyto/WRFdataset")
## Load packages
library(CRHMr)
#install.packages('MBC')
library(MBC)
## Import data: Obs, WRF current and WRF PGW

# observed sample
obs <- readObsFile('D:/FuturePeyto/dataproc/met/A0/crhmOBS_metMOH_ERAp_20200819.obs','etc/GMT+7')
obs <- obs[,2:7]

## CELL 1
# model calibration
cur <-readObsFile('D:/FuturePeyto/dataproc/wrf/A1c_exportRawWRFtoCRHMobs/rawWRF_CUR_Cell1.obs','etc/GMT+7')
cur <- cur[,2:7]
# model output for projected period
pgw <- readObsFile('D:/FuturePeyto/dataproc/wrf/A1c_exportRawWRFtoCRHMobs/rawWRF_PGW_Cell1.obs','etc/GMT+7')
pgw <- pgw [,2:7]
# MBC 
ratio<- c(FALSE, FALSE, FALSE, FALSE, FALSE, TRUE)
fit.mbcn <- MBCn(obs, cur, pgw, ratio.seq=ratio, trace=0.05)
# export result
p_QDM_out<-write.table(fit.mbcn$mhat.c,"D:/FuturePeyto/dataproc/wrf/A1d_QDMbiascorrection/MBCn_c_cell1.txt",sep="\t")
p_QDM_out<-write.table(fit.mbcn$mhat.p,"D:/FuturePeyto/dataproc/wrf/A1d_QDMbiascorrection/MBCn_p_cell1.txt",sep="\t")

## CELL 2
# model calibration
cur <-readObsFile('D:/FuturePeyto/dataproc/wrf/A1c_exportRawWRFtoCRHMobs/rawWRF_CUR_Cell2.obs','etc/GMT+7')
cur <- cur[,2:7]
# model output for projected period
pgw <- readObsFile('D:/FuturePeyto/dataproc/wrf/A1c_exportRawWRFtoCRHMobs/rawWRF_PGW_Cell2.obs','etc/GMT+7')
pgw <- pgw [,2:7]
# MBC 
ratio<- c(FALSE, FALSE, FALSE, FALSE, FALSE, TRUE)
fit.mbcn <- MBCn(obs, cur, pgw, ratio.seq=ratio, trace=0.05)
# export result
p_QDM_out<-write.table(fit.mbcn$mhat.c,"D:/FuturePeyto/dataproc/wrf/A1d_QDMbiascorrection/MBCn_c_cell2.txt",sep="\t")
p_QDM_out<-write.table(fit.mbcn$mhat.p,"D:/FuturePeyto/dataproc/wrf/A1d_QDMbiascorrection/MBCn_p_cell2.txt",sep="\t")

## CELL 3
# model calibration
cur <-readObsFile('D:/FuturePeyto/dataproc/wrf/A1c_exportRawWRFtoCRHMobs/rawWRF_CUR_Cell3.obs','etc/GMT+7')
cur <- cur[,2:7]
# model output for projected period
pgw <- readObsFile('D:/FuturePeyto/dataproc/wrf/A1c_exportRawWRFtoCRHMobs/rawWRF_PGW_Cell3.obs','etc/GMT+7')
pgw <- pgw [,2:7]
# MBC 
ratio<- c(FALSE, FALSE, FALSE, FALSE, FALSE, TRUE)
fit.mbcn <- MBCn(obs, cur, pgw, ratio.seq=ratio, trace=0.05)
# export result
p_QDM_out<-write.table(fit.mbcn$mhat.c,"D:/FuturePeyto/dataproc/wrf/A1d_QDMbiascorrection/MBCn_c_cell3.txt",sep="\t")
p_QDM_out<-write.table(fit.mbcn$mhat.p,"D:/FuturePeyto/dataproc/wrf/A1d_QDMbiascorrection/MBCn_p_cell3.txt",sep="\t")

## CELL 4
# model calibration
cur <-readObsFile('D:/FuturePeyto/dataproc/wrf/A1c_exportRawWRFtoCRHMobs/rawWRF_CUR_Cell4.obs','etc/GMT+7')
cur <- cur[,2:7]
# model output for projected period
pgw <- readObsFile('D:/FuturePeyto/dataproc/wrf/A1c_exportRawWRFtoCRHMobs/rawWRF_PGW_Cell4.obs','etc/GMT+7')
pgw <- pgw [,2:7]
# MBC 
ratio<- c(FALSE, FALSE, FALSE, FALSE, FALSE, TRUE)
fit.mbcn <- MBCn(obs, cur, pgw, ratio.seq=ratio, trace=0.05)
# export result
p_QDM_out<-write.table(fit.mbcn$mhat.c,"D:/FuturePeyto/dataproc/wrf/A1d_QDMbiascorrection/MBCn_c_cell4.txt",sep="\t")
p_QDM_out<-write.table(fit.mbcn$mhat.p,"D:/FuturePeyto/dataproc/wrf/A1d_QDMbiascorrection/MBCn_p_cell4.txt",sep="\t")

## CELL 5
# model calibration
cur <-readObsFile('D:/FuturePeyto/dataproc/wrf/A1c_exportRawWRFtoCRHMobs/rawWRF_CUR_Cell5.obs','etc/GMT+7')
cur <- cur[,2:7]
# model output for projected period
pgw <- readObsFile('D:/FuturePeyto/dataproc/wrf/A1c_exportRawWRFtoCRHMobs/rawWRF_PGW_Cell5.obs','etc/GMT+7')
pgw <- pgw [,2:7]
# MBC 
ratio<- c(FALSE, FALSE, FALSE, FALSE, FALSE, TRUE)
fit.mbcn <- MBCn(obs, cur, pgw, ratio.seq=ratio, trace=0.05)
# export result
p_QDM_out<-write.table(fit.mbcn$mhat.c,"D:/FuturePeyto/dataproc/wrf/A1d_QDMbiascorrection/MBCn_c_cell5.txt",sep="\t")
p_QDM_out<-write.table(fit.mbcn$mhat.p,"D:/FuturePeyto/dataproc/wrf/A1d_QDMbiascorrection/MBCn_p_cell5.txt",sep="\t")


