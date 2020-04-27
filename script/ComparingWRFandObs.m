%% Compare WRF and OBS
% edited April 24, 2020

%% Compare WRF, bc-WRF and OBS
 % pick up work here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% OLD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load current wrf
load('D:\FuturePeyto\WRFdataset\CurrentWRF.mat')
wrft = time';
% Change the mixing ratio to saturation vapor pressure
p = squeeze(PSFCcurrent(3,4,:));
T = squeeze(Tcurrent(3,4,:));
r = squeeze(Q2current(3,4,:));

% echange q to ea
  psurf = P .* 0.01 ;                       
  e = r .* psurf ./ (0.378 .* r + 0.622);
  ea =  e .* 0.1 ;

u = sqrt(squeeze(U10current(3,4,:)).^2 + squeeze(V10current(3,4,:)).^2);
% not working

% Making the matrix of T, RH, u, SW, LW
wrfd = [T-273.15 ea u squeeze(SWDOWNcurrent(3,4,:)) squeeze(GLWcurrent(3,4,:)) squeeze(PRECcurrent(3,4,:))];
wrfd = wrfd(8:end, :);
wrft = wrft(8:end);
save ('D:\FuturePeyto\WRFcurrentprocessed.mat', 'wrfd', 'wrft')
clear all
load ('D:\FuturePeyto\WRFcurrentprocessed.mat')

%% Load obs
load('D:\FuturePeyto\Obs\ERAI_20002015.mat')
obst = datetime([time zeros(length(time), 1)]);
e0 = 6.113 ;   % hPa
L = 2.5*10^6; % J kg-1
Rv = 461.5; % J K-1 kg  
Rd = 287.1;  % J K-1 kg 
T0 = 273.15;    % K
T = data(:, 1)+273.15;
RH = data(:, 6);
e = ((e0 * exp (L./Rv * (1/T0 - 1./T))) .* RH./ 100)* 10;

a =  find(obst == wrft(end));
obst = obst(2:a, :);
obsd= [data(2:a, 1) e(2:a, 1) data(2:a, 7) data(2:a, 8) data(2:a, 15) data(2:a, 16)];

clear time data a
save ('D:\FuturePeyto\Obsprocessed.mat', 'obsd', 'obst')

%% Compare both raw variables
clear all
load ('D:\FuturePeyto\WRFcurrentprocessed.mat')
load ('D:\FuturePeyto\Obsprocessed.mat')
load('D:\FuturePeyto\Obs\ObsFiles.mat', 'MNH_MOH_2010_2018', 'MNH_MOHt_2010_2018')
titl={'Air Temperature', 'Vapor Pressure', 'Wind Speed', 'SWin', 'LWin', 'Precip'};
fig = figure('units','inches','outerposition',[0 0 8 11]);

fn = MNH_MOHt_2010_2018;
MNH_MOHt_2010_2018 = datetime([fn zeros(length(fn),1)]);

a = find(wrft == '05-Oct-2010 01:00')
b = find(MNH_MOHt_2010_2018 == '29-Sep-2015 17:00')
wrfd2 = wrfd(a:end, :);
wrft2 = wrft(a:end);
mnht = MNH_MOHt_2010_2018(1:b);
mnhd = MNH_MOH_2010_2018(1:b, :);
save ('D:\FuturePeyto\MNHprocessed.mat', 'mnhd', 'mnht')

xlimit =[-40 30;0 2.5;0 25;0 1100;125 450; 0 10]
ylimit = xlimit;
for i = 1:5
subplot (3,2,i)
scatter (mnhd(:, i), wrfd2(:, i), 1, 'k', 'filled'); hold on
h = lsline
xlim([xlimit(i, :)])
ylim([xlimit(i, :)])
set(h(1),'Color', [0 0 0])
set(h(1), 'Linewidth', 1.5)
rl = refline(1, 0)
set(rl(1), 'Color', [0.5 .5 .5])
set(rl(1), 'Linewidth', 1.5)
a = round(corrcoef(mnhd(:, i), wrfd2(:, i), 'rows', 'pairwise'), 2);
title (strcat(titl{i}, ', r^2 = ', num2str(a(2))))
xlabel ('MNH')
ylabel ('WRF')
end 
%% save figure
tightfig(fig)
filename = 'D:\FuturePeyto\Figure\Fig_MNH_WRF_Bias'
savefig (filename);
saveas (gcf,filename, 'png')
saveas (gcf,filename, 'svg')

