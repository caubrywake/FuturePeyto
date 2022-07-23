
%% C2d - mass balance per hru type for period
%% Mass fluxes per HRU cover type
% For current and PGW period
addpath('D:\5_FuturePeyto')
clear all
close all

savedir = 'D:\5_FuturePeyto\dataproc\modeloutput\'
figdir = 'D:\5_FuturePeyto\fig\C2d\'

%% Import CRHM results CUR
load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat', 'SWECUR', 'SWEmeltCUR', 'cumSWE_inCUR', 'cumSWE_outCUR', 'firnmeltCUR', 'hru_actetCUR', 'hru_driftCUR', 'hru_rainCUR', 'hru_snowCUR', 'hru_sublCUR', 'icemeltCUR', 'meltrunoffCUR', 'runoffCUR',  'timeCUR')
% hru_elev = hruelev;
hru_area = hruarea;
hru_elev = [2949 2802 2701 2654 2560 2449 2250 2216 2187 2141 2956 2799 2660 2552 2460 2405 2260 2705 2545 2445 2208 2741 2501 2554 2264 2204 2771 2502 2273 2702 2533 2375 2393 2413 2482 2727 2847];
snow = hru_snowCUR; 
rain = hru_rainCUR;
precip = snow+rain;

SWEin = cumSWE_inCUR;
SWEout= cumSWE_outCUR;
ET = hru_actetCUR;
swemelt = SWEmeltCUR;
icemelt =icemeltCUR;
firnmelt = firnmeltCUR;
drift = hru_driftCUR;
subl = hru_sublCUR;
rainfallrunoff = (runoffCUR(:, 38:end)) -icemeltCUR/24  -firnmeltCUR/24;
rainfallrunoff(rainfallrunoff<0)=0;
timeCRHM = timeCUR;

%% Water balance variable, for year a:b
Cliff_SteepTalus = [24,30, 36, 37, 35, 22, 27];
LowTalus_Moraine = [28,23, 31,32, 10,26]
HighIce = [1,2,3,11,12,18];
MidIce = [4,5,6,13,14,15,16,19,20,34];
LowIce = [7,8,9];
Debris = [33,17,21,];
IceCored = [25, 29];
All = [1:37];
% glacier hru elev
hru_elev(HighIce)
hru_elev(MidIce)
hru_elev(LowIce)

    y1 = 2000;
    y2 = 2014;
       
    
[Cl] = mean(VarTimeAverage3 (y1, y2, timeCRHM, Cliff_SteepTalus, hru_area, SWEin, SWEout, drift-subl, snow,rain,  -rainfallrunoff, -ET,  -swemelt/24,-icemelt/24, -firnmelt/24));
[LT] = mean(VarTimeAverage3 (y1, y2, timeCRHM, LowTalus_Moraine,hru_area, SWEin, SWEout,drift -subl,snow,rain,  -rainfallrunoff, -ET,  -swemelt/24,-icemelt/24, -firnmelt/24));
[HI] = mean(VarTimeAverage3 (y1, y2, timeCRHM, HighIce, hru_area, SWEin, SWEout, drift-subl,  snow,rain, -rainfallrunoff, -ET,  -swemelt/24,-icemelt/24, -firnmelt/24));
[MI] = mean(VarTimeAverage3 (y1, y2, timeCRHM, MidIce,hru_area, SWEin, SWEout,drift-subl,snow,rain,  -rainfallrunoff, -ET,  -swemelt/24,-icemelt/24, -firnmelt/24));
[LI] = mean(VarTimeAverage3(y1, y2,timeCRHM, LowIce,hru_area, SWEin, SWEout,drift-subl, snow,rain,  -rainfallrunoff,-ET,   -swemelt/24,-icemelt/24, -firnmelt/24));
[De] = mean(VarTimeAverage3 (y1, y2, timeCRHM, Debris,hru_area, SWEin, SWEout, drift-subl,  snow,rain,  -rainfallrunoff, -ET,  -swemelt/24,-icemelt/24, -firnmelt/24));
[Ic] = mean(VarTimeAverage3(y1, y2,timeCRHM, IceCored,hru_area, SWEin, SWEout,drift-subl, snow,rain,  -rainfallrunoff,-ET,   -swemelt/24,-icemelt/24, -firnmelt/24));
[Ba] =  mean(VarTimeAverage3(y1, y2,timeCRHM, All,hru_area, SWEin, SWEout,drift-subl, snow,rain,  -rainfallrunoff,-ET,   -swemelt/24,-icemelt/24, -firnmelt/24));
HRUwhole = [Cl; LT; HI;MI;LI;De; Ic; Ba] %7 hru, 9 fkuxes

