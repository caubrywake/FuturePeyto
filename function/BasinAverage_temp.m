function [var_basinaverage] = BasinAverage_temp(var,hruarea)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

basinarea = sum(hruarea);
    v = var;% select flux from 3d matrix, convert from mm to m
    v = sum(v.*(hruarea)./basinarea,2); % mena of eahc hru*hruarea
    var_basinaverage = v; 

end 