for i = 1:6
subplot (3,2,i)
scatter (obsd(:, i), wrfd(:, i), 1, 'k', 'filled'); hold on
h = lsline
xlim([xlimit(i, :)])
ylim([xlimit(i, :)])
set(h(1),'Color', [0 0 0])
set(h(1), 'Linewidth', 1.5)
rl = refline(1, 0)
set(rl(1), 'Color', [0.5 .5 .5])
set(rl(1), 'Linewidth', 1.5)
a = round(corrcoef(obsd(:, i), wrfd(:, i), 'rows', 'pairwise'), 2);
title (strcat(titl{i}, ', r^2 = ', num2str(a(2))))
xlabel ('Bias Corrected ERAi')
ylabel ('WRF')
end 
%% save figure
tightfig(fig)
filename = 'D:\FuturePeyto\Figure\Fig_ERAI_WRF_Bias'
savefig (filename);
saveas (gcf,filename, 'png')
saveas (gcf,filename, 'svg')

%% Also organise the pgw dataset
load('D:\FuturePeyto\WRFdataset\PGWWRF.mat')
% Change the mixing ratio to saturation vapor pressure
p = squeeze(PSFCpgw(3,4,:));
T = squeeze(Tpgw(3,4,:));
r = squeeze(Q2pgw(3,4,:));

% echange q to ea
  psurf = p .* 0.01 ;                       
  e = r .* psurf ./ (0.378 .* r + 0.622);
  ea =  e .* 0.1 ;

u = sqrt(squeeze(U10pgw(3,4,:)).^2 + squeeze(V10pgw(3,4,:)).^2);
% not working

% Making the matrix of T, RH, u, SW, LW
wrfdf = [T-273.15 ea u squeeze(SWDOWNpgw(3,4,:)) squeeze(GLWpgw(3,4,:)) squeeze(PRECpgw(3,4,:))];
wrfdf = wrfdf(8:end, :);
a = datevec(wrft);
a(:, 1) =  a(:, 1) + 85;
wrftf = datetime(a);
save ('D:\FuturePeyto\WRFpgwprocessed.mat', 'wrfdf', 'wrftf')

%%  Save them as table
clear all
load('WRFpgwprocessed.mat')
load('WRFcurrentprocessed.mat')
load('Obsprocessed.mat')
load('MNHprocessed.mat')

obst = mnht;
obsd = mnhd;
Obs = table(obst, obsd);
writetable(Obs,'D:\FuturePeyto\BiasCorrection\Obs.csv')

Mnh = table(mnht, mnhd);
writetable(Mnh,'D:\FuturePeyto\BiasCorrection\Mnh.csv')

Cur = table(wrft, wrfd);
writetable(Cur,'D:\FuturePeyto\BiasCorrection\Cur.csv')

