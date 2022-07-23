%% 3D bar plot pf stats (as suggested by Wouter)
% show % change from reference WRF PGW run for each simulation (MET +
% Landscape)
% make a pretty figure with colros 

% Change relative to PGW
close all
clear all

load('D:\5_FuturePeyto\crhm\C_Scenarios\output\Scenario_bf.mat')
load ('D:\5_FuturePeyto\crhm\D_MetSim\output\ScenarioMET_basinflow.mat')

t_original = t; % keep a orginial time stamp in case

var = [bfREF(367:end, 2),bfREF(367:end, 1),  bfICE(367:end, :), bfLAK(367:end, :),bfGW(367:end, :) ,...
    bfVEG(367:end, :), bfWET(367:end, :),bfT(367:end, :), bfP(367:end, :), bfC(367:end, :) ]; % compile the variable in one matrix
t = t(367:end, :); % remove first years (as it was a spin up year)

lab = {'CUR', 'PGW-Ref', ...
        'Ice 0%','Ice 8%','Ice 16%',...
        'No Surf','Lake','Pond',...
        'Sub x1','Sub x5','Sub x10', ...
        'Veg <1%','Veg 5%','Veg 15%',...
        'Wet', 'Dry', ...
        'T-2', 'T-1', 'T+1', 'T+2',...
        'P-20%', 'P-10%', 'P+10%', 'P+20%',...
        'CD', 'CW', 'WD', 'WW'}'; % create the labels to match the variables
clear bfWET bfVEG bfREF bfLAK bfICE bfGW % rmeove indiviudal variable

% remove the leap years to be able to do the 15 year average
sz = size (var); % get the size of the variable
timevec = datevec(t); % change to a time vector
var(find(timevec(:,2) == 2 & timevec(:,3) == 29), :) = []; % remove leap years days
t(find(timevec(:,2) == 2 & timevec(:,3) == 29), :) = [];
% select the April 1 as the star of the year
t= datetime(t);
timevec = datevec(t);
tidx = find(timevec(:, 2) ==4 & timevec(:, 3) == 1);
t(tidx) % quick check for the dates for each year - this should give a list of april 1st 

for ii = 1:sz(2) % for the scenarios
     varPGW= var(:,ii);
for i = 1:length(tidx)-1 % for every year
    if i <=15
   varRSHP_PGW(:, i) = varPGW(tidx(i):tidx(i+1)-1); % select the data from that year
    else 
   varRSHP_PGW(:, i) = [varPGW(tidx(i):tidx(i+1)); nan(364-(tidx(15)-tidx(14)), 1)]; % last year shorter, so I pad with nan
  end 
end 
VarPGW(:,:,ii) = varRSHP_PGW; % compile in a 3d matrix (15 years, 16 scenarios)
end
for i = 1:sz(2)    
    dd= VarPGW(:,:,i);
    BF(:, i) = nanmean(dd, 2); % the average of the 15 years 
end 
 td = t(tidx(1):tidx(2)-1); % create a time array for 364 days

clear varRSHP_PGW varPGW sz ii dd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compiling statistics compared with PGW
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Total streamflow
SUM = round(sum(BF)./sum(BF(:, 2)), 2) *100 -100;
% from CUR
SUMcur = round(sum(BF)./sum(BF(:, 1)), 2) *100 -100;

%% DIFF
DIFF = BF - BF(:, 2);
plot(td, smooth(DIFF(:,25),12)); hold on
plot(td, smooth(DIFF(:,26),12));
plot(td, smooth(DIFF(:,27),12));
plot(td, smooth(DIFF(:,28),12));
legend ('CD', 'CW', 'WD', 'WW')
t1 = find(td == '16-Jun-2085')
t2 = find(td == '13-Oct-2085')
mean(DIFF(t1:t2, 25:28))
t1 = find(td == '1-Nov-2085')
t2 = find(td == '30-Mar-2086')
mean(DIFF(t1:t2, 25:28))
    %    'CD', 'CW', 'WD', 'WW'
