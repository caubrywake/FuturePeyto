%% Compare MET, WRF and WRFbc
% edited April 24, 2020
% This script does a visual comparison of MET data at Peyto, WRF raw and WRF
% bias corrected. 
% The data is first loaded and then graphed in scatter plots and time
% series. 
close all
clear all
%% Step 1: Load data
% MET: Peyto 2000-2015
% manually import 'dataproc\met\ObsPeyto_24042020.obs' and save as matlab format
load('D:\FuturePeyto\dataproc\met\ObsPeyto24042020.mat')
obs = ObsPeyto24042020_data;
obstime = datetime([ObsPeyto24042020_time(:, 1:5) zeros(length(ObsPeyto24042020_time), 1)]);
clear ObsPeyto24042020_data ObsPeyto24042020_time
% WRf raw : already in matlab format
load('D:\FuturePeyto\dataproc\wrf\WRFCur_PGW_24042020.mat', 'CUR', 'PGW')
curtime = datetime([CUR(:, 1:5) zeros(length(CUR), 1)]);
CUR = CUR(:, 6:end);
PGW = PGW(:, 6:end);

% WRF bias corrected
% bias correction occured in R. load individual txt files and assemble
% matrixe
t = importdata('D:\FuturePeyto\dataproc\wrf\t_QDM.txt'); t = t.data;
ea = importdata('D:\FuturePeyto\dataproc\wrf\ea_QDM.txt'); ea = ea.data;
u = importdata('D:\FuturePeyto\dataproc\wrf\u_QDM.txt'); u = u.data;
qsi = importdata('D:\FuturePeyto\dataproc\wrf\Qsi_QDM.txt'); qsi = qsi.data;
qsi(qsi<0)=0; % quick correction of negative SW
qli = importdata('D:\FuturePeyto\dataproc\wrf\Qli_QDM.txt'); qli = qli.data;
p = importdata('D:\FuturePeyto\dataproc\wrf\p_QDM.txt');p = p.data;
CUR_bc =[t(:, 1), ea(:,1),  u(:, 1), qsi(:, 1), qli(:, 1), p(:, 1)];
PGW_bc =[t(:, 2), ea(:,2),  u(:, 2), qsi(:, 2), qli(:,2), p(:, 2)];
clear t ea u qsi qli p eadata

% 5 sets of data
% Observations : MET data form Peyto AWS
% CUR and PGW : WRF raw datasets
% CUR_bc and PGW_bc : WRF ouputs corrected by quantile mapping to the
% observations
%% Scatter plots comparions 

% 1) Compare Current, Current_bc and OBS
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
subplot (3,2,1)
scatter(obs(:,1), CUR(:, 1), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,1), CUR_bc(:, 1), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
xlim([-50 30]); ylim([-50 30]); grid on
a = round(corrcoef(obs(:, 1), CUR(:, 1), 'rows', 'pairwise'), 2);
text(-48, 21, ({'(a) Air Temperature (^{\circ}C)' ;strcat('   r = ', num2str(a(2)))}));xlabel ('OBS')
ylabel ('WRF')
legend ('Original', 'Bias Corrected', 'Best Linear Fit, Original', 'Best Linear Fit, Bias-corrected', '1:1 line', 'Orientation', 'Horizontal')

subplot (3,2,2)
scatter(obs(:,2), CUR(:, 2), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,2), CUR_bc(:, 2), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
xlim([0 2.5]); ylim([0 2.5]); grid on
a = round(corrcoef(obs(:, 2), CUR(:, 2), 'rows', 'pairwise'), 2);
text(.05, 2.2, ({'(b) Specific Humidity (kPa)' ;strcat('   r = ', num2str(a(2)))}));xlabel ('OBS')
ylabel ('WRF')

