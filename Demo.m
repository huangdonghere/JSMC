%%
% This is a demo for the Jointly Smoothed Multi-view Subspace Clustering 
% (JSMC) algorithm. If you find it helpful in your research, please cite 
% the paper below.
%
% Xiaosha Cai, Dong Huang, Guangyu Zhang, Chang-Dong Wang. 
% Seeking Commonness and Inconsistencies: A Jointly Smoothed Approach to 
% Multi-view Subspace Clustering. Information Fusion, in press, 2022. 
%
% DOI: 10.1016/j.inffus.2022.10.020
%%

clear all;

addpath(genpath('./tools/'));

load('3Scources.mat','gt','X');
% gt: ground truth label
% X: input data

K = numel(unique(gt)); % number of clusters

%parameters
alpha = 10.^[-5];
beta = 100;
lambda = 10;

disp('Start running the JSMC algorithm...');
label = runJSMC(X, K, alpha, beta, lambda);
disp('Done.');

nmiScore = NMImax(label,gt);
disp(['NMI =', num2str(nmiScore)]);