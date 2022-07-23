%% A2b - Focus on Cell 4 (one at Peyto AWS) and export as CRHM obs
% This script generates figures to assess the bias correction quality for
% the WRF cell 4 for MET and 5 for precipitation to create an observation
% file to run CRHM
% As the different cell after bias correction are very similar, we pick cell 4. 
close all
clear all

%% Part 1: Import data for cell 4 and 5
%load qdm WRF CUR and PGW
load('D:\FuturePeyto\dataproc\wrf\A2a_CompareAWS_QDM\qdmWRF.mat')
qdmCUR4(:,:) = qdmCUR(:, :, 4);
qdmPGW4(:,:) = qdmPGW(:,:,4);
qdmCUR5(:,:) = qdmCUR(:, :, 5);
qdmPGW5(:,:) = qdmPGW(:,:,5);

clear qdmCUR qdmPGW

 figure;plot(cumsum(qdmCUR4(:,6))); hold on; plot(cumsum(qdmPGW4(:,6)));
 plot(cumsum(qdmCUR5(:,6))); hold on; plot(cumsum(qdmPGW5(:,6)));

% qdmCUR has time x variable x cell (6 variable, 5 cells)
save ('D:\FuturePeyto\dataproc\wrf\A2a_CompareAWS_QDM\qdmWRF_Cell4_20200701.mat', 'qdmCUR4', 'qdmPGW4')
save ('D:\FuturePeyto\dataproc\wrf\A2a_CompareAWS_QDM\qdmWRF_Cell5_20200701.mat', 'qdmCUR5', 'qdmPGW5')
% quick check of qdmPGW to make sure its not totally wrong, then delete it
clear qdmPGW4

% load raw WRF  
load('D:\FuturePeyto\dataproc\wrf\A1b_ComparingrawWRF_MET\rawWRF_CUR_perCell_timeseries.mat')
rawCUR = VarCell_CUR;
rawCUR= permute(rawCUR, [1,3,2]);
rawCURmet = rawCUR(8:131406, 1:5, 4);
rawCURp = rawCUR(8:131406, 6, 5);
rawCUR4 = [rawCURmet rawCURp];
CURtime = time(8:131406)';
rawCUR4(:, 1) = rawCUR4(:, 1)-273.15;
clear VarCell_CUR rawCURmet rawCURp rawCUR time


% load Peyto MET
load('D:\FuturePeyto\dataproc\met\A0\crhmOBS_metMOH_ERAp_20200819.mat')
obstime = datetime([crhmOBS_metMOH_ERA_20200819(:, 1:5) zeros(length(crhmOBS_metMOH_ERA_20200819),1)]);
obs =crhmOBS_metMOH_ERA_20200819(:, 6:11);
clear crhmOBS_metMOH_ERA_20200819

%% Change ea to rh
clear var1
time = CURtime;
var1 = rawCUR4(:, 1); % temp
for ii = 1:length(time)
    % saturated vapour pressure from air temperature
    if var1(ii, 1) > 0 
        estar_ctl(ii,1) = 0.611 * exp((17.27 * var1(ii, 1)) ./ (var1(ii, 1)+ 237.3)); % kPa
    else
        estar_ctl(ii,1) = 0.611 * exp((21.88 *var1(ii, 1)) ./ (var1(ii, 1) + 265.5));
    end
end    
rh_var1=  (rawCUR4(:, 2)./ estar_ctl)* 100;%relative humdiity
rh_rawCUR4_raw = rh_var1;
% remove values above 100 and <1 (it causes CRHM to bug)
for ii = 1:length(time)
% check for bad rh, including when rh > 100 and rh < 0  
    if rh_var1(ii) > 100 
        rh_var1(ii) = 100;
    else if rh_var1(ii) < 1
        rh_var1(ii) = 5;
    end
end
end
rh_rawCUR4= rh_var1; % replace RH in data

% qdm CUR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear var1
time = CURtime;
var1 = qdmCUR4(:, 1); % temp
for ii = 1:length(time)
    % saturated vapour pressure from air temperature
    if var1(ii, 1) > 0 
        estar_ctl(ii,1) = 0.611 * exp((17.27 * var1(ii, 1)) ./ (var1(ii, 1)+ 237.3)); % kPa
    else
        estar_ctl(ii,1) = 0.611 * exp((21.88 *var1(ii, 1)) ./ (var1(ii, 1) + 265.5));
    end
end    
rh_var1=  (qdmCUR4(:, 2)./ estar_ctl)* 100;%relative humdiity
% remove values above 100 and <1 (it causes CRHM to bug)
for ii = 1:length(time)
% check for bad rh, including when rh > 100 and rh < 0  
    if rh_var1(ii) > 100 
        rh_var1(ii) = 100;
    else if rh_var1(ii) < 1
        rh_var1(ii) = 5;
    end