subplot (3,2,3)
scatter(obs(:,3), CUR(:, 3), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,3), CUR_bc(:, 3), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
xlim([0 25]); ylim([0 25]); grid on
a = round(corrcoef(obs(:, 3), CUR(:, 3), 'rows', 'pairwise'), 2);
text(.5, 22, ({'(c) Wind Speed (m s^{-1})';strcat('   r = ', num2str(a(2)))}));xlabel ('OBS')
ylabel ('WRF')

subplot (3,2,4)
scatter(obs(:,4), CUR(:, 4), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,4), CUR_bc(:, 4), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
xlim([0 1080]); ylim([0 1080]); grid on
a = round(corrcoef(obs(:, 4), CUR(:, 4), 'rows', 'pairwise'), 2);
text(10, 980, ({'(d) SWin (W m^{-2})';strcat('   r = ', num2str(a(2)))}));
xlabel ('OBS'); ylabel ('WRF')

subplot (3,2,5)
scatter(obs(:,5), CUR(:, 5), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,5), CUR_bc(:, 5), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
xlim([50 400]); ylim([50 400]); grid on
a = round(corrcoef(obs(:, 5), CUR(:, 5), 'rows', 'pairwise'), 2);
text(55, 360, ({'(e) LWin (W m^{-2})' ;strcat('   r = ', num2str(a(2)))}));xlabel ('OBS')
ylabel ('WRF')

subplot (3,2,6)
scatter(obs(:,6), CUR(:, 6), ms, 'o','MarkerFaceColor',c1,'MarkerEdgeColor',c1,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
hold on
scatter(obs(:,6), CUR_bc(:, 6), ms, 'o','MarkerFaceColor',c2,'MarkerEdgeColor',c2,...
    'MarkerFaceAlpha',tr1,'MarkerEdgeAlpha',tr2)
h = lsline; h(1).Color = l2; h(2).Color = l1; h(1).LineWidth = hw; h(2).LineWidth = hw; 
rl = refline(1,0); rl.Color = rlc; rl.LineStyle = ':'; rl.LineWidth = rlw;
xlim([0 10]); ylim([0 10]); grid on
a = round(corrcoef(obs(:, 6), CUR(:, 6), 'rows', 'pairwise'), 2);
text(.2, 9, ({'(f) Precipitation (mm)' ;strcat('   r = ', num2str(a(2)))}));xlabel ('OBS')
ylabel ('WRF')
set(findall(gcf,'-property','FontSize'),'FontSize',10)
%% Save figure
saveas (gcf, 'D:\FuturePeyto\fig\dataproc\ScatterPlots_Obs_WRF_WRFbc_Current.pdf')
saveas (gcf, 'D:\FuturePeyto\fig\dataproc\ScatterPlots_Obs_WRF_WRFbc_Current.png')
savefig(gcf, 'D:\FuturePeyto\fig\dataproc\ScatterPlots_Obs_WRF_WRFbc_Current')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compile tables with stats:
% r, RMSD and MAD (root mean square difference and mean absolute difference)
clear RMSD_raw RMSD_bc r r_raw r_bc MAD_raw MAD_bc
for i = 1:6
RMSD_raw(i, 1) =  sqrt(mean((obs(:, i) - CUR(:, i)).^2));
RMSD_bc(i, 1) =  sqrt(mean((obs(:, i) - CUR_bc(:, i)).^2));
r = corrcoef(obs(:, i), CUR(:, i)); r_raw(i, 1) = r(2);
r = corrcoef(obs(:, i), CUR_bc(:, i)); r_bc(i, 1) = r(2);
MAD_raw(i, 1) = mean(abs(obs(:, i) - CUR(:, i)));
MAD_bc(i, 1) = mean(abs(obs(:, i) - CUR_bc(:, i)));
end 
varname = {'t'; 'ea'; 'u'; 'qsi'; 'qli'; 'p'};
stat_WRF = table(varname, r_raw, r_bc, RMSD_raw, RMSD_bc, MAD_raw, MAD_bc);
writetable(stat_WRF, 'D:\FuturePeyto\dataproc\wrf\Stats_R_RMSD_MAD_WRFCurrent_BiasCorrection.txt')

%% Quantile Quantile plot
fig = figure('units','inches','position',[0 0 11 8]); 
% air t
subplot(3,4,1)
q = qqplot(obs(:, 1), CUR(:, 1)); grid on; 
set(q(1),'marker','x','markersize',3,'markeredgecolor',[0 0 0]); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
xlim([-50 30]); ylim([-50 30]); grid on
text(-48, 21, ('(a) Air Temperature (^{\circ}C)'));
xlabel ('OBS'); ylabel ('WRF')
legend (q([1,2,3]), {'Q:Q', 'Best Linear fit', '1:1 line'}, 'Orientation', 'Horizontal')

subplot(3,4,2)
q = qqplot(obs(:, 1), CUR_bc(:, 1)); grid on; 
set(q(1),'marker','x','markersize',3,'markeredgecolor',[0 0 0]); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
xlim([-50 30]); ylim([-50 30]); grid on
text(-48, 21, ('(b) Air Temperature (^{\circ}C)'));
xlabel ('OBS'); ylabel ('WRF bias corrected')

% ea %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,4,3)
q = qqplot(obs(:, 2), CUR(:, 2)); grid on; 
set(q(1),'marker','x','markersize',3,'markeredgecolor',[0 0 0]); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
xlim([0 2.5]); ylim([0 2.5]); grid on
text(.05, 2.2, ('(c) Specific Humidity (kPa)'));
xlabel ('OBS'); ylabel ('WRF')