Pgw = table(wrftf, wrfdf);
writetable(Pgw,'D:\FuturePeyto\BiasCorrection\Pgw.csv')
%% Seasonal does not improve perfomance %%
% %% Save them as summer and winter table
% clear all
% load('WRFpgwprocessed.mat')
% load('Obsprocessed.mat')
% yrid = {'01','02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15'}
% for i = 1:length(obst);
%     a = find(obst == strcat('01-Jul-20', yrid{i}))
%     b = find(obst == strcat('15-Sep-20', yrid{i}))
%  X = obsd(a:b, :);
%  T = obst(a:b);
% 
%   if i == 1
%     obsd_summer= X; 
%     obst_summer = T; 
%   else
%     obsd_summer= [obsd_summer; X];
%     obst_summer =[obst_summer;T];
%     
%   end 
% end 
% 
% %% Summer only (nana for rest)// OBS
% yrid = {'00', '01','02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15'}
% Y1 = obsd;
% Y2 = wrfd;
% Y3 = wrfdf;
% for i = 1:length(yrid)-1;
%     if i == 1
%         a = find(obst == '01-Oct-2000 01:00')
%         b = find(obst == strcat('30-Jun-20', yrid{i+1}, ' 23:00'))
%         Y1(a:b, :) = nan; 
%         Y2(a:b, :) = nan;
%         Y3(a:b, :) = nan;
%     elseif i == 15
%     a = find(obst == strcat('1-Sep-20', yrid{i}, ' 00:00'))
%     b = find(obst == strcat('30-Jun-20', yrid{i+1}, ' 23:00'))
%         Y1(a:b, :) = nan; 
%         Y2(a:b, :) = nan;
%         Y3(a:b, :) = nan;
%     a = find(obst == strcat('1-Sep-20', yrid{i+1}, ' 23:00'))
%     b = find(obst == '29-Sep-2015 17:00')
%      	Y1(a:b, :) = nan; 
%         Y2(a:b, :) = nan;
%         Y3(a:b, :) = nan;
%     else
%     a = find(obst == strcat('1-Sep-20', yrid{i}, ' 00:00'))
%     b = find(obst == strcat('30-Jun-20', yrid{i+1}, ' 23:00'))
%     	Y1(a:b, :) = nan; 
%         Y2(a:b, :) = nan;
%         Y3(a:b, :) = nan;
%     end
% end 
% plot (X, Y(:, 1))
% xlim([X(1) X(end)])
% %% Winter only (summer as nan)
% yrid = {'01','02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15'}
% Y1w = obsd;
% Y2w = wrfd;
% Y3w = wrfdf;
% 
% for i = 1:length(yrid);
%         a = find(obst == strcat('01-Jul-20', yrid{i}, ' 00:00'))
%         b = find(obst == strcat('31-Aug-20', yrid{i}, ' 23:00'))
%         Y1w(a:b, :) = nan;
%         Y2w(a:b, :) = nan;
%         Y3w(a:b, :) = nan;
% end
%    %% 
% plot (obst, Ywin(:, 1));
% hold on
% plot (obst,Y(:, 1));
% %% export seasonal table
% %summer
% obsd = Y1;
% Obs = table(obst, Y1);
% writetable(Obs,'D:\FuturePeyto\BiasCorrection\Obs_summer.csv')
% 
% Cur = table(wrft, Y2);
% writetable(Cur,'D:\FuturePeyto\BiasCorrection\Cur_summer.csv')
% 
% Pgw = table(wrftf, Y3);
% writetable(Pgw,'D:\FuturePeyto\BiasCorrection\Pgw_summer.csv')
% % winter
% Obs = table(obst, Y1w);
% writetable(Obs,'D:\FuturePeyto\BiasCorrection\Obs_winter.csv')
% 
% Cur = table(wrft, Y2w);
% writetable(Cur,'D:\FuturePeyto\BiasCorrection\Cur_winter.csv')
% 
% Pgw = table(wrftf, Y3w);
% writetable(Pgw,'D:\FuturePeyto\BiasCorrection\Pgw_winter.csv')

%% Perform quantile mapping
% in R

