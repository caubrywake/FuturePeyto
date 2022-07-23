# Running CRHM
install.packages("usethis")
library(usethis)
install.packages("backports")
library(backports)
install.packages("devtools")
library(devtools)
install_github("CentreForHydrology/CRHMr")
library(CRHMr)

obs<- readObsFile('D:/FuturePeyto/dataproc/wrf/A2b_Cell4toCRHMobs/crhmOBS_qdmCUR4.obs','etc/GMT+7')
result <- writeObsFile(obs, 'D:/FuturePeyto/crhm/B_ReferenceSimulation/obs/crhmOBS_qdmCUR4_20201006.obs')

obs<- readObsFile('D:/FuturePeyto/dataproc/wrf/A2b_Cell4toCRHMobs/crhmOBS_qdmPGW4.obs','etc/GMT+7')
result <- writeObsFile(obs, 'D:/FuturePeyto/crhm/B_ReferenceSimulation/obs/crhmOBS_qdmPGW4_20201006.obs')
##########################################################################################
## ## Running current

####
prjname <- 'D:/5_FuturePeyto/crhm/B_ReferenceSimulation/prjfile/PeytoCUR_Ref_20201028.prj'

filename <- 'D:/FuturePeyto/crhm/B_ReferenceSimulation/setoutputvar/1_SWE_basinflow_glacierh2o.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/B_ReferenceSimulation/output/CUR/1_SWE_basinflow_glacierh2o_test.txt')

# 2_SWEmelt_Icemelt_Firnmelt_T_RH.prj
filename <- 'D:/FuturePeyto/crhm/B_ReferenceSimulation/setoutputvar/2_Swemelt_Icemelt_Firnmelt_T_RH.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile ='D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/B_ReferenceSimulation/output/CUR/2_Swemelt_Icemelt_Firnmelt_T_RH.txt')

# 3_AcET_Drift_Subl_AvyIn_AvyOut.prj
filename <- 'D:/FuturePeyto/crhm/B_ReferenceSimulation/setoutputvar/3_AcET_Drift_Subl_AvyIn_AvyOut.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/B_ReferenceSimulation/output/CUR/3_AcET_Drift_Subl_AvyIn_AvyOut.txt')

# 4_Infilact_Soilmoist_GWflow_Rain_Snow.prj
filename <- 'D:/FuturePeyto/crhm/B_ReferenceSimulation/setoutputvar/4_Infilact_Soilmoist_GWflow_Rain_Snow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/B_ReferenceSimulation/output/CUR/4_Infilact_Soilmoist_GWflow_Rain_Snow.txt')

# 5_T_Rain_Snow_SoilRunoff_GW.prj
filename <- 'D:/FuturePeyto/crhm/B_ReferenceSimulation/setoutputvar/5_SoilRunoff_GW_Precip_Qsi_Qli.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/B_ReferenceSimulation/output/CUR/5_SoilRunoff_GW_Precip_Qsi_Qli.txt')

# 8_Soilssr_SdEvap_U_Meltrunoff_SnowInfil.prj
filename <- 'D:/FuturePeyto/crhm/B_ReferenceSimulation/setoutputvar/8_Soilssr_SdEvap_U_Meltrunoff_SnowInfil.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/B_ReferenceSimulation/output/CUR/8_Soilssr_SdEvap_U_Meltrunoff_SnowInfil.txt')

# 9_SoilMoist_GWflow.prj
filename <- 'D:/FuturePeyto/crhm/B_ReferenceSimulation/setoutputvar/9_SoilMoist_GWflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/B_ReferenceSimulation/output/CUR/9_SoilMoist_GWflow.txt')

# 10_INFIL
filename <- 'D:/5_FuturePeyto/crhm/B_ReferenceSimulation/setoutputvar/10_infil.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/5_FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/5_FuturePeyto/crhm/B_ReferenceSimulation/output/PGW/10_infil.txt')

 ## Future ####
prjname <- 'D:/5FuturePeyto/crhm/B_ReferenceSimulation/prjfile/PeytoPGW_Ref_20201028.prj'

## 1_GlacierH2O_SWE_Basinflow.prj
filename <- 'D:/FuturePeyto/crhm/B_ReferenceSimulation/setoutputvar/1_SWE_basinflow_glacierh2o.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/B_ReferenceSimulation/output/PGW/1_SWE_basinflow_glacierh2o.txt')

# 2_SWEmelt_Icemelt_Firnmelt_T_RH.prj
filename <- 'D:/FuturePeyto/crhm/B_ReferenceSimulation/setoutputvar/2_Swemelt_Icemelt_Firnmelt_T_RH.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile ='D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/B_ReferenceSimulation/output/PGW/2_Swemelt_Icemelt_Firnmelt_T_RH.txt')

# 3_AcET_Drift_Subl_AvyIn_AvyOut.prj
filename <- 'D:/FuturePeyto/crhm/B_ReferenceSimulation/setoutputvar/3_AcET_Drift_Subl_AvyIn_AvyOut.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/B_ReferenceSimulation/output/PGW/3_AcET_Drift_Subl_AvyIn_AvyOut.txt')

# 4_Infilact_Soilmoist_GWflow_Rain_Snow.prj
filename <- 'D:/FuturePeyto/crhm/B_ReferenceSimulation/setoutputvar/4_Infilact_Soilmoist_GWflow_Rain_Snow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/B_ReferenceSimulation/output/PGW/4_Infilact_Soilmoist_GWflow_Rain_Snow.txt')

# 5_T_Rain_Snow_SoilRunoff_GW.prj
filename <- 'D:/FuturePeyto/crhm/B_ReferenceSimulation/setoutputvar/5_SoilRunoff_GW_Precip_Qsi_Qli.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/B_ReferenceSimulation/output/PGW/5_SoilRunoff_GW_Precip_Qsi_Qli.txt')

# 8_Soilssr_SdEvap_U_Meltrunoff_SnowInfil.prj
filename <- 'D:/FuturePeyto/crhm/B_ReferenceSimulation/setoutputvar/8_Soilssr_SdEvap_U_Meltrunoff_SnowInfil.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/B_ReferenceSimulation/output/PGW/8_Soilssr_SdEvap_U_Meltrunoff_SnowInfil.txt')

# 9_SoilMoist_GWflow.prj
filename <- 'D:/FuturePeyto/crhm/B_ReferenceSimulation/setoutputvar/9_Soilmoist_GWflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/B_ReferenceSimulation/output/PGW/9_Soilmoist_GWflow.txt')

# 10_INFIL
filename <- 'D:/5_FuturePeyto/crhm/B_ReferenceSimulation/setoutputvar/10_infil.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/5_FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/5_FuturePeyto/crhm/B_ReferenceSimulation/output/PGW/10_infil.txt')