end
end
rh_qdmCUR4= rh_var1; % replace RH in data

% MET
clear var1
time = CURtime;
var1 = obs(:, 1); % temp
for ii = 1:length(time)
    % saturated vapour pressure from air temperature
    if var1(ii, 1) > 0 
        estar_ctl(ii,1) = 0.611 * exp((17.27 * var1(ii, 1)) ./ (var1(ii, 1)+ 237.3)); % kPa
    else
        estar_ctl(ii,1) = 0.611 * exp((21.88 *var1(ii, 1)) ./ (var1(ii, 1) + 265.5));
    end
end    
rh_var1=  (obs(:, 2)./ estar_ctl)* 100;%relative humdiity
rh_obsraw = rh_var1;
% remove values above 100 and <1 (it causes CRHM to bug)
for ii = 1:length(time)
% check for bad rh, including when rh > 100 and rh < 0  
    if rh_var1(ii) > 100 
        rh_var1(ii) = 100;
    else if rh_var1(ii) < 1
        rh_var1(ii) = 5;
    end
end
end
rh_obs= rh_var1; % replace RH in data


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
fig = figure('units','inches','position',[0 0 8 11]); 
subplot(2,3,1);
% Ta
scatter(obs(:,1), rawCUR4(:, 1), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,1), qdmCUR4(:, 1), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
ylabel ('WRF, Ta (C)'); xlabel('MET, Ta (C)')
grid on

% Ea
subplot (2,3,2)
scatter(obs(:,2), rawCUR4(:, 2), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,2), qdmCUR4(:, 2), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
grid on
ylabel ('WRF, ea (hpa)'); xlabel('MET, ea (hpa)')

% U
subplot (2,3,3)
scatter(obs(:,3), rawCUR4(:, 3), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,3), qdmCUR4(:, 3), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
grid on
ylabel ('WRF,  U (m/s)'); xlabel('MET, U (m/s)')
legend ('rawWRF', 'qdmWRF')

% SW
subplot (2,3,4)
scatter(obs(:,4), rawCUR4(:, 4), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,4), qdmCUR4(:, 4), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
grid on
ylabel ('WRF,  SWin (W/m2)'); xlabel('MET, SWin (W/m2)')

% LW
subplot (2,3,5)
scatter(obs(:,5), rawCUR4(:, 5), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,5), qdmCUR4(:, 5), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
grid on
ylabel ('WRF,  LWin (W/m2)'); xlabel('MET, LWin (W/m2)')

% P
subplot (2,3,6)
scatter(obs(:,6), rawCUR4(:, 6), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,6), qdmCUR4(:, 6), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
grid on
ylabel ('WRF,  P(mm)'); xlabel('MET,  P(mm)')

mtit ('MET (x) and WRF cell correspinding to AWS(y)')

% performance of QDM WRF cell very similar between the cells
figname ='ScatterPlots_MET_rawCUR_qdmCUR_Cell4';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\A2b\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\A2b\', figname))
% close all

%% Plot 2: Q:Q
c2 = [0 0 153]/255;
crl =[0.5 0.5 0.5];
close all 
fig = figure('units','inches','position',[0 0 9 5], 'DefaultAxesFontSize',8); 
 % Ta
 subplot(2,3,1);
 q = qqplot(obs(:,1), rawCUR4(:, 1)); grid on; 
set(q(1),'marker','x','markersize',2,'markeredgecolor',c2); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
hold on
rl = refline(1,0);  rl.Color = crl; rl.LineWidth = 1;
qq = qqplot(obs(:,1), qdmCUR4(:, 1)); grid on;  
set(qq(1),'marker','x','markersize',1,'markeredgecolor','r'); set(qq(2), 'Color', 'r', 'linewidth', 1);set(qq(3), 'Color', 'r', 'linewidth', 1, 'linestyle', ':'); % dashed line
xlabel ('Observed hourly air temperature (^{\circ}C)')
ylabel ('WRF CUR hourly air temperature (^{\circ}C)')
xlim ([-46 25])
ylim ([-46 25])
xticks ([-40:10:20])
yticks ([-40:10:20])
grid off
legend ([q(1) q(2) qq(1) qq(2) rl(1)] , 'WRF-CUR', 'WRF-CUR best fit line', 'corr. WRF-CUR', 'corr. WRF-CUR best fit line',  '1:1 line')
% RH
subplot(2,3,2);
 q = qqplot(rh_obs, rh_rawCUR4_raw); grid on; 
set(q(1),'marker','x','markersize',2,'markeredgecolor',c2); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
hold on
rl = refline(1,0);  rl.Color = crl; rl.LineWidth = 1;
qq = qqplot(rh_obs, rh_qdmCUR4); grid on;  
set(qq(1),'marker','x','markersize',1,'markeredgecolor','r'); set(qq(2), 'Color', 'r', 'linewidth', 1);set(qq(3), 'Color', 'r', 'linewidth', 1, 'linestyle', ':'); % dashed line
xlabel ('Observed hourly relative humidity (%)')
ylabel ('WRF CUR hourly relative humidity (%)')
xlim ([0 100])
ylim ([0 180])
xticks ([0:20:100])
yticks ([0:20:180])
grid off