subplot(3,4,4)
q = qqplot(obs(:, 2), CUR_bc(:, 2)); grid on; 
set(q(1),'marker','x','markersize',3,'markeredgecolor',[0 0 0]); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
xlim([0 2.5]); ylim([0 2.5]); grid on
text(.05, 2.2, ('(d) Specific Humidity (kPa)'));
xlabel ('OBS'); ylabel ('WRF bias corrected')
% u %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,4,5)
q = qqplot(obs(:, 3), CUR(:, 3)); grid on; 
set(q(1),'marker','x','markersize',3,'markeredgecolor',[0 0 0]); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
xlim([0 25]); ylim([0 25]); grid on
text(.5, 22, ('(e) Wind Speed (m s^{-1})'));
xlabel ('OBS'); ylabel ('WRF')

subplot(3,4,6)
q = qqplot(obs(:, 3), CUR_bc(:, 3)); grid on; 
set(q(1),'marker','x','markersize',3,'markeredgecolor',[0 0 0]); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
xlim([0 25]); ylim([0 25]); grid on
text(.5, 22, ('(f) Wind Speed (m s^{-1})'));
xlabel ('OBS'); ylabel ('WRF bias corrected')
% SW %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,4,7)
q = qqplot(obs(:, 4), CUR(:, 4)); grid on; 
set(q(1),'marker','x','markersize',3,'markeredgecolor',[0 0 0]); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
xlim([0 1080]); ylim([0 1080]); grid on
text(10, 980, ('(g) SWin (W m^{-2})'));
xlabel ('OBS'); ylabel ('WRF')

subplot(3,4,8)
q = qqplot(obs(:, 4), CUR_bc(:,4)); grid on; 
set(q(1),'marker','x','markersize',3,'markeredgecolor',[0 0 0]); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
xlim([0 1080]); ylim([0 1080]); grid on
text(10, 980, ('(h) SWin (W m^{-2})'));
xlabel ('OBS'); ylabel ('WRF bias corrected')

% LWin %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,4,9)
q = qqplot(obs(:, 5), CUR(:, 5)); grid on; 
set(q(1),'marker','x','markersize',3,'markeredgecolor',[0 0 0]); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
xlim([50 400]); ylim([50 400]); grid on
text(55, 360, ('(i) LWin (W m^{-2})'));
xlabel ('OBS'); ylabel ('WRF')

