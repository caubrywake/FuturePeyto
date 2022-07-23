function [varargout] = ImportOutput(varargin)
A_headers = importdata(varargin{1},' ',2);
A = importdata(varargin{1}) ;
for n = 2:nargin
splitcells = regexp(A_headers(2, 1), '\s+', 'split');
units = vertcat(splitcells{:});
splitcells = regexp(A_headers(1, 1), '\s+', 'split');
headers = vertcat(splitcells{:});
headersunits = vertcat (headers, units);
IndexC = strfind( headersunits(1, :), varargin{n});
Index = find(not(cellfun('isempty', IndexC)));
varargout{n-1} = A.data(:, Index);
end 
end
