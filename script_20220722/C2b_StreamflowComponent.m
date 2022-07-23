%% B3_Changes in streamflow components
% create a 5 panel graph with streamflow composition: icemelt, firnmelt,
% snowmelt and streamflow. each subplot has the current and future on it
% to do: clean up the variable names to make the code more efficient
close all
clear all

% load variables
 load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat','SWEmeltCUR', 'icemeltCUR', 'firnmeltCUR','basinflowCUR', 'timeCUR')
 load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat','SWEmeltPGW', 'icemeltPGW', 'firnmeltPGW', 'basinflowPGW')
hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 
basinarea = sum(hruarea); % m2


% compile in basin average
% Variable: basinflow, swemelt, firnmelt, icemelt, rainfall runoff
var = basinflowCUR/basinarea*1000; % m3/hr / m2 * 1000 = mm/hr
CUR(:, 1) = var;
var = SWEmeltCUR*0.001 /24; % m/hr
var = sum(var.*hruarea,2);% m3/hr - total volume/hr for each hru the entire catchment
var = var/basinarea * 1000; % mm (height of water distributed acorss the whole ctahcment, for each hour)
CUR(:, 2) = var;
var = (icemeltCUR + firnmeltCUR)*0.001 /24; % m/hr
var = sum(var.*hruarea,2);% m3/hr - total volume/hr for each hru the entire catchment
var = var/basinarea * 1000; % mm (height of water distributed acorss the whole ctahcment, for each hour)
CUR(:, 3) = var;

var = basinflowPGW/basinarea*1000; % m3/hr / m2 * 1000 = mm/hr
PGW(:, 1) = var;
var = SWEmeltPGW*0.001 /24; % m/hr
var = sum(var.*hruarea,2);% m3/hr - total volume/hr for each hru the entire catchment
var = var/basinarea * 1000; % mm (height of water distributed acorss the whole ctahcment, for each hour)
PGW(:, 2) = var;
var = (icemeltPGW + firnmeltPGW)*0.001 /24; % m/hr
var = sum(var.*hruarea,2);% m3/hr - total volume/hr for each hru the entire catchment
var = var/basinarea * 1000; % mm (height of water distributed acorss the whole ctahcment, for each hour)
PGW(:, 3) = var;

% remove the first yr
 PGW(1:8784, :) = [];
 CUR(1:8784, :) = [];
 timeCUR(1:8784, :) = [];

%%
% reshape each variable into water year values - acocunt for leap year
% 9remove Feb 29), and has to be applied differenlty for pre 2010, post
% 2010 and final year as it ends on sept 27
sz = size(PGW);
timevec = datevec(timeCUR);
PGW(find(timevec(:,2) == 2 & timevec(:,3) == 29), :) = []; % remove leap years days
CUR(find(timevec(:,2) == 2 & timevec(:,3) == 29), :)  = [];
timeCUR(find(timevec(:,2) == 2 & timevec(:,3) == 29)) =[]; 
timevec = datevec(timeCUR);
tidx = find(timevec(:, 2) ==10& timevec(:, 3) == 1 & timevec(:, 4) == 1);
tidx(16) = length(timeCUR)
timeCUR(tidx)

% remove the first year as well

% rehape into 15 years
for ii = 1:sz(2)
     varCUR = CUR(:,ii);
     varPGW= PGW(:,ii);
for i = 1:length(tidx)-1
    if i <=14
   varRSHP_CUR(:, i) = varCUR(tidx(i):tidx(i+1)-1);
   varRSHP_PGW(:, i) = varPGW(tidx(i):tidx(i+1)-1);

    else 
   varRSHP_CUR(:, i) = [varCUR(tidx(i):tidx(i+1)); nan(8759-(tidx(16)-tidx(15)), 1)];
   varRSHP_PGW(:, i) = [varPGW(tidx(i):tidx(i+1)); nan(8759-(tidx(16)-tidx(15)), 1)];
  end 
end 
VarCUR(:,:,ii) = varRSHP_CUR;
VarPGW(:,:,ii) = varRSHP_PGW;

end

% Compile into daily averages (mm/day)
t =  (datetime('01-Oct-2000 01:00'):hours(1):datetime('01-Oct-2001 00:00'))';
for i= 1:sz(2)
    d =VarCUR(:,:,i) ;
x = timetable (t,d);
xx = retime(x, 'daily', 'sum');
Vd(:,:,i)= table2array(xx);
td= xx.t;
    dd =VarPGW(:,:,i) ;
