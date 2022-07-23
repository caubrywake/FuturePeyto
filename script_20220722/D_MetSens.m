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
##  ref
prjname <- 'D:/FuturePeyto/crhm/B_ReferenceSimulation/prjfile/PeytoPGW_Ref.prj'
filename <- 'D:/FuturePeyto/crhm/C_Scenarios/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/C_Scenarios/output/ref_soilbasinflow.txt')

## ice1
prjname <- 'D:/FuturePeyto/crhm/C_Scenarios/prjfile/ice1.prj'
filename <- 'D:/FuturePeyto/crhm/C_Scenarios/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/C_Scenarios/output/ice1_soilbasinflow.txt')

## ice2
prjname <- 'D:/FuturePeyto/crhm/C_Scenarios/prjfile/ice2.prj'
filename <- 'D:/FuturePeyto/crhm/C_Scenarios/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/C_Scenarios/output/ice2_soilbasinflow.txt')

## ice3
prjname <- 'D:/FuturePeyto/crhm/C_Scenarios/prjfile/ice3.prj'
filename <- 'D:/FuturePeyto/crhm/C_Scenarios/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/C_Scenarios/output/ice3_soilbasinflow.txt')

## sur1
prjname <- 'D:/FuturePeyto/crhm/C_Scenarios/prjfile/sur1.prj'
filename <- 'D:/FuturePeyto/crhm/C_Scenarios/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/C_Scenarios/output/sur1_soilbasinflow.txt')

## sur1
prjname <- 'D:/FuturePeyto/crhm/C_Scenarios/prjfile/sur1.prj'
filename <- 'D:/FuturePeyto/crhm/C_Scenarios/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/C_Scenarios/output/sur1_soilbasinflow.txt')

## sur2
prjname <- 'D:/FuturePeyto/crhm/C_Scenarios/prjfile/sur2.prj'
filename <- 'D:/FuturePeyto/crhm/C_Scenarios/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/C_Scenarios/output/sur2_soilbasinflow.txt')

## sur3
prjname <- 'D:/FuturePeyto/crhm/C_Scenarios/prjfile/sur3.prj'
filename <- 'D:/FuturePeyto/crhm/C_Scenarios/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/C_Scenarios/output/sur3_soilbasinflow.txt')

## sub1
prjname <- 'D:/FuturePeyto/crhm/C_Scenarios/prjfile/sub1.prj'
filename <- 'D:/FuturePeyto/crhm/C_Scenarios/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/C_Scenarios/output/sub1_soilbasinflow.txt')

## sub2
prjname <- 'D:/FuturePeyto/crhm/C_Scenarios/prjfile/sub2.prj'
filename <- 'D:/FuturePeyto/crhm/C_Scenarios/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/C_Scenarios/output/sub2_soilbasinflow.txt')

## sub3
prjname <- 'D:/FuturePeyto/crhm/C_Scenarios/prjfile/sub3.prj'
filename <- 'D:/FuturePeyto/crhm/C_Scenarios/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/C_Scenarios/output/sub3_soilbasinflow.txt')

## veg1
prjname <- 'D:/FuturePeyto/crhm/C_Scenarios/prjfile/veg1.prj'
filename <- 'D:/FuturePeyto/crhm/C_Scenarios/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/C_Scenarios/output/veg1_soilbasinflow.txt')

## veg2
prjname <- 'D:/FuturePeyto/crhm/C_Scenarios/prjfile/veg2.prj'
filename <- 'D:/FuturePeyto/crhm/C_Scenarios/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/C_Scenarios/output/veg2_soilbasinflow.txt')

## veg3
prjname <- 'D:/FuturePeyto/crhm/C_Scenarios/prjfile/veg3.prj'
filename <- 'D:/FuturePeyto/crhm/C_Scenarios/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/C_Scenarios/output/veg3_soilbasinflow.txt')

## wet
prjname <- 'D:/FuturePeyto/crhm/C_Scenarios/prjfile/wet.prj'
filename <- 'D:/FuturePeyto/crhm/C_Scenarios/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/C_Scenarios/output/wet_soilbasinflow.txt')

## dry
prjname <- 'D:/FuturePeyto/crhm/C_Scenarios/prjfile/dry.prj'
filename <- 'D:/FuturePeyto/crhm/C_Scenarios/setoutputvar/1_soilbasinflow.prj'
variables <- readPrjOutputVariables(filename, asDataframe=FALSE)
setPrjOutputVariables(prjname, variables)
result <- automatePrj(prjname)
result<-runCRHM(CRHMfile = 'D:/FuturePeyto/crhm/crhm_20200702/CRHM.exe',prjname, outFile='D:/FuturePeyto/crhm/C_Scenarios/output/dry_soilbasinflow.txt')
