function [mean_accuracy1,std_accuracy1,mean_accuracy2,std_accuracy2,mean_accuracy3,std_accuracy3,mean_accuracy4,std_accuracy4,mean_accuracymax,std_accuracymax,max_signal]= crossvalidation(data,c,a,b,d,lambda)
x1 = data.xa;
x2 = data.xb;
y = data.y;

[n,~] = size(x1);
x1 = [x1,ones(n,1)];

[n,~] = size(x2);
x2 = [x2, ones(n,1)];


[M,N]=size(y);
indices=crossvalind('Kfold',y(1:M,N),5);
i=find(indices==2);
indices(i(1))=1;
for k=1:5
    
    test = (indices == k);
   % aaa =size(test)
    sum(test(:));
    train = ~test;

    train_x1=x1(train,:);
    train_x2=x2(train,:);
    train_target=y(train,:);
    test_x1=x1(test,:);
    test_x2=x2(test,:);
    test_target=y(test,:);
    size(test_target);

    [modela, modelb,r1,r2] = mvlinex(train_x1,train_x2,train_target,c,a,b,d,lambda);
    acc0=predict_svm2(modela, modelb,test_x1,test_x2,test_target,0,r1,r2);
    acc1=predict_svm2(modela, modelb,test_x1,test_x2,test_target,1,r1,r2);
    acc2=predict_svm2(modela, modelb,test_x1,test_x2,test_target,2,r1,r2);
    acc3=predict_svm2(modela, modelb,test_x1,test_x2,test_target,3,r1,r2);
    all_accuracy0(k) = acc0;
    all_accuracy1(k) = acc1;
    all_accuracy2(k) = acc2;
    all_accuracy3(k) = acc3;
    
    
end
mean_accuracy1 = nanmean(all_accuracy0);
std_accuracy1 = nanstd(all_accuracy0);
mean_accuracy2 = nanmean(all_accuracy1);
std_accuracy2 = nanstd(all_accuracy1);
mean_accuracy3 = nanmean(all_accuracy2);
std_accuracy3 = nanstd(all_accuracy2);
mean_accuracy4 = nanmean(all_accuracy3);
std_accuracy4 = nanstd(all_accuracy3);
mean_accuracymax = max([nanmean(all_accuracy0),nanmean(all_accuracy1),nanmean(all_accuracy2),nanmean(all_accuracy3)]);
if mean_accuracymax == nanmean(all_accuracy0)
    std_accuracymax = nanstd(all_accuracy0);
    max_signal = 'a';
elseif mean_accuracymax == nanmean(all_accuracy1)
    std_accuracymax = nanstd(all_accuracy1);
    max_signal = 'b';
elseif mean_accuracymax == nanmean(all_accuracy2)
    std_accuracymax = nanstd(all_accuracy2);
    max_signal = 'ab';
else
    std_accuracymax = nanstd(all_accuracy3);
    max_signal = 'weight';
end