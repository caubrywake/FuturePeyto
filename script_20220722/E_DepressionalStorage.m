%% Dynamic catchment storage

% looking more closely at the impat fof depressional storage on streamflow
% 4 cases: hru 6, hru 8 and catchment averaged
% for REF (pond + lake) SUR1 (no storage) and SUR3(pond only) 

% 1: look at depressional storagea and 2 look at streamflow routing within
% each hru (runoff, gw flow of subsurface flow)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% surface
close all
clear all

load('D:\\5_FuturePeyto\crhm\C_Scenarios\output\PeytoSUR1.mat', 'SdSUR1', 'hru_actetSUR1','soil_runoffSUR1','soil_ssrSUR1','gw_flowSUR1')
load('D:\\5_FuturePeyto\crhm\C_Scenarios\output\PeytoSUR2.mat', 'SdSUR2', 'hru_actetSUR2','soil_runoffSUR2','soil_ssrSUR2','gw_flowSUR2')
load('D:\\5_FuturePeyto\crhm\C_Scenarios\output\PeytoSUR3.mat', 'SdSUR3', 'hru_actetSUR3','soil_runoffSUR3','soil_ssrSUR3','gw_flowSUR3')
load('D:\\5_FuturePeyto\crhm\C_Scenarios\output\PeytoREF.mat', 'SdREF', 'hru_actetREF','soil_runoffREF','soil_ssrREF','gw_flowREF', 'timeREF')

%% Assemble
HRU6_1 = cat(2,SdSUR1(:, 43),...
           soil_runoffSUR1(:, 6),...
           soil_ssrSUR1(:, 6),  ...
           hru_actetSUR1(:, 6),...
           gw_flowSUR1(:, 6)) ; 
HRU6_3 = cat(2,SdSUR3(:, 43),...
           soil_runoffSUR3(:, 6),...
           soil_ssrSUR3(:, 6),  ...
           hru_actetSUR3(:, 6),...
           gw_flowSUR3(:, 6)) ; 
HRU6_ref = cat(2,SdREF(:, 43),...
           soil_runoffREF(:, 6),...
           soil_ssrREF(:, 6),  ...
           hru_actetREF(:, 6),...
           gw_flowREF(:, 6)) ; 
HRU8_1 = cat(2,SdSUR1(:, 45),...
           soil_runoffSUR1(:, 8),...
           soil_ssrSUR1(:, 8),  ...
           hru_actetSUR1(:, 8),...
           gw_flowSUR1(:, 8)) ; 
HRU8_3 = cat(2,SdSUR3(:, 45),...
           soil_runoffSUR3(:, 8),...
           soil_ssrSUR3(:, 8),  ...
           hru_actetSUR3(:, 8),...
           gw_flowSUR3(:, 8)) ; 
HRU8_ref = cat(2,SdREF(:, 45),...
           soil_runoffREF(:, 8),...
           soil_ssrREF(:, 8),  ...
           hru_actetREF(:, 8),...
           gw_flowREF(:, 8)) ;       
       
%% daily averages
varname = cat(3,HRU6_1, HRU6_3, HRU6_ref,HRU8_1, HRU8_3, HRU8_ref);
T = timetable (timeREF, varname);  TT = retime (T, 'daily','mean'); 
var = table2array(TT);

%% depressional storage betwene environements
load('D:\\5_FuturePeyto\crhm\C_Scenarios\output\PeytoSUR1.mat', 'SdSUR1', 'hru_actetSUR1','soil_runoffSUR1','soil_ssrSUR1','gw_flowSUR1')
load('D:\\5_FuturePeyto\crhm\C_Scenarios\output\PeytoSUR2.mat', 'SdSUR2', 'hru_actetSUR2','soil_runoffSUR2','soil_ssrSUR2','gw_flowSUR2')
load('D:\\5_FuturePeyto\crhm\C_Scenarios\output\PeytoSUR3.mat', 'SdSUR3', 'hru_actetSUR3','soil_runoffSUR3','soil_ssrSUR3','gw_flowSUR3')
load('D:\\5_FuturePeyto\crhm\C_Scenarios\output\PeytoREF.mat', 'SdREF', 'hru_actetREF','soil_runoffREF','soil_ssrREF','gw_flowREF', 'timeREF')