subplot(3,4,10)
q = qqplot(obs(:, 5), CUR_bc(:, 5)); grid on; 
set(q(1),'marker','x','markersize',3,'markeredgecolor',[0 0 0]); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
xlim([50 400]); ylim([50 400]); grid on
text(55, 360, ('(j) LWin (W m^{-2})'));
xlabel ('OBS'); ylabel ('WRF bias corrected')

% p%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,4,11)
q = qqplot(obs(:, 6), CUR(:, 6)); grid on; 
set(q(1),'marker','x','markersize',3,'markeredgecolor',[0 0 0]); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
xlim([0 10]); ylim([0 10]); grid on
text(.2, 9, ('(k)  Precipitation (mm)'));
xlabel ('OBS'); ylabel ('WRF')

subplot(3,4,12)
q = qqplot(obs(:, 6), CUR_bc(:,6)); grid on; 
set(q(1),'marker','x','markersize',3,'markeredgecolor',[0 0 0]); set(q(2), 'Color', c2, 'linewidth', 1);set(q(3), 'Color', c2, 'linewidth', 1, 'linestyle', ':'); % dashed line
xlim([0 10]); ylim([0 10]); grid on
text(.2, 9, ('(l) Precipitation (mm)'));
xlabel ('OBS'); ylabel ('WRF bias corrected')

set(findall(gcf,'-property','FontSize'),'FontSize',10)

saveas (gcf, 'D:\FuturePeyto\fig\dataproc\QQplot_Obs_WRF_WRFbc_Current.pdf')
saveas (gcf, 'D:\FuturePeyto\fig\dataproc\QQplot_Obs_WRF_WRFbc_Current.png')
savefig(gcf, 'D:\FuturePeyto\fig\dataproc\QQplot_Obs_WRF_WRFbc_Current')
clear a c1 c2 fig h hw l1 l2 rl rlc tr1 tr2 ms rlw

%% A set of plot comparing BC current to OBS in a time series way
fig = figure('units','inches','position',[0 0 10 7]); 
subplot(3,2,1)
plot (obstime, obs(:, 1)); hold on
plot (curtime, CUR_bc(:, 1))
legend ('Obs', 'WRF bc')
ylabel ('Ta ({\circ}C)')

subplot(3,2,2)
plot (obstime, obs(:, 2)); hold on
plot (curtime, CUR_bc(:, 2))
legend ('Obs', 'WRF bc')
ylabel ('ea (kPa)')

subplot(3,2,3)
plot (obstime, obs(:, 3)); hold on
plot (curtime, CUR_bc(:, 3))
legend ('Obs', 'WRF bc')
ylabel ('U (m s^{-1})')

subplot(3,2,4)
plot (obstime, obs(:, 4)); hold on
plot (curtime, CUR_bc(:, 4))
legend ('Obs', 'WRF bc')
ylabel ('SWin (W m^{-2})')

subplot(3,2,5)
plot (obstime, obs(:, 5)); hold on
plot (curtime, CUR_bc(:, 5))
legend ('Obs', 'WRF bc')
ylabel ('LWin (W m^{-2})')

subplot(3,2,6)
plot (obstime, obs(:,6)); hold on
plot (curtime, CUR_bc(:, 6))
legend ('Obs', 'WRF bc')
ylabel ('P (mm)')

saveas (gcf, 'D:\FuturePeyto\fig\dataproc\TimeSeries_Obs_WRFbc_Current.pdf')
saveas (gcf, 'D:\FuturePeyto\fig\dataproc\TimeSeries_Obs_WRFbc_Current.png')
savefig(gcf, 'D:\FuturePeyto\fig\dataproc\TimeSeries_Obs_WRFbc_Current')

%% Plot change between current and future WRF
% plot the CUR-bc vs PGW-bc
fig = figure('units','inches','position',[0 0 11 8]); 

