function [var_noleapyears, t_noleapyears] = RemoveLeapYears(var_daily, t_daily)
% var_daily = var;
% t_daily = t;

%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
time_vector = datevec(t_daily); % change to a time vector
x = find(time_vector(:,2) == 2 & time_vector(:,3) == 29); % find leap days

t_daily(x, :) = []; % remove the lap days
var_daily(x, :) = [];

var_noleapyears = var_daily;
t_noleapyears = t_daily;

end

