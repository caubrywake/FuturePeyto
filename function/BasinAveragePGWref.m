function [var_basinaverage ] =BasinAverage(var,hruarea)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
sz= size(var);basinarea = sum(hruarea);
for i = 1:sz(3)
    if i == 4||  i==5 % specifal case soil moisture and storage
    v = var(:,:,i)*0.001;   v = nanmean(v.*hruarea,2); v = v/basinarea * 1000; 
    else    
    v = var(:,:,i)*0.001; 
    v = sum(v.*(hruarea),2);
    v = v/basinarea * 1000; 
    end 
  var_basinaverage (:, i) = v; 
end 

end