subplot(3,2,1)
plot (curtime, CUR_bc(:, 1)); hold on
plot (curtime, PGW_bc(:, 1));
legend ('Current bc', 'PGW bc')
ylabel ('Ta ({\circ}C)')

subplot(3,2,2)
plot (curtime, CUR_bc(:, 2)); hold on
plot (curtime, PGW_bc(:,2));
legend ('Current bc', 'PGW bc')
ylabel ('ea (kPa)')

subplot(3,2,3)
plot (curtime, CUR_bc(:, 3)); hold on
plot (curtime, PGW_bc(:, 3));
legend ('Current bc', 'PGW bc')
ylabel ('U (m s^{-1})')

subplot(3,2,4)
plot (curtime, CUR_bc(:, 4)); hold on
plot (curtime, PGW_bc(:, 4));
legend ('Current bc', 'PGW bc')
ylabel ('SWin (W m^{-2})')

subplot(3,2,5)
plot (curtime, CUR_bc(:, 5)); hold on
plot (curtime, PGW_bc(:, 5));
legend ('Current bc', 'PGW bc')
ylabel ('LWin (W m^{-2})')

subplot(3,2,6)
plot (curtime, CUR_bc(:, 6)); hold on
plot (curtime, PGW_bc(:, 6));
legend ('Current bc', 'PGW bc')
ylabel ('P (mm)')

saveas (gcf, 'D:\FuturePeyto\fig\dataproc\TimeSeries_WRFbc_Cur_PGW.pdf')
saveas (gcf, 'D:\FuturePeyto\fig\dataproc\TimeSeries_WRFbc_Cur_PGW.png')
savefig(gcf, 'D:\FuturePeyto\fig\dataproc\TimeSeries_WRFbc_Cur_PGW')


%% Plot annual cycle for each variable
% reshape to get annual value (365x15)
clear  t d VarOut VarA 
for ii = 1:6

for i = 1:14
    if i <9 % 2000-2008
a = find(curtime == strcat('01-Oct-200', num2str(i)));
b = find (curtime == strcat('30-Sep-200', num2str(i+1)));
t = curtime (a:b);
d = CUR_bc(a:b, ii);
dd  = PGW_bc(a:b, ii);
if length (t) > 8737 % remove Feb 29
    t1 = find(t == datetime(strcat('29-Feb-200', num2str(i+1), ' 00:00')));
    t2 = find(t == datetime(strcat('29-Feb-200', num2str(i+1), ' 23:00')));
    d(t1:t2) = [];
    dd(t1:t2) = [];
end 
VarA(:, i) = d;
VarB (:, i) = dd;
    end
    
 if i == 9 % 2009 % not a leap year
a = find(curtime == strcat('01-Oct-200', num2str(i)));
b = find (curtime == strcat('30-Sep-20', num2str(i+1)));
t = curtime (a:b);
d = CUR_bc(a:b, ii);
dd = PGW_bc(a:b, ii);
VarA(:, i) = d;
VarB(:, i) = dd;
end 
 
if i > 9 & i < 14 % 2014
a = find(curtime == strcat('01-Oct-20', num2str(i)));
b = find (curtime == strcat('30-Sep-20', num2str(i+1)));
t = curtime (a:b);
d = CUR_bc(a:b, ii);
dd = PGW_bc(a:b, ii);

if length (t) > 8737 % remove Feb 29
    t1 = find(t == datetime(strcat('29-Feb-20', num2str(i+1), ' 00:00')));
    t2 = find(t == datetime(strcat('29-Feb-20', num2str(i+1), ' 23:00')));
    d(t1:t2) = [];
     dd(t1:t2) = [];
end 
VarA(:, i) = d;
VarB(:, i) = dd;

end 
    
if i == 14 % 2010-2013
a = find(curtime == strcat('01-Oct-20', num2str(i)));
b = find (curtime == strcat('27-Sep-20', num2str(i+1)));
t = curtime (a:b);
d = CUR_bc(a:b, ii);
dd = PGW_bc(a:b, ii);

