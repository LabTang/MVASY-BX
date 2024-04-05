function acc=predict_svm2(modela, modelb,test_x1,test_x2,y,type,r1,r2)

    if type == 0
        label=test_x1*modela;

    elseif type == 1
        label=test_x2*modelb ;

    elseif type == 2
        label=test_x2*modelb +test_x1*modela;
    else
        label=r2*test_x2*modelb +r1*test_x1*modela;

    end
    
    
    [n,~] = size(label);


    P = 0;
    N = 0;
    TP = 0;
    FN = 0;
    TN = 0;
    FP = 0;
    for i=1:n
        if y(i) == 1
            P = P + 1; 
            if label(i)>=0
                TP = TP+1;
            else
                FN = FN+1;
            end
        else
            N = N + 1;
            if label(i)>=0
                FP = FP+1;
            else
                TN = TN+1;
            end
        end
    end
    acc = (TP+TN)/(TP+TN+FP+FN);
end