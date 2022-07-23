close all
clear all
load('D:\5_FuturePeyto\crhm\D_MetSim\output\PeytoP1.mat', 'SWEP1')
load('D:\5_FuturePeyto\crhm\D_MetSim\output\PeytoP2.mat', 'SWEP2')
load('D:\5_FuturePeyto\crhm\D_MetSim\output\PeytoP_1.mat', 'SWEP_1')
load('D:\5_FuturePeyto\crhm\D_MetSim\output\PeytoP_2.mat', 'SWEP_2')

load('D:\5_FuturePeyto\crhm\D_MetSim\output\PeytoT1.mat', 'SWET1')
load('D:\5_FuturePeyto\crhm\D_MetSim\output\PeytoT2.mat', 'SWET2')
load('D:\5_FuturePeyto\crhm\D_MetSim\output\PeytoT_1.mat', 'SWET_1')
load('D:\5_FuturePeyto\crhm\D_MetSim\output\PeytoT_2.mat', 'SWET_2')


load('D:\5_FuturePeyto\crhm\D_MetSim\output\PeytoWW.mat', 'SWEWW')
load('D:\5_FuturePeyto\crhm\D_MetSim\output\PeytoWD.mat', 'SWEWD')
load('D:\5_FuturePeyto\crhm\D_MetSim\output\PeytoCD.mat', 'SWECD')
load('D:\5_FuturePeyto\crhm\D_MetSim\output\PeytoCW.mat', 'SWECW')

 load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat','SWECUR', 'timeCUR')
 load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat', 'SWEPGW', 'timePGW')

%% catchment values
hruarea = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]*10^6; 
var = SWECD;
SWECD  = sum(var .*(hruarea/sum(hruarea)),2); %m w.e per hru
var = SWECW;
SWECW = sum(var .*(hruarea/sum(hruarea)),2); %m w.e per hru
var = SWEWD;
SWEWD  = sum(var .*(hruarea/sum(hruarea)),2); %m w.e per hru
var = SWEWW;
SWEWW = sum(var .*(hruarea/sum(hruarea)),2); %m w.e per hru

var = SWEP1;
SWEP1  = sum(var .*(hruarea/sum(hruarea)),2); %m w.e per hru
var = SWEP2;
SWEP2  = sum(var .*(hruarea/sum(hruarea)),2); %m w.e per hru
var = SWEP_1;
SWEP_1  = sum(var .*(hruarea/sum(hruarea)),2); %m w.e per hru
var = SWEP_2;
SWEP_2  = sum(var .*(hruarea/sum(hruarea)),2); %m w.e per hru

var = SWET1;
SWET1  = sum(var .*(hruarea/sum(hruarea)),2); %m w.e per hru
var = SWET2;
SWET2  = sum(var .*(hruarea/sum(hruarea)),2); %m w.e per hru
var = SWET_1;
SWET_1  = sum(var .*(hruarea/sum(hruarea)),2); %m w.e per hru
var = SWET_2;
SWET_2  = sum(var .*(hruarea/sum(hruarea)),2); %m w.e per hru

var = SWECUR;
SWECUR  = sum(var .*(hruarea/sum(hruarea)),2); %m w.e per hru
var = SWEPGW;
SWEPGW = sum(var .*(hruarea/sum(hruarea)),2); %m w.e per hru

save ('D:\5_FuturePeyto\crhm\D_MetSim\output]ScenarioMET_SWE.mat', 'SWECUR','SWEPGW',...
            'SWEP1','SWEP2','SWEP_1','SWEP_2',...
            'SWET1','SWET2','SWET_1','SWET_2',...
            'SWECD','SWECW','SWEWD','SWEWW')
%% plot
timeREF= timePGW;
x = timetable(timeREF, SWEPGW, SWECUR);
xx = retime(x, 'daily', 'mean');
t = xx.timeREF;
SWEREF = table2array(xx);

x = timetable(timeREF, SWEP_2, SWEP_1, SWEP1, SWEP2);
xx = retime(x, 'daily', 'mean');
t = xx.timeREF;
SWEP = table2array(xx);

x = timetable(timeREF, SWET_2, SWET_1, SWET1, SWET2);
xx = retime(x, 'daily', 'mean');
t = xx.timeREF;
SWET = table2array(xx);

x = timetable(timeREF, SWECD, SWECW, SWEWD, SWEWW);
xx = retime(x, 'daily', 'mean');
t = xx.timeREF;
SWEC = table2array(xx);
save ('D:\5_FuturePeyto\crhm\D_MetSim\output]ScenarioMET_SWE.mat', 'SWEREF','SWET','SWEP','SWEC', 't')


%% 15 year average daily plot
% 1 april to 30 march instead of water year

% reshape into 15 years
tor = timeREF;
var = [SWEREF(367:end, 2), SWEREF(367:end, 1), SWET(367:end, :), SWEP(367:end, :),SWEC(367:end, :)];
% so that cur, pgw, temp, precip, combo
t = t(367:end, :);


