function [var_dailysum, t_daily] = RetimeDailySum(t_hrly,var_hrly)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
  x = timetable (t_hrly,var_hrly);
  xx = retime(x, 'daily', 'sum');
  var_dailysum= table2array(xx);
  t_daily= xx.t_hrly;
end