x = timetable (t,dd);
xx = retime(x, 'daily', 'sum');
Vdd(:,:,i)= table2array(xx);
td = xx.t;
end

% Cmpile the mean and stadard deviation
for i = 1:sz(2)
     d= Vd(:,:,i);
     M(:, i) = nanmean(d, 2);
     STDev (:, i) = nanstd(d, 0, 2);
     
          dd= Vdd(:,:,i);
     Mpgw(:, i) = nanmean(dd, 2);
     STDevpgw (:, i) = nanstd(dd, 0, 2);
end 

%% table of output
deltaChange = round(sum(Mpgw)-sum(M))'
TotalVolHist = round(sum(M))'
TotalVolPGW = round(sum(Mpgw))'
PercentChange = round(sum(Mpgw)./sum(M)*100 - 100)'

varname = {'streamflow'; 'snowmelt'; 'icemelt'};
flowcomponent_annual = table(varname, TotalVolHist, TotalVolPGW, deltaChange, PercentChange)
writetable(flowcomponent_annual, 'D:\FuturePeyto\fig\C2b\Stats_ChangeinFlowComp_Cur_PGW.csv')

%% Plot outputs
fig = figure('units','inches','position',[0 0 8 8]); 
subplot (3,1,1)
p1 = plot(td,Vd(:, :, 1), 'Color', [.5 .5 .5 .8]); hold on
p2 = plot(td,Vdd(:, :, 1),'Color', [255 102 102 200]/255);
p11 = plot(td,M(:, 1), 'Color', 'k', 'linewidth', 1.5); hold on
p22 = plot(td,Mpgw(:,1),'Color', 'r', 'linewidth', 1.5);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([0 85]);
yticks ([0:20:80]);
ylabel ({'Streamflow (mm)'});
lg = legend ([p1(1) p2(1) p11(1)  p22(1)], 'CTRL, mean',  'PGW, mean','CTRL, individual year', 'PGW, individual year', 'Location', 'NorthWest')
lg.FontSize = 8;

subplot (3,1,2)
p1 = plot(td,Vd(:, :, 2), 'Color', [.5 .5 .5 .8]); hold on
p2 = plot(td,Vdd(:, :, 2),'Color', [255 102 102 200]/255);
p11 = plot(td,M(:, 2), 'Color', 'k', 'linewidth', 1.5); hold on
p22 = plot(td,Mpgw(:,2),'Color', 'r', 'linewidth', 1.5);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([0 130]);
yticks ([0:40:120]);
ylabel ({'Snowmelt (mm)'});
lg.FontSize = 8;

subplot (3,1,3)
p1 = plot(td,Vd(:, :, 3), 'Color', [.5 .5 .5 .8]); hold on
p2 = plot(td,Vdd(:, :, 3),'Color', [255 102 102 200]/255);
p11 = plot(td,M(:, 3), 'Color', 'k', 'linewidth', 1.5); hold on
p22 = plot(td,Mpgw(:,3),'Color', 'r', 'linewidth', 1.5);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([0 35]);
yticks ([0:10:30]);
ylabel ({'Icemelt (mm)'});
lg.FontSize = 8;

%
figname ='StreamflowComponent_CUR_PGW_lines';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\C2b\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\C2b\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\C2b\', figname))

%% Plot outputs
t = [M(:, 1) M(:, 1)+STDev(:, 1) M(:, 1)-STDev(:, 1)]';
ea =[M(:, 2) M(:, 2)+STDev(:, 2) M(:, 2)-STDev(:, 2)]';
u = [M(:, 3) M(:, 3)+STDev(:, 3) M(:, 3)-STDev(:, 3)]';

tpgw = [Mpgw(:, 1) Mpgw(:, 1)+STDevpgw(:, 1) Mpgw(:, 1)-STDevpgw(:, 1)]';
eapgw = [Mpgw(:, 2) Mpgw(:, 2)+STDevpgw(:, 2) Mpgw(:, 2)-STDevpgw(:, 2)]';
upgw = [Mpgw(:, 3) Mpgw(:, 3)+STDevpgw(:, 3) Mpgw(:, 3)-STDevpgw(:,3)]';

