%% A1c: Export rawWRF Cells as CRHM observations files
% this script export the rawWRF files as observations to be imported in R
% for QDM bias-correction
close all
clear all
% Load data
load('D:\FuturePeyto\dataproc\wrf\A1b_ComparingrawWRF_MET\rawWRF_CUR_perCell_timeseries.mat')

% Export each cell into an CRHM obs
% Current
for i=1:5
    % create the obs matrix and save it in a mat file
t = datevec(time);
t = t(8:131406, 1:5);
d = squeeze(VarCell_CUR(8:131406, i ,:)); % to remove some nan in last day and finish ona full day
d(:, 1) = d(:, 1)-273.15; % change to Celcius
CUR = [t d]; % compiled time and data together, and save it in a matlab format

fn = strcat('D:\FuturePeyto\dataproc\wrf\A1c_exportRawWRFtoCRHMobs\rawWRF_CUR_Cell',num2str(i), '.mat');
save (fn, 'CUR');  
 % create the obs text file
headerlines = {'Obs file, WRF current';
              't 1 (C)';
              'ea 1 (hpa)';
              'u 1 (m/s)';
              'qsi 1 (W/m2)';
              'qli 1 (W/m2)';
              'p 1 (mm)';
              '$$ Missing ' ;
              ' #####      t.1  ea.1    u.1 qsi.1   qli.1   p.1'}
fp = strcat('D:\FuturePeyto\dataproc\wrf\A1c_exportRawWRFtoCRHMobs\rawWRF_CUR_Cell',num2str(i),  '.obs');
fid = fopen(fp, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(fp, CUR  , '-append', 'delimiter', '\t'); 
end

% PGW
clear all
load('D:\FuturePeyto\dataproc\wrf\A1b_ComparingrawWRF_MET\rawWRF_PGW_perCell_timeseries.mat')
for i=1:5
    % create the obs matrix and save it in a mat file
t = datevec(time);
t = t(8:131406, 1:5);
t(:, 1) = t(:, 1) + 84; % set at end of century
d = squeeze(VarCell_PGW(8:131406, i ,:));
d(:, 1) = d(:, 1)-273.15; % change to Celcius
PGW = [t d]; % compiled time and data together, and save it in a matlab format


fn = strcat('D:\FuturePeyto\dataproc\wrf\A1c_exportRawWRFtoCRHMobs\rawWRF_PGW_Cell',num2str(i), '.mat');
save (fn, 'PGW');  
 % create the obs text file
headerlines = {'Obs file, WRF PGW';
              't 1 (C)';
              'ea 1 (hpa)';
              'u 1 (m/s)';
              'qsi 1 (W/m2)';
              'qli 1 (W/m2)';
              'p 1 (mm)';
              '$$ Missing ' ;
              ' #####      t.1  ea.1    u.1 qsi.1   qli.1   p.1'}
fp = strcat('D:\FuturePeyto\dataproc\wrf\A1c_exportRawWRFtoCRHMobs\rawWRF_PGW_Cell',num2str(i),  '.obs');
fid = fopen(fp, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(fp, PGW  , '-append', 'delimiter', '\t'); 
end

%% Next step: quantile mapping bias correction in R