% %% Import result for the seasonal table
% load('D:\FuturePeyto\BiasCorrection\WRFbc_current_winter.mat')
% load('D:\FuturePeyto\BiasCorrection\WRFbc_current_summer.mat')
% load('Obsprocessed.mat')
% yrid = {'01','02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15'}
% Y = nan(length(obsd), 6);
% for i = 1:length(yrid);
%         a = find(obst == strcat('01-Jul-20', yrid{i}, ' 00:00'))
%         b = find(obst == strcat('31-Aug-20', yrid{i}, ' 23:00'))
%         Y(a:b, :) = Wrfbc_current_summer(a:b, :);
% end
% yrid = {'00', '01','02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15'}
% for i = 1:length(yrid)-1;
%     if i == 1
%         a = find(obst == '01-Oct-2000 01:00')
%         b = find(obst == strcat('30-Jun-20', yrid{i+1}, ' 23:00'))
%         Y(a:b, :) = WRFbc_current_winter(a:b, :);
% 
%     elseif i == 15
%     a = find(obst == strcat('1-Sep-20', yrid{i}, ' 00:00'))
%     b = find(obst == strcat('30-Jun-20', yrid{i+1}, ' 23:00'))
%         Y(a:b, :) =  WRFbc_current_winter(a:b, :); 
% 
%     a = find(obst == strcat('1-Sep-20', yrid{i+1}, ' 23:00'))
%     b = find(obst == '29-Sep-2015 17:00')
%      	Y(a:b, :) = nan; 
% 
%     else
%     a = find(obst == strcat('1-Sep-20', yrid{i}, ' 00:00'))
%     b = find(obst == strcat('30-Jun-20', yrid{i+1}, ' 23:00'))
%     	Y(a:b, :) =  WRFbc_current_winter(a:b, :); 
%     end
% end 
% figure;
% plot(obst, obsd(:, 1)); hold on
% plot(obst, Y(:, 1));
% plot(obst, wrfd(:, 1));
% plot(obst, wrfd_corr(:, 1));
% legend ('OBS', 'season BC', 'WRF raw', 'WRF BC')
% 
% figure; scatter(obsd(:, 1), Y(:, 1)); lsline; refline(1, 0); 
% figure; scatter(obsd(:, 1), wrfd(:, 1)); lsline; refline(1, 0); 
% figure; scatter(obsd(:, 1), wrfd_corr(:, 1)); lsline; refline(1, 0); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Import MNH abd WRF, current
load('D:\FuturePeyto\BiasCorrection\WRFcurrentprocessed.mat')
load ('D:\FuturePeyto\Obs\MNHprocessed.mat')
load('D:\FuturePeyto\BiasCorrection\WrfCurrent_corrected_mnh.mat')

load('D:\FuturePeyto\BiasCorrection\WRFpgwprocessed.mat')
load('D:\FuturePeyto\Obs\Obsprocessed.mat')
load('D:\FuturePeyto\BiasCorrection\WrfCurrent_corrected.mat')
load('D:\FuturePeyto\BiasCorrection\WrfCPGW_corrected_mnh.mat')
a = find(wrft == '05-Oct-2010 01:00')
wrfd2 = wrfd(a:end, :);
wrft2 = wrft(a:end);
wrfd2_corr = WRFcurbiascorrectedmnh(a:end, :);


%% Plotting WRF corrected and Raw vs MNH

titl={'Air Temperature', 'Vapor Pressure', 'Wind Speed', 'SWin', 'LWin', 'Precip'};
fig = figure('units','inches','outerposition',[0 0 8 11]);
clear h

for i = 1:5
subplot (3,2,i)
scatter (mnhd(:, i), wrfd2(:, i), 1, 'k', 'filled'); hold on
scatter (mnhd(:, i), wrfd2_corr(:, i), 1, [100 100 100]./255, 'filled'); hold on
h = lsline
% xlim([xlimit(i, :)])
% ylim([xlimit(i, :)])

set(h(1),'color', [0 76 153]./255)
set(h(2),'Color', [0 0 0])
set(h(1), 'Linewidth', 1.5)
set(h(2), 'Linewidth', 1.5)
rl = refline(1, 0)
set(rl(1), 'Color', [0.5 .5 .5])
set(rl(1),'Linewidth', 1.5)
a = round(corrcoef(mnhd(:, i), wrfd2_corr(:, i), 'rows', 'pairwise'), 2);
 b = round(sqrt(nanmean((mnhd(:, i) - wrfd2_corr(:, i)).^2)), 2)
 c  = round(sqrt(nanmean((mnhd(:, i) - wrfd2(:, i)).^2)), 2)
title (strcat(titl{i}, ', r^2 = ', num2str(a(2)), ', RMSE raw = ', num2str(c), ', RMSEcorr = ',num2str(b)))
xlabel ('MNH')
ylabel ('WRF')

clear h
end 
legend ('Raw', 'Bias Corrected')
tightfig(fig)
filename = 'D:\FuturePeyto\Fig_MNH_WRF_RAW_BiasCorrectedQM'
savefig (filename);
saveas (gcf,filename, 'png')
saveas (gcf,filename, 'svg')
%% PLot MNH and WRF corr
close all
titl={'Air Temperature (^{\circ}C)', 'Vapor Pressure(hPa)', 'Wind Speed (ms^{-1})', 'SWin (Wm^{-2})', 'LWin (Wm^{-2})', 'Precip (mm)'};
fig = figure('units','inches','outerposition',[0 0 6 7]);
clear h
xlimit =[-38 27;0 1.2;0 17;0 1200; 100 380;0 5]
%ylab ={'WRF ';'WRF ';'WRF ';'WRF ';'WRF '}

