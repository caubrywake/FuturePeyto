%% A1a: Import raw WRF output
% % This script imports the raw WRF variable from the data folder, 
% where they were downloaded from the GWF cuizinart. 
% The code is divided in 2 sections: import current (CUR) 
% and pseudo global warming (PGW). % The code also trim 
% them to the 4x3x131448 cell covering the peyto glacier and 
% bow summit, and permute the spatial frame to gave the 
% northwest corner at (1,1) and the southeast corner as (4,3) 
% The variables are saved under 
% D:\FuturePeyto\dataproc\wrf\rawWRF_CUR_20200630.mat and 
% rawWRF_PGW_20200630.mat as a 4D data cube, 
% with dimension being lat x lon x time x variable, 
% with 4x3x131448x8 (T, v10, u10, q2, psfc, showdown, glw, prec)
% and the constant are lat, lon, elev in rawWRF_constant
% by Caroline Aubry-Wake
% last edited June 30, 2020

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1 - Import WRF variable 
close all
clear all

allfiles = dir('D:\FuturePeyto\data\wrf\Current_WCA_2'); % select directory raw WRF file
allfiles = allfiles (3:end) ; % remove the first 3 file in the list

for i = 1:length(allfiles) % for loop which imports and append each variable for all the files in the directory
nf = strcat(allfiles(i, :).folder, '\', allfiles(i, :).name);
t = ncread(nf, 'T2');
v10= ncread(nf, 'V10');
u10= ncread(nf, 'U10');
q2= ncread(nf, 'Q2');
psfc= ncread(nf, 'PSFC');
swdown= ncread(nf, 'SWDOWN');
glw=  ncread(nf, 'GLW');
prec= ncread(nf, 'PREC');
lat = ncread(nf, 'lat');
lon = ncread(nf, 'lon');
if i == 1
    T= t;
    V10= v10;
    U10 = u10;
    Q2 = q2;
    PSFC =psfc;
    SWDOWN = swdown;
    GLW = glw;
    PREC = prec;
    LAT = lat;
    LON = lon;
else 
T = cat(3, T, t);
V10 = cat(3, V10, v10);
U10= cat(3, U10, u10);
Q2 = cat(3, Q2, q2);
PSFC = cat(3, PSFC, psfc);
SWDOWN = cat(3, SWDOWN, swdown);
GLW = cat(3, GLW, glw);
PREC = cat(3, PREC, prec);
LON = cat(3, LON , lon);
LAT = cat(3, LAT, lat);
end 
end 
 clear t v10 u10 q2 psfc swdown glw prec lat lon 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2- Import elevation
% elevation values are stored in a different file, covering the entire WCA domain. The matching latitude and longitude between the WCA and the Peyto domain are found and the elevation is trimmed to the Peyto domai

load('D:\FuturePeyto\data\wrf\constants.mat', 'elev', 'lat', 'lon') % the elevation, lat and longitude of the WCA domain

LAT = squeeze(LAT(:,:,1)); %reduce dimension
LON = squeeze(LON(:,:,1)); %reduce dimension

% Find the upper left corner (cell (1,1) of the Peyto area)
ilat = find(lat == LAT(1,1)) % find the WCAdomain latitude  (lat, lon)matching the peyto domain lat (LAT LON)
[rowlat, collat] = ind2sub([639, 699], ilat); % change from induced to subscript (row, col)
ilon = find(lon == LON(1,1)) 
[rowlon, collon] = ind2sub([639, 699], ilon);

% Find the lower right corner (cell (5,7) of the Peyto area)
ilon = find(lon == LON(5,8))
[rowlon2, collon2] = ind2sub([639, 699], ilon);

% Select the WCA domain subset corresponding to Peyto area
lat_sub = lat(rowlon:rowlon2, collon:collon2);
lon_sub = lon(rowlon:rowlon2, collon:collon2);

% Visual confirmation that the 2 domain (subset of WCA) and Peyto area match
figure;
subplot(2,2,1)
imagesc(LAT); caxis([51.55 51.8]) ;colorbar
title('Visual Confirmation that WCA subset matches Peyto domain')
subplot(2,2,2)
imagesc(lat_sub); caxis([51.55 51.8]) ; colorbar
subplot(2,2,3)
imagesc(LON);  caxis([-116.65 -116.45]); colorbar
subplot(2,2,4)
imagesc(lon_sub);  caxis([-116.65 -116.45]); colorbar

ELEV= elev(rowlon:rowlon2, collon:collon2);% They do match, so moving forward to extract the elevation of the subset area

clear lat_sub lon_sub rowlon rowlon2 collon collon2 ilon ilat 

% Now I have each variable as a 5x7 area
% Create a 4d cube with the data

D = cat(4, T ,V10 ,U10, Q2 ,PSFC, SWDOWN, GLW,  PREC); % variable with multiple time step
Dc = cat(3, LAT,LON,  ELEV); % constant with one time step

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3 - Shift geospatial frame
% the grid extracted from WRF are not following an orientation 
% that makes it easy to visually look at it. I switch the orientation 
% off the grid to have the grid with (1,1) being the northwest corner
% and (5,8) being the southeast corner. This is also a bit complicated 
% that the different matlab graphing approach have different layout. 

%here is an example of the permutation with the WCA domain
lat_perm = permute(lat, [2,1]);
lat_flip = flip(lat_perm, 1);
lon_perm = permute(lon, [2,1]);
lon_flip = flip(lon_perm, 1);
elev_perm = permute(elev, [2,1]);
elev_flip = flip(elev_perm, 1);

figure;
subplot(1,2,1)
imagesc(elev_flip); colorbar % test the permutation
s = pcolor(lon_flip, lat_flip, elev_flip)
s.EdgeColor = 'none';
title ({'Flipped  area,';'pcolor(lon_flip,lat_flip_elev flip)'})
colorbar
subplot(1,2,2)
imagesc(elev_flip)
title ('Flipped area,imagesc(elev flip)')
figname = 'PermutationTest';
saveas (gcf, strcat( 'D:\FuturePeyto\fig\A1a\', figname, '.pdf'))
saveas (gcf, strcat('D:\FuturePeyto\fig\A1a\', figname, '.png'))
savefig(gcf, strcat('D:\FuturePeyto\fig\A1a\', figname))


% Permute all the variables using the data cube D
clear sz Dtrim X X_perm X_flip X_tirm
sz = size(D)
for i = 1:sz(4) % for the number off variable in the data cube
X = D(:,:,:,i); % extract the variable
X_perm = permute(X, [2,1,3]);
X_flip = flip(X_perm, 1);
X_trim = X_flip(3:6,2:4, :);% % on top of peyto. 
% Upper left elev is 2502, lower right elev is 2337
Dtrim(:,:,:,i) = X_trim;
end 
% Update name 
rawWRF_CUR = Dtrim;  % 3x4 grid of peyto glacier and bow summit

% same for constants
clear sz Dtrim X X_perm X_flip X_tirm
sz = size(Dc)
for i = 1:sz(3) % for the number off variable in the data cube
X = Dc(:,:,i); % extract the variable
X_perm = permute(X, [2, 1]);
X_flip = flip(X_perm, 1);
X_trim = X_flip(3:6,2:4); % make sure this is right
Dtrim(:,:,i) = X_trim;
end 
% Update name 
rawWRF_CUR_constant= Dtrim;  % 3x4 grid of peyto glacier and bow summit for lat, lon and elevation

% create time array
time = datetime ('01-Oct-2000 01:00')-hours(7):hours(1):datetime('2015-09-30')-hours(7);% change the timestamp to UTC+7

% Save variables
save ('D:\FuturePeyto\dataproc\wrf\A1a_rawWRFimport\rawWRF_CUR.mat', 'time', 'rawWRF_CUR','rawWRF_CUR_constant')

%% For PGW
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1 - Import WRF variable 
close all
clear all

allfiles = dir('D:\FuturePeyto\data\wrf\PGW_WCA'); % select directory raw WRF file
allfiles = allfiles (3:end) ; % remove the first 3 file in the list

for i = 1:length(allfiles) % for loop which imports and append each variable for all the files in the directory
nf = strcat(allfiles(i, :).folder, '\', allfiles(i, :).name);
t = ncread(nf, 'T2');
v10= ncread(nf, 'V10');
u10= ncread(nf, 'U10');
q2= ncread(nf, 'Q2');
psfc= ncread(nf, 'PSFC');
swdown= ncread(nf, 'SWDOWN');
glw=  ncread(nf, 'GLW');
prec= ncread(nf, 'PREC');
lat = ncread(nf, 'lat');
lon = ncread(nf, 'lon');
if i == 1
    T= t;
    V10= v10;
    U10 = u10;
    Q2 = q2;
    PSFC =psfc;
    SWDOWN = swdown;
    GLW = glw;
    PREC = prec;
    LAT = lat;
    LON = lon;
else 
T = cat(3, T, t);
V10 = cat(3, V10, v10);
U10= cat(3, U10, u10);
Q2 = cat(3, Q2, q2);
PSFC = cat(3, PSFC, psfc);
SWDOWN = cat(3, SWDOWN, swdown);
GLW = cat(3, GLW, glw);
PREC = cat(3, PREC, prec);
LON = cat(3, LON , lon);
LAT = cat(3, LAT, lat);
end 
end 
 clear t v10 u10 q2 psfc swdown glw prec lat lon 


D = cat(4, T ,V10 ,U10, Q2 ,PSFC, SWDOWN, GLW,  PREC); % variable with multiple time step
Dc = cat(3, squeeze(LAT(:,:,1)),squeeze(LON(:,:,1))); % constant with one time step

%%
% Permute all the variables using the data cube D
% first the constnat
% same for constants
clear sz Dtrim X X_perm X_flip X_tirm
sz = size(Dc)
for i = 1:sz(3) % for the number off variable in the data cube
X = Dc(:,:,i); % extract the variable
X_perm = permute(X, [2, 1]);
X_flip = flip(X_perm, 1);
X_trim = X_flip(:,:,:); % make sure this is right
Dtrim(:,:,i) = X_trim;
end 
% Update name 
rawWRF_PGW_constant= Dtrim;  % 3x4 grid of peyto glacier and bow summit for lat, lon and elevation
% compare lat and lon
latPGW = rawWRF_PGW_constant(:,:,1);
lonPGW = rawWRF_PGW_constant(:,:,2);
% load CUR ;at and lon
 load('D:\FuturePeyto\dataproc\wrf\A1a_rawWRFimport\rawWRF_CUR.mat', 'rawWRF_CUR_constant')
latCUR = rawWRF_CUR_constant(:,:,1);
lonCUR = rawWRF_CUR_constant(:,:,2);

latPGWtrim = latPGW(3:6, 2:4);
lonPGWtrim= lonPGW(3:6, 2:4);

latPGWtrim == latCUR
lonPGWtrim == lonCUR

% now permute and trim variables
clear sz Dtrim X X_perm X_flip X_tirm
sz = size(D)
for i = 1:sz(4) % for the number off variable in the data cube
X = D(:,:,:,i); % extract the variable
X_perm = permute(X, [2,1,3]);
X_flip = flip(X_perm, 1);
X_trim = X_flip(3:6,2:4, :);% % on top of peyto. 
% Upper left elev is 2502, lower right elev is 2337
Dtrim(:,:,:,i) = X_trim;
end 
% Update name 
rawWRF_PGW= Dtrim;  % 3x4 grid of peyto glacier and bow summit


% create time array
time = datetime ('01-Oct-2084 01:00')-hours(7):hours(1):datetime('2099-09-30')-hours(7);% change the timestamp to UTC+7

% Save variables
save ('D:\FuturePeyto\dataproc\wrf\A1a_rawWRFimport\rawWRF_PGW', 'time', 'rawWRF_PGW','latPGWtrim','lonPGWtrim')

