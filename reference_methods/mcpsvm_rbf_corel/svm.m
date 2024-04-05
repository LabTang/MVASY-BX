% clear
% data=load ('..\论文\twin数据集\irisorignal.txt');
% X=data;
% x=X(11:90,:);
% y=cat(1,ones(40,1),-ones(40,1));
% x1=cat(1,X(1:10,:),X(91:100,:));
% y1=cat(1,ones(10,1),-ones(10,1));
% x=[1,2,3;1,3,4;7,7,7;7,8,9];
% y=[1;1;-1;-1];
% x1=[1,1,1;9,9,9];
% y1=[1;-1];
clear;
load('matlab.mat');

warning off;
C=1;
gamma=0.001;
%如果rbf，则需要指定gamma
% model=train_svm(x,y,'linear',C,gamma);
model=svm2k(x,x2,y,'linear',1,1,1,0.1);
accuracy=predict_svm2k(model,x,x2,y);
disp(accuracy);