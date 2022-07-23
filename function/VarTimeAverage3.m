function [OUT] = VarTimeAverage3(varargin)
% 1 and 2 are yr start and end
% 3 is time array
% 5 is hru

yr = varargin{1}:varargin{2}
hru = varargin{4}
hru_area = varargin{5}

for i = 1:length (yr)
   t1 = strcat ('01-Oct-', num2str(yr(i)-1), {' '}, '1:00');
   t2 = strcat ('30-Sep-', num2str(yr(i)), {' '}, '1:00');
a = find(varargin{3}==datetime(t1));
b = find(varargin{3}==datetime(t2));
swein = varargin {6};
sweout = varargin {7};
avyIN = swein(b, hru)- swein(a, hru);
avyOUT = sweout(b, hru)- sweout(a, hru);
AVY = avyIN-avyOUT;
xa  = AVY; %m w.e per hru
xb = xa.*hru_area(hru)*10^6 ;% snow per hru in m3
xc = sum(xb)./sum(hru_area(hru)*10^6); % m3 w.e. 
OUT(i, 1) = xc;

for n = 8:nargin
x = varargin{n};
xa  = sum(x(a:b, hru)); %annual sum, kg/m2
xb = xa.*hru_area(hru)*10^6 ;% kg
xc = sum(xb)./sum(hru_area(hru)*10^6); % kg/m2 
OUT(i, n-6) = xc;
end 
end 
end
