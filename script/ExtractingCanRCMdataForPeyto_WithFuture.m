%% net cdf from rcanRC<
ncdisp ('R:\Model_Output\110_CanRCM4-22\tas\r8i2p1r1\tas_NAM-22_CCCma-CanESM2_historical-r1_r8i2p1_CCCma-CanRCM4_r2_1hr_2000010101-2001010100.nc')
lat = ncread ('R:\Model_Output\110_CanRCM4-22\tas\r8i2p1r1\tas_NAM-22_CCCma-CanESM2_historical-r1_r8i2p1_CCCma-CanRCM4_r2_1hr_2000010101-2001010100.nc', 'lat');
lon = ncread ('R:\Model_Output\110_CanRCM4-22\tas\r8i2p1r1\tas_NAM-22_CCCma-CanESM2_historical-r1_r8i2p1_CCCma-CanRCM4_r2_1hr_2000010101-2001010100.nc', 'lon');
%% Which cell correspond to Peyto:
A = rand(1,2);
B = rand(10,2);
A = [51.69, 243.46];
x = reshape (lat,[310*260],1);
y = reshape (lon,[310*260], 1);
B = [x y];
distances = sqrt(sum(bsxfun(@minus, B, A).^2,2));
%find the smallest distance and use that as an index into B:
closest = B(find(distances==min(distances)),:);

[idx, idy] = find(lat == closest(1));
[idxlon, idylon]  = find(lon == closest(2));

