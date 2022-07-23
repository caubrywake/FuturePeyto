% edited by Caroline Aubry-Wake, June 3, 2020
close all
clear all
%% basinflo

% load variables
 load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat','basinflowCUR', 'timeCUR')
 load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat', 'basinflowPGW')
hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 
basinarea = sum(hruarea); % m2


% compile in basin average
% Variable: basinflow, swemelt, firnmelt, icemelt, rainfall runoff
var = [basinflowCUR basinflowPGW]/basinarea*1000 ; % m3/hr / m2 * 1000 = mm/hr
bf = var;

% load variables
 load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat',...
     'hru_rainCUR','hru_snowCUR','hru_actetCUR','hru_sublCUR','hru_driftCUR',...
     'cumSWE_outCUR','cumSWE_inCUR','icemeltCUR','firnmeltCUR','SWEmeltCUR',...
     'soil_moistCUR', 'gwCUR','E_intCUR', 'timeCUR')

 load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat',...
     'hru_rainPGW','hru_snowPGW','hru_actetPGW','hru_sublPGW','hru_driftPGW',...
    'cumSWE_outPGW','cumSWE_inPGW','icemeltPGW','firnmeltPGW','SWEmeltPGW',...
     'soil_moistPGW', 'gwPGW','E_intPGW','timePGW')
 
 hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 
basinarea = sum(hruarea); % m2

%%
clear PGW CUR
VAlab = {'Rain', 'Snow', 'Evaporation', 'Sd', 'Blowing Snow Sublimation' ,...
    'Blowing Snow Transport', 'Avalanche Transport', 'Icemelt', 'Snowmelt', ...
    'Soil Moisture', 'Groundwater Storage'};
avyinCUR = [zeros(1, 37); diff(cumSWE_inCUR)];
avyoutCUR = [zeros(1, 37); diff(cumSWE_outCUR)];
avyinPGW = [zeros(1, 37); diff(cumSWE_inPGW)];
avyoutPGW = [zeros(1, 37); diff(cumSWE_outPGW)];

E_intCUR(E_intCUR<0)=0;
E_intPGW(E_intPGW<0)=0;

VA = cat(3, hru_rainCUR, hru_snowCUR, hru_actetCUR+E_intCUR,...
hru_sublCUR, abs(hru_driftCUR), avyoutCUR,  ...
(icemeltCUR + firnmeltCUR)/24, SWEmeltCUR/24, soil_moistCUR, gwCUR);

VB = cat(3, hru_rainPGW, hru_snowPGW, hru_actetPGW+E_intPGW, ...
hru_sublPGW, abs(hru_driftPGW), avyoutPGW,  ...
(icemeltPGW + firnmeltPGW)/24, SWEmeltPGW/24, soil_moistPGW, gwPGW);

sz= size(VA);
for i = 1:sz(3)
    if i == 9||  i==10 % specifal case soil moisture and storgae
    va = VA(:,:,i)*0.001;   va = nanmean(va.*hruarea,2); va = va/basinarea * 1000; 
    vb = VB(:,:,i)*0.001;   vb = nanmean(vb.*hruarea,2); vb = vb/basinarea * 1000; 
    else
    va = VA(:,:,i)*0.001; % mm to m
    va = sum(va.*(hruarea),2); % m*m2 = m3
    va = va/basinarea * 1000; % m3/area - back to mm
    
    vb = VB(:,:,i)*0.001; 
    vb = sum(vb.*(hruarea),2);
    vb = vb/basinarea * 1000; 
    end 
  CUR(:, i) = va;
  PGW (:, i) = vb; 
end 
clear hru_rainCUR hru_snowCUR hru_actetCUR hru_sublCUR hru_driftCUR...
    cumSWE_inCUR cumSWE_outCUR icemeltCUR firnmeltCUR SWEmeltCUR soil_moistCUR...
    gwCUR gw_flowCUR hru_rainPGW hru_snowPGW hru_actetPGW hru_sublPGW hru_driftPGW...
    cumSWE_inPGW cumSWE_outPGW icemeltPGW firnmeltPGW SWEmeltPGW soil_moistPGW...
    gwPGW gw_flowPGW VA VB va vb i 
% add streamflow
CUR(:, 11)= bf(:, 1);
PGW(:, 11)= bf(:, 2);
PGW(1:8784, :) = [];
CUR(1:8784, :) = [];
timeCUR(1:8784, :) = [];
timePGW(1:8784, :) = [];


% 
VAlab = {'Rain', 'Snow', 'Evaporation', 'Blowing Snow Sublimation' ,...
    'Blowing Snow Transport', 'Avalanche Transport', 'Icemelt', 'Snowmelt', ...
    'Soil Moisture', 'Groundwater Storage'};

