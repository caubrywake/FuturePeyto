%% D1a Import CRHM scneario sruns Sceanrio analysis

% start with importing the data
%% REF
close all
clear all

cd D:\5_FuturePeyto\crhm\C_Scenarios\output\
fileList = dir('D:\5_FuturePeyto\crhm\C_Scenarios\output\ref*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'REF');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeREF= datetime(datevec(timeREF+ 693960));
timeREF = dateshift(timeREF,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('D:\5_FuturePeyto\crhm\C_Scenarios\output\PeytoREF.mat')
%% SUB storage scenario 1
close all
clear all
cd D:\5_FuturePeyto\crhm\C_Scenarios\output\
fileList = dir('D:\5_FuturePeyto\crhm\C_Scenarios\output\sub1*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'SUB1');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeSUB1= datetime(datevec(timeSUB1+ 693960));
timeSUB1 = dateshift(timeSUB1,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('PeytoSUB1.mat')
%% SUB 2
close all
clear all
cd D:\5_FuturePeyto\crhm\C_Scenarios\output\
fileList = dir('D:\5_FuturePeyto\crhm\C_Scenarios\output\sub2*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'SUB2');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeSUB2= datetime(datevec(timeSUB2+ 693960));
timeSUB2 = dateshift(timeSUB2,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('PeytoSUB2.mat')
%% SUB 3
close all
clear all
cd D:\5_FuturePeyto\crhm\C_Scenarios\output\
fileList = dir('D:\5_FuturePeyto\crhm\C_Scenarios\output\sub3*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'SUB3');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeSUB3= datetime(datevec(timeSUB3+ 693960));
timeSUB3 = dateshift(timeSUB3,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('PeytoSUB3.mat')

%% Initial Ice volume scenario
close all
clear all

cd D:\5_FuturePeyto\crhm\C_Scenarios\output\
fileList = dir('D:\5_FuturePeyto\crhm\C_Scenarios\output\ice1*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'ICE1');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeICE1= datetime(datevec(timeICE1+ 693960));
timeICE1 = dateshift(timeICE1,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('PeytoICE1.mat')
%% ICE 2
close all
clear all

cd D:\5_FuturePeyto\crhm\C_Scenarios\output\
fileList = dir('D:\5_FuturePeyto\crhm\C_Scenarios\output\ice2*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'ICE2');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeICE2= datetime(datevec(timeICE2+ 693960));
timeICE2 = dateshift(timeICE2,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('PeytoICE2.mat')
%% ICE 3
close all
clear all

cd D:\5_FuturePeyto\crhm\C_Scenarios\output\
fileList = dir('D:\5_FuturePeyto\crhm\C_Scenarios\output\ice3*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'ICE3');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeICE3= datetime(datevec(timeICE3+ 693960));
timeICE3 = dateshift(timeICE3,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('PeytoICE3.mat')

%% Surface water
close all
clear all
cd D:\5_FuturePeyto\crhm\C_Scenarios\output\
fileList = dir('D:\5_FuturePeyto\crhm\C_Scenarios\output\sur1*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'SUR1');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeSUR1= datetime(datevec(timeSUR1+ 693960));
timeSUR1 = dateshift(timeSUR1,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('PeytoSUR1.mat')
%% Lak 2
close all
clear all
cd D:\5_FuturePeyto\crhm\C_Scenarios\output\
fileList = dir('D:\5_FuturePeyto\crhm\C_Scenarios\output\sur2*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'SUR2');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeSUR2= datetime(datevec(timeSUR2+ 693960));
timeSUR2 = dateshift(timeSUR2,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('PeytoSUR2.mat')

%% Lak 3
close all
clear all
cd D:\5_FuturePeyto\crhm\C_Scenarios\output\
fileList = dir('D:\5_FuturePeyto\crhm\C_Scenarios\output\sur3*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'SUR3');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeSUR3= datetime(datevec(timeSUR3+ 693960));
timeSUR3 = dateshift(timeSUR3,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('PeytoSUR3.mat')

%% No Veg 1
close all
clear all

cd D:\5_FuturePeyto\crhm\C_Scenarios\output\
fileList = dir('D:\5_FuturePeyto\crhm\C_Scenarios\output\veg1*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'VEG1');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeVEG1= datetime(datevec(timeVEG1+ 693960));
timeVEG1 = dateshift(timeVEG1,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('PeytoVEG1.mat')
%% VEG 2
close all
clear all

cd D:\5_FuturePeyto\crhm\C_Scenarios\output\
fileList = dir('D:\5_FuturePeyto\crhm\C_Scenarios\output\veg2*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'VEG2');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeVEG2= datetime(datevec(timeVEG2+ 693960));
timeVEG2 = dateshift(timeVEG2,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('PeytoVEG2.mat')
%% Veg 3
close all
clear all

cd D:\5_FuturePeyto\crhm\C_Scenarios\output\
fileList = dir('D:\5_FuturePeyto\crhm\C_Scenarios\output\veg3*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'VEG3');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeVEG3= datetime(datevec(timeVEG3+ 693960));
timeVEG3 = dateshift(timeVEG3,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('PeytoVEG3.mat')

%% WET
close all
clear all

cd D:\5_FuturePeyto\crhm\C_Scenarios\output\
fileList = dir('D:\5_FuturePeyto\crhm\C_Scenarios\output\wet*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'WET');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeWET= datetime(datevec(timeWET+ 693960));
timeWET = dateshift(timeWET,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('PeytoWET.mat')
%% DRY
close all
clear all

cd D:\5_FuturePeyto\crhm\C_Scenarios\output\
fileList = dir('D:\5_FuturePeyto\crhm\C_Scenarios\output\dry*.txt'); % get all the CRHM outputs starting with PeytoCUR_1OBS
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
varname = strcat(varname, 'DRY');
assignin('base',varname,D.data(:, Index));
end 

end 
%convert the time to a datetime format
timeDRY= datetime(datevec(timeDRY+ 693960));
timeDRY = dateshift(timeDRY,'start','hour', 'nearest');

clear D H fileList fn headers i idxvar ii Index numvar pattern splitcells str varname  
save ('PeytoDRY.mat')