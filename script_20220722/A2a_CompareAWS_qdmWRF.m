%% A2a: Import qdmWRF and compare with OBS
% Is there a bif diffference in performance between the cell is they are
% all bias-corrected? 
% this script makes the point that the bias correction to Peyto AWS would
% be good for any cell that covers Peyto and give negliable difference in
% perfomance. Picking the right cell if running it with a unique cell would
% not be very different and lead to different forcings.
close all
clear all
%% Part 1: Import data
%load qdm WRF CUR and PGW
for Cn = 1:5 % number of cell
str = importdata(strcat('D:\FuturePeyto\dataproc\wrf\A1d_QDMbiascorrection\MBCn_c_cell', num2str(Cn)', '.txt')); cur = str.data;
str = importdata(strcat('D:\FuturePeyto\dataproc\wrf\A1d_QDMbiascorrection\MBCn_p_cell', num2str(Cn)', '.txt')); pgw = str.data;
qdmCUR(:,:,Cn) = cur;
qdmPGW(:,:,Cn) = pgw;
end 
% qdmCUR has time x variable x cell (6 variable, 5 cells)
save ('D:\FuturePeyto\dataproc\wrf\A2a_CompareAWS_QDM\qdmWRF.mat', 'qdmCUR', 'qdmPGW')
clear qdmPGW

% load raw WRF  
load('D:\FuturePeyto\dataproc\wrf\A1b_ComparingrawWRF_MET\rawWRF_CUR_perCell_timeseries.mat')
rawCUR = VarCell_CUR;
rawCUR= permute(rawCUR, [1,3,2]);
rawCUR = rawCUR(8:131406, :, :);
CURtime = time(8:131406)';
rawCUR(:, 1, :) = rawCUR(:, 1, :)-273.15;

% load Peyto MET
load('D:\FuturePeyto\dataproc\met\A0\crhmOBS_metMOH_ERAp_20200819.mat')
obstime = datetime([crhmOBS_metMOH_ERA_20200819(:, 1:5) zeros(length(crhmOBS_metMOH_ERA_20200819),1)]);
obs =crhmOBS_metMOH_ERA_20200819(:, 6:11);
clear crhmOBS_metMOH_ERA_20200819


%% Plot 1: Scatterplot
% obs vs variable, for eahc cell
ms = 2; %marker size
c1 = [0.2 0.2 0.2] ; % black
c2 = [200 0 0]/255; % dark red
l1 = [0.1 0.1 0.1] ; % black
l2 = [150 0 0]/255; % dark red
tr1 = 0.8 % marke edge transparency
tr2 = 0.1 % marke face transparency (1 is full, 0 is transparent)
rlc = 'k'
rlw = 1;
hw = 1;
close all 
fig = figure('units','inches','position',[0 0 11 11]); 
jj = 1; % subplot number

for i= 1:5
subplot(5,6,jj);
    % Ta
scatter(obs(:,1), rawCUR(:, 1, i), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,1), qdmCUR(:, 1, i), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
grid on
jj = jj+1;

% Ea
subplot (5,6,jj)
scatter(obs(:,2), rawCUR(:, 2, i), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,2), qdmCUR(:, 2, i), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
grid on
jj = jj+1;

% U
subplot (5,6,jj)
scatter(obs(:,3), rawCUR(:, 3, i), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,3), qdmCUR(:, 3, i), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
grid on
jj = jj+1;

% SW
subplot (5,6,jj)
scatter(obs(:,4), rawCUR(:, 4, i), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,4), qdmCUR(:, 4, i), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
grid on
jj = jj+1;

% LW
subplot (5,6,jj)
scatter(obs(:,5), rawCUR(:, 5, i), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,5), qdmCUR(:, 5, i), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
grid on
jj = jj+1;

% P
subplot (5,6,jj)
scatter(obs(:,6), rawCUR(:, 6, i), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,6), qdmCUR(:, 6, i), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
grid on
jj = jj+1;
end 
mtit ('MET (x) and WRF (y) for raw (black) and QDM (red). for column: Ta, Ea, U, SW, LW and P, and row: Cell 1-5)')

% performance of QDM WRF cell very similar between the cells
figname ='ScatterPlots_MET_rawCUR_qdmCUR_5cells';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2a\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\A2a\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\A2a\', figname))
% close all

%% Plot 2: Q:Q
close all 
fig = figure('units','inches','position',[0 0 11 11]); 
jj = 1; % subplot number
c2 = [0 0 153]/255
crl =[0.5 0.5 0.5]
for i= 1:5
 % Ta
 subplot(5,6,jj);
 q = qqplot(obs(:,1), rawCUR(:, 1, i)); grid on; 
set(q(1),'marker','x','markersize',2,'markeredgecolor',c2); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
hold on
rl = refline(1,0);  rl.Color = crl; rl.LineWidth = 1;
qq = qqplot(obs(:,1), qdmCUR(:, 1, i)); grid on;  
set(qq(1),'marker','x','markersize',1,'markeredgecolor','r'); set(qq(2), 'Color', 'r', 'linewidth', 1);set(qq(3), 'Color', 'r', 'linewidth', 1, 'linestyle', ':'); % dashed line
jj = jj+1;

% Ea
subplot(5,6,jj);
 q = qqplot(obs(:,2), rawCUR(:, 2, i)); grid on; 
set(q(1),'marker','x','markersize',2,'markeredgecolor',c2); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
hold on
rl = refline(1,0);  rl.Color = crl; rl.LineWidth = 1;
qq = qqplot(obs(:,2), qdmCUR(:, 2, i)); grid on;  
set(qq(1),'marker','x','markersize',1,'markeredgecolor','r'); set(qq(2), 'Color', 'r', 'linewidth', 1);set(qq(3), 'Color', 'r', 'linewidth', 1, 'linestyle', ':'); % dashed line
jj = jj+1;

% U
subplot(5,6,jj);
 q = qqplot(obs(:,3), rawCUR(:, 3, i)); grid on; 
set(q(1),'marker','x','markersize',2,'markeredgecolor',c2); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
hold on
rl = refline(1,0);  rl.Color = crl; rl.LineWidth = 1;
qq = qqplot(obs(:,3), qdmCUR(:, 3, i)); grid on;  
set(qq(1),'marker','x','markersize',1,'markeredgecolor','r'); set(qq(2), 'Color', 'r', 'linewidth', 1);set(qq(3), 'Color', 'r', 'linewidth', 1, 'linestyle', ':'); % dashed line
jj = jj+1;

% SW
subplot(5,6,jj);
 q = qqplot(obs(:,4), rawCUR(:, 4, i)); grid on; 
set(q(1),'marker','x','markersize',2,'markeredgecolor',c2); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
hold on
rl = refline(1,0);  rl.Color = crl; rl.LineWidth = 1;
qq = qqplot(obs(:,4), qdmCUR(:, 4, i)); grid on;  
set(qq(1),'marker','x','markersize',1,'markeredgecolor','r'); set(qq(2), 'Color', 'r', 'linewidth', 1);set(qq(3), 'Color', 'r', 'linewidth', 1, 'linestyle', ':'); % dashed line
jj = jj+1;

% LW
subplot(5,6,jj);
 q = qqplot(obs(:,5), rawCUR(:, 5, i)); grid on; 
set(q(1),'marker','x','markersize',2,'markeredgecolor',c2); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
hold on
rl = refline(1,0);  rl.Color = crl; rl.LineWidth = 1;
qq = qqplot(obs(:,5), qdmCUR(:, 5, i)); grid on;  
set(qq(1),'marker','x','markersize',1,'markeredgecolor','r'); set(qq(2), 'Color', 'r', 'linewidth', 1);set(qq(3), 'Color', 'r', 'linewidth', 1, 'linestyle', ':'); % dashed line
jj = jj+1;

% P
subplot(5,6,jj);
 q = qqplot(obs(:,6), rawCUR(:, 6, i)); grid on; 
set(q(1),'marker','x','markersize',2,'markeredgecolor',c2); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
hold on
rl = refline(1,0);  rl.Color = crl; rl.LineWidth = 1;
qq = qqplot(obs(:,6), qdmCUR(:, 6, i)); grid on;  
set(qq(1),'marker','x','markersize',1,'markeredgecolor','r'); set(qq(2), 'Color', 'r', 'linewidth', 1);set(qq(3), 'Color', 'r', 'linewidth', 1, 'linestyle', ':'); % dashed line
jj = jj+1;
end 
mtit ('MET (x) and WRF (y) for raw (black) and QDM (red). for column: Ta, Ea, U, SW, LW and P, and row: Cell 1-5)')

figname ='QQplot_MET_rawCUR_qdmCUR_5cells';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2a\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\A2a\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\A2a\', figname))

%% Statistics table:
clear RMSD
for ii = 1:5% cell
for i = 1:6 % variable
RMSD(ii, i)   =  sqrt(mean((obs(:, i) - rawCUR(:, i, ii)).^2));
RMSD(ii+5, i) =  sqrt(mean((obs(:, i) - qdmCUR(:, i, ii)).^2));
end 
end 
CellName = {'raw Cell 1'; 'raw Cell 2'; 'raw Cell 3'; 'raw Cell 4'; 'raw Cell 5'; ...
          'qdm Cell 1'; 'qdm Cell 2'; 'qdm Cell 3'; 'qdm Cell 4'; 'qdm Cell 5'};
T = RMSD(:, 1);
Ea = RMSD(:, 2);
U = RMSD(:, 3);
SWin = RMSD(:, 4);
LWin= RMSD(:, 5);
P =  RMSD(:, 6);
stat_RMSD = table(CellName, T, Ea, U, SWin, LWin, P);
writetable(stat_RMSD, 'D:\FuturePeyto\fig\A2a\Table_RMSE_RawQDM.csv')

% R2
clear r r2
for ii = 1:5% cell
for i = 1:6 % variable
r = corrcoef(obs(:, i),rawCUR(:, i, ii));
R2(ii, i) = r(2);
r = corrcoef(obs(:, i),qdmCUR(:, i, ii));
R2(ii+5, i) = r(2);
end 
end 
CellName = {'raw Cell 1'; 'raw Cell 2'; 'raw Cell 3'; 'raw Cell 4'; 'raw Cell 5'; ...
          'qdm Cell 1'; 'qdm Cell 2'; 'qdm Cell 3'; 'qdm Cell 4'; 'qdm Cell 5'};
T = R2(:, 1);
Ea = R2(:, 2);
U = R2(:, 3);
SWin = R2(:, 4);
LWin= R2(:, 5);
P =  R2(:, 6);
stat_R2 = table(CellName, T, Ea, U, SWin, LWin, P);
writetable(stat_R2, 'D:\FuturePeyto\fig\A2a\Table_R2_RawQDM.csv')

% MAE
clear MAE
for ii = 1:5% cell
for i = 1:6 % variable
MAE(ii, i) = mean(abs(obs(:, i) - rawCUR(:, i, ii)));
MAE(ii+5, i) = mean(abs(obs(:, i) - qdmCUR(:, i, ii)));
end 
end 
CellName = {'raw Cell 1'; 'raw Cell 2'; 'raw Cell 3'; 'raw Cell 4'; 'raw Cell 5'; ...
          'qdm Cell 1'; 'qdm Cell 2'; 'qdm Cell 3'; 'qdm Cell 4'; 'qdm Cell 5'};
T = MAE(:, 1);
Ea = MAE(:, 2);
U = MAE(:, 3);
SWin = MAE(:, 4);
LWin= MAE(:, 5);
P =  MAE(:, 6);
stat_MAE = table(CellName, T, Ea, U, SWin, LWin, P);
writetable(stat_MAE, 'D:\FuturePeyto\fig\A2a\Table_MAE_RawQDM.csv')

% Save the tables as matlab varaibles as well
save ('D:\FuturePeyto\dataproc\wrf\A2a_CompareAWS_QDM\Stats_raw_qdm_WRF.mat', 'stat_MAE', 'stat_R2', 'stat_RMSD');

%% Plot 3: Montlhy time series for each variables
close all

% Compile into montlhy means (annual sum for prcipitation)
x = timetable(obstime, obs(:, 1:5));
xx = retime(x, 'monthly', 'mean');
metm = table2array(xx);
mettimem = xx.obstime;

x = timetable(obstime, obs(:, 6));
xx = retime(x, 'yearly', 'sum');
metp_year = table2array(xx);
mettime_year = xx.obstime;
clear x xx 

% load time serie data

for ii = 1:5
x = timetable(CURtime, squeeze(rawCUR(:, ii, 1:5))); xx = retime(x, 'monthly', 'mean');
rawCURm(:,:,ii) = table2array(xx); %
x = timetable(CURtime, squeeze(qdmCUR(:, ii, 1:5))); xx = retime(x, 'monthly', 'mean');
qdmCURm(:,:,ii) = table2array(xx); %Temperature raw cell monthly : Trcm
tm= xx.CURtime;
end 

% Annual sum for precip
x = timetable(CURtime, squeeze(rawCUR(:, 6, 1:5))); xx = retime(x, 'yearly', 'sum');
rawPy = table2array(xx);
x = timetable(CURtime, squeeze(qdmCUR(:, 6, 1:5))); xx = retime(x, 'yearly', 'sum');
qdmPy = table2array(xx);
ty = xx.CURtime;
clear x xx 

% Temperature
fig = figure('units','inches','position',[0 0 8 3]); 
p1 = plot(tm, rawCURm(:,:,1),  'r', 'linewidth', .5); hold on
p2 = plot(tm, qdmCURm(:,:,1), 'b', 'linewidth', .5); hold on
p3 = plot(mettimem, metm(:, 1), 'k', 'linewidth', 1)
legend ([p1(1) p2(1) p3(1)], 'raw WRF','qdm WRF', 'AWS', 'Orientation', 'Horizontal', 'Location', 'North');
ylim([-22 20])
ylabel ('Monthly mean temperature (C)')
tightfig(fig)
figname = 'TemperatureTS_raw_qdm_WRFCells_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2a\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A2a\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A2a\', figname))

% Ea
fig = figure('units','inches','position',[0 0 8 3]); 
p1 = plot(tm, rawCURm(:,:,2),  'r', 'linewidth', .5); hold on
p2 = plot(tm, qdmCURm(:,:,2), 'b', 'linewidth', .5); hold on
p3 = plot(mettimem, metm(:, 2), 'k', 'linewidth', 1)
legend ([p1(1) p2(1) p3(1)], 'raw WRF','qdm WRF', 'AWS', 'Orientation', 'Horizontal', 'Location', 'North');
ylim([0 1])
ylabel ('Monthly mean vapor pressure (hpa)')
tightfig(fig)
figname = 'VaporPressureTS_raw_qdm_WRFCells_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2a\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A2a\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A2a\', figname))

% U
fig = figure('units','inches','position',[0 0 8 3]); 
p1 = plot(tm, rawCURm(:,:,3),  'r', 'linewidth', .5); hold on
p2 = plot(tm, qdmCURm(:,:,3), 'b', 'linewidth', .5); hold on
p3 = plot(mettimem, metm(:, 3), 'k', 'linewidth', 1)
legend ([p1(1) p2(1) p3(1)], 'raw WRF','qdm WRF', 'AWS', 'Orientation', 'Horizontal', 'Location', 'North');
ylim([2 12])
ylabel ('Wind Speed (m/s)')
tightfig(fig)
figname = 'WindSpeedTS_raw_qdm_WRFCells_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2a\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A2a\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A2a\', figname))

% SW
fig = figure('units','inches','position',[0 0 8 3]); 
p1 = plot(tm, rawCURm(:,:,4),  'r', 'linewidth', .5); hold on
p2 = plot(tm, qdmCURm(:,:,4), 'b', 'linewidth', .5); hold on
p3 = plot(mettimem, metm(:, 4), 'k', 'linewidth', 1)
legend ([p1(1) p2(1) p3(1)], 'raw WRF','qdm WRF', 'AWS', 'Orientation', 'Horizontal', 'Location', 'North');
ylim([0 500])
ylabel ('Monthly mean SWin (Wm-2)')
tightfig(fig)
figname = 'SWinTS_raw_qdm_WRFCells_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2a\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A2a\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A2a\', figname))

% LW
fig = figure('units','inches','position',[0 0 8 3]); 
p1 = plot(tm, rawCURm(:,:,5),  'r', 'linewidth', .5); hold on
p2 = plot(tm, qdmCURm(:,:,5), 'b', 'linewidth', .5); hold on
p3 = plot(mettimem, metm(:, 5), 'k', 'linewidth', 1)
legend ([p1(1) p2(1) p3(1)], 'raw WRF','qdm WRF', 'AWS', 'Orientation', 'Horizontal', 'Location', 'North');
ylim([180 330])
ylabel ('Monthly mean LWin (Wm-2)')
tightfig(fig)
figname = 'LWinTS_raw_qdm_WRFCells_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2a\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A2a\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A2a\', figname))

% Precipitation
fig = figure('units','inches','position',[0 0 8 3]); 
subplot (2,1,1);
bar(ty, [rawPy metp_year]); hold on
ylim ([0 2200]);
title ('raw WRF Cell')
ylabel ('Annual p (mm)')
subplot (2,1,2);
bar(ty, [qdmPy metp_year]); hold on
legend ('1','2','3','4','5', 'AWS', 'Orientation', 'Horizontal', 'Location', 'North');
ylim ([0 2200]);
title ('Wrf cell QDM to Peyto AWS')
ylabel ('Annual p (mm)')
figname = 'PrecipitationBar_raw_qdm_WRFCells_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2a\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A2a\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A2a\', figname))
%
close all

%% Next step: export  cell 4qdm wrf cell into an obsvertaion file for CRHM (A2b) 