function [max_acc,std,max_acc3,std3]=ACC_MVLSSVM(data1,data2)

    
    C1 = [1,10]
    C = [1,10]
    RBF = [100]

    max_acc=0;
    std=0;
    
    max_acc3=0;
    std3=0;
    
	for c1 = C1
        for c = C
            for rbf = RBF
                c2 = c1;
                [mean_accuracy,std_accuracy,mean_accuracy3,std_accuracy3] = Crossvalidation(data1,data2,1,1,c1,c2,c,rbf);
                [mean_accuracy,std_accuracy,mean_accuracy3,std_accuracy3,c1,c2,c,rbf]
                if mean_accuracy>max_acc
                    max_acc = mean_accuracy;
                    std = std_accuracy;
                end
                if mean_accuracy3>max_acc3
                    max_acc3 = mean_accuracy3;
                    std3 = std_accuracy3;
                end
            end
        end
	end

    
    
end