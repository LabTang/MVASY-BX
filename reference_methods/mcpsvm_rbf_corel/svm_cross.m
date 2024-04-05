function [accuracy21,accuracy22,accuracy23]=svm_cross(data,data2,y,c,g,folds)
[M,N]=size(data);
indices=crossvalind('Kfold',data(1:M,N),folds);
t1=0;t2=0;t3=0;
for k=1:folds
    test = (indices == k);
    train = ~test;
    train_data=data(train,:);
    train_data2=data2(train,:);
    train_target=y(train,:);
    test_data=data(test,:);
    test_data2=data2(test,:);
    test_target=y(test,:);
    tic;
    model=train_svm2(train_data,train_target,'rbf',c,g);
    accuracy1(k)=predict_svm2(model,test_data,test_target);
    t1=t1+toc;
    clear model;
    tic;
    model=train_svm2(train_data2,train_target,'rbf',c,g);
    accuracy2(k)=predict_svm2(model,test_data2,test_target);
    t2=t2+toc;
    clear model;
    tic;
    model=svm2k(train_data,train_data2,train_target,'rbf',c,c,c,g);
    accuracy3(k)=predict_svm2k(model,test_data,test_data2,test_target);
    t3=t3+toc;
    clear model;
end
accuracy21.mean=mean(accuracy1);
accuracy21.std=std(accuracy1,1);
accuracy21.time=t1/folds;
accuracy22.mean=mean(accuracy2);
accuracy22.std=std(accuracy2,1);
accuracy22.time=t2/folds;
accuracy23.mean=mean(accuracy3);
accuracy23.std=std(accuracy3,1);
accuracy23.time=t3/folds;
end
