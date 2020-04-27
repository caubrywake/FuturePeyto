%% Looking at Clarke output
close all
clear all

load('MIROC-320km_RCP85_R10_2009-2100.mat')
load('grids_R10.mat')

x_grid = map_western_edge+0.5*dx :dx:map_eastern_edge-0.5*dx
y_grid = map_northern_edge-0.5*dy:-dy:map_southern_edge+0.5*dy
[Xg,Yg] = meshgrid(x_grid,y_grid);

figure;
subplot(2,2,1)
surf(longitude, latitude, B, 'EdgeColor', 'none'); view(2);
title ('Lat and Lon')
subplot(2,2,2)
imagesc(x_grid, y_grid, B);
title ('Imagesc Xgrid')
subplot(2,2,3)
surf(Xg, Yg, B, 'EdgeColor', 'none'); view(2);
title ('Xg, Yg')
subplot(2,2,4)
surf(X, Y, B, 'EdgeColor', 'none'); view(2);
title ('X, y')
%% Crop it
Sc = S(:, 1080:1130, 865:905);
Bc = B(1080:1130, 865:905);
Xc = X(1080:1130, 865:905);
Yc = Y(1080:1130, 865:905);
latc = latitude(1080:1130, 865:905);
longc = longitude(1080:1130, 865:905);
Rmaskc = Rmask(1080:1130, 865:905);
xgridc = longc(1, :);
ygridc = latc(:, 1);

% Load a peyto outline shapefile?
% figure
figure(1)
subplot(2,2,1)
imagesc(xgridc, ygridc, Bc);colorbar
set(gca,'YDir','normal') 
xlabel('Easting distance (m)')
ylabel('Northing distance (m)')
title('Bed surface topography (m)')

S_10_map = squeeze(Sc(1,:,:));  % surface elevation in 2010
S_40_map = squeeze(Sc(31,:,:)); % surface elevation in 2040
S_85_map = squeeze(Sc(76,:,:)); % surface elevation at 2085
S_100_map = squeeze(Sc(91,:,:));% surface elevation at 2100

% Elevation change 
figure(1)
subplot(2,2,1)
imagesc(xgridc, ygridc, S_10_map);colorbar
set(gca,'YDir','normal') 
xlabel('Easting distance (m)'); ylabel('Northing distance (m)')
title('Surface topography, 2010 (m)')

subplot(2,2,2)
imagesc(xgridc, ygridc, S_40_map);colorbar
set(gca,'YDir','normal') 
xlabel('Easting distance (m)'); ylabel('Northing distance (m)')
title('Surface topography, 2040 (m)')

subplot(2,2,3)
imagesc(xgridc, ygridc, S_85_map);colorbar
set(gca,'YDir','normal') 
xlabel('Easting distance (m)'); ylabel('Northing distance (m)')
title('Surface topography, 2085 (m)')

subplot(2,2,4)
imagesc(xgridc, ygridc, S_100_map);colorbar
set(gca,'YDir','normal') 
xlabel('Easting distance (m)'); ylabel('Northing distance (m)')
title('Surface topography, 2100 (m)')

H_10 = S_10_map-  Bc; % ice thickness 
H_40 = S_40_map-  Bc; % ice thickness 
H_85 = S_85_map-  Bc; % ice thickness 
H_100 = S_100_map-Bc; % ice thickness 

% Ice thickness
figure(2)
subplot(2,2,1)
imagesc(xgridc, ygridc, H_10);colorbar
set(gca,'YDir','normal') 
xlabel('Easting distance (m)'); ylabel('Northing distance (m)')
title('Ice Thickness, 2010 (m)')

subplot(2,2,2)
imagesc(xgridc, ygridc, H_40);colorbar
set(gca,'YDir','normal') 
xlabel('Easting distance (m)'); ylabel('Northing distance (m)')
title('Ice Thickness, 2040 (m)')

subplot(2,2,3)
imagesc(xgridc, ygridc, H_85);colorbar
set(gca,'YDir','normal') 
xlabel('Easting distance (m)'); ylabel('Northing distance (m)')
title('Ice Thickness, 2085 (m)')

subplot(2,2,4)
imagesc(xgridc, ygridc, H_100);colorbar
set(gca,'YDir','normal') 
xlabel('Easting distance (m)'); ylabel('Northing distance (m)')
title('Ice Thickness, 2100 (m)')

