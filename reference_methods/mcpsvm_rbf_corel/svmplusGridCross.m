% Gridsearch + cross validation
clear;
clc;
warning off;
load('data_corel.mat');
data = x;
data2= x2;
targets = y;
%# grid of parameters
folds = 5; e=0.2; rho=0.99;
[C1, C2] = meshgrid(-3:3,-3:3);
%# grid search, and cross-validation
acc = zeros(1, numel(C1)); Std_acc = zeros(1, numel(C1)); 
parfor i = 1:numel(C1)
% [Accuracy,clustertime,traintime,testtime,cp,cn] = AccSNP(data, targets, 16, 4, 0.1250, e, rho, folds);
   [Accuracy,traintime,testtime] = AccSVMplus(data, data2,targets, 10^ C1(i), 10^ C2(i), e, rho, folds);
   acc(i) = Accuracy.mean;
   Std_acc(i) = Accuracy.std;
   Traintime_mean(i) = traintime.mean;
   Traintime_std(i) = traintime.std;
   Testtime_mean(i) = testtime.mean;
   Testtime_std(i) = testtime.std;
end
%# pair (C,rho) with best accuracy
[Max_acc,Idx] = max(acc);
Std_acc = Std_acc(Idx);
Traintime_mean = Traintime_mean(Idx);
Testtime_mean = Testtime_mean(Idx);
Traintime_std = Traintime_std(Idx);
Testtime_std = Testtime_std(Idx);
Best_C1 = 10^C1(Idx);
Best_C2 = 10^C2(Idx);