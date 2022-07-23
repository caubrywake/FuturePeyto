%% Same idea, but with the processes instead
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% With processes fpr MET %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% pgw
close all; clear all
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat', 'SWEPGW', 'hru_rainPGW', 'hru_snowPGW', 'hru_tPGW', 'timePGW')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat', 'SWEmeltPGW', 'gwPGW', 'hru_actetPGW', 'icemeltPGW', 'soil_moistPGW')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
time = timeREF; % rename time
var = cat(3, hru_actetREF,icemeltREF/24, SWEmeltREF/24, soil_moistREF, gwREF);% compile variable into one 3D matrix
varnames= {'Evaporation','Icemelt', 'Snowmelt', 'Soil Moisture', 'Groundwater Storage'};% compile variable names
[var_basinaverage ] =BasinAverage(var,hruarea);% create area weigthed basin average
var_basinaverage(1:8784, :) = []; time(1:8784, :) = [];% remove first year (spin up year)
[var_daily, t_daily] = RetimeDailySum(time,var_basinaverage) ;% change to daily sum
[var_nly, t_nly] = RemoveLeapYears(var_daily, t_daily);% remove the leap years 
[REFmean,REFstd,REFrshp_annual] = DailyAverage(var_nly,10, 1,t_nly); % compile daily mean, std and 15 years tables
time = t_nly(1:365);
save ('D:\FuturePeyto\crhm\C_Scenarios\output\REFprocesses.mat', 'REFmean','REFstd','REFrshp_annual','time', 'varnames')
%% Ice1
close all; clear all
 load('D:\FuturePeyto\crhm\D_MetSim\output\PeytoT1.mat', 'hru_actetICE1','icemeltICE1','SWEmeltICE1','soil_moistICE1', 'gwICE1','timeICE1')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
time = timeICE1; % rename time
var = cat(3, hru_actetICE1,icemeltICE1/24, SWEmeltICE1/24, soil_moistICE1, gwICE1);% compile variable into one 3D matrix
varnames= {'Evaporation','Icemelt', 'Snowmelt', 'Soil Moisture', 'Groundwater Storage'};% compile variable names
[var_basinaverage] =BasinAverage(var,hruarea);% create area weigthed basin average
var_basinaverage(1:8784, :) = []; time(1:8784, :) = [];% remove first year (spin up year)
[var_daily, t_daily] = RetimeDailySum(time,var_basinaverage) ;% change to daily sum
[var_nly, t_nly] = RemoveLeapYears(var_daily, t_daily);% remove the leap years 
[ICE1mean,ICE1std,ICE1rshp_annual] = DailyAverage(var_nly,10, 1,t_nly); % compile daily mean, std and 15 years tables
time = t_nly(1:365);
save ('D:\FuturePeyto\crhm\C_Scenarios\output\ICE1processes.mat', 'ICE1mean','ICE1std','ICE1rshp_annual','time', 'varnames')
%% Ice2
close all; clear all
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoICE2.mat','hru_actetICE2','icemeltICE2','SWEmeltICE2','soil_moistICE2', 'gwICE2','timeICE2')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
time = timeICE2; % rename time
var = cat(3, hru_actetICE2,icemeltICE2/24, SWEmeltICE2/24, soil_moistICE2, gwICE2);% % compile variable into one 3D matrix
varnames= {'Evaporation','Icemelt', 'Snowmelt', 'Soil Moisture', 'Groundwater Storage'};% compile variable names
[var_basinaverage ] =BasinAverage(var,hruarea);% create area weigthed basin average
var_basinaverage(1:8784, :) = []; time(1:8784, :) = [];% remove first year (spin up year)
[var_daily, t_daily] = RetimeDailySum(time,var_basinaverage) ;% change to daily sum
[var_nly, t_nly] = RemoveLeapYears(var_daily, t_daily);% remove the leap years 
[ICE2mean,ICE2std,ICE2rshp_annual] = DailyAverage(var_nly,10, 1,t_nly); % compile daily mean, std and 15 years tables
time = t_nly(1:365);
save ('D:\FuturePeyto\crhm\C_Scenarios\output\ICE2processes.mat', 'ICE2mean','ICE2std','ICE2rshp_annual','time', 'varnames')
%% Ice3
close all; clear all
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoICE3.mat','hru_actetICE3','icemeltICE3','SWEmeltICE3','soil_moistICE3', 'gwICE3','timeICE3')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
time = timeICE3; % rename time
var = cat(3, hru_actetICE3,icemeltICE3/24, SWEmeltICE3/24, soil_moistICE3, gwICE3);% % compile variable into one 3D matrix
varnames= {'Evaporation','Icemelt', 'Snowmelt', 'Soil Moisture', 'Groundwater Storage'};% compile variable names
[var_basinaverage ] =BasinAverage(var,hruarea);% create area weigthed basin average
var_basinaverage(1:8784, :) = []; time(1:8784, :) = [];% remove first year (spin up year)
[var_daily, t_daily] = RetimeDailySum(time,var_basinaverage) ;% change to daily sum
[var_nly, t_nly] = RemoveLeapYears(var_daily, t_daily);% remove the leap years 
[ICE3mean,ICE3std,ICE3rshp_annual] = DailyAverage(var_nly,10, 1,t_nly); % compile daily mean, std and 15 years tables
time = t_nly(1:365);
save ('D:\FuturePeyto\crhm\C_Scenarios\output\ICE3processes.mat', 'ICE3mean','ICE3std','ICE3rshp_annual','time', 'varnames')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sub1
close all; clear all
 load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUB1.mat', 'hru_actetSUB1','icemeltSUB1','SWEmeltSUB1','soil_moistSUB1', 'gwSUB1','timeSUB1')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
