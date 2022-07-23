%% D1c - Changes in oprocesses between scenarios
clear all
close all
% Load variables
% load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat', 'SWECUR', 'basinflowCUR', 'firnmeltCUR', 'icemeltCUR', 'hru_rainCUR', 'runoffCUR', 'infilCUR', 'hru_snowCUR', 'SWEmeltCUR', 'hru_tCUR', 'timeCUR')
% load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoPGW_ref.mat', 'SWEPGW', 'basinflowPGW', 'firnmeltPGW', 'icemeltPGW', 'hru_rainPGW', 'runoffPGW', 'infilPGW', 'hru_snowPGW', 'SWEmeltPGW', 'hru_tPGW', 'timePGW')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Storage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% SWE
close all
clear all
 load('D:\FuturePeyto\crhm\C_Scenarios\output\IceInit\PeytoICE1.mat', 'SWEICE1')
 load('D:\FuturePeyto\crhm\C_Scenarios\output\IceInit\PeytoICE2.mat', 'SWEICE2')
 load('D:\FuturePeyto\crhm\C_Scenarios\output\IceInit\PeytoICE3.mat', 'SWEICE3')

 load('D:\FuturePeyto\crhm\C_Scenarios\output\LakeForm\PeytoLAK1.mat',  'SWELAK1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\LakeForm\PeytoLAK2.mat',  'SWELAK2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\LakeForm\PeytoLAK3.mat',  'SWELAK3')

 load('D:\FuturePeyto\crhm\C_Scenarios\output\NoVeg\PeytoVEG1.mat', 'SWEVEG1')
 load('D:\FuturePeyto\crhm\C_Scenarios\output\NoVeg\PeytoVEG2.mat', 'SWEVEG2')
 load('D:\FuturePeyto\crhm\C_Scenarios\output\NoVeg\PeytoVEG3.mat', 'SWEVEG3')

load('D:\FuturePeyto\crhm\C_Scenarios\output\GWstorage\PeytoGW1.mat', 'SWEGW1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\GWstorage\PeytoGW2.mat', 'SWEGW2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\GWstorage\PeytoGW3.mat', 'SWEGW3')
load('D:\FuturePeyto\crhm\C_Scenarios\output\Ref\PeytoREF.mat', 'SWEREF', 'timeREF')

hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 

 varPGW = cat(3,SWEREF, SWEICE1, SWEICE2, SWEICE3, SWELAK1, SWELAK2, SWELAK3, ...
     SWEVEG1,SWEVEG2, SWEVEG3, SWEGW1, SWEGW2, SWEGW3);
 clear  SWEICE1 SWEICE2 SWEICE3 SWELAK1 SWELAK2 SWELAK3 SWEVEG1 SWEVEG2 SWEVEG3 SWEGW1 SWEGW2 SWEGW3

yrCUR = 2085:2099;
timeCUR = timeREF;
hru = 1:37;
for ii = 1:13
 for i = 1:length(yrCUR)
t1 = strcat ('01-Oct-', num2str(yrCUR(i)-1), {' '}, '1:00:00');  a = find(timeCUR==datetime(t1));
t2 = strcat ('30-Sep-', num2str(yrCUR(i)), {' '}, '1:00:00');
if i == 15
    t2 = ('26-Sep-2099 00:00:00');
end
b = find(timeCUR==datetime(t2));

varPGWyr  = varPGW(a:b, hru, ii)./1000; %
varPGWhru = varPGWyr.*(hruarea(hru)./(sum(hruarea(hru))));%
varPGWmean= sum(varPGWhru, 2)*1000; % 
T = timetable (timeCUR(a:b), varPGWmean); TT = retime(T, 'daily', 'mean');
varPGWdaily = table2array(TT); 

if length(varPGWdaily) == 366 % rmeove leap years
    varPGWdaily= [varPGWdaily(1:59); varPGWdaily(61:end)]; %remove Feb 29
end 

if i == 15 % padding last year so it finsihes on Sep 30
varPGWdaily= [varPGWdaily; nan(4,1)];
 end 
varPGWdaily_allyr(:, i, ii) = varPGWdaily; 
 end 
end

SWE_REF = squeeze(varPGWdaily_allyr(:,:, 1));
SWE_SCE = varPGWdaily_allyr(:,:, 2:13);
tdaily = datetime('01-Oct-2084'):days(1):datetime('30-Sep-2085');
fig = figure('units','inches','position',[0 0 8 5]); 
subplot (2,2,1);
p1 = plot(tdaily, SWE_REF, 'Color', [51 153 255]./255); hold on;
p2 = plot(tdaily, SWE_SCE(:, :, 1), 'Color', [255 102 102]./255);
p3 = plot(tdaily, nanmean(SWE_REF, 2), 'Color', [0 0 153]./255, 'linewidth', 2); hold on;
p4 = plot(tdaily, nanmean(SWE_SCE(:,:,1),2), 'Color', [153 0 0]./255,  'linewidth', 2);
legend ([p1(1), p2(1), p3(1), p4(1)], 'ind. year REF', 'ind y, Sce1-3', '15 yr mean, REF', '15 yr mean, Sce 1-3', 'Location', 'Northwest')
title ('Remaining Ice')
ylabel('mm')
xtickformat ('dd-MMM')
subplot (2,2,2);
p1 = plot(tdaily, SWE_REF, 'Color', [51 153 255]./255); hold on;
p2 = plot(tdaily, SWE_SCE(:, :, 4), 'Color', [255 102 102]./255);
p3 = plot(tdaily, nanmean(SWE_REF, 2), 'Color', [0 0 153]./255, 'linewidth', 2); hold on;
p4 = plot(tdaily, nanmean(SWE_SCE(:,:,4),2), 'Color', [153 0 0]./255,  'linewidth', 2);
p4 = plot(tdaily, nanmean(SWE_SCE(:,:,5),2), 'Color', [153 0 0]./255,  'linewidth', 2);
p4 = plot(tdaily, nanmean(SWE_SCE(:,:,6),2), 'Color', [153 0 0]./255,  'linewidth', 2);
title ('Surface Water Storage')
xtickformat ('dd-MMM')