% U
subplot(2,3,3);
 q = qqplot(obs(:,3), rawCUR4(:, 3)); grid on; 
set(q(1),'marker','x','markersize',2,'markeredgecolor',c2); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
hold on
rl = refline(1,0);  rl.Color = crl; rl.LineWidth = 1;
qq = qqplot(obs(:,3), qdmCUR4(:, 3)); grid on;  
set(qq(1),'marker','x','markersize',1,'markeredgecolor','r'); set(qq(2), 'Color', 'r', 'linewidth', 1);set(qq(3), 'Color', 'r', 'linewidth', 1, 'linestyle', ':'); % dashed line
xlabel ('Observed hourly wind speed (m s^{-1})')
ylabel ('WRF CUR hourly wind speed (m s^{-1})')
xlim ([0 25])
ylim ([0 25])
xticks ([0:5:25])
yticks ([0:5:25])
grid off

% SW
subplot(2,3,4);
 q = qqplot(obs(:,4), rawCUR4(:, 4)); grid on; 
set(q(1),'marker','x','markersize',2,'markeredgecolor',c2); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
hold on
rl = refline(1,0);  rl.Color = crl; rl.LineWidth = 1;
qq = qqplot(obs(:,4), qdmCUR4(:, 4)); grid on;  
set(qq(1),'marker','x','markersize',1,'markeredgecolor','r'); set(qq(2), 'Color', 'r', 'linewidth', 1);set(qq(3), 'Color', 'r', 'linewidth', 1, 'linestyle', ':'); % dashed line
xlabel ({'Observed','hourly incoming solar radiation (W m^{-2})'})
ylabel ({'WRF CUR hourly';'incoming solar radiation (W m^{-2})'})
xlim ([0 1000])
ylim ([0 1000])
xticks ([0:200:1000])
yticks ([0:200:1000])
grid off
% LW
subplot(2,3,5);
 q = qqplot(obs(:,5), rawCUR4(:, 5)); grid on; 
set(q(1),'marker','x','markersize',2,'markeredgecolor',c2); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
hold on
rl = refline(1,0);  rl.Color = crl; rl.LineWidth = 1;
qq = qqplot(obs(:,5), qdmCUR4(:, 5)); grid on;  
set(qq(1),'marker','x','markersize',1,'markeredgecolor','r'); set(qq(2), 'Color', 'r', 'linewidth', 1);set(qq(3), 'Color', 'r', 'linewidth', 1, 'linestyle', ':'); % dashed line
xlabel ({'Observed';'hourly incoming longwave radiation (W m^{-2})'})
ylabel ({'WRF CUR hourly';'incoming longwave radiation (W m^{-2})'})
xlim ([80 375])
ylim ([80 375])
xticks ([100:50:350])
yticks ([100:50:350])
grid off

% P
subplot(2,3,6);
 q = qqplot(obs(:,6), rawCUR4(:, 6)); grid on; 
set(q(1),'marker','x','markersize',2,'markeredgecolor',c2); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
hold on
rl = refline(1,0);  rl.Color = crl; rl.LineWidth = 1;
qq = qqplot(obs(:,6), qdmCUR4(:, 6)); grid on;  
set(qq(1),'marker','x','markersize',1,'markeredgecolor','r'); set(qq(2), 'Color', 'r', 'linewidth', 1);set(qq(3), 'Color', 'r', 'linewidth', 1, 'linestyle', ':'); % dashed line
xlabel ('Observed hourly precipitation (mm)')
ylabel ('WRF CUR hourly precipitation (mm)')
xlim ([0 15])
ylim ([0 15])
xticks ([0:5:15])
yticks ([0:5:15])
grid off
%
figname ='QQplot_MET_rawCUR_qdmCUR_Cell4';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\A2b\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\A2b\', figname))

%% Statistics table:
clear S
for i = 1:6 % variable
if i == 2
S(1,i)   =  sqrt(nanmean((rh_obs - rh_rawCUR4_raw).^2));
S(2, i) =  sqrt(nanmean((rh_obs - rh_qdmCUR4).^2));
r = corrcoef(rh_obs,rh_rawCUR4_raw);
S(3, i) = r(2);
r = corrcoef(rh_obs,rh_qdmCUR4);
S(4,i) = r(2);
S(5, i) = nanmean(abs(rh_obs - rh_rawCUR4_raw));
S(6, i) = nanmean(abs(rh_obs - rh_qdmCUR4));
 
