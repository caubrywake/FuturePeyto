# Running CRHM
install.packages("usethis")
library(usethis)
install.packages("backports")
library(backports)
install.packages("devtools")
library(devtools)
install_github("CentreForHydrology/CRHMr")
library(CRHMr)


##########################################################################################
## Basinflow
## Cold dry 
prjname <- 'D:/FuturePeyto/crhm/D_MetSim/prjfile/PeytoPGW_ColdDry.prj'
filename <- 'D:/FuturePeyto/crhm/D_MetSim/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/D_MetSim/output/ColdDry_soilbasinflow.txt')

## Warm dry 
prjname <- 'D:/FuturePeyto/crhm/D_MetSim/prjfile/PeytoPGW_WarmDry.prj'
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/D_MetSim/output/WarmDry_soilbasinflow.txt')


## Warm WET 
prjname <- 'D:/FuturePeyto/crhm/D_MetSim/prjfile/PeytoPGW_WarmWet.prj'
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/D_MetSim/output/WarmWet_soilbasinflow.txt')

## COLD  WET 
prjname <- 'D:/FuturePeyto/crhm/D_MetSim/prjfile/PeytoPGW_ColdWet.prj'
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/D_MetSim/output/ColdWet_soilbasinflow.txt')


## Temp
## T-1
prjname <- 'D:/FuturePeyto/crhm/D_MetSim/prjfile/PeytoPGW_T_1.prj'
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/D_MetSim/output/T_1_soilbasinflow.txt')

## T+1
prjname <- 'D:/FuturePeyto/crhm/D_MetSim/prjfile/PeytoPGW_T1.prj'
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/D_MetSim/output/T1_soilbasinflow.txt')

## T-2
prjname <- 'D:/FuturePeyto/crhm/D_MetSim/prjfile/PeytoPGW_T_2.prj'
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/D_MetSim/output/T_2_soilbasinflow_2.txt')

## T2
prjname <- 'D:/FuturePeyto/crhm/D_MetSim/prjfile/PeytoPGW_T2.prj'
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/D_MetSim/output/T2_soilbasinflow_2.txt')

## Precip
## P-1
prjname <- 'D:/FuturePeyto/crhm/D_MetSim/prjfile/PeytoPGW_P_1.prj'
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/D_MetSim/output/P_1_soilbasinflow.txt')

## P+1
prjname <- 'D:/FuturePeyto/crhm/D_MetSim/prjfile/PeytoPGW_P1.prj'
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/D_MetSim/output/P1_soilbasinflow.txt')

## P-2
prjname <- 'D:/FuturePeyto/crhm/D_MetSim/prjfile/PeytoPGW_P_2.prj'
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/D_MetSim/output/P_2_soilbasinflow.txt')

## P2
prjname <- 'D:/FuturePeyto/crhm/D_MetSim/prjfile/PeytoPGW_P2.prj'
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/D_MetSim/output/P2_soilbasinflow_2.txt')
