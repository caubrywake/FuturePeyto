%% C2cb - Compile basin averaged forcings between CUR and PGW

clear all
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat',...
'Qli_VarCUR', 'QsiS_VarCUR', 'hru_rainCUR', 'hru_snowCUR',  'hru_rhCUR', 'hru_tCUR', 'hru_uCUR', 'timeCUR');

load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat',...
'Qli_VarPGW', 'QsiS_VarPGW', 'hru_rainPGW', 'hru_snowPGW', 'hru_rhPGW', 'hru_tPGW', 'hru_uPGW', 'timePGW');

hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 
basinarea = sum(hruarea); % m2

clear PGW CUR
VAlab = {'Air Temperature (C)', 'Relative Humidity (%)', 'Wind speed (m/s)' ,...
    'SWin (Wm^{-2})', 'LWin (Wm^{-2})', 'Total Precipitation (mm)'};
VA = cat(3, hru_tCUR(8785:140160,:), hru_rhCUR(8785:140160,:),  hru_uCUR(8785:140160,:), QsiS_VarCUR(8785:140160,:), Qli_VarCUR(8785:140160,:), hru_rainCUR(8785:140160,:)+hru_snowCUR(8785:140160,:));
VB = cat(3, hru_tPGW(8785:140160,:), hru_rhPGW(8785:140160,:),  hru_uPGW(8785:140160,:), QsiS_VarPGW(8785:140160,:), Qli_VarPGW(8785:140160,:), hru_rainPGW(8785:140160,:)+hru_snowPGW(8785:140160,:));
tPGW = timePGW (8785:140160);
tCUR = timeCUR (8785:140160);

clear  hru_tCUR hru_rhCUR  hru_uCUR QsiS_VarCUR Qli_VarCUR hru_rainCUR hru_snowCUR hru_tPGW hru_rhPGW  hru_uPGW QsiS_VarPGW Qli_VarPGW hru_rainPGW  hru_snowPGW

sz= size(VA);
for i = 1:sz(3)
    if i >= 1 & i <5  % temp, rh, U, SWin, LWin
    va = VA(:,:,i);  va = sum(va.*(hruarea/basinarea),2);  
    vb = VB(:,:,i);  vb =sum(vb.*(hruarea/basinarea),2);
    else % precip
    va = VA(:,:,i)*0.001; va = sum(va.*hruarea,2);va = va/basinarea * 1000; 
    vb = VB(:,:,i)*0.001; vb = sum(vb.*hruarea,2);vb = vb/basinarea * 1000; 
    end
  CUR(:, i) = va;
  PGW (:, i) = vb; 
end 
clear VA VB va vb i 