ylabel('mm')
subplot (2,2,3);
p1 = plot(tdaily, SWE_REF, 'Color', [51 153 255]./255); hold on;
p2 = plot(tdaily, SWE_SCE(:, :, 7), 'Color', [255 102 102]./255);
p3 = plot(tdaily, nanmean(SWE_REF, 2), 'Color', [0 0 153]./255, 'linewidth', 2); hold on;
p4 = plot(tdaily, nanmean(SWE_SCE(:,:,7),2), 'Color', [153 0 0]./255,  'linewidth', 2);
p4 = plot(tdaily, nanmean(SWE_SCE(:,:,8),2), 'Color', [153 0 0]./255,  'linewidth', 2);
p4 = plot(tdaily, nanmean(SWE_SCE(:,:,9),2), 'Color', [153 0 0]./255,  'linewidth', 2);
title ('Vegetation')
ylabel('mm')
xtickformat ('dd-MMM')

subplot (2,2,4);
p1 = plot(tdaily, SWE_REF, 'Color', [51 153 255]./255); hold on;
p2 = plot(tdaily, SWE_SCE(:, :, 10), 'Color', [255 102 102]./255);
p3 = plot(tdaily, nanmean(SWE_REF, 2), 'Color', [0 0 153]./255, 'linewidth', 2); hold on;
p4 = plot(tdaily, nanmean(SWE_SCE(:,:,10),2), 'Color', [153 0 0]./255,  'linewidth', 2);
p4 = plot(tdaily, nanmean(SWE_SCE(:,:,11),2), 'Color', [153 0 0]./255,  'linewidth', 2);
p4 = plot(tdaily, nanmean(SWE_SCE(:,:,12),2), 'Color', [153 0 0]./255,  'linewidth', 2);
title ('Soil water storage')
ylabel('mm')
xtickformat ('dd-MMM')


figname ='SWE_Scenarios';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\D1c\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\D1c\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\D1c\', figname))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Depressionnal storage
clear all
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUB1.mat','SdSUB1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUB2.mat','SdSUB2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUB3.mat','SdSUB3')

load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoICE1.mat','SdICE1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoICE2.mat','SdICE2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoICE3.mat','SdICE3')

load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUR1.mat','SdSUR1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUR2.mat', 'SdSUR2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUR3.mat','SdSUR3')

load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoVEG1.mat','SdVEG1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoVEG2.mat','SdVEG2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoVEG3.mat','SdVEG3')

load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoWET.mat','SdWET')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoDRY.mat','SdDRY')

load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoREF.mat','SdREF', 'timeREF')
load('D:\FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat','SdCUR')

hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 

 varPGW = cat(3,SdREF(:, 38:74),...
     SdICE1(:, 38:74), SdICE2(:, 38:74), SdICE3(:, 38:74),...
     SdSUR1(:, 38:74), SdSUR2(:, 38:74), SdSUR3(:, 38:74), ...
     SdVEG1(:, 38:74),SdVEG2(:, 38:74), SdVEG3(:, 38:74), ...
     SdSUB1(:, 38:74), SdSUB2(:, 38:74), SdSUB3(:, 38:74), ...
     SdWET(:, 38:74), SdDRY(:, 38:74));
 clear  SdREF SdICE1 SdICE2 SdICE3 SdSUR1 SdSUR2 SdSUR3 SdVEG1 SdVEG2 SdVEG3 SdSUB1 SdSUB2 SdSUB3 SdWET SdDRY
varPGW = varPGW(8785:end, :, :);
timeREF = timeREF(8785:end); % removing spin up yer

hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 
basinarea = sum(hruarea); % m2


%
% VAlab = {'Ref', 'Snow', 'Evaporation', 'Blowing Snow Sublimation' ,...
%     'Blowing Snow Transport', 'Avalanche Transport', 'Icemelt', 'Snowmelt', ...
%     'Soil Moisture', 'Groundwater Storage'};
VA = varPGW;
sz= size(VA);
clear varPGW 

for i = 1:sz(3)
     va = VA(:,:,i)*0.001;   va = nanmean(va.*hruarea,2); va = va/basinarea * 1000; 
  CUR(:, i) = va;
