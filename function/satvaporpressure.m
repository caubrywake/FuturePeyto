
function e_s = satvaporpressure (T);
% This function calculate saturaration vapor pressure.
% The input T is in K
e0 = 6.113 ;   % hPa
L = 2.5*10^6; % J kg-1
Lice = 2.83*10^6; % J/kg
Rv = 461.5;	% J K-1 kg 
Rd = 287.1; % J K-1 kg 
T0 = 273.15;    % K
if T < 273.15;
e_s = (e0 * exp (Lice/Rv * (1/T0 - 1/T)));
else
    e_s = (e0 * exp (L/Rv * (1/T0 - 1/T))) ;
% source: Kullen, p. 88
end 
end 