if length (t) > 8737 % remove Feb 29
    t1 = find(t == datetime(strcat('29-Feb-20', num2str(i+1), ' 00:00')));
    t2 = find(t == datetime(strcat('29-Feb-20', num2str(i+1), ' 23:00')));
    d(t1:t2) = [];
    dd(t1:t2) = [];

end 

% pad with nan
pad = 8737 - length(d);
d = [d; nan(pad,1)];
VarA(:, i) = d;
dd = [dd; nan(pad,1)];
VarB(:, i) = dd;

    end 
end 
VarCUR(:,:,ii) = VarA;
VarPGW(:,:,ii) = VarB;
end 

% %%
% Tannual = VarOut(:,:,1);
% Eaannual = VarOut(:,:,2);
% Uannual = VarOut(:,:,3);
% SWannual = VarOut(:,:,4);
% LWannual = VarOut(:,:,5);
% Pannual = VarOut(:,:,6);
% tannual =  (datetime('01-Oct-2000'):hours(1):datetime('30-Sep-2001'))';

% Compile a daily average
t =  (datetime('01-Oct-2000'):hours(1):datetime('30-Sep-2001'))';
for i= 1:5
    d =VarCUR(:,:,i) ;
x = timetable (t,d);
xx = retime(x, 'daily', 'mean');
Vd(:,:,i)= table2array(xx);
    dd =VarPGW(:,:,i) ;
x = timetable (t,dd);
xx = retime(x, 'daily', 'mean');
Vdd(:,:,i)= table2array(xx);

end
% precip is cumul
d =VarCUR(:,:,6) ;
x = timetable (t,d);
xx = retime(x, 'daily', 'sum');
Vd(:,:,6)= table2array(xx);

dd =VarPGW(:,:,6) ;
x = timetable (t,dd);
xx = retime(x, 'daily', 'sum');
Vdd(:,:,6)= table2array(xx);
td= xx.t;

%% Compile mean and Std
for i = 1:6
     d= Vd(:,:,i);
     M(:, i) = nanmean(d, 2);
     STDev (:, i) = nanstd(d, 0, 2);
     
          dd= Vdd(:,:,i);
     Mpgw(:, i) = nanmean(dd, 2);
     STDevpgw (:, i) = nanstd(dd, 0, 2);
end 

%% Make the plots
t = [M(:, 1) M(:, 1)+STDev(:, 1) M(:, 1)-STDev(:, 1)]';
ea = [M(:, 2) M(:, 2)+STDev(:, 2) M(:, 2)-STDev(:, 2)]';
u = [M(:, 3) M(:, 3)+STDev(:, 3) M(:, 3)-STDev(:,3)]';
qsi = [M(:, 4) M(:, 4)+STDev(:, 4) M(:, 4)-STDev(:,4)]';
qli= [M(:, 5) M(:, 5)+STDev(:, 5) M(:, 5)-STDev(:, 5)]';
p = [M(:, 6) M(:, 6)+STDev(:, 6) M(:, 6)-STDev(:, 6)]';

tpgw = [Mpgw(:, 1) Mpgw(:, 1)+STDevpgw(:, 1) Mpgw(:, 1)-STDevpgw(:, 1)]';
eapgw = [Mpgw(:, 2) Mpgw(:, 2)+STDevpgw(:, 2) Mpgw(:, 2)-STDevpgw(:, 2)]';
upgw = [Mpgw(:, 3) Mpgw(:, 3)+STDevpgw(:, 3) Mpgw(:, 3)-STDevpgw(:,3)]';
qsipgw = [Mpgw(:, 4) Mpgw(:, 4)+STDevpgw(:, 4) Mpgw(:, 4)-STDevpgw(:,4)]';
qlipgw= [Mpgw(:, 5) Mpgw(:, 5)+STDevpgw(:, 5) Mpgw(:, 5)-STDevpgw(:, 5)]';
ppgw = [Mpgw(:, 6) Mpgw(:, 6)+STDevpgw(:, 6) Mpgw(:, 6)-STDevpgw(:, 6)]';