sz = size (var);
timevec = datevec(t);
var(find(timevec(:,2) == 2 & timevec(:,3) == 29), :) = []; % remove leap years days
t(find(timevec(:,2) == 2 & timevec(:,3) == 29), :) = [];
t= datetime(t);
timevec = datevec(t);
tidx = find(timevec(:, 2) ==10 & timevec(:, 3) == 1);
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
% c = [102 178 255;... % light blue
%     0 0 204; ...    % darkj blue
%     204 0 0;...%dark red 
%     255 102 178]./255; % light red
c=[183 80 0; ...
   230 97 1; ...
    94 60 153;...
    56 34 95]./255;
% c=[183 80 0; ...
%    230 97 1; ...
%     253 184 99;
%     178 171 210;...
%     94 60 153;...
%     56 34 95]
% what about orange, oruple, turqoise?
% c = [27 158 119;...
%    0 204 204; ...
%    0 102 204]./255; % red, blue, green
set(0,'defaultAxesFontSize',10)
lw = .8; % linewitdg
fs = 10; %fontsize
td = t(tidx(1):tidx(2)-1);
fig = figure('units','inches','position',[0 0 7 7]); 
sp1 = subplot(3,1,1)
p3 = plot (td, Mpgw(:, 3), 'Color',c(1, :), 'linewidth', lw); hold on; 
p4 = plot (td, Mpgw(:, 4), 'Color',c(2, :), 'linewidth', lw); hold on;
p5 = plot (td, Mpgw(:, 5), 'Color',c(3, :), 'linewidth', lw); hold on;
p6 = plot (td, Mpgw(:, 6), 'Color',c(4, :), 'linewidth', lw); hold on;
p1 = plot (td, Mpgw(:, 2), 'k', 'linewidth', lw);
p2 = plot (td, Mpgw(:, 1), ':k', 'linewidth', lw);
xtickformat ('dd-MMM');xticklabels ([]);
ylabel({'SWE','(mm w.e.)'})
xlim ([td(1) td(end)]);
ylim([0 1500])
text(td(2),1400, '(a) Temperature', 'Fontsize', fs)
sp1.Position = sp1.Position + [0 0 0.05 0.03];
lg = legend ([p1(1) p2(1) p3(1) p4(1) p5(1) p6(1)], 'PGW-Ref', 'CUR','-2', '-1', '+1', '+2', 'location', 'Northeast');
%lg.Position = [.81, 900, .1, .1]; %.

sp2 = subplot(3,1,2)
p3= plot (td, Mpgw(:, 7), 'Color',c(1, :), 'linewidth', lw); hold on;
p4 = plot (td, Mpgw(:, 8), 'Color',c(2, :), 'linewidth', lw); hold on;
p5 = plot (td, Mpgw(:, 9), 'Color',c(3, :), 'linewidth', lw); hold on;
p6 = plot (td, Mpgw(:, 10), 'Color',c(4, :), 'linewidth', lw); hold on;

p1 = plot (td, Mpgw(:, 2), 'k', 'linewidth',lw);
p2 = plot (td, Mpgw(:, 1), ':k','linewidth', lw);
lg = legend ([p1(1) p2(1) p3(1) p4(1) p5(1) p6(1)], 'PGW-Ref', 'CUR','-20%', '-10%', '+10%', '+20%', 'location', 'Northeast');
xtickformat ('dd-MMM'); xticklabels ([]);
ylabel({'SWE','(mm w.e.)'})
xlim ([td(1) td(end)]);
ylim([0 1500])
text(td(2),1400,{'(b) Precipitation'}, 'Fontsize', fs)
sp2.Position = sp2.Position + [0 0 0.05 0.03];
%lg.Position = [.81, .515, .1, .1]; %.

sp3 = subplot(3,1,3)
p3 = plot (td, Mpgw(:, 11), 'Color',c(1, :), 'linewidth', lw); hold on;
p4 = plot (td, Mpgw(:, 12), 'Color',c(2, :), 'linewidth', lw); hold on;
p5 = plot (td, Mpgw(:, 13), 'Color',c(3, :), 'linewidth', lw); hold on;
p6 = plot (td, Mpgw(:, 14), 'Color',c(4, :), 'linewidth', lw); hold on;

p1= plot (td, Mpgw(:, 2), 'k','linewidth', lw);
p2 = plot (td, Mpgw(:, 1), ':k', 'linewidth',lw);
lg = legend ([p1(1) p2(1) p3(1) p4(1) p5(1) p6(1)], 'PGW-Ref', 'CUR','Cold Dry', 'Cold Wet', 'Warm Dry', 'Warm Wet', 'location', 'Northeast');
xtickformat ('MMM');
ylabel({'SWE','(mm w.e.)'})
xlim ([td(1) td(end)]);
ylim([0 1500])
text(td(2), 1400,{'(c) Combination'}, 'Fontsize', fs)
sp3.Position = sp3.Position + [0 0 0.05 0.03];
%lg.Position = [.81, .215, .1, .1]; %.