%% Figure2
% COLOR PALETTE
cavy = [102 170 255]/255%pale blue
csnow= [0 102 204]/255%  mid blue
crain = [0 51 102]/255% dark blue
crunoff = [0 153 153]/255 % light green
cdrift = [0 102 102]/255% dark green
cET = [0 204 204]/255 % black
csnowm = [200 200 200]/255% light grey
cicem =  [140 140 140]/255% mid grey 
cfirnm = [90 90 90]/255% dark grey

cmap = [cavy;cdrift;csnow;crain; crunoff;cET;csnowm;cicem;cfirnm];

% avy; snow; rain; snowmele,t; icemelt; firnmelt; runoff; subl
X = HRUwhole;
Xneg = X;
Xneg(Xneg>0) = 0
Xnegpercent = round((-Xneg./nansum(Xneg,2))*100)
Xpos = X;
Xpos(Xpos<0) = 0;
Xpospercent = round((Xpos./nansum(Xpos,2))*100)
alldata = (Xpospercent+Xnegpercent)
alldata = alldata(:,[3,4,1,2,5,6,7,8,9]) % table in mansucript!

% percentage
% rowname = {'Cliff';'Talus_Moraine';'High Ice';'Mid Ice';'Low Ice';'Debris'; 'Ice Cored'} ;
% colname = {'hrutype', 'snowfall','rainfall','avalanche', 'Drift_subl','rainfallrunoff', 'ET','snowmelt','icemelt','firnmelt'}
% 
% MassFluxes_perRegion_ratios_CUR = table(rowname, alldata(:, 1), alldata(:, 2), alldata(:, 3), alldata(:, 4)...
%     , alldata(:, 5), alldata(:, 6), alldata(:, 7), alldata(:, 8), alldata(:, 9));
% 
% MassFluxes_perRegion_ratios_CUR.Properties.VariableNames = colname;
% writetable(MassFluxes_perRegion_ratios_CUR, strcat(savedir, 'MassFluxes_perRegion_ratios_CUR.txt'))
% save(strcat(savedir, 'MassFluxes_perRegion_ratios_CUR.mat'), 'MassFluxes_perRegion_ratios_CUR'); 

%% ACTUAL FIGURE
fig = figure('units','inches','outerposition',[0 0 8 5.5]);

hold on
h = bar(Xpos,'stack')
h = bar(Xneg,'stack')

%hold off
colormap(cmap)
xticks (1:9)
xticklabels ({'Cliff and Steep Talus'; 'Talus and Moraine'; 'High Ice'; 'Mid Ice'; 'Low Ice';  'Debris'; 'Ice-Cored Moraine';'Basin'})
ylabel ('Annua Mass Fluxes (kg m^{-2})')
%title ('Mass Balance, average 1990-2017')
grid on
box on

neworder = [4,3, 1,2,  5, 6, 7,8,9];
labels= {'avalanche',  'drift + subl','snow', 'rain','rainfall runoff + infil','ET',   'snowmelt', 'icemelt', 'firnmelt'};
legend(h(neworder), labels(neworder), 'Location', 'Best', 'Color', [1 1 1]);
ylim ([-5000 3000])

% save fig
filename = 'MassFluxesperHRUtype_CUR'
saveas (gcf,strcat(figdir, filename), 'png')
saveas (gcf,strcat(figdir, filename), 'pdf')
savefig (gcf,strcat(figdir, filename))


