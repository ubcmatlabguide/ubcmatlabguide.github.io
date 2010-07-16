function [a,b,c,d] = inputparserDemoFun(varargin)
% [a,b,c,d] = inputparseDemoFun(first [numeric], second [char], ...)
% where ... are name,value pairs or a struct.
% Names are from this list (default in brackets)
% third [3]
% fourth [4]

p = inputParser;
p.addRequired('first', @isnumeric);
p.addRequired('second', @ischar);
p.addParamValue('third', 3, @isnumeric);
p.addParamValue('fourth', 4, @isnumeric);
p.parse(varargin{:});
%S = struct2cell(p.Results); [a,b,c,d]=deal(S{:});
% The above doesn't work because Matlab stores the fields in alphabetical
% order, so we use this 
S = struct2cell(p.Results); [a,d,b,c]=deal(S{:});
%{
or this long form
a = p.Results.first;
b = p.Results.second;
c = p.Results.third;
d = p.Results.fourth;
%}
 fprintf('a %d, b %s, c %d, d %d\n', a, b, c, d);
 end 