%
tightfig(fig)
%
figname ='BasinflowScenario_MetSim_SWE';
saveas (gcf, strcat( 'D:\5_FuturePeyto\fig\E1b\', figname, '.pdf'))
saveas (gcf, strcat('D:\5_FuturePeyto\fig\E1b\', figname, '.png'))
savefig(gcf, strcat('D:\5_FuturePeyto\fig\E1b\', figname))

%% stats
%% Total streamflow
BF = var;
SUM = round(sum(BF)./sum(BF(:, 1)), 2) *100 -100;

%% Total summmer
BFsum = BF(62:183, :);
SUMsummer = round(sum(BFsum)./sum(BFsum(:, 1)), 2)*100 -100;

%% Peak flow
[pkflow, pkflow_idx] = max(BF)
% change in peak flow
PKFLOW = round(pkflow/pkflow(1), 2) *100 -100


%% CV year
for i = 1:14
    x = var(:, i);
    cv(i) = std(x)./nanmean(x);
end 
cvD = round(cv*100/cv(1))'-100

%% CV summer
a = datevec(t);
b = find(a(:, 2) == 6 | a(:, 2) == 7| a(:, 2) == 8| a(:, 2) == 9);
var_sht=var(b, :);
for i = 1:14
 x = var_sht(:, i);
cv_summer(i) = std(x)./nanmean(x);
end 
cvsummerD = round(cv_summer*100/cv_summer(1))'-100

% %% CV per month
% a = datevec(t);
% for ii = 1:12
%    b = find(a(:, 2) == ii);
% var_mt=var(b, :);
% 
% for i = 1:16
%  x = var_mt(:, i);
% cv_mt(i, ii) = std(x)./nanmean(x);
% end 
% end 
% monthlab= {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
% lab = {'CUR', 'PGW', '0I','8I','16I','NoStor','Lake','Pond','<1V','5V','15V','x1SM','x5SM','x10S<', 'Lush', 'Bare'};
% 
% fig = figure('units','inches','position',[0 0 11 6]); 
% for i = 1:12
% subplot(3,4, i)
% bar(cv_mt(:, i))
% ylabel (strcat('CV, ', monthlab{i}))
% xticks ([1:16])
% xticklabels (lab)
% xlim ([.05 16.5]); ylim ([0 2])
% xtickangle (90)
% end
% 
% tightfig(fig)
% figname ='BasinflowScenario_CVMontlhy';
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.pdf'))
% saveas (gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname, '.png'))
% savefig(gcf, strcat('D:\5_FuturePeyto\fig\D1b\', figname))
%% August low flow
BFaug = BF(123:153, :);
[augflow, augflow_idx] = min(BFaug)
% change in peak flow
MINaug = round(augflow/augflow(1), 2) *100 -100


%% Bar plot 
lab = {'CUR', 'PGW-Ref', 'T-2','T-1','T+1','T+2','P-20%','P-10%','P+10%','P+20%','CD','CW','WD','WW'}
c = [0 0 0;0 0 0;...% black
    255 153 153; 255 51 51; 255 0 0;150 0 0;   ... % yellow to red
    153 153 255; 51 51 255; 0 0 200; 0 0 150;  ... % purple to blue
    204 153 255; 153 51 255; 102 0 204; 51 0 102]./255 % 
    
fig = figure('units','inches','position',[0 0 8 5]); 

subplot(2,2,1)
hold on
for i = 2:14
    b  = bar(i, SUM(i))
set(b, 'FaceColor', c(i,:))
end 
hold on
grid on; box on
xticks ([1:15])
xlim ([1.1 14.9]); ylim ([-40 20])
xticklabels (lab)
xtickangle (45)
ylabel ({'\Delta Annual ','streamflow (%)'})
text(1.3, 18, '(a)')
 
subplot(2,2,2)
hold on
for i = 2:14
    b  = bar(i, cvD(i))
set(b, 'FaceColor', c(i,:))
end 
hold on
grid on; box on
xticks ([1:15])
xlim ([1.1 14.9]); ylim ([-40 10])
xticklabels (lab)
xtickangle (45)
ylabel ({'\Delta CV','(%)'})
text(1.3, 5, '(b)')

subplot(2,2,3)
hold on
for i = 2:14
    b  = bar(i,PKFLOW(i))
set(b, 'FaceColor', c(i,:))
end 
hold on
grid on; box on
xticks ([1:15])
xlim ([1.1 14.9]); ylim ([-20 80])
xticklabels (lab)
xtickangle (45)
ylabel ({'\Delta Peak ','Flow (%)'})
text(1.3, 70, '(c)')

subplot(2,2,4)
hold on
for i = 1:14
    b  = bar(i, MINaug(i))
set(b, 'FaceColor', c(i,:))
end 
hold on
grid on; box on
xticks ([1:15])
xlim ([1.1 14.9]); ylim ([-20 80])
xticklabels (lab)
xtickangle (45)
ylabel ({'\Delta Aug ','Low Flow (%)'})
text(1.3, 70, '(d)')
%
tightfig(fig)
%
figname ='SWEScenario_BarStat';
saveas (gcf, strcat('D:\5_FuturePeyto\fig\E1b\', figname, '.pdf'))
saveas (gcf, strcat('D:\5_FuturePeyto\fig\E1b\', figname, '.png'))
savefig(gcf, strcat('D:\5_FuturePeyto\fig\E1b\', figname))

