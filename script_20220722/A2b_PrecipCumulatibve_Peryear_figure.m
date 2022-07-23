%% A2B precip - cumulative values

% load qdm WRF
load('D:\FuturePeyto\dataproc\wrf\crhmOBS_qdmCUR4_20200819.mat')
QDM = crhmOBS_qdmCUR4_20200819(:, 6:11);
QDMtime = datetime([crhmOBS_qdmCUR4_20200819(:, 1:5) zeros(length(crhmOBS_qdmCUR4_20200819), 1)]);
clear crhmOBS_qdmCUR4_20200819
% load raw wrf, cell 5 (precip)
load('D:\FuturePeyto\dataproc\wrf\rawWRF_perCell\rawWRF_CUR_Cell5_20200701.mat')
RAW = CUR(:, 6:11);
RAWtime = datetime([CUR(:, 1:5) zeros(length(CUR), 1)]);
clear CUR
% lod peyto obs
load('D:\FuturePeyto\dataproc\met\crhmOBS_metMOH_ERA_20200819.mat')
MET = crhmOBS_metMOH_ERA_20200819(:, 6:11);
METtime = datetime([crhmOBS_metMOH_ERA_20200819(:, 1:5) zeros(length(crhmOBS_metMOH_ERA_20200819), 1)]);
clear crhmOBS_metMOH_ERA_20200819

% start pct 1st
t = find(METtime == '01-Oct-2000 01:00')
t = find(QDMtime == '01-Oct-2000 01:00')
QDM = QDM(t:end, :);
QDMtime = QDMtime(t:end);

figure
plot(METtime, cumsum(MET(:, 6)))
hold on
plot(RAWtime, cumsum(RAW(:, 6)))
plot(QDMtime, cumsum(QDM(:, 6)))
legend ('MET', 'RAW', 'QDM')

% rehspae in 15 years
timevec = datevec(METtime);
a = find(timevec(:, 2) ==2 & timevec (:, 3) == 29);
time = METtime;
time(a) = [];
QDM(a, :) = [];
RAW(a, :) = [];
MET(a, :) = [];
clear RAWtime METtime QDMtime

timevec = datevec(time);
% pad the last few days
tpad = time(end)+hours(1):hours(1):datetime('01-Oct-2015 00:00:00');
tpad = tpad';
time= [time;tpad];
sz = size(MET);
pad = nan(length(tpad),sz(2)) ;
MET = [MET; pad]; QDM = [QDM;pad];RAW = [RAW;pad];

% split in 15 years
a = find(timevec(:, 2) ==10 & timevec (:, 3) == 1 & timevec (:, 4) == 1);

time(a)

% reshape into the 15 year
 METyr = reshape (MET(:, 6), 8760, 15);
 QDMyr = reshape (QDM(:, 6), 8760, 15);
 RAWyr = reshape (RAW(:, 6), 8760, 15);
 
METyrsum = cumsum(METyr);
QDMyrsum = cumsum(QDMyr);
RAWyrsum = cumsum(RAWyr);

 METsum = reshape (METyrsum, 1, 131400);
 QDMsum = reshape (QDMyrsum, 1, 131400);
 RAWsum = reshape (RAWyrsum, 1, 131400);

fig = figure('units','inches','position',[0 0 8 3]); 
plot(time, METsum, ':k', 'linewidth', 1);hold on
plot(time, RAWsum, 'r', 'linewidth', 1);
plot(time, QDMsum, 'b', 'linewidth', 1);
ylim ([0 1600]);
ylabel('Cumulative Precipitation (mm)')
legend ('MET', 'WRF raw', 'WRF bias-corrected', 'Orientation','horizontal', 'Location', 'Best')

figname ='Precipitation_CumSumYr_RawQdmMet';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A2c\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\A2c\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\A2c\', figname))

518-452
694 - 631
769 - 699 
964 - 788
1009 - 757 
1075 - 909