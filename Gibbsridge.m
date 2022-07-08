function [Beta, Lambda, Delta] = Gibbsridge(k, A, y)
%{
Gibbs Sampler - Bayesian linear regression with l2 regularization (Ridge)

Input:
k : number of MCMC samples
y : n x 1 observation vector
A : n x p design matrix

Output:
Beta: p x k parameter matrix
Lambda: 1 x k squared precision matrix (lambda^2)
Delta : 1 x k squared precision matrix (delta^2)

Author :  Uday Velakur
Email: uvelakur@getyourguide.com
Date: October 2020
%}
M = size(A,1);
N = size(A,2);

L = eye(N);
Nbar = rank(L);

%Time saving operations
AtA = A.'*A;
Aty = A.'*y;

lambda = 1;
delta = 1;
beta = (lambda*AtA + (delta*L)) \ (lambda * Aty);

Beta(:,1) = beta;
Lambda(:,1) = lambda;
Delta(:,1) = delta;


for i = 2:k
    
    %Sample lambda
    shape = M/2 + 1;
    scale = 1/(0.5*sum((A*beta - y).^2) + (1e-4));
    lambda = gamrnd(shape, scale);
    Lambda(:,i) = lambda;
     
    %Sample delta
    shape = Nbar/2 + 1;
    scale = 1/((0.5* beta.'*L*beta) + (1e-4));
    delta = gamrnd(shape, scale);
    Delta(:,i)= delta;
    
    %Sample beta
    MU = (lambda*AtA + (delta*L)) \ (lambda * Aty);
    SIGMA = (lambda*AtA + (delta*L)) \ L;
    beta = mvnrnd(MU,SIGMA).';
    Beta(:,i) = beta;
        
end
end