txtloc   = [-35  23;0.05 1.13; 0.5 16; 50 1120;110 365;.2 4.7]
txtloc2  = [-35  16;0.05 1.0; 0.5 14; 50 970;110 330;.2 4]

for i = 1:5

subplot (3,2,i)
scatter (mnhd(:, i), wrfd2_corr(:, i), 1,'k', 'filled'); hold on
h = lsline

 xlim([xlimit(i, :)])
ylim([xlimit(i, :)])
if i ==1 | i==3| i==5
ylabel('WRF')
end 
if i>4
xlabel ('AWS')
end 
set(h(1),'color', 'k','Linewidth', 1.5)
rl = refline(1, 0)
set(rl(1), 'Color', [0.5 .5 .5], 'Linestyle', ':','Linewidth', 2)
a = round(corrcoef(mnhd(:, i), wrfd2_corr(:, i), 'rows', 'pairwise'), 2);
 b = round(sqrt(nanmean((mnhd(:, i) - wrfd2_corr(:, i)).^2)), 1)
 text(txtloc2(i,1), txtloc2(i, 2),strcat('RMSE = ', num2str(b)), 'Fontsize', 14, 'Color', [153 0 0]/255 ,'FontWeight', 'bold')
 text(txtloc(i,1), txtloc(i, 2),strcat( 'r = ', num2str(a(2))), 'Fontsize', 14, 'Color',[153 0 0]/255 ,'FontWeight', 'bold')

 title (strcat(titl{i}), 'Fontweight', 'normal')
set(gca, 'Fontsize', 14)
box on
clear h
    end 

i =6
subplot (3,2,i)
    scatter (obsd(:, i), wrfd_corr(:, i), 1, [100 100 100]./255, 'filled'); hold on
    h = lsline
    xlim([xlimit(i, :)])
ylim([xlimit(i, :)])

    set(h(1),'color', 'k','Linewidth', 1.5)
rl = refline(1, 0)
set(rl(1), 'Color', [0.5 .5 .5], 'Linestyle', ':','Linewidth', 2)
a = round(corrcoef(obsd(:, i), wrfd_corr(:, i), 'rows', 'pairwise'), 2);
 b = round(sqrt(nanmean(obsd(:, i)- wrfd_corr(:, i).^2)), 1)
 text(txtloc2(i,1), txtloc2(i, 2),strcat('RMSE = ', num2str(b)), 'Fontsize', 14, 'Color', [153 0 0]/255 ,'FontWeight', 'bold')
 text(txtloc(i,1), txtloc(i, 2),strcat( 'r = ', num2str(a(2))), 'Fontsize', 14, 'Color',[153 0 0]/255 ,'FontWeight', 'bold')
xlabel ('Bow Summit')
 title (strcat(titl{i}), 'Fontweight', 'normal')
set(gca, 'Fontsize', 14)
box on
clear h

tightfig(fig)

filename = 'D:\FuturePeyto\Fig_MNH_WRF_BiasCorrectedQM'
savefig (filename);
saveas (gcf,filename, 'png')
saveas (gcf,filename, 'svg')
%% PLot MNH and WRF RAW
titl={'Air Temperature', 'Vapor Pressure', 'Wind Speed', 'SWin', 'LWin', 'Precip'};
fig = figure('units','inches','outerposition',[0 0 8 11]);
clear h

for i = 1:5
subplot (3,2,i)
scatter (mnhd(:, i), wrfd2(:, i), 1, 'k', 'filled'); hold on
h = lsline
% xlim([xlimit(i, :)])
% ylim([xlimit(i, :)])

set(h(1),'color', [0 76 153]./255)
set(h(1), 'Linewidth', 1.5)
rl = refline(1, 0)
set(rl(1), 'Color', [0.5 .5 .5])
set(rl(1),'Linewidth', 1.5)
a = round(corrcoef(mnhd(:, i), wrfd2_corr(:, i), 'rows', 'pairwise'), 2);
 b = round(sqrt(nanmean((mnhd(:, i) - wrfd2_corr(:, i)).^2)), 2)
 c  = round(sqrt(nanmean((mnhd(:, i) - wrfd2(:, i)).^2)), 2)
