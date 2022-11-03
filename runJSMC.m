%%
% This is a demo for the Jointly Smoothed Multi-view Subspace Clustering 
% (JSMC) algorithm. If you find it helpful in your research, please cite 
% the paper below.
%
% Xiaosha Cai, Dong Huang, Guangyu Zhang, Chang-Dong Wang. 
% Seeking Commonness and Inconsistencies: A Jointly Smoothed Approach to 
% Multi-view Subspace Clustering. Information Fusion, 2023, 91:364-375.
%
% DOI: 10.1016/j.inffus.2022.10.020
%%

function  label = runJSMC(X, cntCls, alpha,beta,lambda)

maxIters = 100;

nView = length(X);
nSample = size(X{1},2);
mu = 1;
knn = 5;
Y = zeros(nSample);
S = zeros(nSample);
max_mu = 10^6;
rho = 1.5;
Obj = [];

%% Initialization
[L,G] = constructG(X, knn, nView, nSample);
[C,E,XX,sumXX,sumL]  = Initialization(X,L,G,nView, nSample);

%temp_inv = (XX{v} + beta*eye(n))\eye(n)
temp_inv = cell(1,nView);
for v = 1:nView
    temp_inv{v} = (XX{v} + beta*eye(nSample))\eye(nSample);
end

%% Alternate minizing strategy
for t = 1:maxIters
    %------------- update S -------------
    S = solveS(sumXX, sumL, XX, C, E, Y, mu, alpha, nView, nSample);   
    %------------- update C -------------
    C = solveC(S, Y, mu, lambda);    
    %------------- update E -------------
    E = solveE(XX, S, temp_inv, nView, nSample);    
    %------------- update Y -------------
    Y = Y + mu*(S-C);
    mu = min(max_mu,rho*mu);   
    
    %Compare the current iteration value with the previous iteration value
    Obj(t) = computeObjValue(X,C,E,L,alpha,beta,lambda,nView);
    if (t>1 && abs(Obj(t-1)-Obj(t))<10^-4)
        break;
    end    
end

%output the final result
W = (C'+C)/2;
[label, ~] = SpectralClustering(W, cntCls);
