%% D1b %% Compare basinflow
close all
clear all

load('D:\5_FuturePeyto\crhm\C_Scenarios\output\PeytoSUB1.mat','basinflowSUB1')
load('D:\5_FuturePeyto\crhm\C_Scenarios\output\PeytoSUB2.mat','basinflowSUB2')
load('D:\5_FuturePeyto\crhm\C_Scenarios\output\PeytoSUB3.mat','basinflowSUB3')

load('D:\5_FuturePeyto\crhm\C_Scenarios\output\PeytoICE1.mat','basinflowICE1')
load('D:\5_FuturePeyto\crhm\C_Scenarios\output\PeytoICE2.mat','basinflowICE2')
load('D:\5_FuturePeyto\crhm\C_Scenarios\output\PeytoICE3.mat','basinflowICE3')

load('D:\5_FuturePeyto\crhm\C_Scenarios\output\PeytoSUR1.mat','basinflowSUR1')
load('D:\5_FuturePeyto\crhm\C_Scenarios\output\PeytoSUR2.mat', 'basinflowSUR2')
load('D:\5_FuturePeyto\crhm\C_Scenarios\output\PeytoSUR3.mat','basinflowSUR3')

load('D:\5_FuturePeyto\crhm\C_Scenarios\output\PeytoVEG1.mat','basinflowVEG1')
load('D:\5_FuturePeyto\crhm\C_Scenarios\output\PeytoVEG2.mat','basinflowVEG2')
load('D:\5_FuturePeyto\crhm\C_Scenarios\output\PeytoVEG3.mat','basinflowVEG3')

load('D:\5_FuturePeyto\crhm\C_Scenarios\output\PeytoWET.mat','basinflowWET')
load('D:\5_FuturePeyto\crhm\C_Scenarios\output\PeytoDRY.mat','basinflowDRY')

 load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat','basinflowCUR', 'timeCUR')
 load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat', 'basinflowPGW', 'timePGW')
load('D:\5_FuturePeyto\crhm\C_Scenarios\output\PeytoREF.mat','basinflowREF', 'timeREF')

hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 
basinarea = sum(hruarea); % m2

% Change to daily

x = timetable(timeREF, basinflowREF/3600, basinflowCUR/3600);
xx = retime(x, 'daily', 'mean');
t = xx.timeREF;
bfREF = table2array(xx);
% bfREF = bfREF (365:end, :);
% t = t(365:end);
 
 
x = timetable(timeREF, basinflowICE1/3600, basinflowICE2/3600,basinflowICE3/3600);
xx = retime(x, 'daily', 'mean');
bfICE = table2array(xx);
%bfICE = bfICE (365:end, :);

% figure
%  plot( t, bfICE); hold on
%  plot(t, bfREF(:, 1), 'k'); hold on
%   plot(t, bfREF(:,2), ':k'); hold on
%  title('Remaining Ice')
% legend ('0% ice', '8% ice', '15% ice', 'Ref (5%)', 'CUR')
% figname ='Ice_basinflow_allyear';
% saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))

x = timetable(timeREF, basinflowVEG1/3600, basinflowVEG2/3600,basinflowVEG3/3600);
xx = retime(x, 'daily', 'mean');
bfVEG = table2array(xx);
% bfVEG = bfVEG (365:end, :);
%  figure
%  plot(t, bfVEG); hold on
%  plot(t, bfREF(:, 1), 'k'); hold on
%   plot(t, bfREF(:,2), ':k'); hold on
%  title('Vegetation')
% legend ('<1%', '5%', '15%', 'Ref (0%)', 'CUR')
% figname ='Veg_basinflow_allyear';
% saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))

x = timetable(timeREF, basinflowSUB1/3600, basinflowSUB2/3600,basinflowSUB3/3600);
xx = retime(x, 'daily', 'mean');
bfGW = table2array(xx);
% bfGW = bfGW (365:end, :);
 
%  figure
%  plot(t, bfGW); hold on
%  plot(t, bfREF(:, 1), 'k'); hold on
%   plot(t, bfREF(:,2), ':k'); hold on 
%  title('Sediment Storage')
% legend ('x1', 'x5', 'x10', 'Ref (x2)', 'CUR')
% figname ='Sub_basinflow_allyear';
% saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))

x = timetable(timeREF, basinflowSUR1/3600, basinflowSUR2/3600,basinflowSUR3/3600);
xx = retime(x, 'daily', 'mean');
bfLAK = table2array(xx);
% bfLAK = bfLAK (365:end, :);
%  figure
%  plot(t, bfLAK); hold on
%  plot(t, bfREF(:, 1), 'k'); hold on
%   plot(t, bfREF(:,2), ':k'); hold on
%   title('Surface Water Storage')
% legend ('No ponding, no lake', 'only lake', 'only pond', 'Ref (pond+lake)', 'CUR')
% figname ='Sur_basinflow_allyear';
% saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))


x = timetable(timeREF, basinflowWET/3600, basinflowDRY/3600);%, basinflowDRY/3600);
xx = retime(x, 'daily', 'mean');
bfWET = table2array(xx);
% bfLAK = bfLAK (365:end, :);
%  figure
%  plot(t, bfWET); hold on
%  plot(t, bfREF(:, 1), 'k'); hold on
%  plot(t, bfREF(:,2), ':k'); hold on
%   title('Wet vs DRY')
% legend ('Wet', 'Dry', 'Ref', 'CUR')
% figname ='Wet_Dry_basinflow_allyear';
% saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))


clear basinflowGW1 basinflowGW2 basinflowGW3 basinflowVEG1 basinflowVEG2 basinflowVEG3 basinflowREF
clear basinflowSUR1 basinflowSUR2 basinflowSUR3 basinflowICE1 basinflowICE2 basinflowICE3
clear basinflowSUB1 basinflowSUB2 basinflowSUB3 basinflowWET basinflowDRY basinflowWET
 
save D:\5_FuturePeyto\crhm\C_Scenarios\output\Scenario_bf.mat bfREF bfICE bfVEG bfGW bfLAK bfWET timeREF t
clear all

%% 15 year average daily plot
% 1 april to 30 march instead of water year
 load('D:\5_FuturePeyto\crhm\C_Scenarios\output\Scenario_bf.mat')
% reshape into 15 years
tor = t;
var = [bfREF(367:end, 2), bfREF(367:end, 1), bfICE(367:end, :), bfLAK(367:end, :),bfGW(367:end, :) ,...
    bfVEG(367:end, :), bfWET(367:end, :)];
% so that cur, pgw, ice, sur, veg, gw, 
t = t(367:end, :);
clear bfWET bfVEG bfREF bfLAK bfICE bfGW 

sz = size (var);
timevec = datevec(t);
var(find(timevec(:,2) == 2 & timevec(:,3) == 29), :) = []; % remove leap years days
t(find(timevec(:,2) == 2 & timevec(:,3) == 29), :) = [];
t= datetime(t);
timevec = datevec(t);
tidx = find(timevec(:, 2) ==4 & timevec(:, 3) == 1);
t(tidx)

