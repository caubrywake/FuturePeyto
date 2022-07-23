%% D1a Import CRHM scneario sruns Sceanrio analysis

% start with importing the data
%% Precip +10 %
close all
clear all

cd D:\FuturePeyto\crhm\D_MetSim\output
fileList = dir('D:\FuturePeyto\crhm\D_MetSim\output\P1*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'P1');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeP= datetime(datevec(timeP1+ 693960));
timeP = dateshift(timeP,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('D:\FuturePeyto\crhm\D_MetSim\output\PeytoP1.mat')
%
%% Precip +20 %
close all
clear all

cd D:\FuturePeyto\crhm\D_MetSim\output
fileList = dir('D:\FuturePeyto\crhm\D_MetSim\output\P2*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'P2');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeP= datetime(datevec(timeP2+ 693960));
timeP = dateshift(timeP,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('D:\FuturePeyto\crhm\D_MetSim\output\PeytoP2.mat')
%
%% Precip -10 %
close all
clear all

cd D:\FuturePeyto\crhm\D_MetSim\output
fileList = dir('D:\FuturePeyto\crhm\D_MetSim\output\P_1*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'P_1');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeP= datetime(datevec(timeP_1+ 693960));
timeP = dateshift(timeP,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('D:\FuturePeyto\crhm\D_MetSim\output\PeytoP_1.mat')
%
%% Precip -20 %
close all
clear all

cd D:\FuturePeyto\crhm\D_MetSim\output
fileList = dir('D:\FuturePeyto\crhm\D_MetSim\output\P_2*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'P_2');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeP= datetime(datevec(timeP_2+ 693960));
timeP = dateshift(timeP,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('D:\FuturePeyto\crhm\D_MetSim\output\PeytoP_2.mat')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%
%% Temp  +10 %
close all
clear all

cd D:\FuturePeyto\crhm\D_MetSim\output
fileList = dir('D:\FuturePeyto\crhm\D_MetSim\output\T1*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'T1');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeT= datetime(datevec(timeT1+ 693960));
timeT = dateshift(timeT,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('D:\FuturePeyto\crhm\D_MetSim\output\PeytoT1.mat')
%
%% Temp +20 %
close all
clear all

cd D:\FuturePeyto\crhm\D_MetSim\output
fileList = dir('D:\FuturePeyto\crhm\D_MetSim\output\T2*.txt'); % get all the CRHM outputs starting with TeytoCUR_1OBS
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
varname = strcat(varname, 'T2');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeT= datetime(datevec(timeT2+ 693960));
timeT = dateshift(timeT,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('D:\FuturePeyto\crhm\D_MetSim\output\PeytoT2.mat')
%
%% Temp -10 %
close all
clear all

cd D:\FuturePeyto\crhm\D_MetSim\output
fileList = dir('D:\FuturePeyto\crhm\D_MetSim\output\T_1*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'T_1');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeT= datetime(datevec(timeT_1+ 693960));
timeT = dateshift(timeT,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('D:\FuturePeyto\crhm\D_MetSim\output\PeytoT_1.mat')
%
%% Temp -20 %
close all
clear all

cd D:\FuturePeyto\crhm\D_MetSim\output
fileList = dir('D:\FuturePeyto\crhm\D_MetSim\output\T_2*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'T_2');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeT= datetime(datevec(timeT_2+ 693960));
timeT = dateshift(timeT,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('D:\FuturePeyto\crhm\D_MetSim\output\PeytoT_2.mat')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Cold Dry
close all
clear all

cd D:\FuturePeyto\crhm\D_MetSim\output
fileList = dir('D:\FuturePeyto\crhm\D_MetSim\output\ColdDry*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'CD');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeCD= datetime(datevec(timeCD+ 693960));
timeCD = dateshift(timeCD,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('D:\FuturePeyto\crhm\D_MetSim\output\PeytoCD.mat')
%
%% Cold wet
close all
clear all

cd D:\FuturePeyto\crhm\D_MetSim\output
fileList = dir('D:\FuturePeyto\crhm\D_MetSim\output\ColdWet*.txt'); % get all the CRHM outputs starting with TeytoCUR_1OBS
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
varname = strcat(varname, 'CW');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeCW= datetime(datevec(timeCW+ 693960));
timeCW = dateshift(timeCW,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('D:\FuturePeyto\crhm\D_MetSim\output\PeytoCW.mat')
%
%% Warm Dry
close all
clear all

cd D:\FuturePeyto\crhm\D_MetSim\output
fileList = dir('D:\FuturePeyto\crhm\D_MetSim\output\WarmDry*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'WD');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeWD= datetime(datevec(timeWD+ 693960));
timeWD = dateshift(timeWD,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('D:\FuturePeyto\crhm\D_MetSim\output\PeytoWD.mat')
%
%% Warm Wet
close all
clear all

cd D:\FuturePeyto\crhm\D_MetSim\output
fileList = dir('D:\FuturePeyto\crhm\D_MetSim\output\WarmWet*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'WW');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeWW= datetime(datevec(timeWW+ 693960));
timeWW = dateshift(timeWW,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('D:\FuturePeyto\crhm\D_MetSim\output\PeytoWW.mat')