elseif i == 6
S(1,i)   =  sqrt(nanmean((obs(71353:end, i) - rawCUR4(71353:end, i)).^2));
S(2, i) =  sqrt(nanmean((obs(71353:end, i) - qdmCUR4(71353:end, i)).^2));
r = corrcoef(obs(71353:end, i),rawCUR4(71353:end, i), 'rows', 'pairwise');
S(3, i) = r(2);
r = corrcoef(obs(71353:end, i),qdmCUR4(71353:end, i), 'rows', 'pairwise');
S(4,i) = r(2);
S(5, i) = nanmean(abs(obs(71353:end, i) - rawCUR4(71353:end, i)));
S(6, i) = nanmean(abs(obs(71353:end, i) - qdmCUR4(71353:end, i)));

end 
S(1,i)   =  sqrt(nanmean((obs(:, i) - rawCUR4(:, i)).^2));
S(2, i) =  sqrt(nanmean((obs(:, i) - qdmCUR4(:, i)).^2));
r = corrcoef(obs(:, i),rawCUR4(:, i), 'rows', 'pairwise');
S(3, i) = r(2);
r = corrcoef(obs(:, i),qdmCUR4(:, i), 'rows', 'pairwise');
S(4,i) = r(2);
S(5, i) = nanmean(abs(obs(:, i) - rawCUR4(:, i)));
S(6, i) = nanmean(abs(obs(:, i) - qdmCUR4(:, i)));

end 

CellName = {'rawRMSD', 'qdmRMSD', 'rawR2', 'qdmR2', 'rawMAE', 'qdmMAE'}';
Ta= round(S(:, 1), 2);
RH = round(S(:, 2), 2);
U = round(S(:, 3), 2);
SWin = round(S(:, 4), 2);
LWin =round( S(:, 5), 2);
P = round(S(:, 6), 2);
clear stat_Cell4
stat_Cell4 = table(CellName, Ta, RH, U, SWin, LWin, P)
writetable(stat_Cell4, 'D:\FuturePeyto\fig\A2b\Table_RMSE_RawQDM_Cell4.csv')

figure
plot (cumsum(obs(71353:end, 6))); hold on; plot (cumsum(qdmCUR4(71353:end, 6)));
plot (cumsum(rawCUR4(71353:end, 6)));
%% Plot 3: Monthly time series for each variables
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
x = timetable(CURtime, squeeze(rawCUR4(:, 1:5))); xx = retime(x, 'monthly', 'mean');
rawCURm = table2array(xx); %
x = timetable(CURtime, squeeze(qdmCUR4(:, 1:5))); xx = retime(x, 'monthly', 'mean');
qdmCURm = table2array(xx); %Temperature raw cell monthly : Trcm
tm= xx.CURtime;
% Annual sum for precip
x = timetable(CURtime, squeeze(rawCUR4(:, 6))); xx = retime(x, 'yearly', 'sum');
rawPy = table2array(xx);
x = timetable(CURtime, squeeze(qdmCUR4(:, 6))); xx = retime(x, 'yearly', 'sum');
qdmPy = table2array(xx);
ty = xx.CURtime;
clear x xx 

% Temperature
fig = figure('units','inches','position',[0 0 8 3]); 
p1 = plot(tm, rawCURm(:,1),  'r', 'linewidth', .5); hold on
p2 = plot(tm, qdmCURm(:,1), 'b', 'linewidth', .5); hold on
p3 = plot(mettimem, metm(:, 1), 'k', 'linewidth', 1)
legend ([p1(1) p2(1) p3(1)], 'raw WRF','qdm WRF', 'AWS', 'Orientation', 'Horizontal', 'Location', 'North');
ylim([-22 20])
ylabel ('Monthly mean temperature (C)')
tightfig(fig)
figname = 'TemperatureTS_raw_qdm_Cell4_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A2b\', figname))

% Ea
fig = figure('units','inches','position',[0 0 8 3]); 
p1 = plot(tm, rawCURm(:,2),  'r', 'linewidth', .5); hold on
p2 = plot(tm, qdmCURm(:,2), 'b', 'linewidth', .5); hold on
p3 = plot(mettimem, metm(:, 2), 'k', 'linewidth', 1)
legend ([p1(1) p2(1) p3(1)], 'raw WRF','qdm WRF', 'AWS', 'Orientation', 'Horizontal', 'Location', 'North');
ylim([0 1])
ylabel ('Monthly mean vapor pressure (hpa)')
tightfig(fig)
figname = 'VaporPressureTS_raw_qdm_Cell4_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A2b\', figname))

% U
fig = figure('units','inches','position',[0 0 8 3]); 
p1 = plot(tm, rawCURm(:,3),  'r', 'linewidth', .5); hold on
p2 = plot(tm, qdmCURm(:,3), 'b', 'linewidth', .5); hold on
p3 = plot(mettimem, metm(:, 3), 'k', 'linewidth', 1)
legend ([p1(1) p2(1) p3(1)], 'raw WRF','qdm WRF', 'AWS', 'Orientation', 'Horizontal', 'Location', 'North');
ylim([2 12])
ylabel ('Wind Speed (m/s)')
tightfig(fig)
figname = 'WindSpeedTS_raw_qdm_Cell4_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A2b\', figname))