time = timeSUB1; % rename time
var = cat(3, hru_actetSUB1,icemeltSUB1/24, SWEmeltSUB1/24, soil_moistSUB1, gwSUB1);% compile variable into one 3D matrix
varnames= {'Evaporation','Icemelt', 'Snowmelt', 'Soil Moisture', 'Groundwater Storage'};% compile variable names
[var_basinaverage ] =BasinAverage(var,hruarea);% create area weigthed basin average
var_basinaverage(1:8784, :) = []; time(1:8784, :) = [];% remove first year (spin up year)
[var_daily, t_daily] = RetimeDailySum(time,var_basinaverage) ;% change to daily sum
[var_nly, t_nly] = RemoveLeapYears(var_daily, t_daily);% remove the leap years 
[SUB1mean,SUB1std,SUB1rshp_annual] = DailyAverage(var_nly,10, 1,t_nly); % compile daily mean, std and 15 years tables
time = t_nly(1:365);
save ('D:\FuturePeyto\crhm\C_Scenarios\output\SUB1processes.mat', 'SUB1mean','SUB1std','SUB1rshp_annual','time', 'varnames')
%% Sub2
close all; clear all
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUB2.mat','hru_actetSUB2','icemeltSUB2','SWEmeltSUB2','soil_moistSUB2', 'gwSUB2','timeSUB2')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
time = timeSUB2; % rename time
var = cat(3, hru_actetSUB2,icemeltSUB2/24, SWEmeltSUB2/24, soil_moistSUB2, gwSUB2);% % compile variable into one 3D matrix
varnames= {'Evaporation','Icemelt', 'Snowmelt', 'Soil Moisture', 'Groundwater Storage'};% compile variable names
[var_basinaverage ] =BasinAverage(var,hruarea);% create area weigthed basin average
var_basinaverage(1:8784, :) = []; time(1:8784, :) = [];% remove first year (spin up year)
[var_daily, t_daily] = RetimeDailySum(time,var_basinaverage) ;% change to daily sum
[var_nly, t_nly] = RemoveLeapYears(var_daily, t_daily);% remove the leap years 
[SUB2mean,SUB2std,SUB2rshp_annual] = DailyAverage(var_nly,10, 1,t_nly); % compile daily mean, std and 15 years tables
time = t_nly(1:365);
save ('D:\FuturePeyto\crhm\C_Scenarios\output\SUB2processes.mat', 'SUB2mean','SUB2std','SUB2rshp_annual','time', 'varnames')
%% Sub3
close all; clear all
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUB3.mat','hru_actetSUB3','icemeltSUB3','SWEmeltSUB3','soil_moistSUB3', 'gwSUB3','timeSUB3')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
time = timeSUB3; % rename time
var = cat(3, hru_actetSUB3,icemeltSUB3/24, SWEmeltSUB3/24, soil_moistSUB3, gwSUB3);% % compile variable into one 3D matrix
varnames= {'Evaporation','Icemelt', 'Snowmelt', 'Soil Moisture', 'Groundwater Storage'};% compile variable names
[var_basinaverage ] =BasinAverage(var,hruarea);% create area weigthed basin average
var_basinaverage(1:8784, :) = []; time(1:8784, :) = [];% remove first year (spin up year)
[var_daily, t_daily] = RetimeDailySum(time,var_basinaverage) ;% change to daily sum
[var_nly, t_nly] = RemoveLeapYears(var_daily, t_daily);% remove the leap years 
[SUB3mean,SUB3std,SUB3rshp_annual] = DailyAverage(var_nly,10, 1,t_nly); % compile daily mean, std and 15 years tables
time = t_nly(1:365);
save ('D:\FuturePeyto\crhm\C_Scenarios\output\SUB3processes.mat', 'SUB3mean','SUB3std','SUB3rshp_annual','time', 'varnames')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sur1
close all; clear all
 load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUR1.mat', 'hru_actetSUR1','icemeltSUR1','SWEmeltSUR1','soil_moistSUR1', 'gwSUR1','timeSUR1')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
