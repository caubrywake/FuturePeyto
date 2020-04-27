% % Comparing Peyto Obs and WRF
% % load files
% close all
% clear all
% load('PeytoObs_PERA_20002015.mat')
% % precip is 3 hourly
% 
% % Change RH to vapor pressure e
% e0 = 6.113 ;   % hPa
% L = 2.5*10^6; % J kg-1
% Rv = 461.5; % J K-1 kg  
% Rd = 287.1;  % J K-1 kg 
% T0 = 273.15;    % K
% T = MainOldtRHuQsiHourly1Jan200031Dec2015(:, 1)+273.15;
% RH = MainOldtRHuQsiHourly1Jan200031Dec2015(:, 2);
% e = ((e0 * exp (L./Rv * (1/T0 - 1./T))) .* RH./ 100)* 10;
% e = e/100;
% 
% % common time with WRF: Oct 1, 2000, 1AM to 26 Sep 2015, 5:00
% timep= datetime([time_PERA20002015 zeros(length(time_PERA20002015), 1)]);
% timeobs= datetime([time_1Jan200031Dec2015 zeros(length(time_1Jan200031Dec2015), 1)]);
% a = find(timep == datetime('01-Oct-2000 01:00:00'))
% b = find(timep == datetime('26-Sep-2015 6:00:00'))
% aa = find(timeobs == datetime('01-Oct-2000 01:00:00'))
% bb = find(timeobs == datetime('26-Sep-2015 6:00:00'))
% 
% % Compile into a simplified obs file
% obs = [MainOldtRHuQsiHourly1Jan200031Dec2015(aa:bb,1) e(aa:bb)  MainOldtRHuQsiHourly1Jan200031Dec2015( aa:bb,3:4) P_ERA_20002015(a:b)];
% timeobs = timeobs(aa:bb);
% % save simplified datasets
% save ('D:\FuturePeyto\Obs\V2\obs_p_Peyto_20002015', 'timeobs', 'obs');
% clear all
 load('D:\FuturePeyto\Obs\V2\obs_p_Peyto_20002015.mat')

%% Load the WRF data
% load('D:\FuturePeyto\WRFdataset\CurrentWRF.mat')
% wrft = time';
% % Change the mixing ratio to saturation vapor pressure
% p = squeeze(PSFCcurrent(3,4,:));
% T = squeeze(Tcurrent(3,4,:));
% r = squeeze(Q2current(3,4,:));
% 
% % echange q to ea
%   psurf = p .* 0.01 ;                       
%   e = r .* psurf ./ (0.378 .* r + 0.622);
%   ea =  e .* 0.1 ;
% 
% u = sqrt(squeeze(U10current(3,4,:)).^2 + squeeze(V10current(3,4,:)).^2);
% % not working
% 
% % Making the matrix of T, RH, u, SW, LW
% wrfd = [T-273.15 ea u squeeze(SWDOWNcurrent(3,4,:)) squeeze(GLWcurrent(3,4,:)) squeeze(PRECcurrent(3,4,:))];
% wrfd = wrfd(8:end, :);
% wrft = wrft(8:end);
% save ('D:\FuturePeyto\WRFcurrentprocessed.mat', 'wrfd', 'wrft')
% clear all
load ('D:\FuturePeyto\WRFcurrentprocessed.mat')