%% Table of every number
X = HRUwhole;
Xneg = X;
Xneg(Xneg>0) = 0
Xpos = X;
Xpos(Xpos<0) = 0;
alldata = (Xpos+Xneg);
% 
% alldata = alldata(:,[3,4,1,2,5,6,7,8,9]) % table in mansucript!
% 
% rowname = {'Cliff';'Talus_Moraine';'High Ice';'Mid Ice';'Low Ice';'Debris'; 'Ice Cored'} ;
% colname = {'hrutype', 'snowfall','rainfall','avalanche', 'Drift_subl','rainfallrunoff_infil', 'ET','snowmelt','icemelt','firnmelt'}
% 
% 
% alldata = round(alldata, 2);
% 
% MassFluxes_perRegion_CUR = table(rowname, alldata(:, 1), alldata(:, 2), alldata(:, 3), alldata(:, 4)...
%     , alldata(:, 5), alldata(:, 6), alldata(:, 7), alldata(:, 8), alldata(:, 9));
% 
% MassFluxes_perRegion_CUR.Properties.VariableNames = colname;
% writetable(MassFluxes_perRegion_CUR, strcat(savedir, 'MassFluxes_perRegion_CUR.txt'))
% save(strcat(savedir, 'MassFluxes_perRegion_CUR.mat'), 'MassFluxes_perRegion_CUR'); 
% 
% % glacier area output
% ga_out =  sum(sum(alldata([3:6], [7:9])))
% nonga_out = sum(sum(alldata([1:2,7], [7:9])))
% all_out = sum(sum(alldata(1:7, [7, 8, 9])))
% ga_ratio = ga_out/all_out *100


%% PGW
close all
clear all
load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\hruarea.mat')
load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat', 'SWEPGW', 'SWEmeltPGW', 'cumSWE_inPGW', 'cumSWE_outPGW', 'firnmeltPGW', 'hru_actetPGW', 'hru_driftPGW', 'hru_rainPGW', 'hru_snowPGW', 'hru_sublPGW', 'icemeltPGW', 'meltrunoffPGW', 'runoffPGW',  'timePGW')

savedir = 'D:\5_FuturePeyto\dataproc\modeloutput\'
figdir = 'D:\5_FuturePeyto\fig\C2d\'

% hru_elev = hruelev;
hru_area = hruarea;

snow = hru_snowPGW; 
rain = hru_rainPGW;
precip = snow+rain;

SWEin = cumSWE_inPGW;
SWEout= cumSWE_outPGW;
ET = hru_actetPGW;
swemelt = SWEmeltPGW;
icemelt =icemeltPGW;
firnmelt = firnmeltPGW;
drift = hru_driftPGW;
subl = hru_sublPGW;
rainfallrunoff = (runoffPGW(:, 38:end)) -icemeltPGW/24  -firnmeltPGW/24;
rainfallrunoff(rainfallrunoff<0)=0;
timeCRHM = timePGW;



%% Water balance variable, for year a:b 
Cliff_SteepTalus = [24,30, 36, 37, 35, 22, 27];
LowTalus_Moraine = [28,23, 31,32, 10,26]
HighIce = [1,2,3,11,12,18];
MidIce = [4,5,6,13,14,15,16,19,20,34];
LowIce = [7,8,9];
Debris = [33,17,21,];
IceCored = [25, 29];
All = [1:37];
% Cliff_SteepTalus = [24,30, 36, 37, 35, 22, 27];
% LowTalus_Moraine = [28,23, 31,32, 10,26]
% HighIce = [1,2,3,11,12,18];
% MidIce = [4,5,6,13,14,15,16,19,20,34];
% LowIce = [7,8,9];
% Debris = [33,17,21,];
% IceCored = [25, 29];
% hru_aspect = [40 344 3 352 27 350 350 289 307 67 60 40 75 72 15 40  84 121 111 118 326 287 278 184 180 103 118 145 250 256 305 7  33 80 70 4]
% hru_slope = [19 11 15.36 8.906 9.931 9.247 8.442 14.14 16 21 16.47 13.03 12.29 14.27 15.71 9.868  23 15 11.95 24.21 47.04 30.21 20.04 28.79 17.92 45.31 22.48 17.3 29.4 14.5 32.42 10.4 10.37 34.07 28.3 37.02 ]

