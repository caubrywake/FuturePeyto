% Compile calendar day inter-annual averages for processes for landscape
% scenarios
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% edited Nov 6
close all; clear all
NAME = {'REF','ICE1', 'ICE2','ICE3','SUR1','SUR2','SUR3','SUB1','SUB2','SUB3','VEG1','VEG2','VEG3','WET','DRY'};

%% PGW
% for folder A-Z, 
for i = 1:length(NAME)
name = NAME{i};
var = {strcat('hru_actet', name); strcat('icemelt', name);strcat('soil_runoff', name);...
       strcat('soil_ssr', name); strcat('gw_flow', name); ...
        strcat('soil_moist', name); strcat('gw', name);strcat('Sd', name);...
       strcat('time', name)};
   varname =  {'hru_actet'; 'icemelt';'soil_runoff';'soil_ssr';'gw_flow';'soil_moist';'gw';'Sd';'time'};
% load variable change change variable nae to the generic names
for ii = 1:length(var)
load(strcat('D:\FuturePeyto\crhm\C_Scenarios\output\Peyto',name,'.mat'), var{ii}) 
x = eval(var{ii});
assignin('base', varname{ii}, x)
clear(var{ii})
end
% catchment characteristics
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')

% Calculate the basin average for the fluxes
var = cat(3,  hru_actet, icemelt/24, soil_runoff, soil_ssr, gw_flow, soil_moist, gw, Sd(:, 38:end));% compile variable into one 3D matrix
varnames= {'Evaporation','Icemelt', 'Soil Runoff','SSR runoff', 'GW flow', 'Soil Moisture', 'Groundwater Storage', 'Depressional Storage',};% compile variable names
[var_basinaverage] = BasinAverage(var,hruarea);% create area weigthed basin average

var_basinaverage_all = [var_basinaverage];
varname_basinaverage_all = [varnames];
sz = size(var_basinaverage_all);

% create daily mean or daily sum 
% define which variables should be  daily averages
var_mean ={'Soil Moisture', 'Groundwater Storage', 'Depressional Storage'};
for ii = 1:sz(2)
    if isempty(find((strcmp(var_mean,varname_basinaverage_all{ii}))));% of not, its a sum
[x, t_daily] = RetimeDaily(datetime(datevec(time)),var_basinaverage_all(:, ii),'sum') ;% change to daily sum
    else
[x, t_daily] = RetimeDaily(datetime(datevec(time)),var_basinaverage_all(:, ii),'mean') ;% change to daily sum       
    end
    var_daily(:, ii) = x;
end 
var_daily(1:365, :) = []; t_daily(1:365, :) = [];% remove first year (spin up year)

[var_nly, t_nly] = RemoveLeapYears(var_daily, t_daily);% remove the leap years 
[VARmean,VARstd,VARrshp_annual] = DailyAverage(var_nly,10, 1,t_nly); % compile daily mean, std and 15 years tables
time = t_nly(1:365);

output_name = {strcat(name, 'mean');strcat(name, 'std'); strcat(name, 'rshp_annual')}  

assignin('base', output_name{1}, VARmean);
assignin('base', output_name{2}, VARstd);
assignin('base', output_name{3}, VARrshp_annual);

savestr = strcat('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\', name, 'processes.mat')
save (savestr, output_name{1}, output_name{2}, output_name{3}, 'varname_basinaverage_all')
clear var_daily var_nly varname varname_basinaverage var_basinaverage x

end 