%% Total spring  (April-June)
BFspr = BF(61:91, :);
SUMspr = round(sum(BFspr)./sum(BFspr(:, 2)), 2)*100 -100;
SUMsprcur = round(sum(BFspr)./sum(BFspr(:, 1)), 2)*100 -100;
%% Total summmer (July-Sep)
BFsum = BF(92:183, :);
SUMsum = round(sum(BFsum)./sum(BFsum(:, 2)), 2)*100 -100;
SUMsumcur = round(sum(BFsum)./sum(BFsum(:, 1)), 2)*100 -100;

%% Total fall  (Oct-Dec)
BFfall = BF(184:275, :);
SUMfall = round(sum(BFfall)./sum(BFfall(:, 2)), 2)*100 -100;
%% Total winter  (Jan-March)
BFwin = BF(276:365, :);
SUMwin= round(sum(BFwin)./sum(BFwin(:, 2)), 2)*100 -100;
%% Peak flow
[pkflow, pkflow_idx] = max(BF);
PKFLOW = round(pkflow/pkflow(2), 2) *100 -100;
PKFLOWcur = round(pkflow/pkflow(1), 2) *100 -100;
%% Peak flow timing
PKFLOW_timing = td(pkflow_idx);% date of peak flow
PKFLOW_daydiff = days(PKFLOW_timing - PKFLOW_timing(2));% number of day changed
PKFLOW_daydiffcur = days(PKFLOW_timing - PKFLOW_timing(1));% number of day changed

%% Coefficient of variability - yearly
for i = 1:28
    x = var(:, i);
    cv(i) = std(x)./nanmean(x);
end 
CVyear = round(cv*100/cv(2))'-100
%% Coefficient of variability - spring, summer, fall, winter, 
for i = 1:28
cv_summer(i) = std(BFsum(:, i))./nanmean(BFsum(:, i));
cv_spring(i) = std(BFspr(:, i))./nanmean(BFspr(:, i));
cv_winter(i) = std(BFwin(:, i))./nanmean(BFwin(:, i));
cv_fall(i) = std(BFfall(:, i))./nanmean(BFfall(:, i));
end 
CVsum = round(cv_summer*100/cv_summer(2))'-100
CVspr = round(cv_spring*100/cv_spring(2))'-100
CVfall = round(cv_fall*100/cv_fall(2))'-100
CVwin = round(cv_winter*100/cv_winter(2))'-100
%% August low flow
BFaug = BF(123:153, :);
[augflow, augflow_idx] = min(BFaug)
% change in peak flow
MINaug = round(augflow/augflow(2), 2) *100 -100
MINaugcur = round(augflow/augflow(1),2) *100 -100
%% Time of concentration
% find 50% of flow
clear x x_percent x_50all t50
for i = 1:28;
x = cumsum(BF(:, i));
x_percent = round(x*100./x(end))
x_50all = find(x_percent == 50);
t50(i) = x_50all(1);
end 
t50diff = t50 - t50(2);
%%
Stat_all = [SUM; SUMspr; SUMsum; SUMfall;SUMwin;MINaug;PKFLOW;PKFLOW_daydiff';CVyear';CVspr';CVsum';CVfall';CVwin';t50diff]
Stat_label = {'Total (Annual)';'Total (Spring)'; 'Total (Summer)'; 'Total (Fall)';'Total (Winter)';...
    'August Minimum';'Peak Flow';'Peak Flow Timing';...
    'CV (Annual)';'CV (Spring)'; 'CV (Summer)'; 'CV (Fall)';'CV (Winter)';...
    'Time of Concentration'}


% lab = {'CUR', 'PGW-Ref', 'Ice 0%','Ice 8%','Ice 16%','No Storage','Lake','Ponds',...
%     'x1 Sub','x5 Sub','x10 Sub','Veg <1%','Veg 5%','Veg 15%', 'Lush', 'Bare', ...
%     'T-2C','T-1C','T+1C','T+2C','P-20%','P-10%','P+10%','P+20%'...
%     'Cold Dry', 'Cold Wet', 'Warm Dry', 'Warm Wet'}

