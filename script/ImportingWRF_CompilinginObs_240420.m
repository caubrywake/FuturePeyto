%% Import and process the WRF net cdf file
% by Carolie Aubry-Wake
% last edited Apr. 24, 2020

% this code import the net cdf files and extra the variable neded for the
% CRHM moedl for both current and PGW timing 
% It then find the cell closest to the station and extract the data fro
% taht point ans save it as an obs file

ncdisp ('D:\FuturePeyto\WRFdataset\Current\200010.nc')
% Get the variables
allfiles = dir('D:\FuturePeyto\WRFdataset\Current')
allfiles = allfiles (3:end) ;
for i = 1:length(allfiles)
nf = strcat(allfiles(i, :).folder, '\', allfiles(i, :).name);

T = ncread(nf, 'T2');
V10= ncread(nf, 'V10');
U10= ncread(nf, 'U10');
Q2= ncread(nf, 'Q2');
PSFC= ncread(nf, 'PSFC');
SWDOWN= ncread(nf, 'SWDOWN');
GLW= ncread(nf, 'GLW');
PREC= ncread(nf, 'PREC');

if i == 1
    Tcurrent = T;
    V10current = V10;
    U10current = U10;
    Q2current = Q2;
    PSFCcurrent = PSFC;
    SWDOWNcurrent = SWDOWN;
    GLWcurrent = GLW;
    PRECcurrent = PREC;
else 
Tcurrent = cat(3, Tcurrent, T);
V10current = cat(3, V10current, V10);
U10current = cat(3, U10current, U10);
Q2current = cat(3, Q2current, Q2);
PSFCcurrent = cat(3, PSFCcurrent, PSFC);
SWDOWNcurrent = cat(3, SWDOWNcurrent, SWDOWN);
GLWcurrent = cat(3, GLWcurrent, GLW);
PRECcurrent = cat(3, PRECcurrent, PREC);
end 
end 

time = datetime ('01-Oct-2000 01:00')-hours(7):hours(1):datetime('2015-09-30')-hours(7);% change the timestamp to UTC+7
save ('D:\FuturePeyto\WRFdataset\CurrentWRF.mat', 'time', 'Tcurrent', 'GLWcurrent', 'PRECcurrent', 'PSFCcurrent', 'Q2current', 'SWDOWNcurrent', 'U10current', 'V10current')
%% PGW
close all
clear all

allfiles = dir('D:\FuturePeyto\WRFdataset\PGW')
allfiles = allfiles (3:end) ;
%Tcurrent = zeros(5, 6);
for i = 1:length(allfiles)
nf = strcat(allfiles(i, :).folder, '\', allfiles(i, :).name);

T = ncread(nf, 'T2');
V10= ncread(nf, 'V10');
U10= ncread(nf, 'U10');
Q2= ncread(nf, 'Q2');
PSFC= ncread(nf, 'PSFC');
SWDOWN= ncread(nf, 'SWDOWN');
GLW= ncread(nf, 'GLW');
PREC= ncread(nf, 'PREC');

if i == 1
    Tpgw = T;
    V10pgw = V10;
    U10pgw = U10;
    Q2pgw = Q2;
    PSFCpgw = PSFC;
    SWDOWNpgw = SWDOWN;
    GLWpgw = GLW;
    PRECpgw = PREC;
else 
Tpgw = cat(3, Tpgw, T);
V10pgw = cat(3, V10pgw, V10);
U10pgw = cat(3, U10pgw, U10);
Q2pgw = cat(3, Q2pgw, Q2);
PSFCpgw = cat(3, PSFCpgw, PSFC);
SWDOWNpgw = cat(3, SWDOWNpgw, SWDOWN);
GLWpgw = cat(3, GLWpgw, GLW);
PRECpgw = cat(3, PRECpgw, PREC);
end
end

% TPgw = squeeze(TPgw(3,3,:));
% plot (time, Tcurrent);hold on
% plot (time, TPgw)
% legend ('Current', 'PGW')

save ('D:\FuturePeyto\WRFdataset\PGWWRF.mat',  'Tpgw', 'GLWpgw', 'PRECpgw', 'PSFCpgw', 'Q2pgw', 'SWDOWNpgw', 'U10pgw', 'V10pgw');
%% What cell is closest to Peyto station?
% What is the height of the cell?
ncdisp ('D:\FuturePeyto\WRFdataset\Current\200010.nc')
nf = 'D:\FuturePeyto\WRFdataset\Current\200010.nc';
lator = ncread(nf, 'lat');
lonor  = ncread(nf, 'lon');


%% Constants
% checking the constants
ncdisp('D:\FuturePeyto\WRFdataset\constants_WCA\wrfout_d01_constant.nc')
nf = 'D:\FuturePeyto\WRFdataset\constants_WCA\wrfout_d01_constant.nc'
Elev = ncread(nf, 'HGT');
LU =  ncread(nf, 'LU_INDEX');
lat = ncread(nf, 'XLAT');
lon  = ncread(nf, 'XLONG');
meshgrid(lon, lat, Elev)
s = pcolor(lon, lat, Elev)
s.EdgeColor = 'none';
colorbar

%% figure out which cell is peyto (matching the stuff frm other WRF dataset)
% in or, its cell 3,4
latorpt = lator(3,4);
lonorpt = lonor(3,4);
find(lat == latorpt)

[row, col]= find(lon== lonorpt)
% for cel I use:
Elev(row, col)
LU(row,col)

% for the whole matrix
latca = lator(1,1)
lonoca = lonor(1,1)
[row, col]= find(lon== lonoca)

elev_catchment = Elev(row:row+4, col:col+5)
LU_catchment = LU(row:row+4, col:col+5)
imagesc(elev_catchment)
colorbar
% land use index http://onlinelibrary.wiley.com/doi/10.1002/joc.2036/full

%% Change from Q (mixing ratio) to RH? 
 load('CurrentWRF.mat')
load('PGWWRF.mat')
T = squeeze(Tcurrent(3,4,:))-273.15;
P =squeeze( PSFCcurrent(3,4,:));
Q = squeeze(Q2current(3,4,:));

psurf = P .* 0.01 ;                       
e = Q .* psurf ./ (0.378 .*Q + 0.622);
ea =  e .* 0.1 ;

Tf = squeeze(Tpgw(3,4,:))-273.15;
Pf =squeeze( PSFCpgw(3,4,:));
Qf = squeeze(Q2pgw(3,4,:));

psurff = Pf .* 0.01 ;                       
ef = Qf .* psurff ./ (0.378 .*Qf + 0.622);
eaf =  ef .* 0.1 ;

%% Get wind
u = sqrt(squeeze(U10current(3,4,:)).^2 + squeeze(V10current(3,4,:)).^2);
uf = sqrt(squeeze(U10pgw(3,4,:)).^2 + squeeze(V10pgw(3,4,:)).^2);
%% Compile as an obs file
CUR = [T ea u squeeze(SWDOWNcurrent(3,4,:)) squeeze(GLWcurrent(3,4,:)) squeeze(PRECcurrent(3,4,:))];
PGW = [Tf eaf uf squeeze(SWDOWNpgw(3,4,:)) squeeze(GLWpgw(3,4,:)) squeeze(PRECpgw(3,4,:))];
%% Write as Obs
a = datevec(time);
a = a(:, 1:5);
CUR = [a(8:131406,:) CUR(8:131406,:)]; % compiled time and data together, and save it in a matlab format
PGW = [a(8:131406,:) PGW(8:131406,:)]; % compiled time and data together, and save it in a matlab format
save D:\FuturePeyto\WRFdataset\WRFCur_PGW_Obs_24042020  CUR PGW

% export in obs file format
headerlines = {'Obs file, WRF current';
              't 1 (C)';
              'ea 1 (hpa)';
              'u 1 (m/s)';
              'qsi 1 (W/m2)';
              'qli 1 (W/m2)';
              'p 1 (mm)';
              '$$ Missing ' ;
              ' #####      t.1  ea.1    u.1 qsi.1   qli.1   p.1'}
filepath = 'D:\FuturePeyto\WRFdataset\WRFCUR_24042020.obs ';
fid = fopen(filepath, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(filepath, CUR  , '-append', 'delimiter', '\t');  

%% PGW
headerlines = {'Obs file, WRF PGW';
              't 1 (C)';
              'ea 1 (hpa)';
              'u 1 (m/s)';
              'qsi 1 (W/m2)';
              'qli 1 (W/m2)';
              'p 1 (mm)';
              '$$ Missing ' ;
              ' #####      t.1  ea.1    u.1 qsi.1   qli.1   p.1'}
filepath = 'D:\FuturePeyto\WRFdataset\WRFPGW_24042020.obs ';
fid = fopen(filepath, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(filepath, PGW , '-append', 'delimiter', '\t');  

%% Compileng OBS file form Peyto MET to do the bias correstion
% close all
% clear all
load('D:\FuturePeyto\Obs\Obsprocessed.mat')
a = datevec(obst);
a = a(1:131399, 1:5);
OBS = [a obsd(1:131399,:)]; % compiled time and data together, and save it in a matlab format

headerlines = {'Obs file, Peyto AWS';
              't 1 (C)';
              'ea 1 (hpa)';
              'u 1 (m/s)';
              'qsi 1 (W/m2)';
              'qli 1 (W/m2)';
              'p 1 (mm)';
              '$$ Missing ' ;
              ' #####      t.1  ea.1    u.1 qsi.1   qli.1   p.1'}
filepath = 'D:\FuturePeyto\WRFdataset\ObsPeyto_24042020.obs ';
fid = fopen(filepath, 'wt');
for l = 1:numel(headerlines)
   fprintf(fid, '%s\n', headerlines{l});
end
fclose(fid);
dlmwrite(filepath, OBS , '-append', 'delimiter', '\t');  

%% Check for nan
a = find(isnan(CUR(:, 6)))
a = find(isnan(PGW(:, 6)))
a = find(isnan(OBS(:, 6)))

%% Next step: import in R to make a bias correction using Logan's code