fig = figure('units','inches','position',[0 0 6 8]); 
subplot (3,1,1)
stdshade(t, .4,'k',td, 1) ; hold on
stdshade(tpgw, .4,'r',td, 1) ;
ylabel ({'Daily Mean','Streamflow (mm)'})
lg = legend ('Current st. dev','CUR average', 'PGW st. dev','PGW average', 'Orientation', 'Horizontal')
set(lg, 'Position', [0.5 0.97 0 0])
ylim([0 50])
yticks([0:20:60])
xtickformat ('dd-MMM')
text (td(2), 40, {strcat('Hist = ', num2str(TotalVolHist(1)), 'mm'),...
    strcat('PGW = ', num2str(TotalVolPGW(1)), 'mm'), ...
    strcat('Change =', num2str(PercentChange(1)), '%')})

subplot (3,1,2)
stdshade(ea, .4,'k',td, 1) ; hold on
stdshade(eapgw, .4,'r',td, 1) ; 
ylabel ({'Daily Mean','Snowmelt (mm)'})
ylim([0 50])
yticks([0:20:60])
xtickformat ('dd-MMM')
text (td(2), 40, {strcat('Hist = ', num2str(TotalVolHist(2)), 'mm'),...
    strcat('PGW = ', num2str(TotalVolPGW(2)), 'mm'), ...
    strcat('Change =', num2str(PercentChange(2)), '%')})

subplot (3,1,3)
stdshade(u, .4,'k',td, 1) ; hold on
stdshade(upgw, .4,'r',td, 1) ;
ylabel ({'Daily Mean',' Icemelt (mm)'})
ylim([0 50])
yticks ([0:20:60])
xtickformat ('dd-MMM')
text (td(2), 40, {strcat('Hist = ', num2str(TotalVolHist(3)), 'mm'),...
    strcat('PGW = ', num2str(TotalVolPGW(3)), 'mm'), ...
    strcat('Change =', num2str(PercentChange(3)), '%')})
%
figname ='StreamflowComponent_CUR_PGW';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\C2b\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\C2b\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\C2b\', figname))

%% Monthly basinflow
x = timetable(td, [M, Mpgw]);
xx= retime(x, 'monthly','sum');
Mm = table2array(xx);
tm = xx.td;

xlab = ['Oct';'Nov';'Dec';'Jan';'Feb';'Mar';'Apr';'May';'Jun';'Jul';'Aug';'Sep'];
fig = figure('units','inches','position',[0 0 6 6]); 
subplot(3,1,1);
b = bar(1:12, Mm(1:12, [1,4]))
b(1).FaceColor = 'k';
b(2).FaceColor = 'r';
xticklabels (xlab)
xlim ([0.5 12.5])
ylim ([0 600])
ylabel('Monthly Streamflow (mm)')
text (0.6, 550, '(a)')
legend ('CUR', 'PGW', 'location', 'north')

subplot(3,1,2);
b = bar(1:12, Mm(1:12, [2,5]))
b(1).FaceColor = 'k';
b(2).FaceColor = 'r';
ylabel ('Monthly Snowmelt (mm)')
xticklabels (xlab)
xlim ([0.5 12.5])
ylim ([0 800])
text (0.6,720, '(b)')

subplot(3,1,3);
b= bar(1:12, Mm(1:12, [3,6]))
b(1).FaceColor = 'k';
b(2).FaceColor = 'r';
ylabel ('Monthly Icemelt (mm)')
xlim ([0.5 12.5])
ylim ([0 400])
xticklabels (xlab)
text (0.6, 370, '(c)')


figname ='StreamflowComponent_CUR_PGW_Monthly';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\C2b\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\C2b\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\C2b\', figname))

%%
clear deltaChange PercentChange
for i = 1:12;
deltaChange(i, 1:3) = round(Mm(i, 4:6)-Mm(i, 1:3));
PercentChange (i, 1:3)= round(Mm(i, 4:6)./Mm(i, 1:3)*100 - 100);
end 
StreamflowChange=deltaChange(:, 1);
SnowmeltChange=deltaChange(:, 2);
IcemeltChange=deltaChange(:, 3);
StreamflowPerc=PercentChange(:, 1);
SnowmeltPerc=PercentChange(:, 2);
IcemeltPerc=PercentChange(:, 3);

varname = {'Oct'; 'Nov'; 'Dec';'Jan'; 'Feb'; 'Mar';'Apr'; 'May'; 'June';'Jul'; 'Aug'; 'Sep'};
flowcomponent_monthly = table(varname, StreamflowChange,StreamflowPerc, SnowmeltChange, SnowmeltPerc, IcemeltChange,IcemeltPerc );
writetable(flowcomponent_monthly, 'D:\FuturePeyto\fig\C2b\Stats_ChangeinFlowComp_Cur_PGW_Monthly.csv')

