function [mean_accuracy,std_accuracy,mean_accuracy3,std_accuracy3] = Crossvalidation(data1,data2,a,b,C1,C2,C,rbf_sig)
    x1 = data1.x1;
    x2 = data1.x2;
    y = data1.y;
    
    [n,~] = size(x1);
    x1 = [x1,ones(n,1)];
    
    [n,~] = size(x2);
    x2 = [x2, ones(n,1)];
    
    
    [M,N]=size(y);
    indices=crossvalind('Kfold',y(1:M,N),5);
    for k=1:5
        test = (indices == k); 
        test(1) = [];
        train = ~test;
        train_x1=x1(train,:);
        train_x2=x2(train,:);
        train_target=y(train,:);
        test_x1=x1(test,:);
        test_x2=x2(test,:);
        test_target=y(test,:);
        [modela, modelb] = mvlinex(train_x1,train_x2,train_target,a,b,C1,C2,C,rbf_sig);
        acc0=predict_svm2(modela, modelb,test_x1,test_x2,test_target,rbf_sig,0);
        acc1=predict_svm2(modela, modelb,test_x1,test_x2,test_target,rbf_sig,1);
        acc2=predict_svm2(modela, modelb,test_x1,test_x2,test_target,rbf_sig,2);
        
        all_accuracy0(k) = acc0;
        all_accuracy1(k) = acc1;
        all_accuracy2(k) = acc2;
        
        all_accuracy(k) = max([acc0,acc1,acc2]);
    end
    mean_accuracy = nanmean(all_accuracy);  
    std_accuracy = nanstd(all_accuracy); 
    
    mean_accuracy3 = max([nanmean(all_accuracy0),nanmean(all_accuracy1),nanmean(all_accuracy2)]);  
    if mean_accuracy3 == nanmean(all_accuracy0)
        std_accuracy3 = nanstd(all_accuracy0);
    elseif mean_accuracy3 == nanmean(all_accuracy1)
        std_accuracy3 = nanstd(all_accuracy1);
    else
        std_accuracy3 = nanstd(all_accuracy2);
    end
