%% C2a - Comparing basin fluxes CRU and PGW
clear all
close all
% Load variables
% load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat', 'SWECUR', 'basinflowCUR', 'firnmeltCUR', 'icemeltCUR', 'hru_rainCUR', 'runoffCUR', 'infilCUR', 'hru_snowCUR', 'SWEmeltCUR', 'hru_tCUR', 'timeCUR')
% load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoPGW_ref.mat', 'SWEPGW', 'basinflowPGW', 'firnmeltPGW', 'icemeltPGW', 'hru_rainPGW', 'runoffPGW', 'infilPGW', 'hru_snowPGW', 'SWEmeltPGW', 'hru_tPGW', 'timePGW')

hruelevCUR = [2949, 2802, 2701, 2654, 2560,2449,2250,2216,2187,2141,2956,2799,...
    2660,2552,2460,2405,2260,2705,2545,2445,2208,2741,2501,2554,2264,2204,2771,...
    2502,2273,2702,2533,2375,2393,2413,2482,2727,2847];
hruelevPGW= [2927,2744,2579,2573,2484,2338,2141,2130,2149,2141,2942,2751,2604,...
    2492,2392,2349,2184,2678,2509,2442,2125,2741,2500,2554,2263,2203,2770,2502,...
    2272,2702,2533,2375,2287,2320,2477,2727,2843];
hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 
% % % Correcting rainfall runoff
% rainfallrunoffCUR = (runoffCUR + infilCUR) -icemeltCUR/24  -firnmeltCUR/24;
% rainfallrunoffCUR(rainfallrunoffCUR<0) = 0;
% rainfallrunofffPGW = (runoffPGW + infilPGW) -icemeltPGW/24  -firnmeltPGW/24;
% rainfallrunoffPGW(rainfallrunoffPGW<0) = 0;

 hru = 1:37;
 
 %% Air Temp 
 load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat','hru_tCUR', 'timeCUR')
 load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat','hru_tPGW', 'timePGW')

 varCUR  = hru_tCUR; 
 varPGW = hru_tPGW;
 yrCUR = 2001:2015;
 yrPGW = 2083:2099;
   % need to weight temperature per hru area
%    a = datevec(timeCUR);
%    a(:, 1) = a(:, 1);
%    timeCUR =datetime(a);
 for i = 1:length(yrCUR)
t1 = strcat ('01-Oct-', num2str(yrCUR(i)-1), {' '}, '1:00:00');  a = find(timeCUR==datetime(t1));
t2 = strcat ('30-Sep-', num2str(yrCUR(i)), {' '}, '23:00:00');
if i == 15
    t2 = ('26-Sep-2015 00:00:00');
end
b = find(timeCUR==datetime(t2));
varCURyr  = varCUR(a:b, :).*(hruarea/sum(hruarea)); %m w.e per hru
varCURmean = sum(varCURyr, 2); % m3 w.e. 
T = timetable (timeCUR(a:b), varCURmean); TT = retime(T, 'daily', 'mean');
varCURdaily = table2array(TT); tdaily = TT.Time;

varPGWyr  = varPGW(a:b, :).*(hruarea/sum(hruarea)); %m w.e per hru
varPGWmean = sum(varPGWyr, 2); % m3 w.e. 
T = timetable (timeCUR(a:b), varPGWmean); TT = retime(T, 'daily', 'mean');
varPGWdaily = table2array(TT); 

if length(varCURdaily) == 366 % rmeove leap years
    varCURdaily= [varCURdaily(1:151); varCURdaily(153:end)]; %remove Feb 29
    varPGWdaily= [varPGWdaily(1:151); varPGWdaily(153:end)]; %remove Feb 29
end 

