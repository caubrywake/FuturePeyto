function [var_basinaverage] = BasinAverage_state(var,hruarea)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
sz= size(var);basinarea = sum(hruarea);
for i = 1:sz(3)
    v = var(:,:,i)*0.001;
    v = nanmean(v.*hruarea,2);
    v = v/basinarea * 1000; 
    var_basinaverage(:, i) = v; 

end 

end