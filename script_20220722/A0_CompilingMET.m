%% A0: Compiling MET 
% from the pradhananga data paper
close all
clear all

% Creating 3 files of different diffurtaion with the different oinitial
% file

% Goal: obtaiing a data file to bias correct the WRF product, the longest
% overlap with the WRF simulation (2000-2015_ will help with the bias
% correction

% 1 : MNH 2013-3018
% 2 : MOH, 2000 -2015
% 3: MOH with era inetram to make sure it covers hte whole period; THIS ONE
% IS THE ONE I USE!


%% Option 1: Main New Hut, 2013-2015 with bow summit precip
% load file
load('D:\FuturePeyto\data\met\PeytoMain_tRHuQsiQli_hrly_18July2013_11Aug2018.mat')
obstime = datetime([PeytoMaintRHuQsiQlihrly18July201311Aug2018(:, 1:5) zeros(length(PeytoMaintRHuQsiQlihrly18July201311Aug2018),1)]);
obs =PeytoMaintRHuQsiQlihrly18July201311Aug2018(:, 6:10);
clear PeytoMaintRHuQsiQlihrly18July201311Aug2018

% cut to last day of WRF
b = find (obstime == '27-Sep-2015 23:00')
obstime = obstime(1:b);
obs = obs(1:b, :);

% Precip for same period
load('D:\FuturePeyto\data\met\BowSummit_p_hrly_21Nov2008_31Dec2019.mat')
ptime = datetime([BowSummitphrly21Nov200831Dec2019(:, 1:5) zeros(length(BowSummitphrly21Nov200831Dec2019),1)]);
p  = BowSummitphrly21Nov200831Dec2019(:, 6);
clear BowSummitphrly21Nov200831Dec2019 

a = find(ptime == obstime(1));
b = find (ptime == obstime (end))
ptime = ptime(a:b);
p= p(a:b, :);
obs(:, 6) = p;

t = datevec(obstime);

crhmOBS_metMNH_20200819= [t(:, 1:5) obs]; % compiled time and data together, and save it in a matlab format
% save compiled obs (MNH + bow summit precip)
fn = strcat('D:\FuturePeyto\dataproc\met\A0\crhmOBS_metMNH_20200819.mat');
save (fn, 'crhmOBS_metMNH_20200819');  
 % create the obs text file
headerlines = {'Obs file, CUR bc';
              't 1 (C)';
              'rh 1 (%)';
              'u 1 (m/s)';
              'Qsi 1 (W/m2)';
              'Qli 1 (W/m2)';
              'p 1 (mm)';
              '#####'}
fp = strcat('D:\FuturePeyto\dataproc\met\A0\crhmOBS_metMNH_20200819.obs');
fid = fopen(fp, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(fp, crhmOBS_metMNH_20200819 , '-append', 'delimiter', '\t'); 
% after  compiling the bias correction, it just doesnt work very well. 

%% Option 2: MOH with bow summit precipitation, 2008-2015
% this one has gaps in the LW dataset
% try 2: Using Old hut and bow summit precip, 2008-2015
close all
clear all

% load MOH
load('D:\FuturePeyto\data\met\PeytoMainOld_tEauQsiQli_hrly_6Sept1987_31July2018.mat')
obstime = datetime([PeytoMainOldtEauQsiQlihrly6Sept198731July2018(:, 1:5) zeros(length(PeytoMainOldtEauQsiQlihrly6Sept198731July2018),1)]);
obs =PeytoMainOldtEauQsiQlihrly6Sept198731July2018(:, 6:10);
clear PeytoMaintRHuQsiQlihrly18July201311Aug2018

a = find (obstime == '01-Oct-2000 01:00')
b = find (obstime == '27-Sep-2015 23:00')
obstime = obstime(a:b);
obs = obs(a:b, :);

% precip
load('D:\FuturePeyto\data\met\BowSummit_p_hrly_21Nov2008_31Dec2019.mat')
ptime = datetime([BowSummitphrly21Nov200831Dec2019(:, 1:5) zeros(length(BowSummitphrly21Nov200831Dec2019),1)]);
p  = BowSummitphrly21Nov200831Dec2019(:, 6);
clear BowSummitphrly21Nov200831Dec2019 

% trim obstime to start at the same time as ptime
a = find(obstime== ptime(1));
obs = obs(a:end, :);
obstime = obstime(a:end);

% time ptime to finsih at the same time as obstime
a = find (ptime == obstime(end))
ptime = ptime(1:a);
p= p(1:a, :);

obs(:, 6) = p;
t = datevec(obstime);
crhmOBS_metMNHwithLWnan_20200819= [t(:, 1:5) obs]; % compiled time and data together, and save it in a matlab format

fn = strcat('D:\FuturePeyto\dataproc\met\A0\crhmOBS_metMNHwithLWnan_20200819.mat');
save (fn, 'crhmOBS_metMNHwithLWnan_20200819');  
 % create the obs text file
headerlines = {'Obs file, CUR bc';
              't 1 (C)';
              'ea 1 (%)';
              'u 1 (m/s)';
              'Qsi 1 (W/m2)';
              'Qli 1 (W/m2)';
              'p 1 (mm)';
              '#####'}
fp = strcat('D:\FuturePeyto\dataproc\met\A0\crhmOBS_metMNHwithLWnan_20200819.obs');
fid = fopen(fp, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(fp, crhmOBS_metMNHwithLWnan_20200819 , '-append', 'delimiter', '\t'); 

%% V3 - MOH with ERA interim to extand back to 2000 for precipitation and fill gaps in LW
% on this one, I make sure i cover the entire period for the bais - corection, using a combination of bow summit precip + era interim
% precip, and obs from MOH
close all
clear all

load('D:\FuturePeyto\data\met\PeytoMainOld_tEauQsiQli_hrly_6Sept1987_31July2018.mat')
obstime = datetime([PeytoMainOldtEauQsiQlihrly6Sept198731July2018(:, 1:5) zeros(length(PeytoMainOldtEauQsiQlihrly6Sept198731July2018),1)]);
obs =PeytoMainOldtEauQsiQlihrly6Sept198731July2018(:, 6:10);
clear PeytoMainOldtEauQsiQlihrly6Sept198731July2018
% trim 
t1 = find(obstime == '01-Oct-2000 01:00')
t2 = find(obstime == '27-Sep-2015 23:00')
obstime = obstime(t1:t2);
obs = obs(t1:t2, :);

load('D:\FuturePeyto\data\met\BowSummit_p_hrly_21Nov2008_31Dec2019.mat')
ptime = datetime([BowSummitphrly21Nov200831Dec2019(:, 1:5) zeros(length(BowSummitphrly21Nov200831Dec2019),1)]);
p =BowSummitphrly21Nov200831Dec2019(:, 6);
clear BowSummitphrly21Nov200831Dec2019
% trim precip
t2 = find(ptime == '27-Sep-2015 23:00')
ptime = ptime(1:t2);
p = p(1:t2, :)

load('D:\FuturePeyto\data\met\ERAI_tRHuQsiQlip_BiasCorrect2PeytoBow_Jan1979_Aug2019.mat')
eratime = datetime([ERAItRHuQsiQlipBiasCorrect2PeytoBowJan1979Aug2019(:, 1:5) zeros(length(ERAItRHuQsiQlipBiasCorrect2PeytoBowJan1979Aug2019),1)]);
era =ERAItRHuQsiQlipBiasCorrect2PeytoBowJan1979Aug2019(:, 6:11);
clear ERAItRHuQsiQlipBiasCorrect2PeytoBowJan1979Aug2019
% trim 
t1 = find(eratime == '01-Oct-2000 01:00')
t2 = find(eratime == '27-Sep-2015 23:00')
eratime = eratime(t1:t2);
era = era(t1:t2, :);

% fill in precip
t1 = find(eratime == '01-Oct-2000 01:00')
t2 = find(eratime == ptime(1))
pcomptime = [eratime(1:t2-1); ptime];
pcomp = [era(1:t2-1, 6);p];

% add precip to obs file
obs(:, 6) = pcomp;

% fill in LW
a = find(isnan(obs(:, 5)));
obs(a, 5) = era(a, 5); 
plot(obstime,obs(:, 5)); hold on
plot(eratime, era(:, 5))
plot (pcomptime, pcomp)
figure
scatter(obs(:, 5), era(:, 5))
hold on; lsline; refline (1,0)
figure; plot(pcomptime, cumsum(pcomp))
% double mass curve
eraptime = eratime(t2:end);
erap = era(t2:end,6);
figure
plot(cumsum(erap));
hold on
plot(cumsum(p))

% export as obs file
t = datevec(obstime);
crhmOBS_metMOH_ERA_20200819= [t(:, 1:5) obs]; % compiled time and data together, and save it in a matlab format

fn = strcat('D:\FuturePeyto\dataproc\met\A0\crhmOBS_metMOH_ERAp_20200819.mat');
save (fn, 'crhmOBS_metMOH_ERA_20200819');  
 % create the obs text file
headerlines = {'Obs file, CUR bc';
              't 1 (C)';
              'ea 1 (%)';
              'u 1 (m/s)';
              'Qsi 1 (W/m2)';
              'Qli 1 (W/m2)';
              'p 1 (mm)';
              '#####'}
fp = strcat('D:\FuturePeyto\dataproc\met\A0\crhmOBS_metMOH_ERAp_20200819.obs');
fid = fopen(fp, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(fp, crhmOBS_metMOH_ERA_20200819 , '-append', 'delimiter', '\t'); 

%% nest xtep:
% Extract the WRF product for the Peyto AWS cell (A1 script)  and compare
% raw WRF with MET (A2 script)