for ii = 1:sz(2) % 16 scenarios
     varPGW= var(:,ii);
for i = 1:length(tidx)-1
    if i <=15
   varRSHP_PGW(:, i) = varPGW(tidx(i):tidx(i+1)-1);
    else 
   varRSHP_PGW(:, i) = [varPGW(tidx(i):tidx(i+1)); nan(364-(tidx(15)-tidx(14)), 1)];
  end 
end 
VarPGW(:,:,ii) = varRSHP_PGW;
end


% Cmpile the mean and stadard deviation
for i = 1:sz(2)    
          dd= VarPGW(:,:,i);
     Mpgw(:, i) = nanmean(dd, 2);
     STDevpgw (:, i) = nanstd(dd, 0, 2);
end 
 
%% Plot outputs
% color
c = [255 128 0;...
    0 153 0; ...
    0 0 255]./255; % red, blue, green
% what about orange, oruple, turqoise?
% c = [27 158 119;...
%    0 204 204; ...
%    0 102 204]./255; % red, blue, green
set(0,'defaultAxesFontSize',10)
lw = .8; % linewitdg
fs = 10; %fontsize
td = t(tidx(1):tidx(2)-1);
fig = figure('units','inches','position',[0 0 7 7]); 
sp1 = subplot(5,1,1)
p3 = plot (td, Mpgw(:, 3), 'Color',c(1, :), 'linewidth', lw); hold on; 
p4 = plot (td, Mpgw(:, 4), 'Color',c(2, :), 'linewidth', lw); hold on;
p5 = plot (td, Mpgw(:, 5), 'Color',c(3, :), 'linewidth', lw); hold on;
p1 = plot (td, Mpgw(:, 2), 'k', 'linewidth', lw);
p2 = plot (td, Mpgw(:, 1), ':k', 'linewidth', lw);
xtickformat ('dd-MMM');xticklabels ([]);
ylabel({'Streamflow','(m^3 s^{-1})'})
xlim ([td(1) td(end)]);
ylim([0 6.2])
text(td(2),5.7, '(a) Remaining Ice', 'Fontsize', fs)
sp1.Position = sp1.Position + [0 0 0.05 0.03];
lg = legend ([p1(1) p2(1) p3(1) p4(1) p5(1)], 'PGW-Ref, 3%', 'CUR','0%', '6%', '9%', 'location', 'best');
lg.Position = [.80, .831, .1, .1]; %.

sp2 = subplot(5,1,2)
p3= plot (td, Mpgw(:, 6), 'Color',c(1, :), 'linewidth', lw+.2); hold on;
p4 = plot (td, Mpgw(:, 7), 'Color',c(2, :), 'linewidth', lw-0.1); hold on;
p5 = plot (td, Mpgw(:, 8), 'Color',c(3, :), 'linewidth', lw+0.2); hold on;
p1 = plot (td, Mpgw(:, 2), 'k', 'linewidth',lw-0.1);
p2 = plot (td, Mpgw(:, 1), ':k','linewidth', lw);
lg = legend ([p1(1) p2(1) p3(1) p4(1) p5(1)], 'PGW-Ref, Lake + Ponding', 'CUR', 'No Ponding, No Lake', 'Lake Only', 'Ponding Only', 'location',  'best')
xtickformat ('dd-MMM'); xticklabels ([]);
ylabel({'Streamflow','(m^3 s^{-1})'})
xlim ([td(1) td(end)]);
ylim([0 6.2])
text(td(2),5.7,{'(b) Surface Water Storage'}, 'Fontsize', fs)
sp2.Position = sp2.Position + [0 0 0.05 0.03];
lg.Position = [.75, .658, .1, .1]; %.

sp3 = subplot(5,1,3)
p3 = plot (td, Mpgw(:, 9), 'Color',c(1, :), 'linewidth', lw); hold on;
p4 = plot (td, Mpgw(:, 10), 'Color',c(2, :), 'linewidth', lw); hold on;
p5 = plot (td, Mpgw(:, 11), 'Color',c(3, :), 'linewidth', lw); hold on;
p1= plot (td, Mpgw(:, 2), 'k','linewidth', lw);
p2 = plot (td, Mpgw(:, 1), ':k', 'linewidth',lw);
lg = legend ([p1(1) p2(1) p3(1) p4(1) p5(1)],'PGW-Ref,x2', 'CUR', 'x0.5', 'x1', 'x5',  'location', 'best')
xtickformat ('dd-MMM');xticklabels ([]);
ylabel({'Streamflow','(m^3 s^{-1})'})
xlim ([td(1) td(end)]);
ylim([0 6.2])
text(td(2), 5.7,{'(c) Subsurface Water Storage'}, 'Fontsize', fs)
sp3.Position = sp3.Position + [0 0 0.05 0.03];
lg.Position = [.805, .485, .1, .1]; %.

sp4 = subplot(5,1,4)
p3 = plot (td, Mpgw(:, 12), 'Color',c(1, :), 'linewidth', lw); hold on;
p4 = plot (td, Mpgw(:, 13), 'Color',c(2, :), 'linewidth', lw); hold on;
p5 = plot (td, Mpgw(:, 14), 'Color',c(3, :), 'linewidth', lw); hold on;
p1 = plot (td, Mpgw(:, 2), 'k', 'linewidth',lw);
p2 = plot (td, Mpgw(:, 1), ':k','linewidth', lw);
lg = legend ([p1(1) p2(1) p3(1) p4(1) p5(1)], 'PGW-Ref (0%)', 'CUR','<1%', '5%', '15%', 'location',  'best')
ylabel({'Streamflow','(m^3 s^{-1})'})
xtickformat ('dd-MMM');xticklabels ([]);
xlim ([td(1) td(end)]);
ylim([0 6.2])
text(td(2),5.7, '(d) Vegetation growth', 'Fontsize', fs)
sp4.Position = sp4.Position + [0 0 0.05 0.03];
lg.Position = [.795, .313, .1, .1]; %.

sp5 = subplot(5,1,5)
p3 = plot (td, Mpgw(:, 15), 'Color',c(1, :), 'linewidth', lw); hold on;
p4 = plot (td, Mpgw(:, 16), 'Color',c(3, :), 'linewidth', lw); hold on;
p1 = plot (td, Mpgw(:, 2), 'k', 'linewidth',lw);
p2 = plot (td, Mpgw(:, 1), ':k', 'linewidth',lw);
lg = legend ([p1(1) p2(1) p3(1) p4(1)], 'PGW-Ref', 'CUR','Lush','Bare', 'Position', [3, 1, 1, 1]); % 'location',  'best')
xtickformat ('MMM');
ylabel({'Streamflow','(m^3 s^{-1})'})
xlim ([td(1) td(end)]);
ylim([0 6.2])
text(td(2), 5.7, '(e) Combination', 'Fontsize', fs)
sp5.Position = sp5.Position + [0 0 0.05 0.03];
lg.Position = [.815, .153, .1, .1]; %.

% tightfig(fig)
%
figname ='BasinflowScenario';
saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))