%% Housekeeping
% remove leap year, add nan to complete 2015 year
clear  t d VarOut VarA 
% find and remove all the feb 29
%    a = datevec(timeCUR);
%    a(:, 1) = a(:, 1)-84;
%    timeCUR =datetime(a);
timeCUR = tCUR;
x = datevec(timeCUR);
a = find(x(:, 2)== 2 & x(:, 3)==29);
timeCUR(a) = []; 
CUR(a, :) = []; PGW(a, :) = [];
% add nan to end of 2015 to make it a full water year (3 days)
textra = timeCUR(end)+hours(1):hours(1):datetime('01-Oct-2015 00:00:00');
timeCUR= [timeCUR; textra'];
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
clear va vb VA VB

% cut first yr
%% Daily values
clear yr
yr =  (datetime('01-Oct-2000 00:00:00'):hours(1):datetime('30-Sep-2001 23:00:00'))';
for i= 1:sz(2)
    if i >= 1 & i <=5 
    va  =CURyr(:,:,i) ;
    x = timetable (yr,va);
    xx = retime(x, 'daily', 'mean');
    VA(:,:,i)= table2array(xx);
    td= xx.yr;
    vb =PGWyr(:,:,i) ;
    x = timetable (yr,vb);
    xx = retime(x, 'daily', 'mean');
    VB(:,:,i)= table2array(xx);
    else 
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
end
CURdaily = VA;
PGWdaily = VB;

%% montlhy precipitation
    va  =CURyr(:,:,6) ;
    x = timetable (yr,va);
    xx = retime(x, 'monthly', 'sum');
  CURp_m= table2array(xx);
    tm= xx.yr;
    vb =PGWyr(:,:,i) ;
    x = timetable (yr,vb);
    xx = retime(x, 'monthly', 'sum');
     PGWp_m= table2array(xx);

clear x xx VA VB va vb



%% Daily mean average
for i = 1:sz(2)
     va = CURdaily(:,:,i);
     CURmean(:, i) = nanmean(va, 2);
     CURstd (:, i) = nanstd(va, 0, 2);
     vb= PGWdaily(:,:,i);
     PGWmean(:, i) = nanmean(vb, 2);
     PGWstd (:, i) = nanstd(vb, 0, 2);
end 
clear va vb

% montlhy precip
     va =  CURp_m;
     CURPmean = nanmean(va, 2);
     CURPstd  = nanstd(va, 0, 2);
     vb=   PGWp_m;
     PGWPmean = nanmean(vb, 2);
     PGWPstd  = nanstd(vb, 0, 2);
%% Change
for i = 1:5
deltaChange(i,1) = round(nanmean( CURstd (:,i))-nanmean( CURstd (:,i)),2);
TotalVolHist(i,1) = round(nanmean( CURstd (:,i)),2);
TotalVolPGW(i,1) = round(nanmean(PGWstd(:,i)),2);
PercentChange(i,1) = round(nanmean(PGWstd(:,i))./nanmean(CURstd(:,i))*100 - 100);
end 

deltaChange(6,1) = round(sum(PGWstd(:,6))-sum(CURstd(:,6)),2)
TotalVolHist(6,1) = round(sum(CURstd(:,6)),2)
TotalVolPGW(6,1) = round(sum(PGWstd(:,6)),2)
PercentChange(6,1) = round(sum(PGWstd(:,6))./sum(CURstd(:,6))*100 - 100)
varname = {'airt'; 'rh'; 'u';'swin'; 'lwin'; 'p'};
Forcings_annual_standarddev = table(varname, TotalVolHist, TotalVolPGW, deltaChange, PercentChange);
writetable(Forcings_annual_standarddev, 'D:\FuturePeyto\fig\C2c\Stats_ChangeinForcingDev_Cur_PGW.csv')

%% Change
for i = 1:5
deltaChange(i,1) = round(nanmean(PGWmean(:,i))-nanmean(CURmean(:,i)),2);
TotalVolHist(i,1) = round(nanmean(CURmean(:,i)),2);
TotalVolPGW(i,1) = round(nanmean(PGWmean(:,i)),2);
PercentChange(i,1) = round(nanmean(PGWmean(:,i))./nanmean(CURmean(:,i))*100 - 100);
end 

deltaChange(6,1) = round(sum(PGWmean(:,6))-sum(CURmean(:,6)),2)
TotalVolHist(6,1) = round(sum(CURmean(:,6)),2)
TotalVolPGW(6,1) = round(sum(PGWmean(:,6)),2)
PercentChange(6,1) = round(sum(PGWmean(:,6))./sum(CURmean(:,6))*100 - 100)

varname = {'airt'; 'rh'; 'u';'swin'; 'lwin'; 'p'};
Forcings_annual = table(varname, TotalVolHist, TotalVolPGW, deltaChange, PercentChange);
writetable(Forcings_annual, 'D:\FuturePeyto\fig\C2c\Stats_ChangeinForcing_Cur_PGW.csv')


%% shade plot
t  = [CURmean(:, 1) CURmean(:, 1)+CURstd(:, 1) CURmean(:, 1)-CURstd(:, 1)]';
rh = [CURmean(:, 2) CURmean(:, 2)+CURstd(:, 2) CURmean(:, 2)-CURstd(:, 2)]';
u  = [CURmean(:, 3) CURmean(:, 3)+CURstd(:, 3) CURmean(:, 3)-CURstd(:, 3)]';
sw = [CURmean(:, 4) CURmean(:, 4)+CURstd(:, 4) CURmean(:, 4)-CURstd(:, 4)]';
lw = [CURmean(:, 5) CURmean(:, 5)+CURstd(:, 5) CURmean(:, 5)-CURstd(:, 5)]';
p  = [cumsum(CURmean(:, 6)) cumsum(CURmean(:, 6))+CURstd(:, 6) cumsum(CURmean(:, 6))-CURstd(:, 6)]';


tpgw  = [PGWmean(:, 1) PGWmean(:, 1)+PGWstd(:, 1) PGWmean(:, 1)-PGWstd(:, 1)]';
rhpgw = [PGWmean(:, 2) PGWmean(:, 2)+PGWstd(:, 2) PGWmean(:, 2)-PGWstd(:, 2)]';
upgw  = [PGWmean(:, 3) PGWmean(:, 3)+PGWstd(:, 3) PGWmean(:, 3)-PGWstd(:, 3)]';
swpgw = [PGWmean(:, 4) PGWmean(:, 4)+PGWstd(:, 4) PGWmean(:, 4)-PGWstd(:, 4)]';
lwpgw = [PGWmean(:, 5) PGWmean(:, 5)+PGWstd(:, 5) PGWmean(:, 5)-PGWstd(:, 5)]';
ppgw  = [cumsum(PGWmean(:, 6)) cumsum(PGWmean(:, 6))+PGWstd(:, 6) cumsum(PGWmean(:, 6))-PGWstd(:, 6)]';
%%%
%%
fig = figure('units','inches','position',[0 0 8 6]); 
subplot (3,2,1)
stdshade(t, .4,'k',td, .5) ; hold on
stdshade(tpgw, .4,'r',td, .5) ;
ylabel ({'Daily Mean','Air Temperature ({\circ}C)'})
lg = legend ('Current st. dev','CUR average', 'PGW st. dev','PGW average', 'Orientation', 'Horizontal')
set(lg, 'Position', [0.5 0.97 0 0])
ylim([-25 25])
yticks([-20:10:20])
xtickformat ('dd-MMM')
text (td(2), 22, {strcat('(a) ', '\Delta = ',num2str(round(TotalVolPGW(1)-TotalVolHist(1),1)), '^\circC')})

subplot (3,2,2)
stdshade(rh, .4,'k',td, 1) ; hold on
stdshade(rhpgw, .4,'r',td, 1) ;
ylabel ({'Daily Mean','Relative Humiditiy (%)'})
ylim([0 100])
yticks([0:20:100])
xtickformat ('dd-MMM')
text (td(2), 94, {strcat('(b) ', '\Delta = ',num2str(round(TotalVolPGW(2)-TotalVolHist(2),1)), ' %')})

subplot (3,2,3)
stdshade(u, .4,'k',td, 1) ; hold on
stdshade(upgw, .4,'r',td, 1) ;
ylabel ({'Daily Mean','Wind speed (ms^{-1})'})
ylim([0 12])
yticks([0:4:12])
xtickformat ('dd-MMM')
text (td(2), 11, {strcat('(c) ', '\Delta = ',num2str(round(TotalVolPGW(3)-TotalVolHist(3),1)), ' ms^{-1}')})

subplot (3,2,4)
stdshade(sw, .4,'k',td, 1) ; hold on
stdshade(swpgw, .4,'r',td, 1) ;
ylabel ({'Daily Mean','SWin (Wm^{-2})'})
ylim([0 320])
yticks([0:100:320])
xtickformat ('dd-MMM')
text (td(2), 300, {strcat('(d) ', '\Delta = ',num2str(round(TotalVolPGW(4)-TotalVolHist(4),1)), ' Wm^{-2}')})

subplot (3,2,5)
stdshade(lw, .4,'k',td, 1) ; hold on
stdshade(lwpgw, .4,'r',td, 1) ;
ylabel ({'Daily Mean','LWin (Wm^{-2})'})
ylim([110 370])
yticks([100:100:400])
xtickformat ('dd-MMM')
text (td(2), 360, {strcat('(e) ', '\Delta = ',num2str(round(TotalVolPGW(5)-TotalVolHist(5),1)), ' Wm^{-2}')})

subplot (3,2,6)
stdshade(p, .4,'k',td, 1) ; hold on
stdshade(ppgw, .4,'r',td, 1) ;
ylabel ({'Cumulative','Precipitation (mm)'})
ylim([0 2000])
yticks([0:500:2000])
xtickformat ('dd-MMM')
text (td(2), 1800, {strcat('(f) ', '\Delta = ',num2str(round(TotalVolPGW(6)-TotalVolHist(6),1)), ' mm')})

%%%%
tightfig
figname ='Forcings_15YearMean';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\C2c\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\C2c\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\C2c\', figname))