% figure; plot(timeCUR, cumsum(CUR(:, 1)));hold on
% plot(timeCUR, cumsum(PGW(:, 1)))
% title ('Rain')
% 
% figure; plot(timeCUR, cumsum(CUR(:, 2)));hold on
% plot(timeCUR, cumsum(PGW(:, 2)))
% title ('Snow')
% 
% figure; plot(timeCUR, cumsum(CUR(:, 3)));hold on
% plot(timeCUR, cumsum(PGW(:, 3)))
% title ('Evaporation')
% 
% figure; plot(timeCUR, cumsum(CUR(:, 4)));hold on
% plot(timeCUR, cumsum(PGW(:, 4)))
% title ('Blowing Snow Sublimation');
% 
% figure; plot(timeCUR, cumsum(CUR(:, 5))); hold on
% plot(timeCUR, cumsum(PGW(:, 5)))
% title ('Blowing Snow Transport')
% 
% figure; plot(timeCUR, CUR(:, 6));hold on
% plot(timeCUR, PGW(:, 6))
% title('Avalanche Transport')
% 
% figure;plot(timeCUR, CUR(:, 7));hold on
% plot(timeCUR, PGW(:, 7))
% title('Icemelt')
% 
% figure;plot(timeCUR, CUR(:, 8));hold on
% plot(timeCUR, PGW(:, 8))
% title('Snowmelt')
% 
% figure; plot(timeCUR, CUR(:, 9));hold on
% plot(timeCUR, PGW(:, 9))
% title('Soil Moisture')
% 
% figure; plot(timeCUR, CUR(:, 10));hold on
% plot(timeCUR, PGW(:, 10))
% title('Groundwater Storage')