title (strcat(titl{i}, ', r^2 = ', num2str(a(2)), ', RMSE raw = ', num2str(c), ', RMSEcorr = ',num2str(b)))
xlabel ('MNH')
ylabel ('WRF')

clear h
end 
legend ('Raw')
tightfig(fig)
filename = 'D:\FuturePeyto\Fig_MNH_WRFraw'
savefig (filename);
saveas (gcf,filename, 'png')
saveas (gcf,filename, 'svg')

%%
a = find(wrfd2_corr(:, 4)<=6);
wrfd3_corr(a) = 0;
% With Obs form ERA
titl={'Air Temperature', 'Vapor Pressure', 'Wind Speed', 'SWin', 'LWin', 'Precip'};
fig = figure('units','inches','outerposition',[0 0 8 11]);
clear h

for i = 1:6
subplot (3,2,i)
scatter (obsd(:, i), wrfd(:, i), 1, 'k', 'filled'); hold on
scatter (obsd(:, i), wrfd_corr(:, i), 1, [0 76 153]./255, 'filled'); hold on
h = lsline
% xlim([xlimit(i, :)])
% ylim([xlimit(i, :)])

set(h(1),'color', [0 76 153]./255)
set(h(2),'Color', [0 0 0])
set(h(1), 'Linewidth', 1.5)
set(h(2), 'Linewidth', 1.5)
rl = refline(1, 0)
set(rl(1), 'Color', [0.5 .5 .5])
set(rl(1),'Linewidth', 1.5)
a = round(corrcoef(obsd(:, i), wrfd_corr(:, i), 'rows', 'pairwise'), 2);
 b = round(sqrt(nanmean((obsd(:, i) - wrfd_corr(:, i)).^2)), 2)
 c  = round(sqrt(nanmean((obsd(:, i) - wrfd(:, i)).^2)), 2)
title (strcat(titl{i}, ', r^2 = ', num2str(a(2)), ', RMSEraw = ', num2str(c), ', RMSEcorr = ',num2str(b)))

xlabel ('Bias Corrected ERAi')
ylabel ('WRF')

clear h
end 
legend ('Raw', 'Bias Corrected')
%% save figure
tightfig(fig)
filename = 'D:\FuturePeyto\Fig_ERAI_WRFrawAndWRFBiasCorrected'
savefig (filename);
saveas (gcf,filename, 'png')
saveas (gcf,filename, 'svg')
%% Plot WRF bias corrected and MNH
load('D:\FuturePeyto\BiasCorrection\WRFpgwprocessed.mat')
load('D:\FuturePeyto\Obs\Obsprocessed.mat')
load('D:\FuturePeyto\BiasCorrection\WrfCurrent_corrected.mat')
load('D:\FuturePeyto\BiasCorrection\WrfCPGW_corrected_mnh.mat')
% with mnh

%% Just WRF corrected
titl={'Air Temperature', 'Vapor Pressure', 'Wind Speed', 'SWin', 'LWin', 'Precip'};
fig = figure('units','inches','outerposition',[0 0 8 11]);
clear h
for i = 1:6
subplot (3,2,i)
scatter (obsd(:, i), wrfd_corr(:, i), 1, [0 76 153]./255, 'filled'); hold on
h = lsline
% xlim([xlimit(i, :)])
% ylim([xlimit(i, :)])

set(h(1),'color', [0 76 153]./255)
set(h(1), 'Linewidth', 1.5)
rl = refline(1, 0)
set(rl(1), 'Color', [0.5 .5 .5])
set(rl(1),'Linewidth', 1.5)
a = round(corrcoef(obsd(:, i), wrfd_corr(:, i), 'rows', 'pairwise'), 2);
title (strcat(titl{i}, ', r^2 = ', num2str(a(2))))
xlabel ('Bias Corrected ERAi')
ylabel ('WRF')

clear h
end 
legend ('Raw', 'Bias Corrected')
% seems that for LW. mean bias might be a better?


