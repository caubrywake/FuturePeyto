close all
clear all

cd D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\
fileList = dir('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\CUR\10*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
for i = 1:numel(fileList)
fn = fileList(i).name; % file to import
H = importdata(fn,' ',2); %  % import headers 
D = importdata(fn) ; % import data
headers = regexp(H(1, 1), '\s+', 'split'); % split headers
headers = string(vertcat(headers{:})); % split headers
idxvar = [1, find(contains(headers,'(1)'))]; % select the number of variable in the file
% time is always the first one, followed by 2 or 3 variables
numvar = numel(idxvar); % number of variables

for ii= 1:numvar % for each variable, select all the column with data corresponding to that name
    varname =char(headers(idxvar(ii)));
    varname = strcat(varname(1:end-3)); % remove hru number from name
    if varname == 't' % excpetion is time - it does not have a number
        varname = 'time';
    end 
Index = strfind(headers, varname);
Index = find(not(cellfun('isempty', Index)));
varname = strcat(varname, 'CUR');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeCUR= datetime(datevec(timeCUR+ 693960));
timeCUR = dateshift(timeCUR,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('PeytoCUR_ref_infil.mat')

%% PGW
close all
clear all

cd D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\
fileList = dir('D:\5_FuturePeyto\crhm\B_ReferenceSimulation\output\PGW\10_*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
for i = 1:numel(fileList)
fn = fileList(i).name; % file to import
H = importdata(fn,' ',2); %  % import headers 
D = importdata(fn) ; % import data
headers = regexp(H(1, 1), '\s+', 'split'); % split headers
headers = string(vertcat(headers{:})); % split headers
idxvar = [1, find(contains(headers,'(1)'))]; % select the number of variable in the file
% time is always the first one, followed by 2 or 3 variables
numvar = numel(idxvar); % number of variables

for ii= 1:numvar % for each variable, select all the column with data corresponding to that name
    varname =char(headers(idxvar(ii)));
    varname = strcat(varname(1:end-3)); % remove hru number from name
    if varname == 't' % excpetion is time - it does not have a number
        varname = 'time';
    end 
Index = strfind(headers, varname);
Index = find(not(cellfun('isempty', Index)));
varname = strcat(varname, 'PGW');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timePGW= datetime(datevec(timePGW+ 693960));
timePGW = dateshift(timePGW,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('PeytoPGW_ref_infil.mat')