% ElevGr = [mean(hru_elev(Cliff)) mean(hru_elev(Talus)) mean(hru_elev(HighIce)) ...
%     mean(hru_elev(MidIce)) mean(hru_elev(LowIce)) mean(hru_elev(Debris))];
% AreaGr = [sum(hru_area(Cliff)) sum(hru_area(Talus))...
%     sum(hru_area(HighIce)) sum(hru_area(MidIce)) sum(hru_area(LowIce)) sum(hru_area(Debris))]/sum(hru_area) *100;
% AspectGR = [ mean(hru_aspect(Cliff)) mean(hru_aspect(LowTalus)) mean(hru_aspect(Moraine))...
%     mean(hru_aspect(HighIce)) mean(hru_aspect(MidIce)) mean(hru_aspect(LowIce)) mean(hru_aspect(Debris))];
% SlopeGR = [ mean(hru_slope(Cliff)) mean(hru_slope(LowTalus)) ...
%     mean(hru_slope(HighIce)) mean(hru_slope(MidIce)) mean(hru_slope(LowIce)) mean(hru_slope(Debris))]; 
    
    
    y1 = 2084;
    y2 = 2098;
[Cl] = mean(VarTimeAverage3 (y1, y2, timeCRHM, Cliff_SteepTalus, hru_area, SWEin, SWEout, drift-subl, snow,rain,  -rainfallrunoff, -ET,  -swemelt/24,-icemelt/24, -firnmelt/24));
[LT] = mean(VarTimeAverage3 (y1, y2, timeCRHM, LowTalus_Moraine,hru_area, SWEin, SWEout,drift -subl,snow,rain,  -rainfallrunoff, -ET,  -swemelt/24,-icemelt/24, -firnmelt/24));
[HI] = mean(VarTimeAverage3 (y1, y2, timeCRHM, HighIce, hru_area, SWEin, SWEout, drift-subl,  snow,rain, -rainfallrunoff, -ET,  -swemelt/24,-icemelt/24, -firnmelt/24));
[MI] = mean(VarTimeAverage3 (y1, y2, timeCRHM, MidIce,hru_area, SWEin, SWEout,drift-subl,snow,rain,  -rainfallrunoff, -ET,  -swemelt/24,-icemelt/24, -firnmelt/24));
[LI] = mean(VarTimeAverage3(y1, y2,timeCRHM, LowIce,hru_area, SWEin, SWEout,drift-subl, snow,rain,  -rainfallrunoff,-ET,   -swemelt/24,-icemelt/24, -firnmelt/24));
[De] = mean(VarTimeAverage3 (y1, y2, timeCRHM, Debris,hru_area, SWEin, SWEout, drift-subl,  snow,rain,  -rainfallrunoff, -ET,  -swemelt/24,-icemelt/24, -firnmelt/24));
[Ic] = mean(VarTimeAverage3(y1, y2,timeCRHM, IceCored,hru_area, SWEin, SWEout,drift-subl, snow,rain,  -rainfallrunoff,-ET,   -swemelt/24,-icemelt/24, -firnmelt/24));
[Ba] =  mean(VarTimeAverage3(y1, y2,timeCRHM, All,hru_area, SWEin, SWEout,drift-subl, snow,rain,  -rainfallrunoff,-ET,   -swemelt/24,-icemelt/24, -firnmelt/24));
HRUwhole = [Cl; LT; HI;MI;LI;De; Ic; Ba] %7 hru, 9 fkuxes


%% Figure2
% COLOR PALETTE
cavy = [102 170 255]/255%pale blue
csnow= [0 102 204]/255%  mid blue
crain = [0 51 102]/255% dark blue
crunoff = [0 153 153]/255 % light green
cdrift = [0 102 102]/255% dark green
cET = [0 204 204]/255 % black
csnowm = [200 200 200]/255% light grey
cicem =  [140 140 140]/255% mid grey 
cfirnm = [90 90 90]/255% dark grey

cmap = [cavy;cdrift;csnow;crain; crunoff;cET;csnowm;cicem;cfirnm];

% avy; snow; rain; snowmele,t; icemelt; firnmelt; runoff; subl
X = HRUwhole;
Xneg = X;
Xneg(Xneg>0) = 0
Xnegpercent = round((-Xneg./nansum(Xneg,2))*100)
Xpos = X;
Xpos(Xpos<0) = 0;
Xpospercent = round((Xpos./nansum(Xpos,2))*100)
alldata = (Xpospercent+Xnegpercent)
alldata = alldata(:,[3,4,1,2,5,6,7,8,9]) % table in mansucript!