% save figure
tightfig(fig)
filename = 'D:\FuturePeyto\Fig_ERAI_WRFBiasCorrected'
savefig (filename);
saveas (gcf,filename, 'png')
saveas (gcf,filename, 'svg')

%%
figure;
subplot (2,1,1)
plot (obst, obsd(:, 1)); hold on
plot(wrft, wrfd(:, 1))
plot(wrft,wrfd_corr(:, 1))

subplot (2,1,2)
plot (obst, obsd(:, 1)); hold on
plot(wrft, wrfdf(:, 1))
plot(wrft,wrfdf_corr(:, 1))

%%
tightfig(fig)
filename = 'D:\FuturePeyto\Fig_ERAI_WRF_BiasCorrectedQM'
savefig (filename);
saveas (gcf,filename, 'png')
saveas (gcf,filename, 'svg')

%% In a more visual timeseries ways
load('D:\FuturePeyto\BiasCorrection\WrfCurrent_corrected.mat')
load ('D:\FuturePeyto\WRFcurrentprocessed.mat')
load ('D:\FuturePeyto\Obsprocessed.mat')

plot (obst, obsd(:, 5));
hold on
plot (wrft, wrfd(:, 5));
plot(wrft, wrfd_corr(:, 1));

%% Export the wrf current in an obs format
load('WRFpgwprocessed.mat', 'wrftf')
load('WRFcurrentprocessed.mat', 'wrft')
load('WRFcurrentprocessed.mat', 'wrfd')
 load('WRFpgwprocessed.mat', 'wrfdf')
% change datetime to obs format
a = datevec(wrft);
a = a(:, 1:5);
WRF_biasCorrected_ObsFormat = [a WRFcurbiascorrectedmnh(:, 1) WRFcurbiascorrectedmnh(:, 1) WRFcurbiascorrectedmnh(:, 1) WRFcurbiascorrectedmnh(:, 1) WRFcurbiascorrectedmnh(:, 1)...
    WRFcurbiascorrectedmnh(:, 2) WRFcurbiascorrectedmnh(:, 3)...
    WRFcurbiascorrectedmnh(:, 4) WRFcurbiascorrectedmnh(:, 4) WRFcurbiascorrectedmnh(:, 4) WRFcurbiascorrectedmnh(:, 1) WRFcurbiascorrectedmnh(:, 4) WRFcurbiascorrectedmnh(:, 4) WRFcurbiascorrectedmnh(:, 4)...
    WRFcurbiascorrectedmnh(:, 5) wrfd_corr(:, 6)];
% Add the first year twice at the beginning

extradata = [WRF_biasCorrected_ObsFormat(1:8760, :);WRF_biasCorrected_ObsFormat(1:8760, :)];
a = find(wrft == '31-Dec-2000 23:00')
extradata(1:a, 1) = 1998;
b = find(wrft == '31-Dec-2001 23:00')
extradata(a+1:b, 1) = 1999;
c = find(extradata(:, 1) == 2001)
extradata(c,1) = 2000;

extratime = datetime('01-Oct-1998 01:00'):hours(1):datetime('01-Oct-2000 00:00');
x = datetime([extradata(:, 1:5) zeros(length(extradata), 1)]);
b = find(x == '28-Feb-2000 23:00')
extradata_ly = [extradata(1:b, 6:end); extradata(b:b+23, 6:end); extradata(b+1:end, 6:end)]
xx = datevec(extratime);
xx=xx(:, 1:5);
xxx = [xx extradata_ly];
WRF_biasCorrected_ObsFormat = [xxx;WRF_biasCorrected_ObsFormat];