%% Compare both raw variables
titl={'Air Temperature', 'Vapor Pressure', 'Wind Speed', 'SWin', 'Precip'};
fig = figure('units','inches','outerposition',[0 0 8 11]);
obs(:, 2) = obs(:, 2) /100;
wrfd2 = wrfd;
wrfd2(:, 5)=[];
%%
xlimit =[-40 30;0 2.5;0 25;0 1100; 0 10]
ylimit = xlimit;
for i = 1:5
subplot (3,2,i)
scatter (obs(:, i), wrfd2(:, i), 1, 'k', 'filled'); hold on
h = lsline
xlim([xlimit(i, :)])
ylim([xlimit(i, :)])
set(h(1),'Color', [0 0 0])
set(h(1), 'Linewidth', 1.5)
rl = refline(1, 0)
set(rl(1), 'Color', 'r')
set(rl(1), 'Linewidth', 1.5)
a = round(corrcoef(obs(:, i), wrfd2(:, i), 'rows', 'pairwise'), 2);
title (strcat(titl{i}, ', r^2 = ', num2str(a(2))))
xlabel ('MNH')
ylabel ('WRF')
end 
%% Compare precipitation on 3 hour basis
% make the precip 3 hourly
%%Make sample data
TT1 = timetable(timeobs,obs(:, 5), wrfd(:, 6));
%%Retime to 30 minute intervals
newTimes = [timeobs(1)-hours(1):hours(3):timeobs(end)];
TT2 = retime(TT1,newTimes,'sum');
p_3hrs=table2array(TT2);
time_3hrs = TT2.timeobs;

% check result
figure
plot (time_3hrs, p_3hrs(:, 1)); hold on
plot(timeobs, obs(:, 5));
figure
scatter(p_3hrs(:, 1), p_3hrs(:,2));hold on
refline(1,0)
lsline
xlim([0 20])
ylim ([0 20])
a = round(corrcoef(p_3hrs(:, 1), p_3hrs(:,2), 'rows', 'pairwise'), 2);
b = a(2)
%% Check daily
TT1 = timetable(time_daily,p_daily);
newTimes = [time_daily(1):days(3):time_daily(end)];

TT2 = retime(TT1,newTimes,'sum');
p_3d=table2array(TT2);
time_3d = TT2.time_daily;

% check result
figure
scatter(p_3d(:, 1), p_3d(:,2));hold on
refline(1,0)
lsline
xlim([0 14])
ylim ([0 14])
a = round(corrcoef(p_3d(:, 1), p_3d(:,2), 'rows', 'pairwise'), 2)

%% Check 3 day sum
TT1 = timetable(time_3hrs,p_3hrs);
TT2 = retime(TT1,'daily','sum');
p_daily=table2array(TT2);
time_daily = TT2.time_daily;

% check result
figure
scatter(p_3d(:, 1), p_3d(:,2));hold on
refline(1,0)
lsline
a = corrcoef(p_3d(:, 1), p_3d(:,2), 'rows', 'pairwise');
b = round(a(1,2), 2)


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
set(rl(1), 'Color', 'r')
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


%% Make some plot of tempreature
figure
plot (timeobs, obs(:, 1));
hold on
plot(timeobs, wrfd(:, 1))
legend ('Obs', 'WRF')

% mean bias
Tbias = mean(obs(1:131406,1)) - mean(wrfd(1:131406, 1))
Tbias = mean(obs(1:131406,1)-wrfd(1:131406, 1))

wrfdmod = wrfd2;
wrfdmod(:, 1) = wrfdmod(:,1) + Tbias;

%%
xlimit =[-40 30;0 2.5;0 25;0 1100; 0 10]
ylimit = xlimit;
for i = 1:4
subplot (2,2,i)
scatter (obs(:, i), wrfdmod(:, i), 1, 'k', 'filled'); hold on
h = lsline
xlim([xlimit(i, :)])
ylim([xlimit(i, :)])
set(h(1),'Color', [0 0 0])
set(h(1), 'Linewidth', 1.5)
rl = refline(1, 0)
set(rl(1), 'Color', 'r')
set(rl(1), 'Linewidth', 1.5)
a = round(corrcoef(obs(:, i), wrfd2(:, i), 'rows', 'pairwise'), 2);
title (strcat(titl{i}, ', r^2 = ', num2str(a(2))))
xlabel ('MNH')
ylabel ('WRF')
end 
figure
plot (timeobs, obs(:, 1));
hold on
plot(timeobs, wrfd(:, 1))
plot(timeobs, wrfdmod(:, 1))
legend ('Obs', 'WRF', 'WRF mod')