% copile Sd scneraios
var = SdSUR3(:, 38:74);

% change to daily
T = timetable (timeREF,var);  TT = retime (T, 'daily','mean'); 
var = table2array(TT);
t = TT.timeREF;

% remove first year
t = t (367:end);
var = var(367:end, :);

% reove leap days
sz = size (var);
timevec = datevec(t);
var(find(timevec(:,2) == 2 & timevec(:,3) == 29), :) = []; % remove leap years days
t(find(timevec(:,2) == 2 & timevec(:,3) == 29), :) = [];
t= datetime(t);

% Find water year start
timevec = datevec(t);
tidx = find(timevec(:, 2) ==10 & timevec(:, 3) == 1);
t(tidx)

for ii = 1:sz(2) % 8  (2 hru, 4 scnarios)
     varPGW= var(:,ii);
for i = 1:length(tidx)-1
    if i <=15
   varRSHP_PGW(:, i) = varPGW(tidx(i):tidx(i+1)-1);
    else 
   varRSHP_PGW(:, i) = [varPGW(tidx(i):tidx(i+1)); nan(364-(tidx(16)-tidx(15)), 1)];
  end 
end 
VarPGW(:,:,ii) = varRSHP_PGW;
end

for i = 1:sz(2)    
    dd= VarPGW(:,:,i);
    BF(:, i) = nanmean(dd, 2);
end 
% normalize them to 0-1 range
BFnorm = BF*100./(max(BF));
 td = t(tidx(1):tidx(2)-1);

% plot mean% upbasin

fig = figure('units','inches','outerposition',[0 0 6 4]);
plot (td, mean(BFnorm(:, [2, 12,  18]),2)); hold on
plot (td, mean(BFnorm(:, [3:5, 13, 14, 19]),2)); hold on
plot (td, mean(BFnorm(:, [6, 15, 16]),2)); hold on
plot (td, mean(BFnorm(:, 8:10),2)); hold on
legend ('Upper catchment', 'Mid catchment', 'Lower catchment', 'Lake', 'location', 'best')
ylabel ('Depressional storage level (%)') 
xtickformat('dd-MMM')

