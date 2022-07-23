%% A1b: Compare rawWRF cells and MET 
% this script  produces figures as grid maps and time series of 
% the WRF cells and peyto AWS data. 

% Part 1: generates figures for the temperature and precipitation of
% the 4x4 grid of Peyto as well as precipitation and temperature gradient.
% this sciprt 

% Part 2: Extract the variables as time series for the 5 cells over peyto
% glacier and Bow summit, for both current and PGW and save them. This
% includes change U10 and V10 into wind soeed and mixing ratio Q to vapor pressure Ea
% This section result in variable VarCell, which
% stors the T, Ea, U, SW, LW and precipitation data for the 5 cells of
% interest

% Part 3: Monthly time series graphs between the 5 rawWRF cells and peyto MET
 
% By Caroline Aubry-Wake
% Last edited June 30, 2020
%% 
close all
clear all
%% Part 1: ProducemMaps of of Temperature and Precipitation for the 4x3 area of Peyto
load('D:\FuturePeyto\dataproc\wrf\A1a_rawWRFimport\rawWRF_CUR.mat') % data cube

% Temperature Grid
var = rawWRF_CUR(:,:,:,1); % var is temperature here
tmean = nanmean(var, 3)-273.15; 
tmin= min(var,[], 3)-273.15; 
tmax= max(var, [],3)-273.15; 
elev = rawWRF_CUR_constant(:,:,3)
% Temperature grid maps
fig = figure('units','inches','position',[0 0 8 6]); 
subplot (2,2,1)
imagesc(tmean); colorbar
title ('Mean Temp, 2000-2015')
subplot (2,2,2)
imagesc(tmax); colorbar
title ('Max Temp,  2000-2015')
subplot (2,2,3)
imagesc(tmin); colorbar
title ('Min Temp,  2000-2015')
subplot (2,2,4)
imagesc(elev); colorbar
title ('Elevation of WRF cells (m.a.s.l.)')
figname ='TemperatureGrid_rawWRFCells';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\A1b\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\A1b\', figname))

% Temperature Gradient
fig = figure('units','inches','position',[0 0 8 6]); 
subplot (2,2,1)
scatter(reshape(elev, 1,12), reshape(tmean,1,12))
title ('Mean Temp, 2000-2015')
grid on
xlabel ('elevation (m.a.s.l.)'); ylabel ('temperature (C)');
subplot (2,2,2)
scatter(reshape(elev, 1,12), reshape(tmax, 1,12))
title ('Max Temp,  2000-2015')
grid on
xlabel ('elevation (m.a.s.l.)'); ylabel ('temperature (C)');
subplot (2,2,3)
scatter(reshape(elev, 1,12), reshape(tmin,1,12))
grid on
title ('Min Temp,  2000-2015')
xlabel ('elevation (m.a.s.l.)'); ylabel ('temperature (C)');
tightfig(fig)

figname = 'TemperatureGradient_rawWRFCells';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A1b\', figname))

clear tmax tmean tmin
% Precipitation Grid
var = rawWRF_CUR(:,:,:,2); % var is precipitation
psumgrid = nansum(var, 3); 

fig = figure('units','inches','position',[0 0 8 3]); 
subplot (1,2,1)
imagesc(psumgrid); 
title ('Total Precip (mm), 2000-2015')
colorbar
subplot (1,2,2)
imagesc(elev); 
colorbar
title ('Elevation,  2000-2015')
figname = 'PrecipitationGrid_rawWRFCells';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A1b\', figname))

% Precipitation gradient
fig = figure('units','inches','position',[0 0 4 3]); 
scatter(reshape(elev, 1,12), reshape(psumgrid,1,12))
grid on
title ('Total Precip,  2000-2015')
xlabel ('elevation (m.a.s.l.)'); ylabel ('precipitation (mm)');
tightfig(fig)
figname = 'PrecipitationGradient_rawWRFCells';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A1b\', figname))
clear var psumgrid
% I did not make graph of the other variables but it could be done.
% It just seems Temperature and precipitation are the main 2 to analyse. 

%% Part 2: Extract timeseries for Peyto WRF Cells
% Extract grid cells as time series
extractcell =  [2,1;3,1;3,2;2,3;1,3]; % cell correpsonding to Peyto glacier and bow summit
for ii = 1:8 %
for i = 1:length(extractcell)
   VarCell(:,i, ii) = rawWRF_CUR(extractcell(i, 1),extractcell(i, 2), :, ii);
