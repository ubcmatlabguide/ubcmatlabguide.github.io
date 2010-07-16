function myfunc(varargin)
[A,B,C,D,E] = process_options(varargin,'A',1,'B',2,'C',3,'D',4,'E',5);
fprintf('A %d, B %d, C %d, D %d, E %d\n', A, B, C, D, E);
end