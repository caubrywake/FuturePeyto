%% wastage vs melt at Peyto
addpath('D:\5_FuturePeyto')
clear all
close all
savedir = 'D:\5_FuturePeyto\fig\C2e\'
figdir = 'D:\5_FuturePeyto\fig\C2e\'

 load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat','basinflowCUR', 'timeCUR')
 load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat', 'basinflowPGW')


%% Import CRHM results
load('D:\4_PeytoCRHM_1990_2020\data_process\chrmoutput\HRUelev_area.mat')
load('D:\4_PeytoCRHM_1990_2020\data_process\chrmoutput\output_20210323.mat','SWE','hru_snow', 'time')


close all
clear all
%% basinflo

% load variables
 load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat','basinflowCUR', 'timeCUR')
 load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat', 'basinflowPGW')
hru_area = [0.3231,1.786,0.2819,0.8719,1.459,0.8763,0.3438,0.1275,0.1531,0.1306,...
    0.2594,1.104,0.9737,0.3394,0.2731,0.2081,0.06063,0.5981,0.3425,0.2275,0.1175,...
    0.965,0.7519,0.6162,0.535,0.3431,1.395,0.5512,0.5175,0.4806,0.4644,0.9269,...
    0.1156,0.1912,0.09313,0.35,0.2625]; 
basinarea = sum(hruarea); % m2

%% Compile annual values for annual and seasonal hydrometeorological variables
load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat','hru_snowCUR')
load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\PeytoPGW_ref.mat', 'basinflowPGW')
snow = hru_snowCUR;
timeCRHM = timeCUR;
hru_area=hruarea;
yr = 2000:2015;
hru = [1:9, 11:21,33:34] ;
for i = 1:length (yr)
 t1 = strcat ('01-Oct-', num2str(yr(i)-1), {' '}, '01:00');
 t2 = strcat ('27-Sep-', num2str(yr(i)),{' '}, '00:00');
   
a = find(timeCRHM==datetime(t1));
b = find(timeCRHM==datetime(t2));

x = snow;
xa  = sum(x(a:b, hru))./1000; xb = xa.*hru_area(hru)*10^6 ;xc = sum(xb)/(sum(hru_area(hru)*10^6)); % m3 w.e. 
A(i, 1) = xc;
end

Ps = A;

%% Streamflow components
load('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\PeytoCUR_ref.mat', 'SWEmeltCUR', 'basinflowCUR', 'basingwCUR', 'firnmeltCUR', 'icemeltCUR', 'timeCUR')
swemelt = SWEmeltCUR;
firnmelt = firnmeltCUR;
icemelt= icemeltCUR;
timeCRHM = timeCUR;
basinflow = basinflowCUR;
basingw = basingwCUR;
yr = 2000:2015
hru = [1:9, 11:21,33:34] ;
for i = 1:length (yr)
 t1 = strcat ('01-Oct-', num2str(yr(i)-1), {' '}, '01:00');
 t2 = strcat ('27-Sep-', num2str(yr(i)), { ' '}, '00:00');
   
a = find(timeCRHM==datetime(t1));
b = find(timeCRHM==datetime(t2));

%
x = swemelt/24;
xa  = sum(x(a:b, hru))./1000; xb = xa.*hru_area(hru)*10^6 ;xc = sum(xb)/(sum(hru_area(hru)*10^6)); % m3 w.e. 
A2(i, 1) = xc;

x = icemelt/24;
xa  = sum(x(a:b, hru))./1000; xb = xa.*hru_area(hru)*10^6 ; xc = sum(xb)/(sum(hru_area(hru)*10^6)); 
A2(i, 2) = xc;

x = firnmelt/24;
xa  = sum(x(a:b, hru))./1000; xb = xa.*hru_area(hru)*10^6 ; xc = sum(xb)/(sum(hru_area(hru)*10^6)); 
A2(i, 3) = xc;

A2(i, 5) = sum(basinflow(a:b))/(sum(hru_area*10^6)) + sum(basingw(a:b))/(sum(hru_area*10^6)) ; %m

end
 
A2(:, 4) = sum(A2(:, 2:3),2);

Ms = A2(:, 1);
Mf = A2(:, 3);
Mi = A2(:, 2);
Mif = Mf + Mi;

F = A2(:,5);