figname ='DepressionalStorage';
saveas (gcf, strcat( 'D:\\5_FuturePeyto\fig\D1c\', figname, '.pdf'))

saveas (gcf, strcat('D:\\5_FuturePeyto\fig\D1c\', figname, '.png'))
savefig(gcf, strcat('D:\\5_FuturePeyto\fig\D1c\', figname))



plot (td, VarPGW(:, :, 1), 'k');

title ('HRU 6')
subplot(2,1,2)
plot (td, BF(:, 5));
title ('HRU 8')

% i dont like the 15 year average
%% Let do it for 5 year
a = 6
b = 6+1
subplot(2,1,1)
plot(t(tidx(a):tidx(b)),var(tidx(a):tidx(b), :))
legend ('Hru 6', 'hru 7', 'Hru8', 'hru9')
title ('HRU 6')
xlim([t(tidx(a)) t(tidx(b))])
subplot(2,1,2)
plot(t(tidx(a):tidx(b)),var(tidx(a):tidx(b), [5])); 
legend ('No storage', 'Surface Storage')
title ('HRU 8')
xlim([t(tidx(a)) t(tidx(b))])

X = find(timevec(:, 2) == 10 & timevec(:, 3) == 1);
for i = 1:length(X)
    if i <16
SUM1(i, :) = squeeze(sum(var1(X(i):X(i+1)-1, 6, :)))';
SUM2(i, :) = squeeze(sum(var2(X(i):X(i+1)-1, 6, :)))'
    else 
SUM1(i, :) = squeeze(sum(var1(X(i):end, 6, :)))';
SUM2(i, :) = squeeze(sum(var2(X(i):end, 6, :)))'

end 
end



t1 = find(timeREF == '01-Oct-2089')
t2 = find(timeREF == '01-Oct-2090')


plot (timeREF(t1:t2), cumsum(var1(t1:t2, hru, 7))); hold on
plot (timeREF(t1:t2), cumsum(var2(t1:t2, hru, 7))); hold on

hru = 5;
figure
subplot(2,1,1)
plot(timeREF(t1:t2),cumsum(var1(t1:t2, hru, 2)));hold on
plot(timeREF(t1:t2),cumsum(var1(t1:t2, hru, 3)))
plot(timeREF(t1:t2),cumsum(var1(t1:t2, hru, 4))); 
plot(timeREF(t1:t2),cumsum(var1(t1:t2, hru, 5))); 
plot(timeREF(t1:t2),cumsum(var1(t1:t2, hru, 6))); 
plot(timeREF(t1:t2),cumsum(var1(t1:t2, hru, 7))); 
plot(timeREF(t1:t2),cumsum(sum(var1(t1:t2, hru, [2:7]), 3))); 

title ('No pond')
legend ('ruoff', 'ssr', 'gw', 'evap', 'sd evap', 'gw flow', 'total')

subplot(2,1,2)
plot(timeREF(t1:t2),cumsum(var2(t1:t2, hru, 2)));hold on
plot(timeREF(t1:t2),cumsum(var2(t1:t2, hru, 3)))
plot(timeREF(t1:t2),cumsum(var2(t1:t2, hru, 4))); 
plot(timeREF(t1:t2),cumsum(var2(t1:t2, hru, 5))); 
plot(timeREF(t1:t2),cumsum(var2(t1:t2, hru, 6))); 
plot(timeREF(t1:t2),cumsum(var2(t1:t2, hru, 7))); 
plot(timeREF(t1:t2),cumsum(sum(var2(t1:t2, hru, [2:7]), 3))); 

legend ('ruoff', 'ssr', 'gw', 'evap', 'sd evap', 'gw flow', 'total')
title ('Pond')

%% for each year, i want to ttoal and the chnage in storage
var1 = cat(3, soil_runoffSUR1, soil_ssrSUR1, hru_actetSUR1, gw_flowSUR1,  ) ; 
var2 = cat(3, soil_runoffSUR3,  soil_ssrSUR3, hru_actetSUR3, gw_flowSUR3 )  ; 
       
% daily averages
     T = timetable (timeREF, var1);
     TT = retime (T, 'daily','sum');
     var1 = table2array(TT);
  
    T = timetable (timeREF, var2);
    TT = retime (T, 'daily','sum');
    var2 = table2array(TT);   
    timeREF = TT.timeREF;

timevec = datevec (timeREF);
X = find(timevec(:, 2) == 10 & timevec(:, 3) == 1);
timeREF(X)
clear dS SUM1 SUM2
for i = 1:length(X)
    if i <16
SUM1(i, :) = squeeze(sum(var1(X(i):X(i+1)-1, 6, :)))';
SUM2(i, :) = squeeze(sum(var2(X(i):X(i+1)-1, 6, :)))'
    else 
SUM1(i, :) = squeeze(sum(var1(X(i):end, 6, :)))';
SUM2(i, :) = squeeze(sum(var2(X(i):end, 6, :)))'

end 
end

close all
figure
subplot (2,1,1)
bar(SUM1(:, 1:4), 'stacked')
legend( 'runoff','ssr','actet','gw flow');
ylim ([0 2*10e3])
subplot(2,1,2)
bar(SUM2(:,1:4), 'stacked')
legend( 'runoff','ssr','actet','gw flow');
ylim ([0 2*10e3])

figure; bar(sum(SUM1, 2)-sum(SUM2, 2))
figure; bar(dS)