% SW
fig = figure('units','inches','position',[0 0 8 3]); 
p1 = plot(tm, rawCURm(:,4),  'r', 'linewidth', .5); hold on
p2 = plot(tm, qdmCURm(:,4), 'b', 'linewidth', .5); hold on
p3 = plot(mettimem, metm(:, 4), 'k', 'linewidth', 1)
legend ([p1(1) p2(1) p3(1)], 'raw WRF','qdm WRF', 'AWS', 'Orientation', 'Horizontal', 'Location', 'North');
ylim([0 500])
ylabel ('Monthly mean SWin (Wm-2)')
tightfig(fig)
figname = 'SWinTS_raw_qdm_Cell4_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A2b\', figname))

% LW
fig = figure('units','inches','position',[0 0 8 3]); 
p1 = plot(tm, rawCURm(:,5),  'r', 'linewidth', .5); hold on
p2 = plot(tm, qdmCURm(:,5), 'b', 'linewidth', .5); hold on
p3 = plot(mettimem, metm(:, 5), 'k', 'linewidth', 1)
legend ([p1(1) p2(1) p3(1)], 'raw WRF','qdm WRF', 'AWS', 'Orientation', 'Horizontal', 'Location', 'North');
ylim([180 330])
ylabel ('Monthly mean LWin (Wm-2)')
tightfig(fig)
figname = 'LWinTS_raw_qdm_Cell4_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A2b\', figname))

% Precipitation
fig = figure('units','inches','position',[0 0 8 3]); 
subplot (2,1,1);
bar(ty, [rawPy metp_year]); hold on
ylim ([0 2200]);
title ('raw WRF Cell')
ylabel ('Annual p (mm)')
subplot (2,1,2);
bar(ty, [qdmPy metp_year]); hold on
legend ('cell 5', 'AWS', 'Orientation', 'Horizontal', 'Location', 'North');
ylim ([0 2200]);
title ('Wrf cell QDM to Peyto AWS')
ylabel ('Annual p (mm)')
figname = 'PrecipitationBar_raw_qdm_Cell4_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A2b\', figname))
%
close all

%% As cumulative values
% reshape into 15x365
clear  t d VarOut VarA 
time = CURtime;
var1 = rawCUR4;
var2 = qdmCUR4;
var3 = obs;

for ii = 1:6
for i = 1:15
    if i <9 % 2000-2008
a = find(time == strcat('01-Oct-200', num2str(i)));
b = find (time == strcat('30-Sep-200', num2str(i+1)));
t = time (a:b);
d1 = var1(a:b, ii);
d2 = var2(a:b, ii);
d3 = var3(a:b, ii);
if length (t) > 8737 % remove Feb 29
    t1 = find(t == datetime(strcat('29-Feb-200', num2str(i+1), ' 00:00')));
    t2 = find(t == datetime(strcat('29-Feb-200', num2str(i+1), ' 23:00')));
    d1(t1:t2) = [];
    d2(t1:t2) = [];
    d3(t1:t2) = [];
end 
Var1(:, i) = d1;
Var2(:, i) = d2;
Var3(:, i) = d3;
    end
    
 if i == 9 % 2009 % not a leap year
a = find(time == strcat('01-Oct-200', num2str(i)));
b = find (time == strcat('30-Sep-20', num2str(i+1)));
t = time (a:b);
d1 = var1(a:b, ii);
d2 = var2(a:b, ii);
d3 = var3(a:b, ii);

Var1(:, i) = d1;
Var2(:, i) = d2;
Var3(:, i) = d3;
end 
 
if i > 9 & i < 14 % 2014
a = find(time == strcat('01-Oct-20', num2str(i)));
b = find (time == strcat('30-Sep-20', num2str(i+1)));
t = time (a:b);
d1 = var1(a:b, ii);
d2 = var2(a:b, ii);
d3 = var3(a:b, ii);
if length (t) > 8737 % remove Feb 29
    t1 = find(t == datetime(strcat('29-Feb-20', num2str(i+1), ' 00:00')));
    t2 = find(t == datetime(strcat('29-Feb-20', num2str(i+1), ' 23:00')));
    d1(t1:t2) = [];
    d2(t1:t2) = [];
    d3(t1:t2) = [];
end 
Var1(:, i) = d1;
Var2(:, i) = d2;
Var3(:, i) = d3;
end 
    
if i == 14 % 2010-2013
a = find(time == strcat('01-Oct-20', num2str(i)));
b = find (time == strcat('27-Sep-20', num2str(i+1)));
t = time (a:b);
d1 = var1(a:b, ii);
d2 = var2(a:b, ii);
d3 = var3(a:b, ii);

