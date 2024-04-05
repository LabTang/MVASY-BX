function [accuracy210,accuracy211]=svm_cross_plusmcpk(data,data2,y,c,g,gamma,folds,Da,Db)
[M,N]=size(data);
t10=0;t11=0;
indices=crossvalind('Kfold',data(1:M,N),3);
for k=1:3
    test = (indices == k);
    train = ~test;
    train_data=data(train,:);
    train_data2=data2(train,:);
    train_target=y(train,:);
    test_data=data(test,:);
    test_data2=data2(test,:);
    test_target=y(test,:);
    
    tic;
    model=rpsvm2v(train_data,train_data2,train_target,'linear',c,c,c,g,gamma);
    accuracy10(k)=predict_rpsvm2v(model,test_data,test_data2,test_target);
    t10=t10+toc;
    clear model;
    tic;
    model=rpsvm2v(train_data2,train_data,train_target,'linear',c,c,c,g,gamma);
    accuracy11(k)=predict_rpsvm2v(model,test_data2,test_data,test_target);
    t11=t11+toc;
    clear model;

end

accuracy210.mean=mean(accuracy10);
accuracy210.std=std(accuracy10,1);
accuracy211.mean=mean(accuracy11);
accuracy211.std=std(accuracy11,1);


accuracy210.time=t10/folds;
accuracy211.time=t11/folds;
end