end 
end
% Convert U10, V10 to wind speed and Q to ea
% order of variables: T ,V10 ,U10, Q2 ,PSFC, SWDOWN, GLW,  PREC); 
U = sqrt(VarCell(:,:,2).^2 + VarCell(:,:,3).^2);
Q2 = VarCell(:,:,4);
PSFC = VarCell(:,:,5)*0.01; 
Ea = Q2 .* PSFC ./ (0.378 * Q2 + 0.622)/10; % mb
% reorder VarCell to same order as MET: T, Ea, U, SW, LW, P
Var = cat(3, VarCell(:,:,1), Ea, U, VarCell(:,:,6:8));
VarCell=Var;
clear U Q2 PSFC Ea Var

% change name to get is as current
VarCell_CUR = VarCell;
% save variable 
save ('D:\FuturePeyto\dataproc\wrf\A1b_ComparingrawWRF_MET\rawWRF_CUR_perCell_timeseries.mat',  'VarCell_CUR','time');

% PGW variables
load('D:\FuturePeyto\dataproc\wrf\A1a_rawWRFimport\rawWRF_PGW.mat')
extractcell =  [2,1;3,1;3,2;2,3;1,3]; % cell correpsonding to Peyto glacier and bow summit
for ii = 1:8 
for i = 1:length(extractcell)
   VarCell(:,i, ii) = rawWRF_PGW(extractcell(i, 1),extractcell(i, 2), :, ii);
end 
end
U = sqrt(VarCell(:,:,2).^2 + VarCell(:,:,3).^2);
Q2 = VarCell(:,:,4);
PSFC = VarCell(:,:,5)*0.01; 
Ea = Q2 .* PSFC ./ (0.378 * Q2 + 0.622)/10; % mb
% reorder VarCell to same order as MET: T, Ea, U, SW, LW, P
Var = cat(3, VarCell(:,:,1), Ea, U, VarCell(:,:,6:8));
VarCell_PGW=Var;
clear U Q2 PSFC Ea Var
save ('D:\FuturePeyto\dataproc\wrf\A1b_ComparingrawWRF_MET\rawWRF_PGW_perCell_timeseries.mat',  'VarCell_PGW','time');

for i = 1:5
    plot(cumsum(VarCell_PGW(:,i,6)));
    hold on
end 
legend ('1','2','3','4','5')


%% Part 3:  Monthly time series graphs
close all
clear all
% compare with the dataset form A0: MHN and MOH

load('D:\FuturePeyto\dataproc\met\A0\crhmOBS_metMOH_ERAp_20200819.mat')
metMOHtime = datetime([crhmOBS_metMOH_ERA_20200819(:, 1:5) zeros(length(crhmOBS_metMOH_ERA_20200819),1)]);
metMOH =crhmOBS_metMOH_ERA_20200819(:, 6:11);
clear crhmOBS_metMOH_ERA_20200819

load('D:\FuturePeyto\dataproc\met\A0\crhmOBS_metMNH_20200819.mat')
metMNHtime = datetime([crhmOBS_metMNH_20200819(:, 1:5) zeros(length(crhmOBS_metMNH_20200819),1)]);
metMNH =crhmOBS_metMNH_20200819(:, 6:11);

% mettime = mettime(114577:245975);
% met = met(114577:245975, :);

% Change names
pMOH  = metMOH(:, 6);
pMNH= metMNH(:, 6);

% Compile into montlhy means (annual sum for prcipitation)
x = timetable(metMOHtime, metMOH(:, 1:5));
xx = retime(x, 'monthly', 'mean');
metMOHm = table2array(xx);
metMOHtimem = xx.metMOHtime;

x = timetable(metMNHtime, metMNH(:, 1:5));
xx = retime(x, 'monthly', 'mean');
metMNHm = table2array(xx);
metMNHtimem = xx.metMNHtime;

x = timetable(metMNHtime, pMNH);
xx = retime(x, 'yearly', 'sum');
pMNH_year = table2array(xx);
pMNHtime_year = xx.metMNHtime;
clear x xx 

x = timetable(metMOHtime, pMOH);
xx = retime(x, 'yearly', 'sum');
pMOH_year = table2array(xx);
pMOHtime_year = xx.metMOHtime;
clear x xx 
% Load and compile WrawWRF into monthly time series
load('D:\FuturePeyto\dataproc\wrf\A1b_ComparingrawWRF_MET\rawWRF_CUR_perCell_timeseries.mat')