if i == 15 % padding last year so it finsihes on Sep 30
    varCURdaily= [varCURdaily; nan(4,1)]; tdaily = [tdaily; (tdaily(end)+days(1):tdaily(end)+days(4))'];
    varPGWdaily= [varPGWdaily; nan(4,1)];
end 
varCURdaily_allyr(:, i) = varCURdaily; 
varPGWdaily_allyr(:, i) = varPGWdaily; 
 end 
 
Ta_CUR = varCURdaily_allyr;
Ta_PGW = varPGWdaily_allyr;
fig = figure('units','inches','position',[0 0 7 3]); 
p1 = plot(tdaily, Ta_CUR, 'Color', [51 153 255]./255); hold on;
p2 = plot(tdaily, Ta_PGW, 'Color', [255 102 102]./255);
p3 = plot(tdaily, nanmean(Ta_CUR,2), 'Color', [0 0 153]./255, 'linewidth', 2); hold on;
p4 = plot(tdaily, nanmean(Ta_PGW,2), 'Color', [153 0 0]./255,  'linewidth', 2);
legend ([p1(1), p2(1), p3(1), p4(1)], 'ind. year CUR', 'ind y, PGW', '15 yr mean, CUR', '15 yr mean, PGW', 'Location', 'SouthEast')
title ('Air Temperature, daily averages')
ylabel('\circ C')
xtickformat ('dd-MMM')
figname ='Ta_15YearMean';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\C2a\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\C2a\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\C2a\', figname))
save ('D:\FuturePeyto\dataproc\modeloutput\Ta_Basin_CUR_PGW.mat', 'Ta_CUR', 'Ta_PGW') ;

%% Compare hot and cold years
meanTa = nanmean(Ta_CUR)'
figure
plot(tdaily, Ta_CUR(:, [3,6,15]), 'r'); hold on
plot(tdaily, Ta_CUR(:, [2,8,11]), 'b'); 

%% Rainfall
close all 
clear all
 load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat','hru_rainCUR', 'timeCUR')
 load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat','hru_rainPGW', 'timePGW')
hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 

 varCUR  = hru_rainCUR; 
 varPGW = hru_rainPGW;
 yrCUR = 2001:2015;
 yrPGW = 2087:2099;
   % need to weight temperature per hru area
  hru = 1:37; 
 for i = 1:length(yrCUR)
t1 = strcat ('01-Oct-', num2str(yrCUR(i)-1), {' '}, '1:00:00');  a = find(timeCUR==datetime(t1));
t2 = strcat ('30-Sep-', num2str(yrCUR(i)), {' '}, '1:00:00');
if i == 15
    t2 = ('26-Sep-2015 00:00:00');
end
b = find(timeCUR==datetime(t2));
varCURyr  = varCUR(a:b, hru)./1000; %m w.e per hru
varCURhru = varCURyr.*(hruarea(hru)./(sum(hruarea(hru))));% snow per hru in m3
varCURmean= sum(varCURhru, 2)* 1000;  % mm. 
T = timetable (timeCUR(a:b), varCURmean); TT = retime(T, 'monthly', 'sum');
varCURdaily = table2array(TT); tmonthly = TT.Time;

varPGWyr  = varPGW(a:b, hru)./1000; %
varPGWhru = varPGWyr.*(hruarea(hru)./(sum(hruarea(hru))));%
varPGWmean= sum(varPGWhru, 2)*1000; % 
T = timetable (timeCUR(a:b), varPGWmean); TT = retime(T, 'monthly', 'sum');
varPGWdaily = table2array(TT); 

% if length(varCURdaily) == 366 % rmeove leap years
%     varCURdaily= [varCURdaily(1:59); varCURdaily(61:end)]; %remove Feb 29
%     varPGWdaily= [varPGWdaily(1:59); varPGWdaily(61:end)]; %remove Feb 29
% end 
% 
% if i == 15 % padding last year so it finsihes on Sep 30
%     varCURdaily= [varCURdaily; nan(4,1)]; tdaily = [tdaily; (tdaily(end)+days(1):tdaily(end)+days(4))'];
%     varPGWdaily= [varPGWdaily; nan(4,1)];
% end 
varCURdaily_allyr(:, i) = varCURdaily; 
varPGWdaily_allyr(:, i) = varPGWdaily; 
 end 
 
Rain_CUR = varCURdaily_allyr;
Rain_PGW = varPGWdaily_allyr;

fig = figure('units','inches','position',[0 0 7 3]); 
p1 = bar(tmonthly, [nanmean(Rain_CUR,2),nanmean(Rain_PGW,2)]); hold on;
legend ( '15 yr mean, CUR', '15 yr mean, PGW', 'Location', 'Northwest')
title ('Rainfall, Monthly sum')
ylabel('mm')
xtickformat ('dd-MMM')
figname ='Rain_15YearMean_BarPlot';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\C2a\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\C2a\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\C2a\', figname))

fig = figure('units','inches','position',[0 0 7 3]); 
p1 = plot(tmonthly, Rain_CUR, 'Color', [51 153 255]./255); hold on;
p2 = plot(tmonthly, Rain_PGW, 'Color', [255 102 102]./255);
p3 = plot(tmonthly, nanmean(Rain_CUR,2), 'Color', [0 0 153]./255, 'linewidth', 2); hold on;
p4 = plot(tmonthly, nanmean(Rain_PGW,2), 'Color', [153 0 0]./255,  'linewidth', 2);
legend ([p1(1), p2(1), p3(1), p4(1)], 'ind. year CUR', 'ind y, PGW', '15 yr mean, CUR', '15 yr mean, PGW', 'Location', 'Northwest')
title ('Rainfall, Monthly sum')
ylabel('mm')
xtickformat ('dd-MMM')
figname ='Rain_15YearMean';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\C2a\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\C2a\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\C2a\', figname))
save ('D:\FuturePeyto\dataproc\modeloutput\Rainfall_Basin_CUR_PGW.mat', 'Rain_CUR', 'Rain_PGW') ;

%% Snowfall
close all 
clear all
 load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat','hru_snowCUR', 'timeCUR')
 load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat','hru_snowPGW', 'timePGW')
hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 

 varCUR  = hru_snowCUR; 
 varPGW = hru_snowPGW;
 yrCUR = 2001:2015;
 yrPGW = 2087:2099;
   % need to weight temperature per hru area
  hru = 1:37; 
 for i = 1:length(yrCUR)
t1 = strcat ('01-Oct-', num2str(yrCUR(i)-1), {' '}, '1:00:00');  a = find(timeCUR==datetime(t1));
t2 = strcat ('30-Sep-', num2str(yrCUR(i)), {' '}, '1:00:00');
if i == 15
    t2 = ('26-Sep-2015 00:00:00');
end
b = find(timeCUR==datetime(t2));
varCURyr  = varCUR(a:b, hru)./1000; %m w.e per hru
varCURhru = varCURyr.*(hruarea(hru)./(sum(hruarea(hru))));% snow per hru in m3
varCURmean= sum(varCURhru, 2)* 1000;  % mm. 
T = timetable (timeCUR(a:b), varCURmean); TT = retime(T, 'monthly', 'sum');
varCURdaily = table2array(TT); tmonthly = TT.Time;

varPGWyr  = varPGW(a:b, hru)./1000; %
varPGWhru = varPGWyr.*(hruarea(hru)./(sum(hruarea(hru))));%
varPGWmean= sum(varPGWhru, 2)*1000; % 
T = timetable (timeCUR(a:b), varPGWmean); TT = retime(T, 'monthly', 'sum');
varPGWdaily = table2array(TT); 

% if length(varCURdaily) == 366 % rmeove leap years
%     varCURdaily= [varCURdaily(1:59); varCURdaily(61:end)]; %remove Feb 29
%     varPGWdaily= [varPGWdaily(1:59); varPGWdaily(61:end)]; %remove Feb 29
% end 
% 
% if i == 15 % padding last year so it finsihes on Sep 30
%     varCURdaily= [varCURdaily; nan(4,1)]; tdaily = [tdaily; (tdaily(end)+days(1):tdaily(end)+days(4))'];
%     varPGWdaily= [varPGWdaily; nan(4,1)];
% end 
varCURdaily_allyr(:, i) = varCURdaily; 
varPGWdaily_allyr(:, i) = varPGWdaily; 
 end 
 
Snow_CUR = varCURdaily_allyr;
Snow_PGW = varPGWdaily_allyr;

fig = figure('units','inches','position',[0 0 7 3]); 
p1 = bar(tmonthly, [nanmean(Snow_CUR,2),nanmean(Snow_PGW,2)]); hold on;
legend ( '15 yr mean, CUR', '15 yr mean, PGW', 'Location', 'Northeast')
title ('Snowfall, Monthly sum')
ylabel('mm')
xtickformat ('dd-MMM')
figname ='Snow_15YearMean_BarPlot';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\C2a\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\C2a\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\C2a\', figname))

fig = figure('units','inches','position',[0 0 7 3]); 
p1 = plot(tmonthly, Snow_CUR, 'Color', [51 153 255]./255); hold on;
p2 = plot(tmonthly, Snow_PGW, 'Color', [255 102 102]./255);
p3 = plot(tmonthly, nanmean(Snow_CUR,2), 'Color', [0 0 153]./255, 'linewidth', 2); hold on;
p4 = plot(tmonthly, nanmean(Snow_PGW,2), 'Color', [153 0 0]./255,  'linewidth', 2);
legend ([p1(1), p2(1), p3(1), p4(1)], 'ind. year CUR', 'ind y, PGW', '15 yr mean, CUR', '15 yr mean, PGW', 'Location', 'Northeast')
title ('Snowfall, Monthly sum')
ylabel('mm')
xtickformat ('dd-MMM')
figname ='Snow_15YearMean';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\C2a\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\C2a\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\C2a\', figname))
save ('D:\FuturePeyto\dataproc\modeloutput\Snowfall_Basin_CUR_PGW.mat', 'Snow_CUR', 'Snow_PGW') ;
%% SWE
close all
clear all
 load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat','SWECUR', 'timeCUR')
 load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat','SWEPGW', 'timePGW')
hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 

 varCUR  = SWECUR; 
 varPGW = SWEPGW;
 yrCUR = 2001:2015;
 yrPGW = 2087:2099;
hru = 1:37;
 for i = 1:length(yrCUR)
t1 = strcat ('01-Oct-', num2str(yrCUR(i)-1), {' '}, '1:00:00');  a = find(timeCUR==datetime(t1));
t2 = strcat ('30-Sep-', num2str(yrCUR(i)), {' '}, '1:00:00');
if i == 15
    t2 = ('26-Sep-2015 00:00:00');
end
b = find(timeCUR==datetime(t2));
varCURyr  = varCUR(a:b, hru)./1000; %m w.e per hru
varCURhru = varCURyr.*(hruarea(hru)./(sum(hruarea(hru))));% snow per hru in m3
varCURmean= sum(varCURhru, 2)* 1000;  % mm. 
T = timetable (timeCUR(a:b), varCURmean); TT = retime(T, 'daily', 'mean');
varCURdaily = table2array(TT); tdaily = TT.Time;

varPGWyr  = varPGW(a:b, hru)./1000; %
varPGWhru = varPGWyr.*(hruarea(hru)./(sum(hruarea(hru))));%
varPGWmean= sum(varPGWhru, 2)*1000; % 
T = timetable (timeCUR(a:b), varPGWmean); TT = retime(T, 'daily', 'mean');
varPGWdaily = table2array(TT); 

if length(varCURdaily) == 366 % rmeove leap years
    varCURdaily= [varCURdaily(1:59); varCURdaily(61:end)]; %remove Feb 29
    varPGWdaily= [varPGWdaily(1:59); varPGWdaily(61:end)]; %remove Feb 29
end 

if i == 15 % padding last year so it finsihes on Sep 30
    varCURdaily= [varCURdaily; nan(4,1)]; tdaily = [tdaily; (tdaily(end)+days(1):tdaily(end)+days(4))'];
    varPGWdaily= [varPGWdaily; nan(4,1)];
end 
varCURdaily_allyr(:, i) = varCURdaily; 
varPGWdaily_allyr(:, i) = varPGWdaily; 
 end 
 
SWE_CUR = varCURdaily_allyr;
SWE_PGW = varPGWdaily_allyr;

fig = figure('units','inches','position',[0 0 7 3]); 
p1 = plot(tdaily, SWE_CUR, 'Color', [51 153 255]./255); hold on;
p2 = plot(tdaily, SWE_PGW, 'Color', [255 102 102]./255);
p3 = plot(tdaily, nanmean(SWE_CUR,2), 'Color', [0 0 153]./255, 'linewidth', 2); hold on;
p4 = plot(tdaily, nanmean(SWE_PGW,2), 'Color', [153 0 0]./255,  'linewidth', 2);
legend ([p1(1), p2(1), p3(1), p4(1)], 'ind. year CUR', 'ind y, PGW', '15 yr mean, CUR', '15 yr mean, PGW', 'Location', 'Northwest')
title ('SWE accumulation')
ylabel('mm')
xtickformat ('dd-MMM')
figname ='SWE_15YearMean';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\C2a\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\C2a\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\C2a\', figname))
save ('D:\FuturePeyto\dataproc\modeloutput\Snowfall_Basin_CUR_PGW.mat', 'SWE_CUR', 'SWE_PGW') ;

%% SWEmelt
 close all 
clear all
 load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat','SWEmeltCUR', 'timeCUR')
 load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat','SWEmeltPGW', 'timePGW')
hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 

 varCUR  = SWEmeltCUR/24; 
 varPGW = SWEmeltPGW/24;
 yrCUR = 2001:2015;
 yrPGW = 2087:2099;
   % need to weight temperature per hru area
  hru = 1:37; 
 for i = 1:length(yrCUR)
t1 = strcat ('01-Oct-', num2str(yrCUR(i)-1), {' '}, '1:00:00');  a = find(timeCUR==datetime(t1));
t2 = strcat ('30-Sep-', num2str(yrCUR(i)), {' '}, '1:00:00');
if i == 15
    t2 = ('26-Sep-2015 00:00:00');
end
b = find(timeCUR==datetime(t2));
varCURyr  = varCUR(a:b, hru)./1000; %m w.e per hru
varCURhru = varCURyr.*(hruarea(hru)./(sum(hruarea(hru))));% snow per hru in m3
varCURmean= sum(varCURhru, 2)* 1000;  % mm. 
T = timetable (timeCUR(a:b), varCURmean); TT = retime(T, 'daily', 'mean');
varCURdaily = table2array(TT); tdaily = TT.Time;

varPGWyr  = varPGW(a:b, hru)./1000; %
varPGWhru = varPGWyr.*(hruarea(hru)./(sum(hruarea(hru))));%
varPGWmean= sum(varPGWhru, 2)*1000; % 
T = timetable (timeCUR(a:b), varPGWmean); TT = retime(T, 'daily', 'mean');
varPGWdaily = table2array(TT); 

if length(varCURdaily) == 366 % rmeove leap years
    varCURdaily= [varCURdaily(1:59); varCURdaily(61:end)]; %remove Feb 29
    varPGWdaily= [varPGWdaily(1:59); varPGWdaily(61:end)]; %remove Feb 29
end 

if i == 15 % padding last year so it finsihes on Sep 30
    varCURdaily= [varCURdaily; nan(4,1)]; tdaily = [tdaily; (tdaily(end)+days(1):tdaily(end)+days(4))'];
    varPGWdaily= [varPGWdaily; nan(4,1)];
end 
varCURdaily_allyr(:, i) = varCURdaily; 
varPGWdaily_allyr(:, i) = varPGWdaily; 
 end 
 
Swemelt_CUR = varCURdaily_allyr;
Swemelt_PGW = varPGWdaily_allyr;

fig = figure('units','inches','position',[0 0 7 3]); 
p1 = plot(tdaily, Swemelt_CUR, 'Color', [51 153 255]./255); hold on;
p2 = plot(tdaily, Swemelt_PGW, 'Color', [255 102 102]./255);
p3 = plot(tdaily, nanmean(Swemelt_CUR,2), 'Color', [0 0 153]./255, 'linewidth', 2); hold on;
p4 = plot(tdaily, nanmean(Swemelt_PGW,2), 'Color', [153 0 0]./255,  'linewidth', 2);
legend ([p1(1), p2(1), p3(1), p4(1)], 'ind. year CUR', 'ind y, PGW', '15 yr mean, CUR', '15 yr mean, PGW', 'Location', 'Northwest')
title ('SWE melt, daily mean')
ylabel('mm')
xtickformat ('dd-MMM')
figname ='Swemelt_15YearMean';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\C2a\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\C2a\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\C2a\', figname))

save ('D:\FuturePeyto\dataproc\modeloutput\SWEmelt_Basin_CUR_PGW.mat', 'Swemelt_CUR', 'Swemelt_PGW') ;
%% Icemelt
 close all 
clear all
 load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat','icemeltCUR', 'timeCUR')
 load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat','icemeltPGW', 'timePGW')
hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 

 varCUR  = icemeltCUR/24; 
 varPGW = icemeltPGW/24;
 yrCUR = 2001:2015;
 yrPGW = 2087:2099;
   % need to weight temperature per hru area
  hru = 1:37; 
 for i = 1:length(yrCUR)
t1 = strcat ('01-Oct-', num2str(yrCUR(i)-1), {' '}, '1:00:00');  a = find(timeCUR==datetime(t1));
t2 = strcat ('30-Sep-', num2str(yrCUR(i)), {' '}, '1:00:00');
if i == 15
    t2 = ('26-Sep-2015 00:00:00');
end
b = find(timeCUR==datetime(t2));
varCURyr  = varCUR(a:b, hru)./1000; %m w.e per hru
varCURhru = varCURyr.*(hruarea(hru)./(sum(hruarea(hru))));% snow per hru in m3
varCURmean= sum(varCURhru, 2)* 1000;  % mm. 
T = timetable (timeCUR(a:b), varCURmean); TT = retime(T, 'daily', 'mean');
varCURdaily = table2array(TT); tdaily = TT.Time;

varPGWyr  = varPGW(a:b, hru)./1000; %
varPGWhru = varPGWyr.*(hruarea(hru)./(sum(hruarea(hru))));%
varPGWmean= sum(varPGWhru, 2)*1000; % 
T = timetable (timeCUR(a:b), varPGWmean); TT = retime(T, 'daily', 'mean');
varPGWdaily = table2array(TT); 

if length(varCURdaily) == 366 % rmeove leap years
    varCURdaily= [varCURdaily(1:59); varCURdaily(61:end)]; %remove Feb 29
    varPGWdaily= [varPGWdaily(1:59); varPGWdaily(61:end)]; %remove Feb 29
end 

if i == 15 % padding last year so it finsihes on Sep 30
    varCURdaily= [varCURdaily; nan(4,1)]; tdaily = [tdaily; (tdaily(end)+days(1):tdaily(end)+days(4))'];
    varPGWdaily= [varPGWdaily; nan(4,1)];
end 
varCURdaily_allyr(:, i) = varCURdaily; 
varPGWdaily_allyr(:, i) = varPGWdaily; 
 end 
 
Icemelt_CUR = varCURdaily_allyr;
Icemelt_PGW = varPGWdaily_allyr;

fig = figure('units','inches','position',[0 0 7 3]); 
p1 = plot(tdaily, Icemelt_CUR, 'Color', [51 153 255]./255); hold on;
p2 = plot(tdaily, Icemelt_PGW, 'Color', [255 102 102]./255);
p3 = plot(tdaily, nanmean(Icemelt_CUR,2), 'Color', [0 0 153]./255, 'linewidth', 2); hold on;
p4 = plot(tdaily, nanmean(Icemelt_PGW,2), 'Color', [153 0 0]./255,  'linewidth', 2);
legend ([p1(1), p2(1), p3(1), p4(1)], 'ind. year CUR', 'ind y, PGW', '15 yr mean, CUR', '15 yr mean, PGW', 'Location', 'Northwest')
title ('Icemelt, daily mean')
ylabel('mm')
xtickformat ('dd-MMM')
figname ='Icemelt_15YearMean';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\C2a\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\C2a\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\C2a\', figname))

save ('D:\FuturePeyto\dataproc\modeloutput\Icemelt_Basin_CUR_PGW.mat', 'Icemelt_CUR', 'Icemelt_PGW') ;
%% Frnmelt
 close all 
clear all
 load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat','firnmeltCUR', 'timeCUR')
 load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat','firnmeltPGW', 'timePGW')
hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 

 varCUR  = firnmeltCUR/24; 
 varPGW = firnmeltPGW/24;
 yrCUR = 2001:2015;
 yrPGW = 2087:2099;
   % need to weight temperature per hru area
  hru = 1:37; 
 for i = 1:length(yrCUR)
t1 = strcat ('01-Oct-', num2str(yrCUR(i)-1), {' '}, '1:00:00');  a = find(timeCUR==datetime(t1));
t2 = strcat ('30-Sep-', num2str(yrCUR(i)), {' '}, '1:00:00');
if i == 15
    t2 = ('26-Sep-2015 00:00:00');
end
b = find(timeCUR==datetime(t2));
varCURyr  = varCUR(a:b, hru)./1000; %m w.e per hru
varCURhru = varCURyr.*(hruarea(hru)./(sum(hruarea(hru))));% snow per hru in m3
varCURmean= sum(varCURhru, 2)* 1000;  % mm. 
T = timetable (timeCUR(a:b), varCURmean); TT = retime(T, 'daily', 'mean');
varCURdaily = table2array(TT); tdaily = TT.Time;

varPGWyr  = varPGW(a:b, hru)./1000; %
varPGWhru = varPGWyr.*(hruarea(hru)./(sum(hruarea(hru))));%
varPGWmean= sum(varPGWhru, 2)*1000; % 
T = timetable (timeCUR(a:b), varPGWmean); TT = retime(T, 'daily', 'mean');
varPGWdaily = table2array(TT); 

if length(varCURdaily) == 366 % rmeove leap years
    varCURdaily= [varCURdaily(1:59); varCURdaily(61:end)]; %remove Feb 29
    varPGWdaily= [varPGWdaily(1:59); varPGWdaily(61:end)]; %remove Feb 29
end 

if i == 15 % padding last year so it finsihes on Sep 30
    varCURdaily= [varCURdaily; nan(4,1)]; tdaily = [tdaily; (tdaily(end)+days(1):tdaily(end)+days(4))'];
    varPGWdaily= [varPGWdaily; nan(4,1)];
end 
varCURdaily_allyr(:, i) = varCURdaily; 
varPGWdaily_allyr(:, i) = varPGWdaily; 
 end 
 
Firnmelt_CUR = varCURdaily_allyr;
Firnmelt_PGW = varPGWdaily_allyr;

fig = figure('units','inches','position',[0 0 7 3]); 
p1 = plot(tdaily, Firnmelt_CUR, 'Color', [51 153 255]./255); hold on;
p2 = plot(tdaily, Firnmelt_PGW, 'Color', [255 102 102]./255);
p3 = plot(tdaily, nanmean(Firnemelt_CUR,2), 'Color', [0 0 153]./255, 'linewidth', 2); hold on;
p4 = plot(tdaily, nanmean(Firnmelt_PGW,2), 'Color', [153 0 0]./255,  'linewidth', 2);
legend ([p1(1), p2(1), p3(1), p4(1)], 'ind. year CUR', 'ind y, PGW', '15 yr mean, CUR', '15 yr mean, PGW', 'Location', 'Northwest')
title ('Firnmelt, daily mean')
ylabel('mm')
xtickformat ('dd-MMM')
figname ='Firnmelt_15YearMean';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\C2a\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\C2a\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\C2a\', figname))

save ('D:\FuturePeyto\dataproc\modeloutput\Firnmelt_Basin_CUR_PGW.mat', 'Firnmelt_CUR', 'Firnmelt_PGW') ;

%% basinflow
 close all 
clear all
 load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat','basinflowCUR', 'timeCUR')
 load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat','basinflowPGW', 'timePGW')
hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 

 varCUR  = basinflowCUR/3600; 
 varPGW = basinflowPGW/3600;
 yrCUR = 2001:2015;
 yrPGW = 2087:2099;
   % need to weight temperature per hru area
  hru = 1; 
 for i = 1:length(yrCUR)
t1 = strcat ('01-Oct-', num2str(yrCUR(i)-1), {' '}, '1:00:00');  a = find(timeCUR==datetime(t1));
t2 = strcat ('30-Sep-', num2str(yrCUR(i)), {' '}, '1:00:00');
if i == 15
    t2 = ('26-Sep-2015 00:00:00');
end
b = find(timeCUR==datetime(t2));
varCURyr  = varCUR(a:b); %m3/s
T = timetable (timeCUR(a:b), varCURyr); TT = retime(T, 'daily', 'mean');
varCURdaily = table2array(TT); tdaily = TT.Time;

varPGWyr  = varPGW(a:b, hru); %
T = timetable (timeCUR(a:b), varPGWyr); TT = retime(T, 'daily', 'mean');
varPGWdaily = table2array(TT); 

if length(varCURdaily) == 366 % rmeove leap years
    varCURdaily= [varCURdaily(1:59); varCURdaily(61:end)]; %remove Feb 29
    varPGWdaily= [varPGWdaily(1:59); varPGWdaily(61:end)]; %remove Feb 29
end 

if i == 15 % padding last year so it finsihes on Sep 30
    varCURdaily= [varCURdaily; nan(4,1)]; tdaily = [tdaily; (tdaily(end)+days(1):tdaily(end)+days(4))'];
    varPGWdaily= [varPGWdaily; nan(4,1)];
end 
varCURdaily_allyr(:, i) = varCURdaily; 
varPGWdaily_allyr(:, i) = varPGWdaily; 
 end 
 
Basinflow_CUR = varCURdaily_allyr;
Basinflow_PGW = varPGWdaily_allyr;

fig = figure('units','inches','position',[0 0 7 3]); 
p1 = plot(tdaily, Basinflow_CUR, 'Color', [51 153 255]./255); hold on;
p2 = plot(tdaily, Basinflow_PGW, 'Color', [255 102 102]./255);
p3 = plot(tdaily, nanmean(Basinflow_CUR,2), 'Color', [0 0 153]./255, 'linewidth', 2); hold on;
p4 = plot(tdaily, nanmean(Basinflow_PGW,2), 'Color', [153 0 0]./255,  'linewidth', 2);
legend ([p1(1), p2(1), p3(1), p4(1)], 'ind. year CUR', 'ind y, PGW', '15 yr mean, CUR', '15 yr mean, PGW', 'Location', 'Northwest')
title ('Firnmelt, daily mean')
ylabel('mm')
xtickformat ('dd-MMM')
figname ='basinflow_15YearMean';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\C2a\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\C2a\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\C2a\', figname))

save ('D:\FuturePeyto\dataproc\modeloutput\Basinflow_Basin_CUR_PGW.mat', 'Basinflow_CUR', 'Basinflow_PGW') ;

 
 %% Figure of that
 close all
crunoff = [30 30 30]/255 % light green
csnowm = [220 220 220]/255% light grey
cicem =  [150 150 150]/255% mid grey 
cfirnm = [100 100 100]/255% dark grey
ccur = [0 0 0]/255 % Blue
cpgw = [240 0 0]/255; % Red


fig = figure('units','inches','outerposition',[0 0 6 6.5]);
subplot (3,1,1)
 plot (Xlm(:, 1), 'Color', ccur, 'Linewidth', 1.5) ;
 hold on ; plot(Xhm(:,1),'Color', cpgw, 'Linewidth', 1.5) 
mean(Xhm(:, 1) - Xlm(:, 1))
ylabel('Ta (^{\circ}C)')
xlim ([0 365])
xticks([15:30.5:365])
xticklabels ('');
% legend ( 'Low', 'High', 'Location', 'SouthEast', 'Orientation', 'Horizontal')
%xticklabels ({'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'})
grid on
box on
set (gca, 'Fontsize', 16);

 subplot(3,1,2)
stackData = cat(3, [CURsnow PGWsnow]*1000,[CURrain PGWrain]*1000);
groupLabels = {'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'};
 plotBarStackGroups(stackData, groupLabels)
xlim ([0.5 12.49])
 ylim ([0 245])
 xticklabels ({''})
 ylabel (' Rain (mm)')
% text (0.7, 130, 'b)')
 grid on
 box on
set (gca, 'Fontsize', 16);

subplot (3,1,3)
 plot (Xlm(:,2)*1000, 'Color',ccur, 'Linewidth', 1.5) ;
 hold on ; plot(Xhm(:,2)*1000,'Color', cpgw, 'Linewidth', 1.5) 
xlim ([0 365])
xticks([15:30.5:365])
xticklabels ({'Oct', '', 'Dec', '', 'Feb', '', 'Apr', '', 'Jun', '', 'Aug', ''})
ylabel ('SWE (mm)')
 yticks([0:250:750])
grid on
box on
set (gca, 'Fontsize', 16);
%legend ('Low','High', 'Location', 'NorthEast')

jointfig(fig, 3,1)
lh = legend ( 'Current', 'PGW', 'Location', 'SouthEast', 'Orientation', 'Horizontal' )
set( lh,  'Color', [1 1 1])

% save fig
tightfig(fig)

filename = 'D:\FuturePeyto\CRHM\Figures\Forcings_Current_PGW'
savefig (filename);
export_fig(filename, '-pdf','-tiff', '-transparent')
saveas (gcf,filename, 'png')
saveas (gcf,filename, 'svg')


%% Curent and Futute with overall streamflow
 % 
 close all

crunoff = [30 30 30]/255 % light green
csnowm = [220 220 220]/255% light grey
cicem =  [150 150 150]/255% mid grey 
cfirnm = [100 100 100]/255% dark grey

ccur = [0 0 0]/255 % Blue
cpgw = [240 0 0]/255; % Red

% COLOR PALETTE
% Current

fig = figure('units','inches','outerposition',[0 0 4 6.5]);
lw = 1.5
 subplot (3,1,1)
plot (Xlm(:, 7)*1000, 'Color', ccur, 'Linewidth', lw); hold on
plot (Xhm(:, 7)*1000, 'Color', cpgw, 'Linewidth', lw);
xticks([15:30.5:365])
xticklabels ({'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'})
xlim ([0 365])
ylim ([0 25])
%lh = legend ( 'Current', 'PGW', 'Location', 'Northwest' )
%set( lh,  'Color', [1 1 1])
ylabel ({'Streamflow';'(mm)'})
grid on; box on
set(gca, 'Fontsize', 16)

 subplot (3,1,2)
h= area([smooth(Xlm(:, 6)*1000,5) smooth(Xlm(:, 5)*1000,5) smooth(Xlm(:, 4)*1000,5) smooth(Xlm(:, 3)*1000, 5)])
set(h(1),'facecolor', crunoff)
set(h(3),'facecolor', cicem)
set(h(2),'facecolor', cfirnm)
set(h(4),'facecolor', csnowm)
xlim ([0 365])
ylim ([0 25])
xticks([15:30.5:365])
xticklabels ({'Oct', '', 'Dec', '', 'Feb', '', 'Apr', '', 'Jun', '', 'Aug', ''})
ylabel ('Current (mm)')
grid on; box on
set(gca, 'Fontsize', 16)

subplot (3,1,3)
h= area([smooth(Xhm(:, 6)*1000,5) smooth(Xhm(:, 5)*1000,5) smooth(Xhm(:, 4)*1000,5) smooth(Xhm(:, 3)*1000, 5)])
set(h(1),'facecolor', crunoff)
set(h(3),'facecolor', cicem)
set(h(2),'facecolor', cfirnm)
set(h(4),'facecolor', csnowm)
xlim ([0 365])
ylim ([0 25])
xticks([15:30.5:365])
xticklabels ({'Oct', '', 'Dec', '', 'Feb', '', 'Apr', '', 'Jun', '', 'Aug', ''})
ylabel ('PGW (mm)')
grid on; box on
set(gca, 'Fontsize', 16)

jointfig(fig,3,1)
neworder = [4 3 2 1];
labels= {'Rainfall Runoff','Firnmelt', 'Icemelt','Snowmelt'};
legend(h(neworder), labels(neworder), 'Location', 'northwest', 'Color', [1 1 1], 'Orientation', 'Vertical', 'Fontsize', 14);

%
% save fig
tightfig(fig)
filename = 'D:\FuturePeyto\CRHM\Figures\FlowComponent_Streamflow_Current_PGW'
savefig (filename);
export_fig(filename, '-pdf','-tiff', '-transparent')
saveas (gcf,filename, 'png')
saveas (gcf,filename, 'svg')

%% Gwt the number for these;
IncreaseinComponent(1, :) = [sum(Xlm(:, 3)) sum(Xhm(:, 3)) sum(Xhm(:, 3))*100/sum(Xlm(:, 3))-100];
IncreaseinComponent(2, :) = [sum(Xlm(:, 4)) sum(Xhm(:, 4)) sum(Xhm(:, 4))*100/sum(Xlm(:, 4))-100];
IncreaseinComponent(3, :) = [sum(Xlm(:, 5)) sum(Xhm(:, 5)) sum(Xhm(:, 5))*100/sum(Xlm(:, 5))-100]
IncreaseinComponent(4, :) = [sum(Xlm(:, 6)) sum(Xhm(:, 6)) sum(Xhm(:, 6))*100/sum(Xlm(:, 6))-100]
IncreaseinComponent(5, :) = [sum(Xlm(:, 7)) sum(Xhm(:, 7)) sum(Xhm(:, 7))*100/sum(Xlm(:, 7))-100]
IncreaseinComponent(6, :) = [mean(Xlm(:, 1)) mean(Xhm(:, 1)) mean(Xhm(:, 1))-mean(Xlm(:, 1))]

% for precip (Cur, pgw, % increase)
IncreaseinRain= [sum(Xhprecip(:, 1)) sum(Xlprecip(:, 1)) sum(Xhprecip(:, 1))*100/sum(Xlprecip(:, 1))]
IncreaseinSnow = [sum(Xhprecip(:,2)) sum(Xlprecip(:, 2)) sum(Xhprecip(:, 2))*100/sum(Xlprecip(:, 2))]

% Snow/rain ratio
SumCurPrecip = sum(Xlprecip(:, 1)) + sum(Xlprecip(:, 2))
SumPGWPrecip = sum(Xhprecip(:, 1)) + sum(Xhprecip(:, 2))
ChangeinPrecip = SumPGWPrecip/SumCurPrecip
Cur_totalrain = sum(Xlprecip(:, 1))*1000
Cur_totalsnow = sum(Xlprecip(:, 2))*1000
PGW_totalrain = sum(Xhprecip(:, 1))*1000
PGW_totalsnow = sum(Xhprecip(:, 2))*1000

CurSnowRatio = Cur_totalrain/(Cur_totalsnow+ Cur_totalrain)
PGWCurRatio =PGW_totalrain/(PGW_totalsnow+PGW_totalrain)

% Difference in peak swe
a = max(Xlm(:,2))*1000
b = max(Xhm(:,2))*1000

% Steamflow ratios
cur_totalstreamflow = sum(Xlm(:, 3)) + sum(Xlm(:, 4))+sum(Xlm(:, 5))+sum(Xlm(:, 6))
pgw_totalstreamflow = sum(Xhm(:, 3)) + sum(Xhm(:, 4))+sum(Xhm(:, 5))+sum(Xhm(:, 6))
ratio_current = round([sum(Xlm(:, 3))  sum(Xlm(:, 4)) sum(Xlm(:, 5)) sum(Xlm(:, 6))]/cur_totalstreamflow *100)
ratio_pgw = round([sum(Xhm(:, 3))  sum(Xhm(:, 4)) sum(Xhm(:, 5)) sum(Xhm(:, 6))]/pgw_totalstreamflow *100)


%%v Change in temperature
% Xhm = 
%  %% Low and Hig flow year composiiton
%  % 
%  close all
% clow = 'k'
% chigh = [0   102   204]/255;
% % COLOR PALETTE
% cavy = [102 170 255]/255%pale blue
% csnow= [0 102 204]/255%  mid blue
% crain = [0 51 102]/255% dark blue
% crunoff = [0 153 153]/255 % light green
% cdrift = [0 102 102]/255% dark green
% cET = [0 204 204]/255 % black
% csnowm = [200 200 200]/255% light grey
% cicem =  [140 140 140]/255% mid grey 
% cfirnm = [50 50 50]/255% dark grey
% 
% fig = figure('units','inches','outerposition',[0 0 8 6.5]);
% lw = 1
%  subplot (3,2,1)
% plot (smooth(Xlm(:, 3)*1000,7), 'Color', clow, 'Linewidth', lw); hold on
% plot (smooth(Xhm(:, 3)*1000,7), 'Color', chigh, 'Linewidth', lw); hold on
% xticks([15:30.5:365])
% xticklabels ({'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'})
% xlim ([190 365])
% ylim ([0 20])
% lh = legend ( 'Current', 'PGW', 'Location', 'Northwest' )
% set( lh,  'Color', [1 1 1])
% ylabel ('Snowmelt (mm)')
% grid on; box on
% 
%  subplot (3,2,2)
% plot (smooth(Xlm(:, 4)*1000,7), 'Color', clow,  'Linewidth', lw); hold on
% plot (smooth(Xhm(:, 4)*1000,7),'Color', chigh,  'Linewidth', lw); hold on
% xticks([15:30.5:365])
% xticklabels ({'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'})
% xlim ([190 365])
% ylim ([0 10])
% ylabel ('Icemelt (mm)')
% grid on; box on
% 
%  subplot (3,2,3)
% plot (smooth(Xlm(:, 5)*1000,7), 'Color', clow,  'Linewidth', lw); hold on
%   plot (smooth(Xhm(:, 5)*1000,7),  'Color', chigh,  'Linewidth', lw); hold on
% xticks([15:30.5:365])
% xticklabels ({'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'})
% xlim ([190 365])
% ylim ([0 4])
% ylabel ('Firnmelt (mm)')
% grid on; box on
% lh = legend ( 'Current', 'PGW', 'Location', 'Northwest' )
% set( lh,  'Color', [1 1 1])
% 
%  subplot (3,2,4)
% plot (smooth(Xlm(:, 6)*1000,7), 'Color', clow,  'Linewidth', lw); hold on
%   plot (smooth(Xhm(:, 6)*1000,7), 'Color', chigh,  'Linewidth', lw); hold on
% xticks([15:30.5:365])
% xticklabels ({'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'})
% xlim ([190 365])
% ylim ([0 2.5])
% ylabel ('Rainfall Runoff (mm)')
% grid on; box on
% 
%  subplot (3,2,5)
% h =  area([smooth(Xlm(:, 6)*1000,7) smooth(Xlm(:, 5)*1000,7) smooth(Xlm(:, 4)*1000,7) smooth(Xlm(:, 3)*1000, 7)])
% set(h(1),'facecolor', crunoff)
% set(h(3),'facecolor', cicem)
% set(h(2),'facecolor', cfirnm)
% set(h(4),'facecolor', csnowm)
% xlim ([190 365])
% ylim ([0 30])
% xticks([15:30.5:365])
% xticklabels ({'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'})
% ylabel ('Current (mm)')
% grid on; box on
% neworder = [4 3 2 1];
% labels= {'Rainfall Runoff','Firnmelt', 'Icemelt','Snowmelt'};
% legend(h(neworder), labels(neworder), 'Location', 'northwest', 'Color', [1 1 1], 'Orientation', 'Vertical', 'Fontsize', 8);
% 
% subplot (3,2,6)
% h= area([smooth(Xhm(:, 6)*1000,7) smooth(Xhm(:, 5)*1000,7) smooth(Xhm(:, 4)*1000,7) smooth(Xhm(:, 3)*1000, 7)])
% set(h(1),'facecolor', crunoff)
% set(h(3),'facecolor', cicem)
% set(h(2),'facecolor', cfirnm)
% set(h(4),'facecolor', csnowm)
% xlim ([190 365])
% ylim ([0 30])
% xticks([15:30.5:365])
% xticklabels ({'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'})
% ylabel ('PGW (mm)')
% grid on; box on
% 
% %%
% % save fig
% tightfig(fig)
% filename = 'D:\FuturePeyto\CRHM\Figures\FlowComponent_Current_PGW'
% savefig (filename);
% export_fig(filename, '-pdf','-tiff', '-transparent')
% saveas (gcf,filename, 'png')
% saveas (gcf,filename, 'svg')

