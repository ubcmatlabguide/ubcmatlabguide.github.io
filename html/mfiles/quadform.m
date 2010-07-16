function [X1,X2] = quadform(A,B,C)
% Implementation of the quadratic formula.
% Here A,B and C can be matrices.
tmp = sqrt(B.^2 - 4*A.*C);
X1 = (-B + tmp)./(2*A);
X2 = (-B - tmp)./(2*A);
end