time = timeSUR1; % rename time
var = cat(3, hru_actetSUR1,icemeltSUR1/24, SWEmeltSUR1/24, soil_moistSUR1, gwSUR1);% compile variable into one 3D matrix
varnames= {'Evaporation','Icemelt', 'Snowmelt', 'Soil Moisture', 'Groundwater Storage'};% compile variable names
[var_basinaverage ] =BasinAverage(var,hruarea);% create area weigthed basin average
var_basinaverage(1:8784, :) = []; time(1:8784, :) = [];% remove first year (spin up year)
[var_daily, t_daily] = RetimeDailySum(time,var_basinaverage) ;% change to daily sum
[var_nly, t_nly] = RemoveLeapYears(var_daily, t_daily);% remove the leap years 
[SUR1mean,SUR1std,SUR1rshp_annual] = DailyAverage(var_nly,10, 1,t_nly); % compile daily mean, std and 15 years tables
time = t_nly(1:365);
save ('D:\FuturePeyto\crhm\C_Scenarios\output\SUR1processes.mat', 'SUR1mean','SUR1std','SUR1rshp_annual','time', 'varnames')
%% Sur2
close all; clear all
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUR2.mat','hru_actetSUR2','icemeltSUR2','SWEmeltSUR2','soil_moistSUR2', 'gwSUR2','timeSUR2')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
time = timeSUR2; % rename time
var = cat(3, hru_actetSUR2,icemeltSUR2/24, SWEmeltSUR2/24, soil_moistSUR2, gwSUR2);% % compile variable into one 3D matrix
varnames= {'Evaporation','Icemelt', 'Snowmelt', 'Soil Moisture', 'Groundwater Storage'};% compile variable names
[var_basinaverage ] =BasinAverage(var,hruarea);% create area weigthed basin average
var_basinaverage(1:8784, :) = []; time(1:8784, :) = [];% remove first year (spin up year)
[var_daily, t_daily] = RetimeDailySum(time,var_basinaverage) ;% change to daily sum
[var_nly, t_nly] = RemoveLeapYears(var_daily, t_daily);% remove the leap years 
[SUR2mean,SUR2std,SUR2rshp_annual] = DailyAverage(var_nly,10, 1,t_nly); % compile daily mean, std and 15 years tables
time = t_nly(1:365);
save ('D:\FuturePeyto\crhm\C_Scenarios\output\SUR2processes.mat', 'SUR2mean','SUR2std','SUR2rshp_annual','time', 'varnames')
%% Sur3
close all; clear all
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUR3.mat','hru_actetSUR3','icemeltSUR3','SWEmeltSUR3','soil_moistSUR3', 'gwSUR3','timeSUR3')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
time = timeSUR3; % rename time
var = cat(3, hru_actetSUR3,icemeltSUR3/24, SWEmeltSUR3/24, soil_moistSUR3, gwSUR3);% % compile variable into one 3D matrix
varnames= {'Evaporation','Icemelt', 'Snowmelt', 'Soil Moisture', 'Groundwater Storage'};% compile variable names
[var_basinaverage ] =BasinAverage(var,hruarea);% create area weigthed basin average
var_basinaverage(1:8784, :) = []; time(1:8784, :) = [];% remove first year (spin up year)
[var_daily, t_daily] = RetimeDailySum(time,var_basinaverage) ;% change to daily sum
[var_nly, t_nly] = RemoveLeapYears(var_daily, t_daily);% remove the leap years 
[SUR3mean,SUR3std,SUR3rshp_annual] = DailyAverage(var_nly,10, 1,t_nly); % compile daily mean, std and 15 years tables
time = t_nly(1:365);
save ('D:\FuturePeyto\crhm\C_Scenarios\output\SUR3processes.mat', 'SUR3mean','SUR3std','SUR3rshp_annual','time', 'varnames')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% veg 1
close all; clear all
 load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoVEG1.mat', 'hru_actetVEG1','icemeltVEG1','SWEmeltVEG1','soil_moistVEG1', 'gwVEG1','timeVEG1')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
