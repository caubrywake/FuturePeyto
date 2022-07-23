function [var_basinaverage] = BasinAverage_fluxes(var,hruarea)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
% var=var_fluxes;
sz= size(var);
basinarea = sum(hruarea);
% var = var_fluxes ;
for i = 1:sz(3)
    v = var(:,:,i)*0.001;    % select flux form 3d matrix, convert form mm to convert to m per interval (1hr)
    v = sum(v.*(hruarea),2); % aeach hru value * hru area and sum of all the hru = basin sum
    v = v/basinarea * 1000;  % basin average (baisn sum / basin avrage), convert back to mm
    var_basinaverage(:, i) = v; 
end 

end 