PeytoLoc = [101, 157];
%% Extracting the data for that location
%% Air Temp
allfiles = dir('R:\Model_Output\110_CanRCM4-22\tas\r8i2p1r1\')
allfiles = allfiles(3:end)  ;  
tic
for i = 50:66

nf = strcat(allfiles(i, :).folder, '\', allfiles(i, :).name);
T = squeeze(ncread(nf, 'tas', [101 250 1], [1,1,8760]));
time = ncread(nf, 'time');

if i == 50
    Tcurrent = T;
    timecurrent = time;
else 
Tcurrent = [Tcurrent; T];
timecurrent = [timecurrent; time];
end 
i
toc
end 
save ('D:\FuturePeyto\CanRCM\Temperature.mat', 'Tcurrent', 'timecurrent');
clear all
%% Humidity
allfiles = dir('R:\Model_Output\110_CanRCM4-22\hurs\r8i2p1r1\')
allfiles = allfiles(3:end)  ;
for i = 50:66
nf = strcat(allfiles(i, :).folder, '\', allfiles(i, :).name);
RH = squeeze(ncread(nf, 'hurs', [101 250 1], [1,1,8760]));
if i == 50
    RHcurrent = RH;
else 
RHcurrent = [RHcurrent; RH];
end 
end 
save ('D:\FuturePeyto\CanRCM\RelativeHumidity.mat', 'RHcurrent');
clear all
%% Wind speed
tic
allfiles = dir('R:\Model_Output\110_CanRCM4-22\sfcWind\r8i2p1r1\')
allfiles = allfiles(3:end)  ;
for i =50:66
nf = strcat(allfiles(i, :).folder, '\', allfiles(i, :).name);
U = squeeze(ncread(nf, 'sfcWind', [101 250 1], [1,1,8760]));
if i == 50
    Ucurrent = U;
else 
Ucurrent = [Ucurrent; U];
end 
toc 
i
end 
save ('D:\FuturePeyto\CanRCM\WindSpeed.mat', 'Ucurrent');
clear all
%% SWin
tic
allfiles = dir('R:\Model_Output\110_CanRCM4-22\rsds\r8i2p1r1\')
allfiles = allfiles(3:end)  ;
for i = 50:66
nf = strcat(allfiles(i, :).folder, '\', allfiles(i, :).name);
SWin = squeeze(ncread(nf, 'rsds', [101 250 1], [1,1,8760]));
if i == 50
   SWincurrent = SWin;
else 
SWincurrent = [SWincurrent; SWin];
i
toc
end 
end 
save ('D:\FuturePeyto\CanRCM\ShortwaveIncoming.mat', 'SWincurrent');
clear all
%% LWin
tic
allfiles = dir('R:\Model_Output\110_CanRCM4-22\rlds\r8i2p1r1\'); allfiles = allfiles(3:end);
for i = 50:66
nf = strcat(allfiles(i, :).folder, '\', allfiles(i, :).name);
LWin = squeeze(ncread(nf, 'rlds', [101 250 1], [1,1,8760]));
if i == 50
    LWincurrent =LWin;
else 
LWincurrent = [LWincurrent; LWin];
end
toc
i
end 
save ('D:\FuturePeyto\CanRCM\LongwaveIncoming.mat', 'LWincurrent');
clear all
%% Precip
tic
allfiles = dir('R:\Model_Output\110_CanRCM4-22\pr\r8i2p1r1\')
allfiles = allfiles(3:end)  ;
for i = 50:66
nf = strcat(allfiles(i, :).folder, '\', allfiles(i, :).name);
P = squeeze(ncread(nf, 'pr', [101 250 1], [1,1,8760]));
if i == 50
    Pcurrent = P;
else 
Pcurrent = [Pcurrent; P];
end 
toc
i
end 
save ('D:\FuturePeyto\CanRCM\Precip.mat', 'Pcurrent');
%% FUTURE CanRCM
%% Air Temp
allfiles = dir('R:\Model_Output\110_CanRCM4-22\tas\r8i2p1r1\')
allfiles = allfiles(3:end)  ;  
tic
for i = 135:151

nf = strcat(allfiles(i, :).folder, '\', allfiles(i, :).name);
T = squeeze(ncread(nf, 'tas', [101 250 1], [1,1,8760]));
time = ncread(nf, 'time');

if i == 135
    Tfuture = T;
    timefuture = time;
else 
Tfuture = [Tfuture; T];
timefuture = [timefuture; time];
end 
i
toc
end 
save ('D:\FuturePeyto\CanRCM\TemperatureFuture.mat', 'Tfuture', 'timefuture');
clear all
%% Humidity
allfiles = dir('R:\Model_Output\110_CanRCM4-22\hurs\r8i2p1r1\')
allfiles = allfiles(3:end)  ;
for i = 135:151
nf = strcat(allfiles(i, :).folder, '\', allfiles(i, :).name);
RH = squeeze(ncread(nf, 'hurs', [101 250 1], [1,1,8760]));
if i == 135
    RHfuture = RH;
else 
RHfuture = [RHfuture; RH];
end 
end 
save ('D:\FuturePeyto\CanRCM\RelativeHumidityFuture.mat', 'RHfuture');
clear all
%% Wind speed
tic
allfiles = dir('R:\Model_Output\110_CanRCM4-22\sfcWind\r8i2p1r1\')
allfiles = allfiles(3:end)  ;
for i =135:151
nf = strcat(allfiles(i, :).folder, '\', allfiles(i, :).name);
U = squeeze(ncread(nf, 'sfcWind', [101 250 1], [1,1,8760]));
if i == 135
    Ufuture = U;
else 
Ufuture = [Ufuture; U];
end 
toc 
i
end 
save ('D:\FuturePeyto\CanRCM\WindSpeedFuture.mat', 'Ufuture');
clear all
%% SWin
tic
allfiles = dir('R:\Model_Output\110_CanRCM4-22\rsds\r8i2p1r1\')
allfiles = allfiles(3:end)  ;
for i = 135:151
nf = strcat(allfiles(i, :).folder, '\', allfiles(i, :).name);
SWin = squeeze(ncread(nf, 'rsds', [101 250 1], [1,1,8760]));
if i == 135
   SWinfuture = SWin;
else 
SWinfuture = [SWinfuture; SWin];
i
toc
end 
end 
save ('D:\FuturePeyto\CanRCM\ShortwaveIncomingFuture.mat', 'SWinfuture');
clear all
%% LWin
tic
allfiles = dir('R:\Model_Output\110_CanRCM4-22\rlds\r8i2p1r1\'); allfiles = allfiles(3:end);
for i = 135:151
nf = strcat(allfiles(i, :).folder, '\', allfiles(i, :).name);
LWin = squeeze(ncread(nf, 'rlds', [101 250 1], [1,1,8760]));
if i == 135
    LWinfuture =LWin;
else 
LWinfuture = [LWinfuture; LWin];
end
toc
i
end 
save ('D:\FuturePeyto\CanRCM\LongwaveIncomingFuture.mat', 'LWinfuture');
clear all
%% Precip
tic
allfiles = dir('R:\Model_Output\110_CanRCM4-22\pr\r8i2p1r1\')
allfiles = allfiles(3:end)  ;
for i = 135:151
nf = strcat(allfiles(i, :).folder, '\', allfiles(i, :).name);
P = squeeze(ncread(nf, 'pr', [101 250 1], [1,1,8760]));
if i == 135
    Pfuture = P;
else 
Pfuture = [Pfuture; P];
end 
toc
i
end 
save ('D:\FuturePeyto\CanRCM\PrecipFuture.mat', 'Pfuture');

%% PlotCanRCM and WRF
load('WRFcurrentprocessed.mat', 'wrfd', 'wrft')
load('D:\PeytoVariabilityPaper\MODEL\OBSfile\ObsERA.mat')
load('D:\PeytoVariabilityPaper\MODEL\OBSfile\ObsPNH.mat')
 timeERA = ObsERA.timestr;
 dataERA = table2array(ObsERA(:,2:7));
timePNH = ObsPNH.timestr;
dataPNH = table2array(ObsPNH(:,2));

tc = datetime(datevec(timecurrent))


plot(datetime(timefuture), Tfuture);


tc =datetime('01-Jan-2000 00:00'):hours(1):datetime('01-Jan-2000 00:00')+hours(148919);
plot(tc, Tcurrent-273.15); hold on; plot(wrft, wrfd(:, 1))
plot(timeERA, dataERA(:, 1)); plot(timePNH, dataPNH(:, 1))
legend ('CanRCM', 'WRF', 'ERA', 'Obs')