time = timeVEG1; % rename time
var = cat(3, hru_actetVEG1,icemeltVEG1/24, SWEmeltVEG1/24, soil_moistVEG1, gwVEG1);% compile variable into one 3D matrix
varnames= {'Evaporation','Icemelt', 'Snowmelt', 'Soil Moisture', 'Groundwater Storage'};% compile variable names
[var_basinaverage ] =BasinAverage(var,hruarea);% create area weigthed basin average
var_basinaverage(1:8784, :) = []; time(1:8784, :) = [];% remove first year (spin up year)
[var_daily, t_daily] = RetimeDailySum(time,var_basinaverage) ;% change to daily sum
[var_nly, t_nly] = RemoveLeapYears(var_daily, t_daily);% remove the leap years 
[VEG1mean,VEG1std,VEG1rshp_annual] = DailyAverage(var_nly,10, 1,t_nly); % compile daily mean, std and 15 years tables
time = t_nly(1:365);
save ('D:\FuturePeyto\crhm\C_Scenarios\output\VEG1processes.mat', 'VEG1mean','VEG1std','VEG1rshp_annual','time', 'varnames')
%% veg 2
close all; clear all
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoVEG2.mat','hru_actetVEG2','icemeltVEG2','SWEmeltVEG2','soil_moistVEG2', 'gwVEG2','timeVEG2')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
time = timeVEG2; % rename time
var = cat(3, hru_actetVEG2,icemeltVEG2/24, SWEmeltVEG2/24, soil_moistVEG2, gwVEG2);% % compile variable into one 3D matrix
varnames= {'Evaporation','Icemelt', 'Snowmelt', 'Soil Moisture', 'Groundwater Storage'};% compile variable names
[var_basinaverage ] =BasinAverage(var,hruarea);% create area weigthed basin average
var_basinaverage(1:8784, :) = []; time(1:8784, :) = [];% remove first year (spin up year)
[var_daily, t_daily] = RetimeDailySum(time,var_basinaverage) ;% change to daily sum
[var_nly, t_nly] = RemoveLeapYears(var_daily, t_daily);% remove the leap years 
[VEG2mean,VEG2std,VEG2rshp_annual] = DailyAverage(var_nly,10, 1,t_nly); % compile daily mean, std and 15 years tables
time = t_nly(1:365);
save ('D:\FuturePeyto\crhm\C_Scenarios\output\VEG2processes.mat', 'VEG2mean','VEG2std','VEG2rshp_annual','time', 'varnames')
%% veg 3
close all; clear all
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoVEG3.mat','hru_actetVEG3','icemeltVEG3','SWEmeltVEG3','soil_moistVEG3', 'gwVEG3','timeVEG3')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
time = timeVEG3; % rename time
var = cat(3, hru_actetVEG3,icemeltVEG3/24, SWEmeltVEG3/24, soil_moistVEG3, gwVEG3);% % compile variable into one 3D matrix
varnames= {'Evaporation','Icemelt', 'Snowmelt', 'Soil Moisture', 'Groundwater Storage'};% compile variable names
[var_basinaverage ] =BasinAverage(var,hruarea);% create area weigthed basin average
var_basinaverage(1:8784, :) = []; time(1:8784, :) = [];% remove first year (spin up year)
[var_daily, t_daily] = RetimeDailySum(time,var_basinaverage) ;% change to daily sum
[var_nly, t_nly] = RemoveLeapYears(var_daily, t_daily);% remove the leap years 
[VEG3mean,VEG3std,VEG3rshp_annual] = DailyAverage(var_nly,10, 1,t_nly); % compile daily mean, std and 15 years tables
time = t_nly(1:365);
save ('D:\FuturePeyto\crhm\C_Scenarios\output\VEG3processes.mat', 'VEG3mean','VEG3std','VEG3rshp_annual','time', 'varnames')
%% dry
close all; clear all
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoDRY.mat','hru_actetDRY','icemeltDRY','SWEmeltDRY','soil_moistDRY', 'gwDRY','timeDRY')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
time = timeDRY; % rename time
var = cat(3, hru_actetDRY,icemeltDRY/24, SWEmeltDRY/24, soil_moistDRY, gwDRY);% % compile variable into one 3D matrix
varnames= {'Evaporation','Icemelt', 'Snowmelt', 'Soil Moisture', 'Groundwater Storage'};% compile variable names
[var_basinaverage ] =BasinAverage(var,hruarea);% create area weigthed basin average
var_basinaverage(1:8784, :) = []; time(1:8784, :) = [];% remove first year (spin up year)
[var_daily, t_daily] = RetimeDailySum(time,var_basinaverage) ;% change to daily sum
[var_nly, t_nly] = RemoveLeapYears(var_daily, t_daily);% remove the leap years 
[DRYmean,DRYstd,DRYrshp_annual] = DailyAverage(var_nly,10, 1,t_nly); % compile daily mean, std and 15 years tables
time = t_nly(1:365);
save ('D:\FuturePeyto\crhm\C_Scenarios\output\DRYprocesses.mat', 'DRYmean','DRYstd','DRYrshp_annual','time', 'varnames')
%% wet
close all; clear all
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoWET.mat','hru_actetWET','icemeltWET','SWEmeltWET','soil_moistWET', 'gwWET','timeWET')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
time = timeWET; % rename time
var = cat(3, hru_actetWET,icemeltWET/24, SWEmeltWET/24, soil_moistWET, gwWET);% % compile variable into one 3D matrix
varnames= {'Evaporation','Icemelt', 'Snowmelt', 'Soil Moisture', 'Groundwater Storage'};% compile variable names
[var_basinaverage ] =BasinAverage(var,hruarea);% create area weigthed basin average
var_basinaverage(1:8784, :) = []; time(1:8784, :) = [];% remove first year (spin up year)
[var_daily, t_daily] = RetimeDailySum(time,var_basinaverage) ;% change to daily sum
[var_nly, t_nly] = RemoveLeapYears(var_daily, t_daily);% remove the leap years 
[WETmean,WETstd,WETrshp_annual] = DailyAverage(var_nly,10, 1,t_nly); % compile daily mean, std and 15 years tables
time = t_nly(1:365);
save ('D:\FuturePeyto\crhm\C_Scenarios\output\WETprocesses.mat', 'WETmean','WETstd','WETrshp_annual','time', 'varnames')