%% Scatter plot
load('D:\5_FuturePeyto\crhm\C_Scenarios\output\Scenario_bf.mat')

fig = figure('units','inches','position',[0 0 4 10]); 
subplot(5,1,1)
scatter (bfREF(:, 1), bfICE(:, 3), '.');  hold on;
scatter (bfREF(:, 1), bfICE(:, 2), '.'); 
scatter (bfREF(:, 1), bfICE(:, 1), '.');
rf = refline(1,0); rf.Color = 'k'
title ('Remaining ice')
ylabel('Scenario Streamflow (m^3 s{-1})');
xlabel('Reference Streamflow (m^3 s{-1})');
legend ( '16%','8%','0%', 'location', 'northwest')

subplot(5,1,2)
scatter (bfREF(:, 1), bfLAK(:, 1), '.'); hold on;
scatter (bfREF(:, 1), bfLAK(:, 2), '.');
scatter (bfREF(:, 1), bfLAK(:, 3), '.');
rf = refline(1,0); rf.Color = 'k'
title ('Surface Water')
legend ('No Ponding, No lake', 'Lake Only (No Ponding)', 'Ponding Only (No lake)', 'location', 'northwest')
ylabel('Scenario Streamflow (m^3 s{-1})');
xlabel('Reference Streamflow (m^3 s{-1})');

subplot(5,1,3)
scatter (bfREF(:, 1), bfVEG(:, 3),'.'); hold on;
scatter (bfREF(:, 1), bfVEG(:, 2),'.');
scatter (bfREF(:, 1), bfVEG(:, 1),'.');
rf = refline(1,0); rf.Color = 'k'
title ('Vegetation')
legend ('15%','5%', '<1%',  'location', 'northwest')
ylabel('Scenario Streamflow (m^3 s{-1})');
xlabel('Reference Streamflow (m^3 s{-1})');

subplot(5,1,4)
scatter (bfREF(:, 1), bfGW(:, 3), '.'); hold on;
scatter (bfREF(:, 1), bfGW(:, 2), '.');
scatter (bfREF(:, 1), bfGW(:, 1), '.');
rf = refline(1,0); rf.Color = 'k'
title ('Soil storage')
legend ('x1', 'x5', 'x10', 'Ref,x2', 'location', 'northwest')
ylabel('Scenario Streamflow (m^3 s{-1})');
xlabel('Reference Streamflow (m^3 s{-1})');

subplot(5,1,5)
scatter (bfREF(:, 1), bfWET(:, 1), '.'); hold on;
scatter (bfREF(:, 1), bfWET(:, 2), '.');
rf = refline(1,0); rf.Color = 'k'
title ('Compound')
legend ('Wet', 'Dry', 'location', 'northwest')
ylabel('Scenario Streamflow (m^3 s{-1})');
xlabel('Reference Streamflow (m^3 s{-1})');

figname ='BasinflowScatterlotScenario';
saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))

%% % time of concentration
% time of 50%
SumMpgw = sum(Mpgw);
PerMpgw = round(cumsum(Mpgw).*100./SumMpgw) ;
clear val idx
for i = 1:16
[val(i), idx(i)] = find(PerMpgw(:, i) == 50,1);
end 
%% Plot outputs

td = t(tidx(1):tidx(2)-1);
fig = figure('units','inches','position',[0 0 11 8]); 
subplot(2,3,1)
plot (td, cumsum(Mpgw(:, 3:5))); hold on;
plot (td, cumsum(Mpgw(:, 2)), 'k');
plot (td, cumsum(Mpgw(:, 1)), ':k'); hold on
scatter(td(val(1)),sum(Mpgw(1:val(1), 1)), 'xk')
scatter(td(val(2)),sum(Mpgw(1:val(2), 2)), 'xk')
scatter(td(val(3)),sum(Mpgw(1:val(3), 3)), 'xk')
scatter(td(val(4)),sum(Mpgw(1:val(4), 4)), 'xk')
scatter(td(val(5)),sum(Mpgw(1:val(5), 5)), 'xk')
lg = legend ('0%', '6%', '9%', 'PGW-Ref, 3%', 'CUR', 'location', 'southeast')
xtickformat ('dd-MMM')
ylabel({'Streamflow','(m^3 s^{-1})'})
xlim ([td(1) td(end)]);
ylim ([0 500])

subplot(2,3,2)
plot (td, cumsum(Mpgw(:, 6:8))); hold on;
plot (td, cumsum(Mpgw(:, 2)), 'k');
plot (td, cumsum(Mpgw(:, 1)), ':k');
scatter(td(val(1)),sum(Mpgw(1:val(1), 1)), 'xk')
scatter(td(val(2)),sum(Mpgw(1:val(2), 2)), 'xk')
scatter(td(val(6)),sum(Mpgw(1:val(6), 6)), 'xk')
scatter(td(val(7)),sum(Mpgw(1:val(7), 7)), 'xk')
scatter(td(val(8)),sum(Mpgw(1:val(8), 8)), 'xk')
legend ('No Surf', 'Lake', 'Ponding', 'PGW-Ref', 'CUR', 'location', 'southeast')
xtickformat ('dd-MMM')
ylabel({'Streamflow','(m^3 s^{-1})'})
xlim ([td(1) td(end)]);
ylim ([0 500])

subplot(2,3,3)
plot (td, cumsum(Mpgw(:, 9:11))); hold on;
plot (td, cumsum(Mpgw(:, 2)), 'k');
plot (td, cumsum(Mpgw(:, 1)), ':k');
scatter(td(val(1)),sum(Mpgw(1:val(1), 1)), 'xk')
scatter(td(val(2)),sum(Mpgw(1:val(2), 2)), 'xk')
scatter(td(val(9)),sum(Mpgw(1:val(9), 9)), 'xk')
scatter(td(val(10)),sum(Mpgw(1:val(10), 10)), 'xk')
scatter(td(val(11)),sum(Mpgw(1:val(11), 11)), 'xk')
legend ('x0.5', 'x1', 'x5', 'PGW-Ref,x2', 'CUR', 'location',  'southeast')
xtickformat ('dd-MMM')
ylabel({'Streamflow','(m^3 s^{-1})'})
xlim ([td(1) td(end)]);
ylim ([0 500])

subplot(2,3,4)
plot (td, cumsum(Mpgw(:, 12:14))); hold on;
plot (td,cumsum( Mpgw(:, 2)), 'k');
plot (td, cumsum(Mpgw(:, 1)), ':k');
scatter(td(val(1)),sum(Mpgw(1:val(1), 1)), 'xk')
scatter(td(val(2)),sum(Mpgw(1:val(2), 2)), 'xk')
scatter(td(val(12)),sum(Mpgw(1:val(6), 12)), 'xk')
scatter(td(val(13)),sum(Mpgw(1:val(7), 13)), 'xk')
scatter(td(val(14)),sum(Mpgw(1:val(8), 14)), 'xk')
legend ('<1%', '5%', '15%', 'PGW-Ref, 0%', 'CUR','location',  'southeast')
xtickformat ('dd-MMM')
ylabel({'Streamflow','(m^3 s^{-1})'})
xlim ([td(1) td(end)]);
ylim ([0 500])