WRF_biasCorrected_ObsFormat = WRF_biasCorrected_ObsFormat(1:148950, :);
% compiled time and data together, and save it in a matlab format
save ('D:\FuturePeyto\WRF_biasCorrected_ObsFormat.mat', 'WRF_biasCorrected_ObsFormat')
% export in obs file format
headerlines = {'Obs file from QMcorrected WRF dataset to MNH';
't	1	(C)'														
'lagT1	1'															
'lagT2	1'															
'lagT3	1'															
'lagT4	1'															
'ea	1	(%)'														
'u	1	(m/s)'														
'Qsi	1	(W/m2)	'													
'lagSW1	1'															
'lagSW2	1'															
'lagSW3	1'															
'lagSW4	1'															
'lagSW5	1'															
'lagSW6	1	'														
'Qli	1	(W/m2)	'													
'p	1 (mm)	'
'$rh	rh(t	ea)	'	
'################	t.1	lagT1.1	lagT2.1	lagT3.1	lagT4.1	ea.1	u.1	Qsi.1	lagSW1.1	lagSW2.1	lagSW3.1	lagSW4.1	lagSW5.1	lagSW6.1	Qli.1	p.1'}
filepath = 'D:\FuturePeyto\Obs\WRFcurrent_corr.obs';
fid = fopen(filepath, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(filepath, WRF_biasCorrected_ObsFormat, '-append', 'delimiter', '\t');  

%% Export the wrf pgw dataset
a = datevec(wrftf);
a = a(:, 1:5);
WRFpgw_biasCorrected_ObsFormat = [a WRFpgwbiascorrectedmnh(:, 1) WRFpgwbiascorrectedmnh(:, 1) WRFpgwbiascorrectedmnh(:, 1) WRFpgwbiascorrectedmnh(:, 1) WRFpgwbiascorrectedmnh(:, 1)...
    WRFpgwbiascorrectedmnh(:, 2) WRFpgwbiascorrectedmnh(:, 3)...
    WRFpgwbiascorrectedmnh(:, 4) WRFpgwbiascorrectedmnh(:, 4) WRFpgwbiascorrectedmnh(:, 4) WRFpgwbiascorrectedmnh(:, 1) WRFpgwbiascorrectedmnh(:, 4) WRFpgwbiascorrectedmnh(:, 4) WRFpgwbiascorrectedmnh(:, 4)...
    WRFpgwbiascorrectedmnh(:, 5) wrfdf_corr(:, 6)];

% add the leap year day
extradata = [WRFpgw_biasCorrected_ObsFormat(1:8760, :);WRFpgw_biasCorrected_ObsFormat(1:8760, :)];
a = find(wrftf == '31-Dec-2085 23:00')
extradata(1:a, 1) = 2083;
b = find(wrftf == '31-Dec-2086 23:00')
extradata(a+1:b, 1) = 2084;
c = find(extradata(:, 1) == 2086)
extradata(c,1) = 2085;

extratime = datetime('01-Oct-2083 01:00'):hours(1):datetime('01-Oct-2085 00:00');
b = find(extratime== '28-Feb-2084 23:00')
x = datetime([extradata(:, 1:5) zeros(length(extradata), 1)]);
b = find(x == '28-Feb-2084 23:00')
extradata_ly = [extradata(1:b, 6:end); extradata(b:b+23, 6:end); extradata(b+1:end, 6:end)]
xx = datevec(extratime);
xx=xx(:, 1:5);
xxx = [xx extradata_ly];
WRFpgw_biasCorrected_ObsFormat = [xxx;WRFpgw_biasCorrected_ObsFormat];

% compiled time and data together, and save it in a matlab format
save ('D:\FuturePeyto\WRFpgw_biasCorrected_ObsFormat.mat', 'WRFpgw_biasCorrected_ObsFormat')
% export in obs file format
headerlines = {'Obs file from QMcorrected WRFpgw dataset to MNH';
't	1	(C)'														
'lagT1	1'															
'lagT2	1'															
'lagT3	1'															
'lagT4	1'															
'ea	1	(%)'														
'u	1	(m/s)'														
'Qsi	1	(W/m2)	'													
'lagSW1	1'															
'lagSW2	1'															
'lagSW3	1'															
'lagSW4	1'															
'lagSW5	1'															
'lagSW6	1	'														
'Qli	1	(W/m2)	'													
'p	1 (mm)	'
'$rh	rh(t	ea)	'													
'################	t.1	lagT1.1	lagT2.1	lagT3.1	lagT4.1	ea.1	u.1	Qsi.1	lagSW1.1	lagSW2.1	lagSW3.1	lagSW4.1	lagSW5.1	lagSW6.1	Qli.1	p.1'}
filepath = 'D:\FuturePeyto\Obs\WRFpgw_corr.obs';
fid = fopen(filepath, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(filepath, WRFpgw_biasCorrected_ObsFormat, '-append', 'delimiter', '\t');  