%% Graph 
clear zdata b1 b2 x_neg pos_x 

Stat =Stat_all(:, 3:end); % remove the CUR values and PGW values
deg_sign = char(0176);
lab= {'Ice 0%','Ice 8%','Ice 16%',...
        'No Surf','Lake','Pond',...
        'Sub x1','Sub x5','Sub x10', ...
        'Veg <1%','Veg 5%','Veg 15%',...
        'Lush', 'Bare', ...
        strcat('T -2',deg_sign,'C'), strcat('T -2',deg_sign,'C'), strcat('T +1',deg_sign,'C'), strcat('T +2',deg_sign,'C'),...
        'P-20%', 'P-10%', 'P+10%', 'P+20%',...
        'Cold Dry', 'Cold Wet', 'Warm Dry', 'Warm Wet'}'; % create the labels to match the variables
%%
fig = figure('units','inches','position',[0 0 10 8]); 
sb1 = subplot(2,2,1:2)
b = bar3(Stat+100);
view (2)
% cmap_p = color_shades({[166 97 26]./255, [223 194 125]./255,'white',[128 205 193]./255, [1 133 113]./255})
% cmap_p = color_shades({[57 29 1]./255, [112 60 7]./255, [223 194 125]./255,'white',[128 205 193]./255, [2 94 82]./255, [1 63 54]./255})
% cmap_p2 = color_shades({ [112 60 7]./255, [223 194 125]./255,'white',[128 205 193]./255, [2 94 82]./255})
cmap_p2 = color_shades({[56 34 95]./255, ...
     [94 60 153]./255, ...
    [178 171 210]./255,...
    'white',[253 184 99]./255,[230 97 1]./255,[183 80 0]./255 })

% cmap_p = color_shades({[70, 0 0 ]./255, 'red','white','blue', [0 0 70]./255})
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
colormap(cmap_p2)
caxis ([70 130])
ch = colorbar
ch.TickLabels = ({'-60%';'-40%'; '-20%';'0%'; '20%';'40%'; '60%'})
ch.TickLabels = ({'-30%';'-20%';'-10%';'0%'; '10%';'20%';'30%'})

