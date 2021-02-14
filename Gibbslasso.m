function [Beta, Sigma, Tau, Lambda] = Gibbslasso(k, A, y)
%{
Gibbs Sampler - Bayesian linear regression with l1 regularization (LASSO)

Input:
k : number of MCMC samples
y : n x 1 observation vector
A : n x p design matrix

Output:
Beta: p x k parameter matrix
Sigma: 1 x k variance matrix (Sigma^2)
Tau: p x k inverse tau squared matrix (1/tau^2)
Lambda: 1 x k squared precision matrix (lambda^2)

Author :  Uday Velakur
Email: u.velakur@tu-braunschweig.de
Date: October 2020
%}

n = size(A,1);
p = size(A,2);

%Time saving operations
AtA = A.'*A;
Aty = A.'*y;

Aprime = AtA + eye(p);

beta = Aprime \ Aty;
residue = y - A*beta;
sigma2 = (residue.'*residue) / n;
invTau2 = 1 ./ (beta.^2);
lambda2 = p * sqrt(sigma2) / sum((abs(beta)));

r = 1;
delta = 1/(10*lambda2*lambda2);

Beta(:,1) = beta;
Sigma(:,1) = sigma2;
Tau(:,1) = invTau2;
Lambda(:,1) = lambda2;
index = linspace(1,p,p);

for i = 2:k
 invD = diag(invTau2);
 invA = (AtA + invD) \ eye(p);
 mu = invA * Aty;
 varcov = sigma2 * invA;
 beta = mvnrnd(mu,varcov)';
 Beta(:,i) = beta;
 
 %Sample sigma2 
 shape = (n+p-1)/2;
 residue = y - A*beta;
 scale = (residue'*residue + beta'*invD*beta) / 2;
 sigma2 = 1 / gamrnd(shape,1/scale);
 Sigma(:,i) = sigma2;
 
 %Sample tau2
 muPrime = sqrt((lambda2 * sigma2) ./ (beta.^2));
 lambdaPrime = lambda2;
 invTau2(index) = random('InverseGaussian', muPrime(index) , lambdaPrime);
 pos = find(invTau2==0);
 invTau2(invTau2==0) = Tau(pos,i-1); %Ensures MCMC stability!
 Tau(:,i) = invTau2;

 %Update lambda
 shape = r + p;
 scale = 1/(delta + (sum(1./invTau2)/2));
 lambda2 = gamrnd(shape, scale);
 Lambda(:,i) = lambda2;
 
end
end