%% Plot with shadsing
fig = figure('units','inches','position',[0 0 8 10]); 
subplot (3,2,1)
stdshade(t, .4,'k',td, 1) ; hold on
stdshade(tpgw, .4,'r',td, 1) ;
ylabel ('Ta ({\circ}C)')
legend ('Current st. dev','Current average', 'PGW st. dev','PGW average', 'Orientation', 'Horizontal')

subplot (3,2,2)
stdshade(ea, .4,'k',td, 1) ; hold on
stdshade(eapgw, .4,'r',td, 1) ; 
ylabel ('ea (kPa)')

subplot (3,2,3)
stdshade(u, .4,'k',td, 1) ; hold on
stdshade(upgw, .4,'r',td, 1) ;
ylabel ('U (m s^{-1})')

subplot (3,2,4)
stdshade(qsi, .4,'k',td, 1) ; hold on
stdshade(qsipgw, .4,'r',td, 1) ; 
ylabel ('SWin (W m^{-2})')

subplot (3,2,5)
stdshade(qli, .4,'k',td, 1) ; hold on
stdshade(qlipgw, .4,'r',td, 1) 
ylabel ('LWin (W m^{-2})')

subplot (3,2,6)
stdshade(p, .4,'k',td, 1) ; hold on
stdshade(ppgw, .4,'r',td, 1) 
ylabel ('P (mm)')
%%
saveas (gcf, 'D:\FuturePeyto\fig\dataproc\Shading_Cur_PGW.pdf')
saveas (gcf, 'D:\FuturePeyto\fig\dataproc\Shading_Cur_PGW.png')
savefig(gcf, 'D:\FuturePeyto\fig\dataproc\Shading_Cur_PGW')

%% Plot as box plots
% mean value for boxplot
for i = 1:6
     d= Vd(:,:,i);
     Ma(:, i) = nanmean(d);
     
          dd= Vdd(:,:,i);
     Mapgw(:, i) = nanmean(dd);
end 
% precip is sum 
     d= Vd(:,:,6);
     Ma(:, 6) = nansum(d);
     
          dd= Vdd(:,:,6);
     Mapgw(:, 6) = nansum(dd);
%% 
fig = figure('units','inches','position',[0 0 9 5]); 
subplot(2,3,1)
boxplot([Ma(:, 1), Mapgw(:, 1)]);
ylabel(' Air Temperature');
xticklabels ({'Current ', 'PGW'})
ylabel ('Ta ({\circ}C)')

subplot(2,3,2)
boxplot([Ma(:, 2), Mapgw(:, 2)]);
xticklabels ({'Current ', 'PGW'})
ylabel ('ea (kPa)')

subplot(2,3,3)
boxplot([Ma(:, 3), Mapgw(:,3)]);
xticklabels ({'Current ', 'PGW'})
ylabel ('U (m s^{-1})')

subplot(2,3,4)
boxplot([Ma(:, 4), Mapgw(:, 4)]);
xticklabels ({'Current ', 'PGW'})
ylabel ('SWin (W m^{-2})')

subplot(2,3,5)
boxplot([Ma(:, 5), Mapgw(:, 5)]);
xticklabels ({'Current ', 'PGW'})
ylabel ('LWin (W m^{-2})')

subplot(2,3,6)
boxplot([Ma(:, 6), Mapgw(:, 6)]);
xticklabels ({'Current ', 'PGW'})
ylabel ('Precipitation (mm)')

saveas (gcf, 'D:\FuturePeyto\fig\dataproc\Boxplot_Cur_PGW.pdf')
saveas (gcf, 'D:\FuturePeyto\fig\dataproc\Boxplot_Cur_PGW.png')
savefig(gcf, 'D:\FuturePeyto\fig\dataproc\Boxplot_Cur_PGW')

%%