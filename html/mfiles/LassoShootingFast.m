function [beta,iter] = LassoShootingFast(X,y,lambda,w0)
%#eml
% min_w ||Xw-y||_2^2 + lambda ||w||_1
% Coordinate descent method  ("Shooting"), [Fu, 1998]
% Written by Mark Schmidt
% Modified by Kevin Murphy
% Further modified by Matthew Dunham to make it emlmex complient.

[n,p] = size(X);
maxIter = 10000;
optTol = 1e-5;
beta = w0;
iter = 0;
XX2 = X'*X*2;
Xy2 = X'*y*2;
converged = false;
while ~converged && (iter < maxIter)
  beta_old = beta;
  for j = 1:p
    cj = Xy2(j) - sum(XX2(j,:)*beta) + XX2(j,j)*beta(j);
    aj = XX2(j,j);
    if cj < -lambda
      beta(j,1) = (cj + lambda)/aj;
    elseif cj > lambda
      beta(j,1) = (cj  - lambda)/aj;
    else
      beta(j,1) = 0;
    end
  end
  iter = iter + 1;
  converged = (sum(abs(beta-beta_old)) < optTol);
end