subplot(2,3,5)
plot (td, cumsum(Mpgw(:, 15:16))); hold on;
plot (td, cumsum(Mpgw(:, 2)), 'k');
plot (td, cumsum(Mpgw(:, 1)), ':k');
scatter(td(val(1)),sum(Mpgw(1:val(1), 1)), 'xk')
scatter(td(val(2)),sum(Mpgw(1:val(2), 2)), 'xk')
scatter(td(val(15)),sum(Mpgw(1:val(6), 15)), 'xk')
scatter(td(val(16)),sum(Mpgw(1:val(7), 16)), 'xk')
legend ('Wet','Dry', 'PGW-Ref', 'CUR','location', 'southeast')
xtickformat ('dd-MMM')
ylabel({'Streamflow','(m^3 s^{-1})'})
xlim ([td(1) td(end)]);
ylim ([0 500])

figname ='BasinflowScenario_Cumsum';
saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))

% time to concentration and cumulative mass curve

% %% Stats graph
% load('D:\5_FuturePeyto\crhm\C_Scenarios\output\Scenario_bf.mat')
%  load('D:\5_FuturePeyto\crhm\C_Scenarios\output\Scenario_bf.mat')
% % reshape into 15 years
% tor = t;
% var = [bfREF(367:end, 2), bfREF(367:end, 1), bfICE(367:end, :), bfLAK(367:end, :),bfGW(367:end, :) ,...
%     bfVEG(367:end, :), bfWET(367:end, :)];
% % so that cur, pgw, ice, sur, veg, gw, 
% t = t(367:end, :);
% clear bfWET bfVEG bfREF bfLAK bfICE bfGW 
% 
% sz = size (var);
% timevec = datevec(t);
% var(find(timevec(:,2) == 2 & timevec(:,3) == 29), :) = []; % remove leap years days
% t(find(timevec(:,2) == 2 & timevec(:,3) == 29), :) = [];
% t= datetime(t);
% timevec = datevec(t);
% tidx = find(timevec(:, 2) ==4 & timevec(:, 3) == 1);
% t(tidx)
% 
% bf_mod = var(:, 2:16);
% bf_meas = var(:, 1);
% 
% for i = 1:15
% RMSE(i) =  sqrt(mean((bf_mod(:, i) - bf_meas(:, 1)).^2));
% r = corrcoef(bf_mod(:, i),bf_meas(:, 1)); R2(i) = r(2)^2;
% MAE(i) = mean(abs(bf_mod(:, i) - bf_meas(:, 1)));
% obs = [datenum(t) bf_meas(:, 1)];
% mod = [datenum(t) bf_mod(:, i)];
% [NSE(i), metricid] = nashsutcliffe(obs, mod);
% MB(i) = (sum(mod(:, 2)-obs(:, 2))/sum(obs(:, 2)));
% end
% 
% SUM = sum(bf_mod)./sum(bf_meas) * 100 -100;
% 
% lab = {'PGW', '0% Ice','8% Ice','16% ice','No Pond, No lake','Only Lake','Only Ponding','<1% Veg','4% Veg','8% Veg','x1 Soil Moist','x5 Soil Moist','x10 Soil Moist', 'Wet', 'Dry'};
% 
% fig = figure('units','inches','position',[0 0 8 4]); 
% 
% subplot(1,2,1)
% bar(SUM)
% title ('Total Percent Change')
% ylabel ('% change from CUR')
% xticklabels(lab);
% xtickangle (-45);
% xlim ([0.5 15.5]);
% 
% subplot(1,2, 2)
% bar(MAE)
% title ('Mean Absolute Error')
% ylabel ('m^3 s^{-1}')
% xticklabels(lab);
% xtickangle (-45);
% xlim ([0.5 15.5]);
% 
% figname ='BasinflowScenario_Stat';
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))
% 
% % save as table
% % mae, 
% lab = {  'PGWREF', 'Ice0','Ice8','Ice16',...
%     'NoPondNoLake','OnlyLake','OnlyPond',...
%     'SoilM1','SoilM5','SoilM10',...
%     'Veg1','Veg4','Veg8',...
%     'wet', 'dry'}';
% varname = {'Sim', 'RMSE', 'MAE','MB','R2','SUM'}
% T = table (lab, RMSE', MAE',MB', R2', SUM');
% T.Properties.VariableNames = varname;
%  
% writetable (T, 'D:\5_FuturePeyto\fig\D1b\Scenarios_Stats_table.csv') 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% streamflow indices
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %% Peak flow
% % pk flow value form the 15 year average
% [pkflow, pkflow_idx] = max(Mpgw)
% pkflow_timing = td(pkflow_idx)
% % change in peak flow
% pkflowD = round(pkflow*100/pkflow(1))'
% 
% %% August flow 
% x = timetable (td, Mpgw);
% xx = retime(x, 'monthly','mean');
% Mpgw_mth = table2array(xx);
% tm =xx.td;
% 
% Mpgw_aug = Mpgw_mth(5,:);
% % change in peak f
% Mpgw_augD = round(Mpgw_aug*100/Mpgw_aug(1))'-100
% 
% %% 7 day average flow
% x = timetable (td, Mpgw);
% xx = retime(x, 'weekly','mean');
% Mpgw_wk = table2array(xx);
% tw =xx.td;
% 
% tw_summer = tw(12:31);
% Mpgw_wk_sum = Mpgw_wk(12:31, :);
% [lowflow_sum, lowflow_sum_idx] = min(Mpgw_wk_sum)
% lowflow_sum_timing = tw_summer(lowflow_sum_idx)
% % change in peak f
% lowflowD = round(lowflow*100/lowflow(1))'
% plot(tw, Mpgw_wk)
% % 
% %% CV
% % start with CVB for the whole period, then fo it for each month
% load('D:\5_FuturePeyto\crhm\C_Scenarios\output\Scenario_bf.mat')
% load('D:\5_FuturePeyto\crhm\C_Scenarios\output\Scenario_bf.mat')
% % reshape into 15 years
% 
% for i = 1:16
%     x = var(:, i);
%     cv(i) = std(x)./nanmean(x);
% end 
% cvD = round(cv*100/cv(1))'
% 
% %% cv for summer month (July-Oct)
% a = datevec(tor);
% b = find(a(:, 2) == 6 | a(:, 2) == 7| a(:, 2) == 8| a(:, 2) == 9 | a(:, 2) == 10 );
% var_sht=var(b, :);
% 
% for i = 1:16
%  x = var_sht(:, i);
% cv_summer(i) = std(x)./nanmean(x);
% end 
% bar(cv_summer)
% xticks ([1:16])
% xticklabels (lab)
% xtickangle (90)
% ylabel ('CV')
% cvsummerD = round(cv_summer*100/cv_summer(1))'-100
% 
% titl = {'Jan','Feb','March','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
% lab = {'cur', 'pgw', 'I0','I8','I16',...
%     'NoSurf','Lake','Pond',...
%     'Soil1','Soil5','Soil10', 'Veg1','Veg4','Veg8',... 
%     'Wet', 'Dry'}';
% 
% %%
% 
% fig = figure('units','inches','position',[0 0 9 5]); 
% for i = 5:12
% subplot(2,4,i-4)
% bar(cv_monthly(:, i))
% title (titl{i})
% xticks ([1:16])
% xticklabels (lab)
% xtickangle (90)
% ylabel ('CV')
% % ylim ([0 1.8])
% xlim ([.5 16.5])
% end 
% 
% tightfig(fig)
% figname ='BasinflowScenario_MonthlyCV';
% saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))
% 
% 
% %% Peak flow values and date of peak flow 
% close all
% clear all
% 
% sz = size(VarPGW);
% for ii = 1:sz(2)% yr
% for i = 1:sz(3)%scenario
% pkfl(ii, i, 1) = max(VarPGW(:,ii,i));
% pkfl_idx (ii, i, 2) = find(max(VarPGW(:,ii,i)));
% end 
% end 
% 
% % date of peak flow
% for ii = 1:sz(2)% yr
% for i = 1:sz(3)%scenario
% x = VarPGW(:,ii,i);
% [xx, idx] = max(x);
% maxidx (ii, i) = idx;
% end 
% end 
% 
% for i = 1:16;
% datepk(:,i) = td(maxidx(:,i));
% end 
% 
% % how many differences?
% 
% for i = 1:16;
%     
%     diffdate(:, i) = datepk (:, 1) - datepk(:,i);
% 
% end 
% 
% diffdatedb= days(diffdate)
% 
% T = table (diffdatedb(:, 1), diffdatedb(:, 2),diffdatedb(:, 3),diffdatedb(:,4),...
%     diffdatedb(:, 5), diffdatedb(:,6),diffdatedb(:, 7),diffdatedb(:,8),...
%     diffdatedb(:, 9), diffdatedb(:, 10),diffdatedb(:, 11),diffdatedb(:,12),...
%     diffdatedb(:, 13),diffdatedb(:, 14),diffdatedb(:, 15), diffdatedb(:, 16));
% 
% lab = {'ref', 'Ice0','Ice8','Ice16',...
%     'NoPondNoLake','OnlyLake','OnlyPond',...
%     'Veg1','Veg4','Veg8',...
%     'SoilM1','SoilM5','SoilM10', 'Wet', 'Dry', 'CUR'};
%   T.Properties.VariableNames = lab;
% 
% writetable (T, 'D:\5_FuturePeyto\fig\D1b\PeakFlowDate_DaysDifference.csv') 
% 
% diffdatedb(diffdatedb==1) = 0;
% diffdatedb(diffdatedb==-1) = 0;
% 
% for i = 1:16;
%     x = diffdatedb(:, i);
%    xx = numel(find(x)); 
%    numdays(i) = xx;
% end 
% 
% numdays = numdays'
% T = table ({'ref'; 'Ice0';'Ice8';'Ice16';...
%     'NoPondNoLake';'OnlyLake';'OnlyPond';...
%     'Veg1';'Veg4';'Veg8';...
%     'SoilM1';'SoilM5';'SoilM10';'Wet'; 'Dry'; 'CUR'}, numdays)
%  
% writetable (T, 'D:\5_FuturePeyto\fig\D1b\PeakFlowDate_NumberofYrsChanged.csv') 
% 
% %% 
% yr = 2085:2098
% fig = figure('units','inches','position',[0 0 10 4]); 
% subplot(2,3,1)
% bar(yr,pkfl(:, [1:4])); hold on
% title ('Remaining ice')
% xlabel('Year');
% xtickangle (45)
% xlim ([2084.5 2098.5])
% ylabel('Peak Flow(m^3 s{-1})');
% lg = legend ( 'Ref', '16%','8%','0%', ...
%     'location', 'south', 'Orientation', 'Horizontal')
% ylim ([0 18]);
% lg.FontSize = 8;
% 
% subplot(2,3,2)
% bar(yr,pkfl(:, [1, 5:7])); hold on
% title ('Surface Water')
% lg = legend ('Ref','No Pond, No lake', 'Lake', 'Ponding', ...
%     'location', 'south', 'Orientation', 'Horizontal')
% xlabel('Year');
% xtickangle (45)
% xlim ([2084 2099])
% ylabel('Peak Flow(m^3 s{-1})');
% ylim ([0 18]);
% lg.FontSize = 8;
% 
% subplot(2,3,3)
% bar(yr,pkfl(:, [1, 8:10])); hold on
% title ('Vegetation')
% lg = legend ('Ref, 0%','15%','5%', '<1%',  ...
%     'location', 'south', 'Orientation', 'Horizontal')
% xlabel('Year');
% xtickangle (45)
% xlim ([2084 2099])
% ylabel('Peak Flow(m^3 s{-1})');
% ylim ([0 18]);
% lg.FontSize = 8;
% 
% subplot(2,3,4)
% bar(yr,pkfl(:, [1, 11:13])); hold on
% title ('Soil storage')
% lg = legend ('Ref,x2','x1', 'x5', 'x10', ...
%     'location', 'south', 'Orientation', 'Horizontal')
% xlabel('Year');
% xtickangle (45)
% xlim ([2084 2099])
% ylabel('Peak Flow(m^3 s{-1})');
% ylim ([0 18]);
% lg.FontSize = 8;
% 
% subplot(2,3,5)
% bar(yr,pkfl(:, [1, 14:16])); hold on
% title ('Soil storage')
% lg = legend ('Ref,x2','wet', 'dry', 'cur', ...
%     'location', 'south', 'Orientation', 'Horizontal')
% xlabel('Year');
% xtickangle (45)
% xlim ([2084 2099])
% ylabel('Peak Flow(m^3 s{-1})');
% ylim ([0 18]);
% lg.FontSize = 8;
% 
% figname ='PeakFlow_perScenario';
% saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))
% % what is the difference
% %% 
% for i = 1:16;
% pkfl_diff(:, i) = pkfl(:, i)-pkfl(:, 1);
% 
% end 
% 
% for i = 1:16;
% pkfl_prct(:, i) = pkfl(:, i)*100./pkfl(:, 1);
% end 
% 
% pkfl_diff_mn = mean(pkfl_diff);
% pkfl_diff_prct_mn = mean(pkfl_prct)-100;
% 
% fig = figure('units','inches','position',[0 0 8 7]); 
% 
% subplot(2,1,1)
% bar(pkfl_diff_mn)
% title ({'Difference in mean peakflow','(Scenario - Ref)'})
% xticks([1:16])
% xticklabels (lab);
% xtickangle (45)
% ylabel('Peak Flow difference (m^3 s{-1})');
% grid on
% 
% subplot(2,1,2)
% bar(pkfl_diff_prct_mn)
% title ({'% Difference in mean peakflow','(Scenario - Ref)'})
% xticks([1:16])
% xticklabels (lab);
% xtickangle (45)
% ylabel('% Difference in peak flow (m^3 s{-1})');
% grid on
% 
% figname ='PeakFlowDifference_mean';
% saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %% summer low flows
% 
% % 7 day low flow average
% % make 7 day average
% sz = size(VarPGW);
% for i = 1:16 %sz(3)
% x = timetable (td, VarPGW(:,:,i));
% xx = retime(x, 'weekly','mean');
% VarWk(1:53,1:14,i) = table2array(xx);
% tw =xx.td;
% end 
% % 
% % mean 
% % Cmpile the mean and stadard deviation
% for i = 1:sz(3)    
%           dd= VarWk(:,:,i);
%      Mwk(:, i) = nanmean(dd, 2);
%      STDevMwk (:, i) = nanstd(dd, 0, 2);
% end 
%  
% fig = figure('units','inches','position',[0 0 8 6]); 
% subplot(2,3,1)
% plot (tw, Mwk(:, 2:4)); hold on;
% plot (tw, Mwk(:, 1), 'k');
% title ('Remaining ice')
% legend ('0%', '8%', '16%', 'Ref, 5%', 'location', 'northeast')
% xtickformat ('dd-MMM')
% ylabel('Streamflow (m^3 s{-1})')
% xlim ([tw(1) tw(end)]);
% 
% subplot(2,3,2)
% plot (tw, Mwk(:, 5:7)); hold on;
% plot (tw, Mwk(:, 1), 'k');
% title ('Surface Water')
% legend ('No Ponding, No lake', 'Lake Only', 'Only Ponding', 'Ref, Lake + Ponding', 'location', 'northeast')
% xtickformat ('dd-MMM')
% ylabel('Streamflow (m^3 s{-1})')
% xlim ([tw(1) tw(end)]);
% 
% subplot(2,3,3)
% plot (tw, Mwk(:, 8:10)); hold on;
% plot (tw, Mwk(:, 1), 'k');
% title ('Vegetation')
% legend ('<1%', '5%', '15%', 'Ref, 0%', 'location', 'northeast')
% xtickformat ('dd-MMM')
% ylabel('Streamflow (m^3 s{-1})')
% xlim ([tw(1) tw(end)]);
% 
% subplot(2,3,4)
% plot(tw, Mwk(:, 11:13)); hold on
% plot(tw, Mwk(:, 1), 'k');
% title ('Soil storage')
% legend ('x1', 'x5', 'x10', 'Ref,x2', 'location', 'northeast')
% xtickformat ('dd-MMM')
% ylabel('Streamflow (m^3 s{-1})')
% xlim ([tw(1) tw(end)]);
% 
% subplot(2,3,5)
% plot(tw, Mwk(:, 14:15)); hold on
% plot(tw, Mwk(:, 1), 'k');
% title ('wetness')
% legend ('wet', 'dry',  'Ref,x2', 'location', 'northeast')
% xtickformat ('dd-MMM')
% ylabel('Streamflow (m^3 s{-1})')
% xlim ([tw(1) tw(end)]);
% figname ='BasinflowScenario_Mean7dayFlow';
% saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))
% 
% 
% % for continuous
%  load('D:\5_FuturePeyto\crhm\C_Scenarios\output\Scenario_bf.mat')
% % reshape into 15 years
% tor = t;
% var = [bfREF(367:end, 1), bfICE(367:end, :), bfLAK(367:end, :), bfVEG(367:end, :),...
%     bfGW(367:end, :), bfWET(367:end, :), bfREF(367:end, 2)];
% t = t(367:end, :);
% 
% 
% var = [bfREF(:, 1), bfICE, bfLAK, bfVEG, bfGW];
% x = timetable (tor, var);
% xx = retime(x, 'weekly','mean');
% varwkc = table2array(xx);
% twkc = xx.tor;
% 
% figure
% subplot(2,2,1)
% plot(twkc, varwkc(:, [2:4]));hold on
% plot(twkc, varwkc(:, 1), 'k');
% 
% subplot(2,2,2)
% plot(twkc, varwkc(:, [5:7]));hold on
% plot(twkc, varwkc(:, 1), 'k');
% 
% subplot(2,2,3)
% plot(twkc, varwkc(:, [8:10]));hold on
% plot(twkc, varwkc(:, 1), 'k');
% 
% subplot(2,2,4)
% plot(twkc, varwkc(:, [11:13]));hold on
% plot(twkc, varwkc(:, 1), 'k');
% 
% %% Table of montlhy streamflow
% sz = size(VarPGW);
% for i = 1:sz(3)
% x = timetable (td, VarPGW(:,:,i));
% xx = retime(x, 'monthly','sum');
% VarMth(1:12,1:14,i) = table2array(xx);
% tm =xx.td;
% end 
% % 
% % mean 
% % Cmpile the mean and stadard deviation
% for i = 1:16
%           dd= VarMth(:,:,i);
%      Mmth(:, i) = round(nanmean(dd, 2),2);
%      STDevMmth (:, i) = nanstd(dd, 0, 2);
% end
% 
% T = table (tm, Mmth(:, 1), Mmth(:, 2),Mmth(:, 3),Mmth(:, 4),Mmth(:, 5),...
%     Mmth(:, 6), Mmth(:, 7),Mmth(:, 8),Mmth(:, 9),Mmth(:, 10),...
%     Mmth(:, 11), Mmth(:, 12), Mmth(:, 13), Mmth(:, 14), Mmth(:, 15), Mmth(:, 16));
% 
% lab = {'month', 'ref', 'Ice0','Ice8','Ice16',...
%     'NoPondNoLake','OnlyLake','OnlyPond',...
%     'Veg1','Veg4','Veg8',...
%     'SoilM1','SoilM5','SoilM10', 'wet', 'dry', 'cur'}';
%  T.Properties.VariableNames = lab;
%  
% writetable (T, 'D:\5_FuturePeyto\fig\D1b\MonthlyStreamflow_Scenarios.csv') 
% 
% subplot (2,2,1)
% bar(1:16, Mmth(6, :))
% title ('June')
% xlim ([1.5 16.5])
% ylabel ('Monthly streamflow')
% xticks ([1:16]);
% xticklabels (lab)
% xtickangle (90)
% 
% subplot (2,2,2)
% bar(1:16, Mmth(7, :))
% title ('July')
% xlim ([1.5 16.5])
% ylabel ('Monthly streamflow')
% xticks ([1:16]);
% xticklabels (lab)
% xtickangle (90)
% 
% subplot (2,2,3)
% bar(1:16, Mmth(8, :))
% title ('Aug')
% xlim ([1.5 16.5])
% ylabel ('Monthly streamflow')
% xticks ([1:16]);
% xticklabels (lab)
% xtickangle (90)
% 
% subplot (2,2,4)
% bar(1:16, Mmth(9, :))
% title ('Sept')
% xlim ([1.5 16.5])
% ylabel ('Monthly streamflow')
% xticks ([1:16]);
% xticklabels (lab)
% xtickangle (90)
% 
% figname ='BasinflowScenario_SumFlowSummer';
% saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))
% 
% %% Minimum flow per month
% sz = size(VarPGW);
% for i = 1:sz(3)
% x = timetable (td, VarPGW(:,:,i));
% xx = retime(x, 'monthly','min');
% VarMth(1:12,1:14,i) = table2array(xx);
% tm =xx.td;
% end 
% % 
% % mean 
% % Cmpile the mean and stadard deviation
% for i = 1:16
%           dd= VarMth(:,:,i);
%      Mmth(:, i) = round(nanmean(dd, 2),2);
%      STDevMmth (:, i) = nanstd(dd, 0, 2);
% end
% 
% T = table (tm, Mmth(:, 1), Mmth(:, 2),Mmth(:, 3),Mmth(:, 4),Mmth(:, 5),...
%     Mmth(:, 6), Mmth(:, 7),Mmth(:, 8),Mmth(:, 9),Mmth(:, 10),...
%     Mmth(:, 11), Mmth(:, 12), Mmth(:, 13), Mmth(:, 14), Mmth(:, 15), Mmth(:, 16));
% 
% lab = {'month', 'ref', 'Ice0','Ice8','Ice16',...
%     'NoPondNoLake','OnlyLake','OnlyPond',...
%     'Veg1','Veg4','Veg8',...
%     'SoilM1','SoilM5','SoilM10', 'wet', 'dry', 'cur'}';
%  T.Properties.VariableNames = lab;
%  
% writetable (T, 'D:\5_FuturePeyto\fig\D1b\MinimumMonlthyStreamflow_Scenarios.csv') 
% 
% subplot (2,2,1)
% bar(1:16, Mmth(6, :))
% title ('June')
% xlim ([1.5 16.5])
% ylabel ('Minimum streamflow')
% xticks ([1:16]);
% xticklabels (lab)
% xtickangle (90)
% 
% subplot (2,2,2)
% bar(1:16, Mmth(7, :))
% title ('July')
% xlim ([1.5 16.5])
% ylabel ('Minimum streamflow')
% xticks ([1:16]);
% xticklabels (lab)
% xtickangle (90)
% 
% subplot (2,2,3)
% bar(1:16, Mmth(8, :))
% title ('Aug')
% xlim ([1.5 16.5])
% ylabel ('Minimum streamflow')
% xticks ([1:16]);
% xticklabels (lab)
% xtickangle (90)
% 
% subplot (2,2,4)
% bar(1:16, Mmth(9, :))
% title ('Sept')
% xlim ([1.5 16.5])
% ylabel ('Minimum streamflow')
% xticks ([1:16]);
% xticklabels (lab)
% xtickangle (90)
% figname ='BasinflowScenario_MinFlowSummer';
% saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))
% 
% %% centre of mass (50% flow)
% 
% % reshape into 15 years
% % for each year, cumulative
% td = t(tidx(1):tidx(2)-1);
% 
% % lets just do ir the for the reference run
% Refrun = VarPGW(:, :, 1);
% CumRun = cumsum(Refrun);
% 
% for i = 1:16; % scenario
% x = squeeze(VarPGW(:, :, i)); % scenario i, all years
% CumVarPgw = cumsum(x); % all the yeaRS
% CumSumPer = round(CumVarPgw*100./CumVarPgw (365, :));
% for ii = 1:14;
% dt50 = find(CumSumPer(:, ii) == 50, 1)
% if isempty(dt50)
%    dt50 = find(CumSumPer(:, ii) == 51, 1)
% end 
% Date50(i, ii)= dt50;
% end 
% end 
% 
% %% do this analysis on the mean
% CumSumMean = cumsum(Mpgw);
% CumSumPerMean = round(CumSumMean*100./CumSumMean(365, :));
% 
% for i = 1:16
%   dt50(i) = find(CumSumPerMean(:, i) == 50, 1)
% end 
% td(dt50);
% 
% T = table(td(dt50));
% writetable (T, 'D:\5_FuturePeyto\fig\D1b\Dateof50Percentflow_PerScenarioMean.csv')
% 
% fig = figure('units','inches','position',[0 0 8 6]); 
% subplot(2,3,1)
% plot(td, CumSumMean(:,2:4)); hold on
% plot(td, CumSumMean(:,1), 'k');
% plot(td, CumSumMean(:,16), ':k');
% 
% subplot(2,3,2)
% plot(td, CumSumMean(:,5:7)); hold on
% plot(td, CumSumMean(:,1), 'k');
% plot(td, CumSumMean(:,16), ':k');
% 
% 
% subplot(2,3,3)
% plot(td, CumSumMean(:,8:10)); hold on
% plot(td, CumSumMean(:,1), 'k');
% plot(td, CumSumMean(:,16), ':k');
% 
% subplot(2,3,4)
% plot(td, CumSumMean(:,11:13)); hold on
% plot(td, CumSumMean(:,1), 'k');
% plot(td, CumSumMean(:,16), ':k');
% 
% 
% subplot(2,3,5)
% plot(td, CumSumMean(:,14:15)); hold on
% plot(td, CumSumMean(:,1), 'k');
% plot(td, CumSumMean(:,16), ':k');
% 
% figname ='CumulativeStreamflow_PerScenarios';
% saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))
% 
% 
% 
% % find 50%
% for i = 1:16
% x = squeeze(CumVarPgw(:,:,i));
% tots = x(365, :);
% xper(:,:,i) = x*100./tots;
% end 
% 
% for ii = 1:13;
% for i = 1:13
% a = round(xper(:,:,ii));
% [b(i, ii)]  = find(a(:, i) == 50);
% end 
% end
% 
% %%
% % slope of hdyrograph from summer peak to fall baseflow
% % do tha on the weekly or monglthy curve?
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% CV of streamflow
% % std(x)./mean(x)
% 
% % start with CVB for the whole period, then fo it for each month
% var = [bfREF(:, 1), bfICE, bfLAK, bfVEG, bfGW, bfWET, bfREF(:, 2)];
% 
% for i = 1:16
%     x = var(:, i);
%     cv(i) = std(x)./nanmean(x);
% end 
% bar(cv)
% 
% % For each month
% a = datevec(tor);
% for ii = 1:12; 
% for i = 1:16
% b = find(a(:, 2) == ii); 
%  x = var(b, i);
% cv_monthly(i, ii) = std(x)./nanmean(x);
% end 
% end 
% 
% titl = {'Jan','Feb','March','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
% lab = {'ref', 'I0','I8','I16',...
%     'NoSurf','Lake','Pond',...
%     'Veg1','Veg4','Veg8',...
%     'Soil1','Soil5','Soil10', 'Wet', 'Dry', 'CUR'}';
% 
% fig = figure('units','inches','position',[0 0 9 5]); 
% 
% for i = 5:12;
% subplot(2,4,i-4)
% bar(cv_monthly(:, i))
% title (titl{i})
% xticks ([1:16])
% xticklabels (lab)
% xtickangle (90)
% ylabel ('CV')
% % ylim ([0 1.8])
% xlim ([.5 16.5])
% end 
% 
% tightfig(fig)
% figname ='BasinflowScenario_MonthlyCV';
% saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% flow duration curve
% % only keep melt period (Apr 15-Dec 15)
% tmelt = tor;
% sz = size (var);
% timevec = datevec(tmelt);
% a = find(timevec(:,2) == 1 |timevec(:,2) == 2|timevec(:,2) == 3);
% var(a, :) = []; % remove jan-feb-march
% timevec(a, :) = [];
% 
% 
% var(find(timevec(:,2) == 4 & timevec(:,3)<15), :) = []; % remove dec 16-31
% timevec(find(timevec(:,2) == 4 & timevec(:,3)<15), :) = [];
% var(find(timevec(:,2) == 12 & timevec(:,3) >15), :) = []; % remove apri 1-15
% timevec(find(timevec(:,2) == 12 & timevec(:,3) >15), :) = [];
% 
% bf_mod = var(:, 2:16);
% bf_meas = var(:, 1);
% bf_mod_srt = sort(bf_mod, 'descend');
% M = 1:length(bf_mod_srt);
% n = length(bf_mod_srt);
% P_mod = 100*(M/(n+1));
% bf_meas_srt = sort(bf_meas, 'descend');
% 
% subplot(2,3,1)
% plot(P_mod,bf_mod_srt(:, 1:3)); hold on
% plot(P_mod, bf_meas_srt, 'k');
% 
% subplot(2,3,2)
% plot(P_mod,bf_mod_srt(:, 4:6)); hold on
% plot(P_mod, bf_meas_srt, 'k');
% 
% subplot(2,3,3)
% plot(P_mod,bf_mod_srt(:, 7:9)); hold on
% plot(P_mod, bf_meas_srt, 'k');
% 
% subplot(2,3,4)
% plot(P_mod, bf_mod_srt(:, 10:12)); hold on
% plot(P_mod, bf_meas_srt, 'k');
% 
% subplot(2,3,5)
% plot(P_mod, bf_mod_srt(:, 13:15)); hold on
% plot(P_mod, bf_meas_srt, 'k');
% 
% figname ='BasinflowScenario_FCD';
% saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))
% 
% 
% %% extra stuff
% % td = t(1:365);
% % figure
% % for i = 1:3
% % subplot(2,2,1)
% % plot (td, bfREF- bfICE(:, i)); hold on;
% % title ('Leftover ice')
% % 
% % subplot(2,2,2)
% % plot (td,  bfREF-bfLAK(:, i)); hold on;
% % title ('Proglacial lake')
% % 
% % subplot(2,2,3)
% % plot (t,  bfREF-bfVEG(:, i)); hold on;
% % title ('Vegetation')
% % 
% % subplot(2,2,4)
% % plot (td, bfREF- bfGW(:, i)); hold on;
% % title ('Soil storage')
% % end 
% % %%
% % figure
% % for i = 1:3
% % subplot(2,2,1)
% % plot (t,  cumsum(abs(bfREF- bfICE(:, i)))); hold on;
% % title ('Leftover ice')
% % 
% % subplot(2,2,2)
% % plot (t,  cumsum( abs(bfREF-bfLAK(:, i)))); hold on;
% % title ('Proglacial lake')
% % 
% % subplot(2,2,3)
% % plot (t,   cumsum(abs(bfREF-bfVEG(:, i)))); hold on;
% % title ('Vegetation')
% % 
% % subplot(2,2,4)
% % plot (t, cumsum(abs(bfREF- bfGW(:, i)))); hold on;
% % title ('Soil storage')
% % end 
% % 
% % %% Cumulative plot 
% % subplot(2,2,1)
% % plot (t, bfICE); hold on;
% % plot(t, bfREF, 'k');
% % title ('Leftover ice')
% % 
% % subplot(2,2,2)
% % plot (t, bfLAK); hold on;
% % plot(t, bfREF, 'k');
% % title ('Proglacial lake')
% % 
% % subplot(2,2,3)
% % plot (t, bfVEG); hold on;
% % plot(t, bfREF, 'k');
% % title ('Vegetation')
% % 
% % subplot(2,2,4)
% % plot (t, bfGW); hold on;
% % plot(t, bfREF, 'k');
% % title ('Soil storage')
% % 
% % figname ='BasinflowScenario';
% % saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% % saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% % savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))
% % 
% % %%
% % %% coefficient of variation
% % subplot(2,2,1)
% % plot (t(365:end), cumsum(bfICE(365:end,:))); hold on;
% % plot(t(365:end), cumsum(bfREF(365:end,:)), 'k');
% % title ('Leftover ice')
% % 
% % subplot(2,2,2)
% % plot (t(365:end), cumsum(bfLAK(365:end,:))); hold on;
% % plot(t(365:end), cumsum(bfREF(365:end,:)), 'k');
% % title ('Proglacial lake')
% % 
% % subplot(2,2,3)
% % plot (t(365:end), cumsum(bfVEG(365:end,:))); hold on;
% % plot(t(365:end), cumsum(bfREF(365:end,:)), 'k');
% % title ('Vegetation')
% % 
% % subplot(2,2,4)
% % plot (t(365:end), cumsum(bfGW(365:end,:))); hold on;
% % plot(t(365:end), cumsum(bfREF(365:end,:)), 'k');
% % title ('Soil storage')
% % 
% % figname ='BasinflowHourlyScenario';
% % saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% % saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% % savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))
% % %% coefficient of variation
% % CVar = std([bfREF, bfICE, bfLAK, bfVEG, bfGW])./nanmean([bfREF, bfICE, bfLAK, bfVEG, bfGW]);
% % bar(CVar)
% % %% Annual average
% % % reshape in 15 columen, for average of the 15 years
% % % compile in basin average
% % %% table of output
% % REF = Mpgw(:, 13);
% % deltaChange = (sum(Mpgw)-sum(REF))'
% % TotalVolPGW = sum(Mpgw)'
% % PercentChange = (sum(Mpgw)./sum(REF)*100 - 100)'
% % 
% % varname = {'ICE1','ICE2','ICE3','LAK1','LAK2','LAK3','VEG1','VEG2','VEG3','GW1','GW2','GW3','REF'}';
% % Scenario_annual_basinflow = table(varname, TotalVolPGW, deltaChange, PercentChange);
% % writetable(Scenario_annual_basinflow , 'D:\5_FuturePeyto\fig\D1b\ChangeStreamflowScenario_Cur_PGW.csv')
% % 
% % figure
% % subplot(2,2,1)
% % plot (cumsum(Mpgw(:, 13)), 'k'); hold on
% % plot (cumsum(Mpgw(:, 1:3)), 'b');
% % subplot(2,2,2)
% % plot (cumsum(Mpgw(:, 13)), 'k'); hold on
% % plot (cumsum(Mpgw(:, 4:6)), 'c'); 
% % subplot(2,2,3)
% % plot (cumsum(Mpgw(:, 13)), 'k'); hold on
% % plot (cumsum(Mpgw(:, 7:9)), 'g');
% % subplot(2,2,4)
% % plot (cumsum(Mpgw(:, 13)), 'k');  hold on
% % plot (cumsum(Mpgw(:, 10:12)), 'm');
% % 
% % 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
