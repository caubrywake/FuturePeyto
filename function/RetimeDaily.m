function [var_dailysum, t_daily] = RetimeDaily(t_hrly,var_hrly, retime_function)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
  x = timetable (t_hrly,var_hrly);
  xx = retime(x, 'daily', retime_function);
  var_dailysum= table2array(xx);
  t_daily= xx.t_hrly;
end
