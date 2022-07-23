function [VARmean,VARstd Vrshp_annual] = DailyAverage(var_daily,startmonth, startday,t)
% 15 year matrix of average of the CRHM PGW outputs + mean and standard
% deviation

% inputs: 
% var_daily: time series of the variables of interest (colum is variable,
% line is timestep)
% startmonth, startday: month starting the year of ineterst (Oct 1  would be 10, 1; Apriul 15 would be 4, 15)
% t: time of variable_daily, in datetime format

% outputs:
% VARmean: the 15 year daily average (inter-annual average of each calendar
% day), for each process
% VARstd  the standard divation of the inter-annual mean of each calendar
% day)
% Vrshp_annual: 3 d matirx with the 15 years for eahc process.

sz = size(var_daily);
t= datetime(t);
timevec = datevec(t);
tidx = find(timevec(:, 2) == startmonth & timevec(:, 3) == startday);
t(tidx); % quick check for the dates for each year - this should give a list of april 1st 

for ii = 1:sz(2) % for the variable
     V = var_daily(:,ii);
for i = 1:length(tidx)-1 % for every year
    if i <=15
   varRSHP_PGW(:, i) = V(tidx(i):tidx(i+1)-1); % select the data from that year
    else 
   varRSHP_PGW(:, i) = [V(tidx(i):tidx(i+1)); nan(364-(tidx(15)-tidx(14)), 1)]; % last year shorter, so I pad with nan
  end 
end 
Vrshp_annual(:,:,ii) = varRSHP_PGW; % compile in a 3d matrix (15 years, 16 scenarios)
end
for i = 1:sz(2)    
    dd= Vrshp_annual(:,:,i);
    VARmean(:, i) = nanmean(dd, 2); % the average of the 15 years 
    VARstd(:, i) = nanstd(dd);
end 
td = t(tidx(1):tidx(2)-1); % create a time array for 364 days
end