end 

% Housekeeping
% remove leap year, add nan to complete 2015 year
clear  t d VarOut VarA 
% find and remove all the feb 29
x = datevec(timeREF);
a = find(x(:, 2)== 2 & x(:, 3)==29);
timeREF(a) = [];
CUR(a, :) = [];
% add nan to end of 2015 to make it a full water year (3 days)
textra = timeREF(end)+hours(1):hours(1):datetime('01-Oct-2099 00:00:00');
timeREF= [timeREF; textra'];
% textra = timePGW(end)+hours(1):hours(1):datetime('01-Oct-2099 00:00:00');
% timePGW= [timePGW; textra'];
% pad the data with nan 
sz = size(CUR);
pad = nan(length(textra),sz(2)) ;
CUR = [CUR; pad];
clear a pad textra x 
% Reshape in 15 column (for each year)
clear va va VA VB
for ii = 1:sz(2)
    vb = reshape (CUR(:,ii), 8760, 15);
    VB(:,:,ii) = vb; 
end 
CURyr = VB;
clear va vb VA VB

% Daily values
clear yr
yr =  (datetime('01-Oct-2084 00:00:00'):hours(1):datetime('30-Sep-2085 23:00:00'))';
for i= 1:sz(2)
    va  =CURyr(:,:,i) ;
    x = timetable (yr,va);
    xx = retime(x, 'daily', 'sum');
    VA(:,:,i)= table2array(xx);
    td= xx.yr;
end
CURdaily = VA;
clear x xx VA VB va vb
% Daily mean average

% Compile mean and Std
for i = 1:sz(2)
     va = CURdaily(:,:,i);
     CURmean(:, i) = nanmean(va, 2);
     CURstd (:, i) = nanstd(va, 0, 2);
end 
clear va vb
%Plot
% just theplot withtout shading
fig = figure('units','inches','position',[0 0 9 6]); 
subplot(2,3,1)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,2), 'Color', [128 128 255]/255); hold on
p22 = plot(td,CURdaily(:,:,3), 'Color', [0 204 204]/255); hold on
p22 = plot(td,CURdaily(:,:,4), 'Color', [255 102 102]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,2), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,3), 'Color', [0 153 153]/255, 'LineWidth', 2);
p4 = plot(td, CURmean(:,4), 'r', 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([0 80]);
yticks ([0:20:80]);xticklabels ([]);
ylabel ({'Depressional Storage','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF (5%)',  '0%','8%', '16%', 'Location', 'SouthWest')
title ('Remaining Ice')

subplot(2,3,2)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,5), 'Color', [128 128 255]/255); hold on
p33 = plot(td,CURdaily(:,:,6), 'Color', [0 204 204]/255); hold on
p44 = plot(td,CURdaily(:,:,7), 'Color', [255 102 102]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,5), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,6), 'Color', [0 153 153]/255, 'LineWidth', 2);
p4 = plot(td, CURmean(:,7), 'r', 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([0 80]);
yticks ([0:20:80]);xticklabels ([]);
ylabel ({'Depressional Storage','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF',  'No Storage',' Only Lake', 'Only Ponding', 'Location', 'NorthWest')
title ('Surface Water Storage')

subplot(2,3,3)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,8), 'Color', [128 128 255]/255); hold on
p33 = plot(td,CURdaily(:,:,9), 'Color', [0 204 204]/255); hold on
p44 = plot(td,CURdaily(:,:,10), 'Color', [255 102 102]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,8), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,9), 'Color', [0 153 153]/255, 'LineWidth', 2);
p4 = plot(td, CURmean(:,10), 'r', 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]);  ylim([0 80]);
yticks ([0:20:80]);
ylabel ({'Depressional Storage','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF',  '<1%','5%', '15%', 'Location', 'SouthWest')
title ('Vegetation growth')

subplot(2,3,4)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,11), 'Color', [128 128 255]/255); hold on
p33 = plot(td,CURdaily(:,:,12), 'Color', [0 204 204]/255); hold on
p44 = plot(td,CURdaily(:,:,13), 'Color', [255 102 102]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,11), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,12), 'Color', [0 153 153]/255, 'LineWidth', 2);
p4 = plot(td, CURmean(:,13), 'r', 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([0 80]);
yticks ([0:20:80]);
ylabel ({'Depressional Storage','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF (x2)',  'x1','x5', 'x10', 'Location', 'SouthWest')
title ('Sediment storage')

subplot(2,3,5)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,14), 'Color', [128 128 255]/255); hold on
p33 = plot(td,CURdaily(:,:,15), 'Color', [0 204 204]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,14), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,15), 'Color', [0 153 153]/255, 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([0 80]);
yticks ([0:20:80]);
ylabel ({'Depressional Storage','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF',  'wet','dry','Location', 'SouthWest')
title ('Compound')


figname ='Sd_15YearMean';
%
saveas (gcf, strcat( 'D:\FuturePeyto\fig\D1c\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\D1c\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\D1c\', figname))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Soil Moisture
clear all
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUB1.mat','soil_moistSUB1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUB2.mat','soil_moistSUB2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUB3.mat','soil_moistSUB3')

load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoICE1.mat','soil_moistICE1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoICE2.mat','soil_moistICE2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoICE3.mat','soil_moistICE3')

load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUR1.mat','soil_moistSUR1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUR2.mat', 'soil_moistSUR2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUR3.mat','soil_moistSUR3')

load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoVEG1.mat','soil_moistVEG1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoVEG2.mat','soil_moistVEG2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoVEG3.mat','soil_moistVEG3')

load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoWET.mat','soil_moistWET')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoDRY.mat','soil_moistDRY')

load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoREF.mat','soil_moistREF', 'timeREF')

load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoREF.mat', 'soil_moistREF', 'timeREF')

hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 

 varPGW = cat(3,soil_moistREF , soil_moistICE1 , soil_moistICE2 , soil_moistICE3 , soil_moistSUR1 , soil_moistSUR2 , soil_moistSUR3 , ...
     soil_moistVEG1 ,soil_moistVEG2 , soil_moistVEG3 , soil_moistSUB1 , soil_moistSUB2 , soil_moistSUB3, soil_moistWET, soil_moistDRY);
 clear  soil_moistREF soil_moistDRY soil_moistWET soil_moistICE1 soil_moistICE2 soil_moistICE3 soil_moistSUR1 soil_moistSUR2 soil_moistSUR3 soil_moistVEG1 soil_moistVEG2 soil_moistVEG3 soil_moistSUB1 soil_moistSUB2 soil_moistSUB3
varPGW = varPGW(8785:end, :, :);
timeREF = timeREF(8785:end); % removing spin up yer

hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 
basinarea = sum(hruarea); % m2


%
% VAlab = {'Ref', 'Snow', 'Evaporation', 'Blowing Snow Sublimation' ,...
%     'Blowing Snow Transport', 'Avalanche Transport', 'Icemelt', 'Snowmelt', ...
%     'Soil Moisture', 'Groundwater Storage'};
VA = varPGW;
sz= size(VA);
clear varPGW 

for i = 1:sz(3)
     va = VA(:,:,i)*0.001;   va = nanmean(va.*hruarea,2); va = va/basinarea * 1000; 
  CUR(:, i) = va;
end 

% Housekeeping
% remove leap year, add nan to complete 2015 year
clear  t d VarOut VarA 
% find and remove all the feb 29
x = datevec(timeREF);
a = find(x(:, 2)== 2 & x(:, 3)==29);
timeREF(a) = [];
CUR(a, :) = [];
% add nan to end of 2015 to make it a full water year (3 days)
textra = timeREF(end)+hours(1):hours(1):datetime('01-Oct-2099 00:00:00');
timeREF= [timeREF; textra'];
% textra = timePGW(end)+hours(1):hours(1):datetime('01-Oct-2099 00:00:00');
% timePGW= [timePGW; textra'];
% pad the data with nan 
sz = size(CUR);
pad = nan(length(textra),sz(2)) ;
CUR = [CUR; pad];
clear a pad textra x 
% Reshape in 15 column (for each year)
clear va va VA VB
for ii = 1:sz(2)
    vb = reshape (CUR(:,ii), 8760, 15);
    VB(:,:,ii) = vb; 
end 
CURyr = VB;
clear va vb VA VB

% Daily values
clear yr
yr =  (datetime('01-Oct-2084 00:00:00'):hours(1):datetime('30-Sep-2085 23:00:00'))';
for i= 1:sz(2)
    va  =CURyr(:,:,i) ;
    x = timetable (yr,va);
    xx = retime(x, 'daily', 'sum');
    VA(:,:,i)= table2array(xx);
    td= xx.yr;
end
CURdaily = VA;
clear x xx VA VB va vb
% Daily mean average

% Compile mean and Std
for i = 1:sz(2)
     va = CURdaily(:,:,i);
     CURmean(:, i) = nanmean(va, 2);
     CURstd (:, i) = nanstd(va, 0, 2);
end 
clear va vb
% Plot
% just theplot withtout shading
fig = figure('units','inches','position',[0 0 9 6]); 
subplot(2,3,1)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,2), 'Color', [128 128 255]/255); hold on
p22 = plot(td,CURdaily(:,:,3), 'Color', [0 204 204]/255); hold on
p22 = plot(td,CURdaily(:,:,4), 'Color', [255 102 102]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,2), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,3), 'Color', [0 153 153]/255, 'LineWidth', 2);
p4 = plot(td, CURmean(:,4), 'r', 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([50 120]);
yticks ([50:10:120]);xticklabels ([]);
ylabel ({'Soil Moisture','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF 5%',  '0%','8%', '16%', 'Location', 'NorthWest')
title ('Remaining Ice')

subplot(2,3,2)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,5), 'Color', [128 128 255]/255); hold on
p33 = plot(td,CURdaily(:,:,6), 'Color', [0 204 204]/255); hold on
p44 = plot(td,CURdaily(:,:,7), 'Color', [255 102 102]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,5), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,6), 'Color', [0 153 153]/255, 'LineWidth', 2);
p4 = plot(td, CURmean(:,7), 'r', 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([50 120]);
yticks ([50:10:120]);xticklabels ([]);
ylabel ({'Soil Moisture','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF',  'No storage,','Only lake', 'only pond', 'Location', 'NorthWest')
title ('Surface Water Storage')

subplot(2,3,3)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,8), 'Color', [128 128 255]/255); hold on
p33 = plot(td,CURdaily(:,:,9), 'Color', [0 204 204]/255); hold on
p44 = plot(td,CURdaily(:,:,10), 'Color', [255 102 102]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,8), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,9), 'Color', [0 153 153]/255, 'LineWidth', 2);
p4 = plot(td, CURmean(:,10), 'r', 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([50 120]);
yticks ([50:10:120]);xticklabels ([]);
ylabel ({'Soil Moisture','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF',  '<1%','5%', '15%', 'Location', 'NorthWest')
title ('Vegetation growth')

subplot(2,3,4)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,11), 'Color', [128 128 255]/255); hold on
p33 = plot(td,CURdaily(:,:,12), 'Color', [0 204 204]/255); hold on
p44 = plot(td,CURdaily(:,:,13), 'Color', [255 102 102]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,11), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,12), 'Color', [0 153 153]/255, 'LineWidth', 2);
p4 = plot(td, CURmean(:,13), 'r', 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([50 250]);
yticks ([50:50:250]);xticklabels ([]);
ylabel ({'Soil Moisture','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF(x2)',  'x1','x5', 'x10', 'Location', 'NorthWest')
title ('Sediment storage')

subplot(2,3,5)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,14), 'Color', [128 128 255]/255); hold on
p33 = plot(td,CURdaily(:,:,15), 'Color', [0 204 204]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,14), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,15), 'Color', [0 153 153]/255, 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([50 250]);
yticks ([50:50:250]);xticklabels ([]);
ylabel ({'Soil Moisture','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF',  'wet','dry', 'Location', 'NorthWest')
title ('Compound')

figname ='SoilMoist_15YearMean';
%
saveas (gcf, strcat( 'D:\FuturePeyto\fig\D1c\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\D1c\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\D1c\', figname))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GW storage
close all
clear all

 load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoICE1.mat', 'gwICE1')
 load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoICE2.mat', 'gwICE2')
 load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoICE3.mat', 'gwICE3')

 load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUR1.mat',  'gwSUR1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUR2.mat',  'gwSUR2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUR3.mat',  'gwSUR3')

 load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoVEG1.mat', 'gwVEG1')
 load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoVEG2.mat', 'gwVEG2')
 load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoVEG3.mat', 'gwVEG3')

load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUB1.mat', 'gwSUB1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUB2.mat', 'gwSUB2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoSUB3.mat', 'gwSUB3')

load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoWET.mat', 'gwWET')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoDRY.mat', 'gwDRY')
load('D:\FuturePeyto\crhm\C_Scenarios\output\PeytoREF.mat', 'gwREF', 'timeREF')

hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 

 varPGW = cat(3,gwREF , gwICE1 , gwICE2 , gwICE3 , gwSUR1 , gwSUR2 , gwSUR3 , ...
     gwVEG1 ,gwVEG2 , gwVEG3 , gwSUB1 , gwSUB2 , gwSUB3 );
 clear  gwREF gwICE1 gwICE2 gwICE3 gwSUR1 gwSUR2 gwSUR3 gwVEG1 gwVEG2 gwVEG3 gwSUB1 gwSUB2 gwSUB3
varPGW = varPGW(8785:end, :, :);
timeREF = timeREF(8785:end); % removing spin up yer

hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 
basinarea = sum(hruarea); % m2


%
% VAlab = {'Ref', 'Snow', 'Evaporation', 'Blowing Snow Sublimation' ,...
%     'Blowing Snow Transport', 'Avalanche Transport', 'Icemelt', 'Snowmelt', ...
%     'Soil Moisture', 'Groundwater Storage'};
VA = varPGW;
sz= size(VA);
clear varPGW 

for i = 1:sz(3)
     va = VA(:,:,i)*0.001;   va = nanmean(va.*hruarea,2); va = va/basinarea * 1000; 
  CUR(:, i) = va;
end 

% Housekeeping
% remove leap year, add nan to complete 2015 year
clear  t d VarOut VarA 
% find and remove all the feb 29
x = datevec(timeREF);
a = find(x(:, 2)== 2 & x(:, 3)==29);
timeREF(a) = [];
CUR(a, :) = [];
% add nan to end of 2015 to make it a full water year (3 days)
textra = timeREF(end)+hours(1):hours(1):datetime('01-Oct-2099 00:00:00');
timeREF= [timeREF; textra'];
% textra = timePGW(end)+hours(1):hours(1):datetime('01-Oct-2099 00:00:00');
% timePGW= [timePGW; textra'];
% pad the data with nan 
sz = size(CUR);
pad = nan(length(textra),sz(2)) ;
CUR = [CUR; pad];
clear a pad textra x 
% Reshape in 15 column (for each year)
clear va va VA VB
for ii = 1:sz(2)
    vb = reshape (CUR(:,ii), 8760, 15);
    VB(:,:,ii) = vb; 
end 
CURyr = VB;
clear va vb VA VB

% Daily values
clear yr
yr =  (datetime('01-Oct-2084 00:00:00'):hours(1):datetime('30-Sep-2085 23:00:00'))';
for i= 1:sz(2)
    va  =CURyr(:,:,i) ;
    x = timetable (yr,va);
    xx = retime(x, 'daily', 'sum');
    VA(:,:,i)= table2array(xx);
    td= xx.yr;
end
CURdaily = VA;
clear x xx VA VB va vb
% Daily mean average

% Compile mean and Std
for i = 1:sz(2)
     va = CURdaily(:,:,i);
     CURmean(:, i) = nanmean(va, 2);
     CURstd (:, i) = nanstd(va, 0, 2);
end 
clear va vb
% Plot
% just theplot withtout shading
fig = figure('units','inches','position',[0 0 9 6]); 
subplot(2,2,1)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,2), 'Color', [128 128 255]/255); hold on
p22 = plot(td,CURdaily(:,:,3), 'Color', [0 204 204]/255); hold on
p22 = plot(td,CURdaily(:,:,4), 'Color', [255 102 102]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,2), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,3), 'Color', [0 153 153]/255, 'LineWidth', 2);
p4 = plot(td, CURmean(:,4), 'r', 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([150 450]);
yticks ([150:100:450]);xticklabels ([]);
ylabel ({'Groundwater Storage','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF',  '4%','8%', '16%', 'Location', 'NorthWest')
title ('Remaining Ice')

subplot(2,2,2)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,5), 'Color', [128 128 255]/255); hold on
p33 = plot(td,CURdaily(:,:,6), 'Color', [0 204 204]/255); hold on
p44 = plot(td,CURdaily(:,:,7), 'Color', [255 102 102]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,5), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,6), 'Color', [0 153 153]/255, 'LineWidth', 2);
p4 = plot(td, CURmean(:,7), 'r', 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([150 450]);
yticks ([150:100:450]);xticklabels ([]);
ylabel ({'Groundwater Storage','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF',  'No Lake, no Ponding','Ponding, No lake', 'Lake + Ponding', 'Location', 'NorthWest')
title ('Surface Water Storage')

subplot(2,2,3)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,8), 'Color', [128 128 255]/255); hold on
p33 = plot(td,CURdaily(:,:,9), 'Color', [0 204 204]/255); hold on
p44 = plot(td,CURdaily(:,:,10), 'Color', [255 102 102]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,8), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,9), 'Color', [0 153 153]/255, 'LineWidth', 2);
p4 = plot(td, CURmean(:,10), 'r', 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([150 450]);
yticks ([150:100:450]);
ylabel ({'Groundwater Storage','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF',  '<1%','5%', '15%', 'Location', 'NorthWest')
title ('Vegetation growth')

subplot(2,2,4)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,11), 'Color', [128 128 255]/255); hold on
p33 = plot(td,CURdaily(:,:,12), 'Color', [0 204 204]/255); hold on
p44 = plot(td,CURdaily(:,:,13), 'Color', [255 102 102]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,11), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,12), 'Color', [0 153 153]/255, 'LineWidth', 2);
p4 = plot(td, CURmean(:,13), 'r', 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([150 450]);
yticks ([150:100:450]);
ylabel ({'Groundwater Storage','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF',  'x2','x5', 'x10', 'Location', 'NorthWest')
title ('Sediment storage')

figname ='GW_15YearMean';
%
saveas (gcf, strcat( 'D:\FuturePeyto\fig\D1c\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\D1c\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\D1c\', figname))


%% All storage: Sd + Soil + GW

close all
clear all

 load('D:\FuturePeyto\crhm\C_Scenarios\output\IceInit\PeytoICE1.mat', 'SdICE1')
 load('D:\FuturePeyto\crhm\C_Scenarios\output\IceInit\PeytoICE2.mat', 'SdICE2')
 load('D:\FuturePeyto\crhm\C_Scenarios\output\IceInit\PeytoICE3.mat', 'SdICE3')

 load('D:\FuturePeyto\crhm\C_Scenarios\output\LakeForm\PeytoSUR1.mat',  'SdSUR1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\LakeForm\PeytoSUR2.mat',  'SdSUR2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\LakeForm\PeytoSUR3.mat',  'SdSUR3')

 load('D:\FuturePeyto\crhm\C_Scenarios\output\NoVeg\PeytoVEG1.mat', 'SdVEG1')
 load('D:\FuturePeyto\crhm\C_Scenarios\output\NoVeg\PeytoVEG2.mat', 'SdVEG2')
 load('D:\FuturePeyto\crhm\C_Scenarios\output\NoVeg\PeytoVEG3.mat', 'SdVEG3')

load('D:\FuturePeyto\crhm\C_Scenarios\output\GWstorage\PeytoGW1.mat', 'SdGW1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\GWstorage\PeytoGW2.mat', 'SdGW2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\GWstorage\PeytoGW3.mat', 'SdGW3')
load('D:\FuturePeyto\crhm\C_Scenarios\output\Ref\PeytoREF.mat', 'SdREF', 'timeREF')

 var1 = cat(3,SdREF(:, 38:74), SdICE1(:, 38:74), SdICE2(:, 38:74), SdICE3(:, 38:74), SdSUR1(:, 38:74), SdSUR2(:, 38:74), SdSUR3(:, 38:74), ...
     SdVEG1(:, 38:74),SdVEG2(:, 38:74), SdVEG3(:, 38:74), SdGW1(:, 38:74), SdGW2(:, 38:74), SdGW3(:, 38:74));
 clear  SdREF SdICE1 SdICE2 SdICE3 SdSUR1 SdSUR2 SdSUR3 SdVEG1 SdVEG2 SdVEG3 SdGW1 SdGW2 SdGW3

% Soil Moisture
 load('D:\FuturePeyto\crhm\C_Scenarios\output\IceInit\PeytoICE1.mat', 'soil_moistICE1')
 load('D:\FuturePeyto\crhm\C_Scenarios\output\IceInit\PeytoICE2.mat', 'soil_moistICE2')
 load('D:\FuturePeyto\crhm\C_Scenarios\output\IceInit\PeytoICE3.mat', 'soil_moistICE3')

 load('D:\FuturePeyto\crhm\C_Scenarios\output\LakeForm\PeytoSUR1.mat',  'soil_moistSUR1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\LakeForm\PeytoSUR2.mat',  'soil_moistSUR2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\LakeForm\PeytoSUR3.mat',  'soil_moistSUR3')

 load('D:\FuturePeyto\crhm\C_Scenarios\output\NoVeg\PeytoVEG1.mat', 'soil_moistVEG1')
 load('D:\FuturePeyto\crhm\C_Scenarios\output\NoVeg\PeytoVEG2.mat', 'soil_moistVEG2')
 load('D:\FuturePeyto\crhm\C_Scenarios\output\NoVeg\PeytoVEG3.mat', 'soil_moistVEG3')

load('D:\FuturePeyto\crhm\C_Scenarios\output\GWstorage\PeytoGW1.mat', 'soil_moistGW1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\GWstorage\PeytoGW2.mat', 'soil_moistGW2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\GWstorage\PeytoGW3.mat', 'soil_moistGW3')
load('D:\FuturePeyto\crhm\C_Scenarios\output\Ref\PeytoREF.mat', 'soil_moistREF', 'timeREF')


 var2= cat(3,soil_moistREF , soil_moistICE1 , soil_moistICE2 , soil_moistICE3 , soil_moistSUR1 , soil_moistSUR2 , soil_moistSUR3 , ...
     soil_moistVEG1 ,soil_moistVEG2 , soil_moistVEG3 , soil_moistGW1 , soil_moistGW2 , soil_moistGW3 );
 clear  soil_moistREF soil_moistICE1 soil_moistICE2 soil_moistICE3 soil_moistSUR1 soil_moistSUR2 soil_moistSUR3 soil_moistVEG1 soil_moistVEG2 soil_moistVEG3 soil_moistGW1 soil_moistGW2 soil_moistGW3

load('D:\FuturePeyto\crhm\C_Scenarios\output\IceInit\PeytoICE1.mat', 'gwICE1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\IceInit\PeytoICE2.mat', 'gwICE2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\IceInit\PeytoICE3.mat', 'gwICE3')

load('D:\FuturePeyto\crhm\C_Scenarios\output\LakeForm\PeytoSUR1.mat',  'gwSUR1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\LakeForm\PeytoSUR2.mat',  'gwSUR2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\LakeForm\PeytoSUR3.mat',  'gwSUR3')

load('D:\FuturePeyto\crhm\C_Scenarios\output\NoVeg\PeytoVEG1.mat', 'gwVEG1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\NoVeg\PeytoVEG2.mat', 'gwVEG2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\NoVeg\PeytoVEG3.mat', 'gwVEG3')

load('D:\FuturePeyto\crhm\C_Scenarios\output\GWstorage\PeytoGW1.mat', 'gwGW1')
load('D:\FuturePeyto\crhm\C_Scenarios\output\GWstorage\PeytoGW2.mat', 'gwGW2')
load('D:\FuturePeyto\crhm\C_Scenarios\output\GWstorage\PeytoGW3.mat', 'gwGW3')
load('D:\FuturePeyto\crhm\C_Scenarios\output\Ref\PeytoREF.mat', 'gwREF', 'timeREF')

hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 

 var3 = cat(3,gwREF , gwICE1 , gwICE2 , gwICE3 , gwSUR1 , gwSUR2 , gwSUR3 , ...
     gwVEG1 ,gwVEG2 , gwVEG3 , gwGW1 , gwGW2 , gwGW3 );
 clear  gwREF gwICE1 gwICE2 gwICE3 gwSUR1 gwSUR2 gwSUR3 gwVEG1 gwVEG2 gwVEG3 gwGW1 gwGW2 gwGW3

hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 
basinarea = sum(hruarea); % m2

%%
varPGW = var1+ var2+var3;
VA = varPGW;
sz= size(VA);
clear varPGW 

for i = 1:sz(3)
     va = VA(:,:,i)*0.001;   va = nanmean(va.*hruarea,2); va = va/basinarea * 1000; 
  CUR(:, i) = va;
end 

%% Housekeeping
% remove leap year, add nan to complete 2015 year
clear  t d VarOut VarA 
% find and remove all the feb 29
x = datevec(timeREF);
a = find(x(:, 2)== 2 & x(:, 3)==29);
timeREF(a) = [];
CUR(a, :) = [];
% add nan to end of 2015 to make it a full water year (3 days)
textra = timeREF(end)+hours(1):hours(1):datetime('01-Oct-2099 00:00:00');
timeREF= [timeREF; textra'];
% textra = timePGW(end)+hours(1):hours(1):datetime('01-Oct-2099 00:00:00');
% timePGW= [timePGW; textra'];
% pad the data with nan 
sz = size(CUR);
pad = nan(length(textra),sz(2)) ;
CUR = [CUR; pad];
clear a pad textra x 
%% Reshape in 15 column (for each year)
clear va va VA VB
for ii = 1:sz(2)
    vb = reshape (CUR(:,ii), 8760, 15);
    VB(:,:,ii) = vb; 
end 
CURyr = VB;
clear va vb VA VB

%% Daily values
clear yr
yr =  (datetime('01-Oct-2084 00:00:00'):hours(1):datetime('30-Sep-2085 23:00:00'))';
for i= 1:sz(2)
    va  =CURyr(:,:,i) ;
    x = timetable (yr,va);
    xx = retime(x, 'daily', 'sum');
    VA(:,:,i)= table2array(xx);
    td= xx.yr;
end
CURdaily = VA;
clear x xx VA VB va vb
%% Daily mean average

% Compile mean and Std
for i = 1:sz(2)
     va = CURdaily(:,:,i);
     CURmean(:, i) = nanmean(va, 2);
     CURstd (:, i) = nanstd(va, 0, 2);
end 
clear va vb
%% Plot
% just theplot withtout shading
fig = figure('units','inches','position',[0 0 9 6]); 
subplot(2,2,1)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,2), 'Color', [128 128 255]/255); hold on
p22 = plot(td,CURdaily(:,:,3), 'Color', [0 204 204]/255); hold on
p22 = plot(td,CURdaily(:,:,4), 'Color', [255 102 102]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,2), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,3), 'Color', [0 153 153]/255, 'LineWidth', 2);
p4 = plot(td, CURmean(:,4), 'r', 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([200 600]);
yticks ([150:100:650]);xticklabels ([]);
ylabel ({'Total Storage','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF',  '4%','8%', '16%', 'Location', 'NorthWest')
title ('Remaining Ice')

subplot(2,2,2)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,5), 'Color', [128 128 255]/255); hold on
p33 = plot(td,CURdaily(:,:,6), 'Color', [0 204 204]/255); hold on
p44 = plot(td,CURdaily(:,:,7), 'Color', [255 102 102]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,5), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,6), 'Color', [0 153 153]/255, 'LineWidth', 2);
p4 = plot(td, CURmean(:,7), 'r', 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([200 600]);
yticks ([150:100:650]);xticklabels ([]);
ylabel ({'Total Storage','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF',  'No Lake, no Ponding','Ponding, No lake', 'Lake + Ponding', 'Location', 'NorthWest')
title ('Surface Water Storage')

subplot(2,2,3)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,8), 'Color', [128 128 255]/255); hold on
p33 = plot(td,CURdaily(:,:,9), 'Color', [0 204 204]/255); hold on
p44 = plot(td,CURdaily(:,:,10), 'Color', [255 102 102]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,8), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,9), 'Color', [0 153 153]/255, 'LineWidth', 2);
p4 = plot(td, CURmean(:,10), 'r', 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([200 600]);
yticks ([150:100:650]);
ylabel ({'Total Storage','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF',  '<1%','5%', '15%', 'Location', 'NorthWest')
title ('Vegetation growth')

subplot(2,2,4)
p11 = plot(td, CURdaily(:,:,1), 'Color', [.5 .5 .5]); hold on
p22 = plot(td,CURdaily(:,:,11), 'Color', [128 128 255]/255); hold on
p33 = plot(td,CURdaily(:,:,12), 'Color', [0 204 204]/255); hold on
p44 = plot(td,CURdaily(:,:,13), 'Color', [255 102 102]/255); hold on
p1 = plot(td, CURmean(:,1), 'k', 'LineWidth', 2);
p2 = plot(td, CURmean(:,11), 'b', 'LineWidth', 2);
p3 = plot(td, CURmean(:,12), 'Color', [0 153 153]/255, 'LineWidth', 2);
p4 = plot(td, CURmean(:,13), 'r', 'LineWidth', 2);
xtickformat ('MMM')
xlim ([td(1) td(end)]); ylim([200 800]);
yticks ([150:100:750]);
ylabel ({'Total Storage','(mm)'});
legend ([p1(1) p2(1) p3(1)  p4(1)], 'REF',  'x2','x5', 'x10', 'Location', 'NorthWest')
title ('Sediment storage')

figname ='Storage_15YearMean';
%
saveas (gcf, strcat( 'D:\FuturePeyto\fig\D1c\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\D1c\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\D1c\', figname))