%% Housekeeping
% remove leap year, add nan to complete 2015 year
clear  t d VarOut VarA 
% find and remove all the feb 29
x = datevec(timeCUR);
a = find(x(:, 2)== 2 & x(:, 3)==29);
timeCUR(a) = [];
CUR(a, :) = []; PGW(a, :) = [];
% add nan to end of 2015 to make it a full water year (3 days)
textra = timeCUR(end)+hours(1):hours(1):datetime('01-Oct-2015 00:00:00');
timeCUR= [timeCUR; textra'];
% textra = timePGW(end)+hours(1):hours(1):datetime('01-Oct-2099 00:00:00');
% timePGW= [timePGW; textra'];
% pad the data with nan 
sz = size(PGW);
pad = nan(length(textra),sz(2)) ;
CUR = [CUR; pad]; PGW = [PGW;pad];
clear a pad textra x 
%% Reshape in 15 column (for each year)
clear va va VA VB
for ii = 1:sz(2)
    va = reshape (CUR(:,ii), 8760, 15);
    VA(:,:,ii) = va;
    vb = reshape (PGW(:,ii), 8760, 15);
    VB(:,:,ii) = vb; 
end 
CURyr = VA;
PGWyr = VB;

% CURyrsum = cumsum(CURyr);
% PGWyrsum = cumsum(PGWyr);

clear va vb VA VB

%% Daily values
clear yr
yr =  (datetime('01-Oct-2000 00:00:00'):hours(1):datetime('30-Sep-2001 23:00:00'))';
for i= 1:sz(2)
    va  =CURyr(:,:,i) ;
    x = timetable (yr,va);
    xx = retime(x, 'daily', 'sum');
    VA(:,:,i)= table2array(xx);
    td= xx.yr;

    vb =PGWyr(:,:,i) ;
    x = timetable (yr,vb);
    xx = retime(x, 'daily', 'sum');
    VB(:,:,i)= table2array(xx);
end
CURdaily = VA;
PGWdaily = VB;

CURdaily(:, :, 1:8) = cumsum(CURdaily(:, :, 1:8));
PGWdaily(:, :, 1:8) = cumsum(PGWdaily(:, :, 1:8));
clear x xx VA VB va vb
%% Daily mean average

% Compile mean and Std
for i = 1:sz(2)
     va = CURdaily(:,:,i);
     CURmean(:, i) = nanmean(va, 2);
     CURstd (:, i) = nanstd(va, 0, 2);
     vb= PGWdaily(:,:,i);
     PGWmean(:, i) = nanmean(vb, 2);
     PGWstd (:, i) = nanstd(vb, 0, 2);
end 
clear va vb

%% test correlation and significance
for i =1:11
    [hp(i, 1) , hp(i, 2) ] = ttest(CURmean(:, i), PGWmean(:, i))
end 
h = hp(:, 1);
p = hp(:, 2);
varname = {'rainfall'; 'snowfall'; 'evaporation'; 'blowing snow sublimation'; 'blowinf snow transp'; 'avalanche';  'icemelt'; 'snowmelt';'soil moisture'; 'GW storage'; 'basinflow'};
significancetable =table(varname, h, p)

%% Make a table with these variables
for i= 1:sz(2)
 va = CURmean(:,i) ;
 vb = PGWmean(:,i);
 if i <9 
 CURtotal (i,1) = va(end-1);
 PGWtotal (i,1) = vb(end-1);
 else 
 CURtotal (i,1) = sum(va);
 PGWtotal (i,1) = sum(vb);
%  else
%  CURtotal (i,1) = nanmean(va);
%  PGWtotal (i,1) = nanmean(vb);
 end 
end 
varname = {'rainfall'; 'snowfall'; 'evaporation'; 'blowing snow sublimation'; 'blowinf snow transp'; 'avalanche';  'icemelt'; 'snowmelt';'soil moisture'; 'GW storage'; 'basinflow'};
PGWtotal = round(PGWtotal);
CURtotal = round(CURtotal);
Diff_PGW_CUR = round(PGWtotal - CURtotal);
PercentChange = round(((PGWtotal./CURtotal)*100) - 100);
fluxes_annual =table(varname, CURtotal, PGWtotal, Diff_PGW_CUR, PercentChange)
writetable(fluxes_annual, 'D:\5_FuturePeyto\fig\C2c\Stats_ChangeinAnnualFluxes_Cur_PGW.csv')

%% Plot outputs
M = CURmean;
Mpgw = PGWmean;
STDev = CURstd;
STDevpgw= PGWstd;
%%
x1 = [M(:, 1) M(:, 1)+STDev(:, 1) M(:, 1)-STDev(:, 1)]';
x2 =[ M(:, 2) M(:, 2)+STDev(:, 2) M(:, 2)-STDev(:, 2)]';
x3 = [M(:, 3) M(:, 3)+STDev(:, 3) M(:, 3)-STDev(:, 3)]';
x4 = [M(:, 4) M(:, 4)+STDev(:, 4) M(:, 4)-STDev(:, 4)]';
x5 = [M(:, 5) M(:, 5)+STDev(:, 5) M(:, 5)-STDev(:, 5)]';
x6 = [M(:, 6) M(:, 6)+STDev(:, 6) M(:, 6)-STDev(:, 6)]';
x7 = [M(:, 7) M(:, 7)+STDev(:, 7) M(:, 7)-STDev(:, 7)]';
x8 = [M(:, 8) M(:, 8)+STDev(:, 8) M(:, 8)-STDev(:, 8)]';
x9 = [M(:, 9) M(:, 9)+STDev(:, 9) M(:, 9)-STDev(:, 9)]';
x10 =[M(:, 10) M(:, 10)+STDev(:, 10) M(:, 10)-STDev(:, 10)]';
x11 =[M(:, 11) M(:, 11)+STDev(:, 11) M(:, 11)-STDev(:, 11)]';

%%
x1pgw = [Mpgw(:, 1) Mpgw(:, 1)+STDevpgw(:, 1) Mpgw(:, 1)-STDevpgw(:, 1)]';
x2pgw = [Mpgw(:, 2) Mpgw(:, 2)+STDevpgw(:, 2) Mpgw(:, 2)-STDevpgw(:, 2)]';
x3pgw = [Mpgw(:, 3) Mpgw(:, 3)+STDevpgw(:, 3) Mpgw(:, 3)-STDevpgw(:, 3)]';
x4pgw = [Mpgw(:, 4) Mpgw(:, 4)+STDevpgw(:, 4) Mpgw(:, 4)-STDevpgw(:, 4)]';
x5pgw = [Mpgw(:, 5) Mpgw(:, 5)+STDevpgw(:, 5) Mpgw(:, 5)-STDevpgw(:, 5)]';
x6pgw = [Mpgw(:, 6) Mpgw(:, 6)+STDevpgw(:, 6) Mpgw(:, 6)-STDevpgw(:, 6)]';
x7pgw = [Mpgw(:, 7) Mpgw(:, 7)+STDevpgw(:, 7) Mpgw(:, 7)-STDevpgw(:, 7)]';
x8pgw = [Mpgw(:, 8) Mpgw(:, 8)+STDevpgw(:, 8) Mpgw(:, 8)-STDevpgw(:, 8)]';
x9pgw = [Mpgw(:, 9) Mpgw(:, 9)+STDevpgw(:, 9) Mpgw(:, 9)-STDevpgw(:, 9)]';
x10pgw =[Mpgw(:, 10) Mpgw(:, 10)+STDevpgw(:, 10) Mpgw(:, 10)-STDevpgw(:, 10)]';
x11pgw =[Mpgw(:, 11) Mpgw(:, 11)+STDevpgw(:, 11) Mpgw(:, 11)-STDevpgw(:, 11)]';

% fig = figure('units','inches','position',[0 0 6 8]); 
% subplot (3,1,1)
% sp11 = stdshade(t, .4,'k',td, 1) ; hold on
% sp12 = stdshade(tpgw, .4,'r',td, 1) ;
% ylabel ({'Daily Mean','Streamflow (mm)'})
% lg = legend ('Current st. dev','CUR average', 'PGW st. dev','PGW average', 'Orientation', 'Horizontal')
% set(lg, 'Position', [0.5 0.97 0 0])
% ylim([0 50])
% yticks([0:20:60])
% xtickformat ('dd-MMM')
% text (td(2), 40, {strcat('Hist = ', num2str(TotalVolHist(1)), 'mm'),...
%     strcat('PGW = ', num2str(TotalVolPGW(1)), 'mm'), ...
%     strcat('Change =', num2str(PercentChange(1)), '%')})

close all
xp = 0.01
yp =0.02
fig = figure('units','inches','position',[0 0 9 11]); 
t = timeCUR (1:8760);
sp11= subplot(7,2,1:4)
stdshade(x11, .4,'k',td, 1) ; hold on
stdshade(x11pgw, .4,'r',td, 1) ;
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([0 50]);
yticks ([0:10:50]);
ylabel ({'Streamflow (mm)'});
lg = legend ( 'CUR +/1 1SD  ', 'CUR','PGW +/- SD', 'PGW');%, 'Location', 'NorthWest')
lg.FontSize = 8;
lg.Position = [0.3 .87 0 0]
sp11.Position = sp11.Position + [0 0.017 xp 0];
text(td(5), 48, strcat('(a) \Delta = ',{'  '},  num2str(Diff_PGW_CUR(11)), ' mm'), 'Fontweight', 'bold')

i = 1; sp1= subplot(7,2,i+4);
stdshade(x1, .4,'k',td, 1) ; hold on
stdshade(x1pgw, .4,'r',td, 1) ;
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([0 900]);
yticks ([0:250:2000]);xticklabels ([]);
ylabel ({'Rainfall',' (mm)'});
sp1.Position = sp1.Position + [0 0 xp yp];
text(td(5), 780, strcat('(b) \Delta = ',{'  '},  num2str(Diff_PGW_CUR(1)), ' mm'), 'Fontweight', 'bold')

i = 2; sp2= subplot(7,2,i+4);
stdshade(x2, .4,'k',td, 1) ; hold on
stdshade(x2pgw, .4,'r',td, 1) ;
p1 = plot(td, CURmean(:,i), 'k', 'LineWidth', 2);
p2 = plot(td, PGWmean(:,i), 'r', 'LineWidth', 2);
xtickformat ('MMM');xticklabels ([]);
xlim ([td(1) td(end)]); ylim([0 2300]);
yticks ([0:1000:2000]);
ylabel ({'Snowfall',' (mm)'});
sp2.Position = sp2.Position + [0 0 xp yp];
text(td(5), 2100, strcat('(c) \Delta = ', {'  '}, num2str(Diff_PGW_CUR(2)), ' mm'))

i = 3; sp3= subplot(7,2,i+4);
stdshade(x3, .4,'k',td, 1) ; hold on
stdshade(x3pgw, .4,'r',td, 1) ;
xtickformat ('MMM');
xlim ([td(1) td(end)]); ylim([0 45]);
yticks ([0:10:100]);xticklabels ([]);
ylabel ({'Evaporation',' (mm)'})
sp3.Position = sp3.Position + [0 0 xp yp];
text(td(5),40, strcat('(d) \Delta = ', {'  '}, num2str(Diff_PGW_CUR(3)), ' mm'), 'Fontweight', 'bold')


i = 4; sp4= subplot(7,2,i+4);
stdshade(x4, .4,'k',td, 1) ; hold on
stdshade(x4pgw, .4,'r',td, 1) ;
xtickformat ('MMM');
xlim ([td(1) td(end)]); ylim([0 240]);
yticks ([0:100:250]);xticklabels ([]);
ylabel ({'Blowing Snow','Subl. (mm)'});
sp4.Position = sp4.Position + [0 0 xp yp];
text(td(5),215, strcat('(e) \Delta = ', {'  '}, num2str(Diff_PGW_CUR(4)), ' mm'), 'Fontweight', 'bold')

i = 5; sp5= subplot(7,2,i+4);
stdshade(x5, .4,'k',td, 1) ; hold on
stdshade(x5pgw, .4,'r',td, 1) ;
xtickformat ('MMM');xticklabels ([]);
xlim ([td(1) td(end)]); ylim([0 500]);
yticks ([0:200:500]);
ylabel ({'Blowing Snow', 'Transp. (mm)'});
sp5.Position = sp5.Position + [0 0 xp yp];
text(td(5),450, strcat('(f) \Delta = ', {'  '}, num2str(Diff_PGW_CUR(5)), ' mm'), 'Fontweight', 'bold')

i = 6; sp6= subplot(7,2,i+4);
stdshade(x6, .4,'k',td, 1) ; hold on
stdshade(x6pgw, .4,'r',td, 1) ;
xtickformat ('MMM');
xlim ([td(1) td(end)]); ylim([0 300]);
yticks ([0:200:400]);xticklabels ([]);
ylabel ({'Avalanche',' (mm)'});
sp6.Position = sp6.Position + [0 0 xp yp];
text(td(5),250, strcat('(g) \Delta = ',{'  '},  num2str(Diff_PGW_CUR(6)), ' mm'), 'Fontweight', 'bold')

i = 7; sp7= subplot(7,2,i+4);
stdshade(x7, .4,'k',td, 1) ; hold on
stdshade(x7pgw, .4,'r',td, 1) ;
xtickformat ('MMM');xticklabels ([]);
xlim ([td(1) td(end)]); ylim([0 1500]);
yticks ([0:500:1500]);
ylabel ({'Icemelt',' (mm)'});
sp7.Position = sp7.Position + [0 0 xp yp];
text(td(5),1350, strcat('(h) \Delta = ',{'  '},  num2str(Diff_PGW_CUR(7)), ' mm'), 'Fontweight', 'bold')

i = 8;sp8= subplot(7,2,i+4);
stdshade(x8, .4,'k',td, 1) ; hold on
stdshade(x8pgw, .4,'r',td, 1) ;
xtickformat ('MMM');xticklabels ([]);
xlim ([td(1) td(end)]); ylim([0 2500]);
ylabel ({'Snowmelt','(mm)'});
sp8.Position = sp8.Position + [0 0 xp yp];
text(td(5),2200, strcat('(i) \Delta = ',{'  '}, num2str(Diff_PGW_CUR(8)), ' mm'))

i = 9; sp9 = subplot(7,2,i+4);
stdshade(x9, .4,'k',td, 1) ; hold on
stdshade(x9pgw, .4,'r',td, 1) ;
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([45 110]);
yticks ([50:25:100]);
ylabel ({'Soil moisture',' (mm)'});
sp9.Position = sp9.Position + [0 0 xp yp];
text(td(5),105, strcat('(j) \Delta = ',{'  '},  num2str(Diff_PGW_CUR(9)), ' mm'), 'Fontweight', 'bold')


i = 10; sp10 = subplot(7,2,i+4);
stdshade(x10, .4,'k',td, 1) ; hold on
stdshade(x10pgw, .4,'r',td, 1) ;
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([150 600]);
yticks ([150:150:600]);
ylabel ({'GW Storage',' (mm)'});
sp10.Position = sp10.Position + [0 0 xp yp];
text(td(5), 560, strcat('(k) \Delta = ', {'  '}, num2str(Diff_PGW_CUR(10)), ' mm'))


set(findall(gcf,'-property','FontSize'),'FontSize', 10)
tightfig(fig)
figname ='HydroProcesses_15YearMean_shaded';

%
saveas (gcf, strcat( 'D:\FuturePeyto\fig\C2c\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\C2c\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\C2c\', figname))

%% Clauclate change in peak flow for th 15 years
x = CURdaily(:,:,11);
plot(td, x)
[a , aa] =  max(x)
timeofpeakflow_meanyrs_CUR = mean(aa)
peakflow_meanyrs_CURmean= mean (a)
td(round(timeofpeakflow_meanyrs_CUR))

xx = PGWdaily(:,:,11);
plot(td, xx)
[b , bb] =  max(xx)
timeofpeakflow_meanyrs_PGW = mean(bb)
peakflow_meanyrs_PGWmean = mean(b)
td(round(timeofpeakflow_meanyrs_PGW))

%% winter events
a = find(td == '01-Jan-2001')
b = find(td == '01-Apr-2001')

xcut = x(a:b, :);
xxcut = xx(a:b, :);

winterflow_cur = numel(find(xcut>3))
winterflow_pgw = numel(find(xxcut>3))