% oh yeh oh yeah
xticks ([1:26])
xlim ([0 27])
xticklabels (lab)
xtickangle (90)
yticklabels (Stat_label)
box on
%sb1.Position = sb1.Position + [-0.1 0 0.15 0.05];% subplot 2
%%
% figname ='Stats_ChangeFromPGW_AllScenarios';
% saveas (gcf, strcat('D:\FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\FuturePeyto\fig\D1b\', figname))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Same idea but with the processes
% load data
load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\REFprocesses.mat',  'REFmean', 'varname_basinaverage_all')
varname_REF = varname_basinaverage_all;
load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\ICE1processes.mat', 'ICE1mean')
load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\ICE2processes.mat', 'ICE2mean')
load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\ICE3processes.mat', 'ICE3mean')
load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\SUR1processes.mat', 'SUR1mean')
load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\SUR2processes.mat', 'SUR2mean')
load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\SUR3processes.mat', 'SUR3mean')
load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\SUB1processes.mat', 'SUB1mean')
load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\SUB2processes.mat', 'SUB2mean')
load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\SUB3processes.mat', 'SUB3mean')
load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\VEG1processes.mat', 'VEG1mean')
load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\VEG2processes.mat', 'VEG2mean')
load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\VEG3processes.mat', 'VEG3mean')
load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\DRYprocesses.mat', 'DRYmean')
load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\WETprocesses.mat',  'WETmean')
load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\ICE1processes.mat', 'varname_basinaverage_all')

load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\P1processes.mat', 'P1mean' , 'varname_basinaverage_all')
 varnameMETSIM= varname_basinaverage_all;
load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\P_1processes.mat', 'P_1mean')
load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\T2processes.mat', 'T2mean')
load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\P_2processes.mat', 'P_2mean')
load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\CWprocesses.mat', 'CWmean')
load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\T1processes.mat', 'T1mean')
load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\T_1processes.mat', 'T_1mean')
load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\P2processes.mat', 'P2mean')
load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\CDprocesses.mat', 'CDmean')
load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\WDprocesses.mat', 'WDmean')
load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\WWprocesses.mat', 'WWmean')
load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\T_2processes.mat', 'T_2mean')

load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\PGWprocesses.mat', 'PGWmean')
% add pad colum to the scenario runs
pad = nan(365,3);
pad2 = nan(365, 1);
var_processes = cat(3,[PGWmean(:,1:3),REFmean, PGWmean(:, 4)], [pad,ICE1mean, pad2], [pad,ICE2mean, pad2], [pad,ICE3mean, pad2],...
    [pad,SUR1mean, pad2], [pad,SUR2mean, pad2], [pad,SUR3mean, pad2],...
    [pad,SUB1mean, pad2], [pad,SUB2mean, pad2], [pad,SUB3mean, pad2], ...
    [pad,VEG1mean, pad2], [pad,VEG2mean, pad2], [pad,VEG3mean, pad2],...
    [pad,DRYmean, pad2], [pad,WETmean, pad2],...
    T_2mean, T_1mean, T1mean, T2mean,...
    P_2mean, P_1mean, P1mean,P2mean,...
    CDmean, CWmean, WDmean, WWmean);
lab_processes = {'PGW-Ref', ...
        'Ice 0%','Ice 8%','Ice 16%',...
        'No Surf','Lake','Pond',...
        'Sub x1','Sub x5','Sub x10', ...
        'Veg <1%','Veg 5%','Veg 15%',...
        'Bare', 'Lush', ...
        'T-2', 'T-1', 'T+1', 'T+2',...
        'P-20%', 'P-10%', 'P+10%', 'P+20%',...
        'CD', 'CW', 'WD', 'WW'}'; % create the labels to match the variables

% Compile stats
% annual
%% Total evap
x = sum(squeeze( var_processes(:, 4, :)));
SUMevap = x *100./x(1);
%% Total icemelt
x = sum(squeeze( var_processes(:, 5, :)));
SUMicemelt = x *100./x(1);
%% Total Soil Runoff
x = sum(squeeze( var_processes(:, 6, :)));
SUMsoilrunoff = x *100./x(1);
%% Total surface runoff
x = sum(squeeze( var_processes(:, 7, :)));
SUMssrrunoff = x *100./x(1);
%% total subsurface runoff
x = sum(squeeze( var_processes(:, 8, :)));
SUMgwflow= x *100./x(1);
%% Total soil moist
x = sum(squeeze( var_processes(:, 9, :)));
SUMsoilmoist= x *100./x(1);
%% total gw storage
x = sum(squeeze( var_processes(:, 10, :)));
SUMgw= x *100./x(1);
%% total depressional storge
x = sum(squeeze( var_processes(:, 11, :)));
SUMsd= x *100./x(1);
%% rain/snow ratio
x = sum(squeeze(var_processes(:, 1, :)))./sum(squeeze( var_processes(:, 2, :)));
RainRatio=round(  x *100./x(1));

%% Compile in a areray
Stat_all = [SUMevap; SUMicemelt; SUMsoilrunoff;SUMssrrunoff;SUMgwflow;SUMsoilmoist;SUMgw;SUMsd;RainRatio]
% change nana to zero
x = isnan(Stat_all)
Stat_all(x) = 100;
Stat_processes = Stat_all(:, 2:end);
% pad with nan to make same size as above
deg_sign = char(0176);
Stat_processes_pad  = [Stat_processes; ones(6, 26)*100];
 
Stat_label = {'Evaporation'; 'Ice melt'; 'Soil Runoff';'Subsurface Runoff';'GW flow';'Soil Moisture Storage';'GW Storage';'Depressional Storage'; 'Rainfall Ratio'}
lab_processes = {'Ice 0%','Ice 8%','Ice 16%',...
        'No Surf','Lake','Pond',...
        'Sub x1','Sub x5','Sub x10', ...
        'Veg <1%','Veg 5%','Veg 15%',...
        'Bare', 'Lush', ...
        strcat('T -2',deg_sign,'C'), strcat('T -2',deg_sign,'C'), strcat('T +1',deg_sign,'C'), strcat('T +2',deg_sign,'C'),...
        'P-20%', 'P-10%', 'P+10%', 'P+20%',...
        'Cold Dry', 'Cold Wet', 'Warm Dry', 'Warm Wet'}'; % create the labels to match the variables
%% with negative
clear zdata b1 b2 x_neg pos_x 

sb2 = subplot(2,2,3:4)
b = bar3(Stat_processes_pad);
view (2)
% c = [;... % light blue
%     ; ...    % darkj blue
%     204 0 0;...%dark red 
%     255 102 178]./255;
% cmap_p2 = color_shades({[166 97 26]./255, [223 194 125]./255,'white',[128 205 193]./255, [1 133 113]./255})
% cmap_p2 = color_shades({[112 60 7]./255, [223 194 125]./255,'white',[128 205 193]./255, [2 94 82]./255})
cmap_p2 = color_shades({[56 34 95]./255, ...
     [94 60 153]./255, ...
    [178 171 210]./255,...
    'white',[253 184 99]./255,[230 97 1]./255,[183 80 0]./255 })

%cmap_p2 = color_shades({[70, 0 0 ]./255, 'red','white','blue', [0 0 70]./255})
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
colormap(cmap_p2)
caxis ([0 200])
ch = colorbar
ch.TickLabels = ({'-100%';'-50%';'0%'; '50%';'100%'})
% oh yeh oh yeah
xticks ([1:26])
xlim ([0 27])
xticklabels (lab_processes)
xtickangle (45)
yticklabels (Stat_label)
box on
% sb2.Position = sb2.Position + [0 0 -0.05 0.08];% subplot 2
%^

figname ='Stats_ChangeFromPGW_Basinflow_Processes_forLandscape';
saveas (gcf, strcat('D:\FuturePeyto\fig\D1b\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\D1b\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\D1b\', figname))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %% for the METsim
%  close all
%  clear all
%  
%  load('D:\FuturePeyto\crhm\C_Scenarios\output\AnnualAverages\REFprocesses.mat', 'REFmean', 'varname_basinaverage_all')
%  varnameREF = varname_basinaverage_all;
% load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\PGWprocesses.mat', 'PGWmean', 'varname_basinaverage_all')
% varnamePGW=varname_basinaverage_all;
%  load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\P1processes.mat', 'P1mean' , 'varname_basinaverage_all')
%  varnameMETSIM= varname_basinaverage_all;
% load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\P_1processes.mat', 'P_1mean')
% load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\T2processes.mat', 'T2mean')
% load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\P_2processes.mat', 'P_2mean')
% load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\CWprocesses.mat', 'CWmean')
% load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\T1processes.mat', 'T1mean')
% load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\T_1processes.mat', 'T_1mean')
% load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\P2processes.mat', 'P2mean')
% load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\CDprocesses.mat', 'CDmean')
% load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\WDprocesses.mat', 'WDmean')
% load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\WWprocesses.mat', 'WWmean')
% load('D:\FuturePeyto\crhm\D_MetSim\output\AnnualAverages\T_2processes.mat', 'T_2mean')
% 
% lab = {'T-2C','T-1C','T+1C','T+2C',...
%         'P-20%','P-10%','P+10%','P+20%',...
%         'ColdDry','ColdWet','WarmDry', 'WarmWet'} 
% var_processes = cat(3,REFmean, T_2mean(:,[4:11]), T_1mean(:,[4:11]), T1mean(:,[4:11]), T2mean(:,[4:11]),...
%     P_2mean(:,[4:11]), P_1mean(:,[4:11]), P1mean(:,[4:11]),...
%     P2mean(:,[4:11]), CDmean(:,[4:11]), CWmean(:,[4:11]), WDmean(:,[4:11]), WWmean(:,[4:11]));
% % Compile stats
% % annual
% %% Var Processes
% %% Total evap
% x = sum(squeeze( var_processes(:, 1, :)));
% SUMevap = x *100./x(1);
% %% Total icemelt
% x = sum(squeeze( var_processes(:, 2, :)));
% SUMicemelt = x *100./x(1);
% %% Total Soil Runoff
% x = sum(squeeze( var_processes(:, 3, :)));
% SUMsoilrunoff = x *100./x(1);
% %% Total surface runoff
% x = sum(squeeze( var_processes(:, 4, :)));
% SUMssrrunoff = x *100./x(1);
% %% total subsurface runoff
% x = sum(squeeze( var_processes(:, 5, :)));
% SUMgwflow= x *100./x(1);
% %% Total soil moist
% x = sum(squeeze( var_processes(:, 6, :)));
% SUMsoilmoist= x *100./x(1);
% %% total gw storage
% x = sum(squeeze( var_processes(:, 7, :)));
% SUMgw= x *100./x(1);
% %% total depressional storge
% x = sum(squeeze( var_processes(:, 8, :)));
% SUMsd= x *100./x(1);
% %% Compile in a areray
% Stat_all = [SUMevap; SUMicemelt; SUMsoilrunoff;SUMssrrunoff;SUMgwflow;SUMsoilmoist;SUMgw;SUMsd]
% Stat_label = {'SUMevap'; 'SUMicemelt'; 'SUMsoilrunoff';'SUMssrrunoff';'SUMgwflow';'SUMsoilmoist';'SUMgw';'SUMsd'}
% lab_all = {'PGW-ref','T-2C','T-1C','T+1C','T+2C',...
%         'P-20%','P-10%','P+10%','P+20%',...
%         'ColdDry','ColdWet','WarmDry', 'WarmWet'} 
% 
% %% with negative
% clear zdata b1 b2 x_neg pos_x 
% 
% Stat =Stat_all(:, 2:end); % remove the CUR values and PGW values
% lab = {'T-2C','T-1C','T+1C','T+2C',...
%         'P-20%','P-10%','P+10%','P+20%',...
%         'ColdDry','ColdWet','WarmDry', 'WarmWet'} 
% 
% 
% fig = figure('units','inches','position',[0 0 6 6]); 
% b = bar3(Stat+100);
% view (2)
% cmap_p = color_shades({[70, 0 0 ]./255, 'red','white','blue', [0 0 70]./255})
% for k = 1:length(b)
%     zdata = b(k).ZData;
%     b(k).CData = zdata;
%     b(k).FaceColor = 'interp';
% end
% colormap(cmap_p)
% caxis ([140 260])
% ch = colorbar
% ch.TickLabels = ({'-60%';'-40%'; '-20%';'0%'; '20%';'40%'; '60%'})
% 
% xticks ([1:12])
% xlim ([0 13])
% xticklabels (lab)
% xtickangle (45)
% yticklabels (Stat_label)
% title('Percent change from PGW-reference, MET sim')
% figname ='Stats_ChangeFromPGW_Processes_MET';
% saveas (gcf, strcat('D:\FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\FuturePeyto\fig\D1b\', figname))
% 
% %% Forcings 
% var_forcings = cat(3,PGWmean (:, [4, 1:3]), T_2mean(:,[12,1:3]), T_1mean(:,[12,1:3]), T1mean(:,[12,1:3]), T2mean(:,[12,1:3]),...
%     P_2mean(:,[12,1:3]), P_1mean(:,[12,1:3]), P1mean(:,[12,1:3]),...
%     P2mean(:,[12,1:3]), CDmean(:,[12,1:3]), CWmean(:,[12,1:3]), WDmean(:,[12,1:3]), WWmean(:,[12,1:3]));
% 
% %% cmpare precipitation patterns betwene tepmp and precipitation sensitivity 
% subplot(3,2,1)
% plot(cumsum(P_2mean(:, 1+2))); hold on
% plot(cumsum(P_1mean(:, 1+2))); hold on
% plot(cumsum(P1mean(:, 1+2))); hold on
% plot(cumsum(P2mean(:, 1+2))); hold on
% plot(cumsum(PGWmean(:, 1+2))); hold on
% legend ('P-20','P-10','P+10','P+20','REF', 'location', 'best')
% title('Cumsum Precip - Precip Sim')
% subplot(3,2,2)
% plot(cumsum(T_2mean(:, 1+2))); hold on
% plot(cumsum(T_1mean(:, 1+2))); hold on
% plot(cumsum(T1mean(:, 1+2))); hold on
% plot(cumsum(T2mean(:, 1+2))); hold on
% plot(cumsum(PGWmean(:, 1+2))); hold on
% legend ('T-2','T-1','T+1','T+2','REF', 'location', 'best')
% title ('Cumsum Precip - Temp sim')
% 
% subplot(3,2,3)
% plot(cumsum(P_2mean(:, 1))); hold on
% plot(cumsum(P_1mean(:, 1))); hold on
% plot(cumsum(P1mean(:, 1))); hold on
% plot(cumsum(P2mean(:, 1))); hold on
% plot(cumsum(PGWmean(:, 1))); hold on
% legend ('P-20','P-10','P+10','P+20','REF', 'location', 'best')
% title('Cumsum rain - Precip Sim')
% subplot(3,2,4)
% plot(cumsum(T_2mean(:, 1))); hold on
% plot(cumsum(T_1mean(:, 1))); hold on
% plot(cumsum(T1mean(:, 1))); hold on
% plot(cumsum(T2mean(:, 1))); hold on
% plot(cumsum(PGWmean(:, 1))); hold on
% legend ('T-2','T-1','T+1','T+2','REF', 'location', 'best')
% title ('Cumsum rain - Temp sim')
% 
% subplot(3,2,5)
% plot(cumsum(P_2mean(:, 2))); hold on
% plot(cumsum(P_1mean(:, 2))); hold on
% plot(cumsum(P1mean(:, 2))); hold on
% plot(cumsum(P2mean(:, 2))); hold on
% plot(cumsum(PGWmean(:, 2))); hold on
% legend ('P-20','P-10','P+10','P+20','REF', 'location', 'best')
% title('Cumsum snow - Precip Sim')
% subplot(3,2,6)
% plot(cumsum(T_2mean(:, 2))); hold on
% plot(cumsum(T_1mean(:, 2))); hold on
% plot(cumsum(T1mean(:, 2))); hold on
% plot(cumsum(T2mean(:, 2))); hold on
% plot(cumsum(PGWmean(:, 2))); hold on
% legend ('T-2','T-1','T+1','T+2','REF', 'location', 'best')
% title ('Cumsum snow - Temp sim')
% %%
% 
% 
% 
% 
% 
% 
% 
% 
% 
% plot((T_2mean(:, 12))); hold on
% plot((T_1mean(:, 12))); hold on
% plot((T1mean(:, 12))); hold on
% plot((T2mean(:, 12))); hold on
% plot((PGWmean(:, 4))); hold on
% legend ('T-2','T-1','T+1','T+2','REF')
% figure
% figure
% plot(T_2mean(:, 3)); hold on
% plot(T_1mean(:, 3)); hold on
% plot(T1mean(:, 3)); hold on
% plot(T2mean(:, 3)); hold on
% plot(PGWmean(:, 3)); hold on
% legend ('T-2','T-1','T+1','T+2','REF')
% figure
% plot(T_2mean(:, 2)); hold on
% plot(T_1mean(:, 2)); hold on
% plot(T1mean(:, 2)); hold on
% plot(T2mean(:, 2)); hold on
% plot(PGWmean(:, 2)); hold on
% legend ('T-2','T-1','T+1','T+2','REF')
% 
% figure
% plot((T_2mean(:, 3))); hold on
% plot((T_1mean(:, 3))); hold on
% plot((T1mean(:, 3))); hold on
% plot((T2mean(:,3))); hold on
% plot((PGWmean(:, 3))); hold on
% legend ('T-2','T-1','T+1','T+2','REF')
% plot(P_2mean(:, 3)); hold on
% plot(P_1mean(:, 3)); hold on
% plot(P1mean(:, 3)); hold on
% plot(P2mean(:, 3)); hold on
% plot(PGWmean(:,3)); hold on
% legend ('P-20','P-10','P+10','P+20','REF')
% %% Annual Snow 
% x = sum(squeeze(var_forcings(:, 2, :)));
% SUMsnow = x *100./x(1);
% %% Annual rain
% x = sum(squeeze( var_forcings(:, 3, :)));
% SUMrain = x *100./x(1);
% %% Annual Precip
% x = sum(squeeze( var_forcings(:, 3, :)+var_forcings(:, 4, :)));
% SUMprecip = x *100./x(1);
% %% Total SWE
% x = sum(squeeze( var_processes(:, 5, :)));
% SUMgwflow= x *100./x(1);
% %% Peak swe
% x = sum(squeeze( var_processes(:, 5, :)));
% SUMgwflow= x *100./x(1);
% %% Total soil moist
% x = sum(squeeze( var_processes(:, 6, :)));
% SUMsoilmoist= x *100./x(1);
% %% total gw storage
% x = sum(squeeze( var_processes(:, 7, :)));
% SUMgw= x *100./x(1);
% %% total depressional storge
% x = sum(squeeze( var_processes(:, 8, :)));
% SUMsd= x *100./x(1);
% %% Compile in a areray
% Stat_all = [SUMevap; SUMicemelt; SUMsoilrunoff;SUMssrrunoff;SUMgwflow;SUMsoilmoist;SUMgw;SUMsd]
% Stat_label = {'SUMevap'; 'SUMicemelt'; 'SUMsoilrunoff';'SUMssrrunoff';'SUMgwflow';'SUMsoilmoist';'SUMgw';'SUMsd'}
% lab_all = {'PGW-ref','T-2C','T-1C','T+1C','T+2C',...
%         'P-20%','P-10%','P+10%','P+20%',...
%         'ColdDry','ColdWet','WarmDry', 'WarmWet'} 
% 
% %% with negative
% clear zdata b1 b2 x_neg pos_x 
% 
% Stat =Stat_all(:, 2:end); % remove the CUR values and PGW values
% lab = {'T-2C','T-1C','T+1C','T+2C',...
%         'P-20%','P-10%','P+10%','P+20%',...
%         'ColdDry','ColdWet','WarmDry', 'WarmWet'} 
% 
% 
% fig = figure('units','inches','position',[0 0 9 6]); 
% b = bar3(Stat+100);
% view (2)
% cmap_p = color_shades({[70, 0 0 ]./255, 'red','white','blue', [0 0 70]./255})
% for k = 1:length(b)
%     zdata = b(k).ZData;
%     b(k).CData = zdata;
%     b(k).FaceColor = 'interp';
% end
% colormap(cmap_p)
% caxis ([150 250])
% ch = colorbar
% ch.TickLabels = ({'-50%';'0%';'50%'})
% % oh yeh oh yeah
% xticks ([1:14])
% xlim ([0 15])
% xticklabels (lab)
% xtickangle (45)
% yticklabels (Stat_label)
% title('Percent change from PGW-reference simulation')
% 