% percentage
% rowname = {'Cliff';'Talus_Moraine';'High Ice';'Mid Ice';'Low Ice';'Debris'; 'Ice Cored'} ;
% colname = {'hrutype', 'snowfall','rainfall','avalanche', 'Drift_subl','rainfallrunoff', 'ET','snowmelt','icemelt','firnmelt'}
% 
% MassFluxes_perRegion_ratios_PGW = table(rowname, alldata(:, 1), alldata(:, 2), alldata(:, 3), alldata(:, 4)...
%     , alldata(:, 5), alldata(:, 6), alldata(:, 7), alldata(:, 8), alldata(:, 9));
% 
% MassFluxes_perRegion_ratios_PGW.Properties.VariableNames = colname;
% writetable(MassFluxes_perRegion_ratios_PGW, strcat(savedir, 'MassFluxes_perRegion_ratios_PGW.txt'))
% save(strcat(savedir, 'MassFluxes_perRegion_ratios_PGW.mat'), 'MassFluxes_perRegion_ratios_PGW'); 

%% ACTUAL FIGURE
fig = figure('units','inches','outerposition',[0 0 8 5.5]);

hold on
h = bar(Xpos,'stack')
h = bar(Xneg,'stack')

%hold off
colormap(cmap)
xticks (1:9)
xticklabels ({'Cliff and Steep Talus'; 'Talus and Moraine'; 'High Ice'; 'Mid Ice'; 'Low Ice';  'Debris'; 'Ice-Cored Moraine';'basin'})
ylabel ('Mass Flux (mm w.e.)')
%title ('Mass Balance, average 1990-2017')
grid on
box on

neworder = [4,3, 1,2,  5, 6, 7,8,9];
labels= {'avalanche',  'drift + subl','snow', 'rain','rainfall runoff + infil','ET',   'snowmelt', 'icemelt', 'firnmelt'};
legend(h(neworder), labels(neworder), 'Location', 'Best', 'Color', [1 1 1]);
ylim ([-5000 3000])

% save fig
filename = 'MassFluxesperHRUtype_PGW'
saveas (gcf,strcat(figdir, filename), 'png')
saveas (gcf,strcat(figdir, filename), 'pdf')
savefig (gcf,strcat(figdir, filename))


%% Table of every number
X = HRUwhole;
Xneg = X;
Xneg(Xneg>0) = 0
Xpos = X;
Xpos(Xpos<0) = 0;
alldata = (Xpos+Xneg)/(sum(hru_area)*10^6)*1000

alldata = alldata(:,[3,4,1,2,5,6,7,8,9]) % table in mansucript!
% 
% rowname = {'Cliff';'Talus_Moraine';'High Ice';'Mid Ice';'Low Ice';'Debris'; 'Ice Cored'} ;
% colname = {'hrutype', 'snowfall','rainfall','avalanche', 'Drift_subl','rainfallrunoff_infil', 'ET','snowmelt','icemelt','firnmelt'}
% 
% 
% alldata = round(alldata, 2);
% 
% MassFluxes_perRegion_PGW = table(rowname, alldata(:, 1), alldata(:, 2), alldata(:, 3), alldata(:, 4)...
%     , alldata(:, 5), alldata(:, 6), alldata(:, 7), alldata(:, 8), alldata(:, 9));
% 
% MassFluxes_perRegion_PGW.Properties.VariableNames = colname;
% writetable(MassFluxes_perRegion_PGW, strcat(savedir, 'MassFluxes_perRegion_PGW.txt'))
% save(strcat(savedir, 'MassFluxes_perRegion_PGW.mat'), 'MassFluxes_perRegion_PGW'); 
% 
% % glacier area output
% ga_out =  sum(sum(alldata([3:6], [7:9])))
% nonga_out = sum(sum(alldata([1:2,7], [7:9])))
% all_out = sum(sum(alldata(1:7, [7, 8, 9])))
% ga_ratio = ga_out/all_out *100