% load time serie data
for ii = 1:5
x = timetable(time', squeeze(VarCell_CUR(:, 1:5, ii))); xx = retime(x, 'monthly', 'mean');
VarCellm(:,:,ii) = table2array(xx); %Temperature raw cell monthly : Trcm
tm= xx.Time;
end 
% annual sum for precip
x = timetable(time', squeeze(VarCell_CUR(:, 1:5, 6))); xx = retime(x, 'yearly', 'sum');
Prcy = table2array(xx);
ty = xx.Time;
clear x xx 

% Temperature
fig = figure('units','inches','position',[0 0 8 3]); 
plot(tm, VarCellm(:,:,1)-273.15, 'linewidth', 1); hold on
plot(metMOHtimem, metMOHm(:, 1), ':k', 'linewidth', 1)
plot(metMNHtimem, metMNHm(:, 1), 'k', 'linewidth', 1)
legend ('1','2','3','4','5', 'MOH','MNH', 'Orientation', 'Horizontal', 'Location', 'North');
ylim([-22 20])
ylabel ('Monthly mean temperature (C)')
tightfig(fig)
figname = 'TemperatureTS_rawWRFCells_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A1b\', figname))

% Ea
fig = figure('units','inches','position',[0 0 8 3]); 
plot(tm, VarCellm(:,:,2), 'linewidth', 1); hold on
plot(metMOHtimem, metMOHm(:, 2), ':k', 'linewidth', 1)
plot(metMNHtimem, metMNHm(:, 2), 'k', 'linewidth', 1)
legend ('1','2','3','4','5', 'MOH','MNH', 'Orientation', 'Horizontal', 'Location', 'North');
ylim([0 1])
ylabel ('Monthly mean vapor pressure (hpa)')
tightfig(fig)
figname = 'VaporPressureTS_rawWRFCells_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A1b\', figname))

% U
fig = figure('units','inches','position',[0 0 8 3]); 
plot(tm, VarCellm(:,:,3), 'linewidth', 1); hold on
plot(metMOHtimem, metMOHm(:, 3), ':k', 'linewidth', 1)
plot(metMNHtimem, metMNHm(:, 3), 'k', 'linewidth', 1)
legend ('1','2','3','4','5', 'MOH','MNH', 'Orientation', 'Horizontal', 'Location', 'North');
ylim([2 12])
ylabel ('Wind Speed (m/s)')
tightfig(fig)
figname = 'WindSpeedTS_rawWRFCells_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A1b\', figname))

% SW
fig = figure('units','inches','position',[0 0 8 3]); 
plot(tm, VarCellm(:,:,4), 'linewidth', 1); hold on
plot(metMOHtimem, metMOHm(:, 4), ':k', 'linewidth', 1)
plot(metMNHtimem, metMNHm(:, 4), 'k', 'linewidth', 1)
legend ('1','2','3','4','5', 'MOH','MNH', 'Orientation', 'Horizontal', 'Location', 'North');
ylim([0 500])
ylabel ('Monthly mean SWin (Wm-2)')
tightfig(fig)
figname = 'SWinTS_rawWRFCells_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A1b\', figname))

% LW
fig = figure('units','inches','position',[0 0 8 3]); 
plot(tm, VarCellm(:,:,5), 'linewidth', 1); hold on
plot(metMOHtimem, metMOHm(:, 5), ':k', 'linewidth', 1)
plot(metMNHtimem, metMNHm(:, 5), 'k', 'linewidth', 1)
legend ('1','2','3','4','5', 'MOH','MNH', 'Orientation', 'Horizontal', 'Location', 'North');
ylim([180 330])
ylabel ('Monthly mean LWin (Wm-2)')
tightfig(fig)
figname = 'LWinTS_rawWRFCells_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A1b\', figname))

% Precipitation
p_yr_15 = [pMOH_year] 
fig = figure('units','inches','position',[0 0 8 3]); 
bar(ty, [Prcy p_yr_15]); hold on
legend ('1','2','3','4','5', 'AWS', 'Orientation', 'Horizontal', 'Location', 'North');
ylabel ('Annual precipitation (mm)')
tightfig(fig)
figname = 'PrecipitationBar_rawWRFCells_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A1b\', figname))
%
varp = VarCell_CUR(:,:, 6);
a = find(time == metMOHtime(1))

fig = figure('units','inches','position',[0 0 8 3]); 
plot(time(a:end), cumsum(varp(a:end, :))); hold on
plot(metMOHtime, cumsum(pMOH), 'k'); 
legend ('1','2','3','4','5', 'AWS', 'Orientation', 'Horizontal', 'Location', 'North');
ylabel ('Cumulative precipitation (mm)')
tightfig(fig)
figname = 'PrecipitationCum_rawWRFCells_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A1b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A1b\', figname))
%
close all

%% Next step: export each WRF obs (for each cell) to a CRHM obs forat to do the bias correction (script A1c)


