# Running CRHM
install.packages("usethis")
library(usethis)
install.packages("backports")
library(backports)
install.packages("devtools")
library(devtools)
install_github("CentreForHydrology/CRHMr")
library(CRHMr)


## load and write obs
obs<- readObsFile('D:/FuturePeyto/dataproc/wrf/crhmOBS_qdmCUR4_20200703.obs','etc/GMT+7')
result <- writeObsFile(obs, 'D:/FuturePeyto/crhm/A_CRHM_WRFforcings/obs/crhmOBS_qdmCUR4_20200703.obs')

obs<- readObsFile('D:/FuturePeyto/dataproc/wrf/crhmOBS_CURmbc_20200706.obs','etc/GMT+7')
result <- writeObsFile(obs, 'D:/FuturePeyto/crhm/A_CRHM_WRFforcings/obs/crhmOBS_CURmbc_20200706.obs')

obs<- readObsFile('D:/FuturePeyto/dataproc/wrf/crhmOBS_qdmPGW4_20200703.obs','etc/GMT+7')
result <- writeObsFile(obs, 'D:/FuturePeyto/crhm/B_ReferenceSimulation/obs/crhmOBS_qdmPGW4_20200703.obs')

##########################################################################################
##########################################################################################
## Running with cell 4 downscaled
##########################################################################################
##########################################################################################

#### eval  PeytoCUR_1OBS
prjname <-'D:/FuturePeyto/crhm/A_CRHM_WRFforcings/prjfile/PeytoCUR_1OBS.prj'
filename <- 'D:/FuturePeyto/crhm/A_CRHM_WRFforcings/setoutputvar/Var_eval.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/A_CRHM_WRFforcings/output/PeytoCUR_1OBS_eval.txt')

#### eval  PeytoCUR_4OBS
prjname <-'D:/FuturePeyto/crhm/A_CRHM_WRFforcings/prjfile/PeytoCUR_4OBS.prj'
filename <- 'D:/FuturePeyto/crhm/A_CRHM_WRFforcings/setoutputvar/Var_eval.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/A_CRHM_WRFforcings/output/PeytoCUR_4OBS_eval.txt')

############ These runs are used to evaluated model. Now to run with all the MET
#### MET  PeytoCUR_1OBS
prjname <-'D:/FuturePeyto/crhm/A_CRHM_WRFforcings/prjfile/PeytoCUR_1OBS.prj'
filename <- 'D:/FuturePeyto/crhm/A_CRHM_WRFforcings/setoutputvar/Var_T_RH_U_P.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/A_CRHM_WRFforcings/output/PeytoCUR_1OBS_T_RH_U_P.txt')

#### MET  PeytoCUR_4OBS
prjname <-'D:/FuturePeyto/crhm/A_CRHM_WRFforcings/prjfile/PeytoCUR_4OBS.prj'
filename <- 'D:/FuturePeyto/crhm/A_CRHM_WRFforcings/setoutputvar/Var_T_RH_U_P.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/A_CRHM_WRFforcings/output/PeytoCUR_4OBS_T_RH_U_P.txt')

#### RAD  PeytoCUR_1OBS
prjname <-'D:/FuturePeyto/crhm/A_CRHM_WRFforcings/prjfile/PeytoCUR_1OBS.prj'
filename <- 'D:/FuturePeyto/crhm/A_CRHM_WRFforcings/setoutputvar/Var_Qsi_Qli.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/A_CRHM_WRFforcings/output/PeytoCUR_1OBS_Qsi_Qli.txt')

#### RAD PeytoCUR_4OBS
prjname <-'D:/FuturePeyto/crhm/A_CRHM_WRFforcings/prjfile/PeytoCUR_4OBS.prj'
filename <- 'D:/FuturePeyto/crhm/A_CRHM_WRFforcings/setoutputvar/Var_Qsi_Qli.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/A_CRHM_WRFforcings/output/PeytoCUR_4OBS_T_RH_U_P.txt')