figure; plot(yr, Ps);
hold on
plot(yr, Ms);
plot(yr, Mf);
plot(yr, Mi)
legend ('Ps','Ms', 'Mf','Mi')
% 1996 is a positive mass balance year, as the icemlet is smaller than the
% leftover snow (snowfall-snowmelt)

% so for the other years, what is the wastage?


plot(yr, A2(:, 5));
Ps_m_Ms = Ps-Ms
% hoe much larger
Ms_percent = round(Ms*100./Ps);
mean(Ms_percent)
Ms_percent_pos = Ms_percent;
Ms_percent_pos(Ms_percent_pos<=100)=nan;
nanmean(Ms_percent_pos)
nanmax(Ms_percent_pos)

a = find(Ps_m_Ms<0);
b = find(Ps_m_Ms>0); numel(a)
Ps_m_Ms(a) = 0;
W_1 = Mif - (Ps_m_Ms);

%% without putting only postive number
W_2 = Mif - (Ps-Ms);

figure;
plot (yr, W_1);hold on
plot (yr, W_2);hold on
plot(yr, F)
legend ('W1', 'W2','F')
W_percent1 = round(W_1*100./F)
W_percent2 = round(W_2*100./F)
W_percent2(W_percent2<0) = nan;
W_percent2(W_percent2>100)=nan
nanmax(W_percent2)
nanmin(W_percent2)
nanmean(W_percent2)
nanmean(W_percent1)


W_percent2 = round(W_2*100./F)
%W_percent(W_percent<0) = 0;
W_percent2(W_percent2>100)=0

figure;
bar(yr, W2_percent);
xlim([1988 2021])
%%
%% Make pretty figure;
% Ps, Ms, Mi, Mf
cavy = [102 170 255]/255%pale blue
csnow= [0 102 204]/255%  mid blue
crain = [0 51 102]/255% dark blue

csnowm = [200 200 200]/255% light grey
cicem =  [140 140 140]/255% mid grey 
cfirnm = [90 90 90]/255% dark grey
close all
fig = figure('units','inches','outerposition',[0 0 8 8]);

subplot(3,1,1);
plot(yr, Ps, '-x', 'Color', csnow); hold on
plot(yr, Ms, '-o', 'color', crain);
plot(yr, Mi, '-o', 'color', cicem)
plot(yr, Mf, '-o', 'color', 'k');
legend ('P_s','M_s', 'M_i','M_f')
ylabel ({'Annual Specific';'Glacier-Wide Mass Balance';' components (m w.e.)'})
ylim ([0 3])
xlim ([1988.8 2020.5])
text(1989, 2.8, '(a)')
grid on
box on
h = legend ('P_s','M_s', 'M_i','M_f', 'Orientation', 'Horizontal', 'Location', 'Northeast')

subplot(3,1,2);
p1 = plot(yr, Ps-Ms, '-x', 'Color', csnow); hold on
p2 = plot(yr, Mi + Mf, '-o', 'color', 'k');
l = line([yr(1):yr(end)], [zeros(length(yr),1)]);
l.Color = [0.5 0.5 0.5];
h = legend ([p1(1)  p2(1)],'P_s - M_s', 'M_i + M_f', 'Orientation', 'Horizontal', 'Location', 'Northeast')
pos = h.Position;
h.Position = pos;
ylabel ({'Annual Specific';'Glacier-Wide Mass Balance';' components (m w.e.)'})
ylim ([-1 2.5])
xlim ([1988.8 2020.5])
text(1989, 2.2, '(b)')
grid on
box on


% Wastage ratio
subplot(3,1,3);
bar (yr, W_percent2, 'FaceColor', cicem, 'EdgeColor', cicem)
ylabel ({'Wastage as percentage';'of basin yield (%)'})
ylim ([0 100])
xlim ([1988.5 2020.5])
text(1988.8,94, '(c)')
t = text(1996, 2, 'No Wastage')
set(t,'Rotation',90);
t = text(1999, 2, 'No Wastage')
set(t,'Rotation',90);

grid on
box on

%
filename = 'WastageComp_1987_2020'
saveas (gcf,strcat(figdir, filename), 'png')
saveas (gcf,strcat(figdir, filename), 'pdf')
savefig (gcf,strcat(figdir, filename))