if length (t) > 8737 % remove Feb 29
    t1 = find(t == datetime(strcat('29-Feb-20', num2str(i+1), ' 00:00')));
    t2 = find(t == datetime(strcat('29-Feb-20', num2str(i+1), ' 23:00')));
    d1(t1:t2) = [];
    d2(t1:t2) = [];
    d3(t1:t2) = [];
end 

% pad with nan
pad = 8737 - length(d1);
d1 = [d1; nan(pad,1)];
Var1(:, i) = d1;
d2 = [d2; nan(pad,1)];
Var2(:, i) = d2;
d3 = [d3; nan(pad,1)];
Var3(:, i) = d3;
    end 
end 
Var1compiled(:,:,ii) = Var1;
Var2compiled(:,:,ii) = Var2;
Var3compiled(:,:,ii) = Var3;
end 

clear Var1 var1 Var2 var2 Var3 var3
for i = 1:6;
Var1Cum(:,:,i)= cumsum(Var1compiled(:, :, i));
Var2Cum(:,:,i)= cumsum(Var2compiled(:, :, i));
Var3Cum(:,:,i)= cumsum(Var3compiled(:, :, i));
end 
S = size(Var1Cum);
Var1rsp = reshape(Var1Cum,[S(1)*S(2),S(3)]);
Var2rsp = reshape(Var2Cum,[S(1)*S(2),S(3)]);
Var3rsp = reshape(Var3Cum,[S(1)*S(2),S(3)]);

timersh = datetime('01-Oct-2000 01:00:00'): hours(1):datetime('01-Oct-2000 01:00:00')+hours(122317)'; 
timersh = timersh';
lab = {'Ta', 'Ea', 'U', 'SWin', 'LWin', 'P'}
for i = 1:6
fig = figure('units','inches','position',[0 0 8 3]);
plot(timersh, Var1rsp(:, i), 'r', 'linewidth', 1.5); hold on
plot(timersh, Var2rsp(:, i), 'b', 'linewidth', 1.5);
plot(timersh, Var3rsp(:,i), ':k', 'linewidth', 1.5);
ylabel (lab{i})
 set(findall(gcf,'-property','FontSize'),'FontSize',12)

legend ('rawWRF', 'qdmWRF','AWS',  'Orientation', 'Horizontal', 'location', 'NorthWest')
tightfig(fig)

saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2b\', lab{i}, '_CumYr_Cell4_RawQDMMET.pdf'));
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2b\', lab{i}, '_CumYr_Cell4_RawQDMMET'));
savefig(gcf, strcat( 'D:\FuturePeyto\fig\A2b\', lab{i}, '_CumYr_Cell4_RawQDMMET'));
end 
close all

%% Change ea to RH
clear var1
time = CURtime;
var1 = rawCUR4(:, 1); % temp
for ii = 1:length(time)
    % saturated vapour pressure from air temperature
    if var1(ii, 1) > 0 
        estar_ctl(ii,1) = 0.611 * exp((17.27 * var1(ii, 1)) ./ (var1(ii, 1)+ 237.3)); % kPa
    else
        estar_ctl(ii,1) = 0.611 * exp((21.88 *var1(ii, 1)) ./ (var1(ii, 1) + 265.5));
    end
end    
rh_var1=  (rawCUR4(:, 2)./ estar_ctl)* 100;%relative humdiity
% remove values above 100 and <1 (it causes CRHM to bug)
for ii = 1:length(time)
% check for bad rh, including when rh > 100 and rh < 0  
    if rh_var1(ii) > 100 
        rh_var1(ii) = 100;
    else if rh_var1(ii) < 1
        rh_var1(ii) = 5;
    end
end
end
rh_rawCUR4= rh_var1; % replace RH in data

% qdm CUR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear var1
time = CURtime;
var1 = qdmCUR4(:, 1); % temp
for ii = 1:length(time)
    % saturated vapour pressure from air temperature
    if var1(ii, 1) > 0 
        estar_ctl(ii,1) = 0.611 * exp((17.27 * var1(ii, 1)) ./ (var1(ii, 1)+ 237.3)); % kPa
    else
        estar_ctl(ii,1) = 0.611 * exp((21.88 *var1(ii, 1)) ./ (var1(ii, 1) + 265.5));
    end
end    
rh_var1=  (qdmCUR4(:, 2)./ estar_ctl)* 100;%relative humdiity
% remove values above 100 and <1 (it causes CRHM to bug)
for ii = 1:length(time)
% check for bad rh, including when rh > 100 and rh < 0  
    if rh_var1(ii) > 100 
        rh_var1(ii) = 100;
    else if rh_var1(ii) < 1
        rh_var1(ii) = 5;
    end
end
end
rh_qdmCUR4= rh_var1; % replace RH in data

% MET
clear var1
time = CURtime;
var1 = obs(:, 1); % temp
for ii = 1:length(time)
    % saturated vapour pressure from air temperature
    if var1(ii, 1) > 0 
        estar_ctl(ii,1) = 0.611 * exp((17.27 * var1(ii, 1)) ./ (var1(ii, 1)+ 237.3)); % kPa
    else
        estar_ctl(ii,1) = 0.611 * exp((21.88 *var1(ii, 1)) ./ (var1(ii, 1) + 265.5));
    end
end    
rh_var1=  (obs(:, 2)./ estar_ctl)* 100;%relative humdiity
% remove values above 100 and <1 (it causes CRHM to bug)
for ii = 1:length(time)
% check for bad rh, including when rh > 100 and rh < 0  
    if rh_var1(ii) > 100 
        rh_var1(ii) = 100;
    else if rh_var1(ii) < 1
        rh_var1(ii) = 5;
    end
end
end
rh_obs= rh_var1; % replace RH in data

% Time serie pot
fig = figure('units','inches','position',[0 0 8 3]); 
plot(CURtime, rh_obs);
hold on
plot(CURtime, rh_rawCUR4);
plot(CURtime, rh_qdmCUR4);

% Montlhy rwelatve humidity
x = timetable(CURtime, squeeze(rh_rawCUR4)); xx = retime(x, 'monthly', 'mean');
rawCURRH = table2array(xx); %
x = timetable(CURtime, squeeze(rh_qdmCUR4)); xx = retime(x, 'monthly', 'mean');
qdmCURRH = table2array(xx); %Temperature raw cell monthly : Trcm
tm= xx.CURtime;
x = timetable(obstime, rh_obs);
xx = retime(x, 'monthly', 'mean');
RHm = table2array(xx);
mettimem = xx.obstime;

fig = figure('units','inches','position',[0 0 8 3]); 
p1 = plot(tm, rawCURRH,  'r', 'linewidth', .5); hold on
p2 = plot(tm, qdmCURRH , 'b', 'linewidth', .5); hold on
p3 = plot(mettimem, RHm, 'k', 'linewidth', 1)
legend ([p1(1) p2(1) p3(1)], 'raw WRF','qdm WRF', 'AWS', 'Orientation', 'Horizontal', 'Location', 'South');
ylim([30 100])
ylabel ('Monthly mean relative humidity (%)')
tightfig(fig)
figname = 'RelativeHumidityTS_raw_qdm_Cell4_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A2b\', figname))

%%
% plot
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
% c2 = [0 0 153]/255;%dark blue
crl =[0.5 0.5 0.5];

fig = figure('units','inches','position',[0 0 8 6]); 
subplot (2,2,1)
scatter(rh_obs, rh_rawCUR4, ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(rh_obs, rh_qdmCUR4, ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
grid on
ylabel ('WRF, RH (%)'); xlabel('MET, RH(%)')
legend ('raw', 'qdm');
title ('ea MET vs WRF')

subplot (2,2,2)
scatter(obs(:, 2), rawCUR4(:, 2), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:, 2), qdmCUR4(:, 2), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
grid on
ylabel ('WRF, ea (hpa)'); xlabel('MET, ea (hpa)')
legend ('raw', 'qdm');
title ('RH MET vs WRF')

subplot (2,2,3)
q = qqplot(rh_obs, rh_rawCUR4); grid on; 
set(q(1),'marker','x','markersize',2,'markeredgecolor',c1); set(q(2), 'Color', c1, 'linewidth', 1);set(q(3), 'Color', c1, 'linewidth', 1, 'linestyle', ':'); % dashed line
hold on
rl = refline(1,0);  rl.Color = crl; rl.LineWidth = 1;
qq = qqplot(rh_obs, rh_qdmCUR4); grid on;  
set(qq(1),'marker','x','markersize',1,'markeredgecolor',c2); set(qq(2), 'Color', c2, 'linewidth', 1);set(qq(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
title ('RH, OBS vs WRF')

subplot (2,2,4)
q = qqplot(obs(:, 2), rawCUR4(:, 2)); grid on; 
set(q(1),'marker','x','markersize',2,'markeredgecolor',c1); set(q(2), 'Color', c1, 'linewidth', 1);set(q(3), 'Color', c1, 'linewidth', 1, 'linestyle', ':'); % dashed line
hold on
rl = refline(1,0);  rl.Color = crl; rl.LineWidth = 1;
qq = qqplot(obs(:, 2),qdmCUR4(:, 2)); grid on;  
set(qq(1),'marker','x','markersize',1,'markeredgecolor',c2); set(qq(2), 'Color', c2, 'linewidth', 1);set(qq(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
title ('Ea, MET vs WRF')

figname = 'RH_EA_raw_qdm_Cell4_withMET';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.pdf'))
saveas (gcf,  strcat( 'D:\FuturePeyto\fig\A2b\', figname, '.png'))
savefig(gcf,  strcat('D:\FuturePeyto\fig\A2b\', figname))


%% export QDM Bias corrected in an CRHM obs Current

% This is the observation file for the "traditionnal way", 
% with only 1 set of observation, corrected to the weather station 
a = datevec(CURtime);
a = a(:,1:5); 

% % Add a year to allow a spin up year in the model
    % create the obs matrix and save it in a mat file
crhmOBS_qdmCUR4= [a qdmCUR4(:, 1) rh_qdmCUR4 qdmCUR4(:, 3:end)]; % compiled time and data together, and save it in a matlab format
pad = crhmOBS_qdmCUR4(1:8760, :);
pad(:, 1) = pad(:, 1) - 1;
crhmOBS_qdmCUR4 = [pad; crhmOBS_qdmCUR4];

fn = strcat('D:\FuturePeyto\dataproc\wrf\A2b_Cell4toCRHMobs\crhmOBS_qdmCUR4.mat');
save (fn, 'crhmOBS_qdmCUR4');  
 % create the obs text file
headerlines = {'Obs file, CUR bc';
              't 1 (C)';
              'rh 1 (%)';
              'u 1 (m/s)';
              'Qsi 1 (W/m2)';
              'Qli 1 (W/m2)';
              'p 1 (mm)';
              '#####'}
fp = strcat('D:\FuturePeyto\dataproc\wrf\A2b_Cell4toCRHMobs\crhmOBS_qdmCUR4.obs');
fid = fopen(fp, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(fp, crhmOBS_qdmCUR4 , '-append', 'delimiter', '\t'); 
%% PGW 
close all
clear all
% load QDM
str = importdata('D:\FuturePeyto\dataproc\wrf\A1d_QDMbiascorrection\MBCn_p_cell4.txt'); qdmPGW4 = str.data;
str = importdata('D:\FuturePeyto\dataproc\wrf\A1d_QDMbiascorrection\MBCn_p_cell5.txt'); qdmPGW5 = str.data;
qdmPGW4(:, 6)=  qdmPGW5(:, 6);

load('D:\FuturePeyto\dataproc\wrf\A1c_exportRawWRFtoCRHMobs\rawWRF_CUR_Cell2.mat')
time = CUR(:, 1:5); 
time(:, 1) = time(:, 1) +84; 
clear CUR

% rh 
% qdm PGW %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear var1
var1 = qdmPGW4(:, 1); % temp
for ii = 1:length(time)
    % saturated vapour pressure from air temperature
    if var1(ii, 1) > 0 
        estar_ctl(ii,1) = 0.611 * exp((17.27 * var1(ii, 1)) ./ (var1(ii, 1)+ 237.3)); % kPa
    else
        estar_ctl(ii,1) = 0.611 * exp((21.88 *var1(ii, 1)) ./ (var1(ii, 1) + 265.5));
    end
end    
rh_var1=  (qdmPGW4(:, 2)./ estar_ctl)* 100;%relative humdiity
% remove values above 100 and <1 (it causes CRHM to bug)
for ii = 1:length(time)
% check for bad rh, including when rh > 100 and rh < 0  
    if rh_var1(ii) > 100 
        rh_var1(ii) = 100;
    else if rh_var1(ii) < 1
        rh_var1(ii) = 5;
    end
end
end
rh_qdmPGW4= rh_var1; % replace RH in data

% This is the observation file for the "traditionnal way", 
% with only 1 set of observation, corrected to the weather station 
    % create the obs matrix and save it in a mat file
  
    %% Export at CRHM
crhmOBS_qdmPGW4= [time qdmPGW4(:, 1) rh_qdmPGW4 qdmPGW4(:, 3:end)]; % compiled time and data together, and save it in a matlab format
pad = crhmOBS_qdmPGW4(1:8760, :)
pad(:, 1) = pad(:, 1) - 1;
crhmOBS_qdmPGW4 = [pad; crhmOBS_qdmPGW4];

fn = strcat('D:\FuturePeyto\dataproc\wrf\A2b_Cell4toCRHMobs\crhmOBS_qdmPGW4.mat');
save (fn, 'crhmOBS_qdmPGW4');  
 % create the obs text file
headerlines = {'Obs file, CUR bc';
              't 1 (C)';
              'rh 1 (%)';
              'u 1 (m/s)';
              'Qsi 1 (W/m2)';
              'Qli 1 (W/m2)';
              'p 1 (mm)';
              '#####'}
fp = strcat('D:\FuturePeyto\dataproc\wrf\A2b_Cell4toCRHMobs\crhmOBS_qdmPGW4.obs');
fid = fopen(fp, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(fp, crhmOBS_qdmPGW4 , '-append', 'delimiter', '\t'); 
