function [original_result,max_result]=find_para(data,i)


% C = [1,2,4,8,16,32,64,128,256];
% A = [-1.04,-1.03,-1.02,-1.01,-1.00,-0.99,-0.98,-0.97,-0.96,-0.95];
% D = [1,2,4,8,16,32,64,128,256];
% LAMBDA = [0.1,1,10];

A = [-1,-1.2,-0.8];%确定是这个范围了 
D = [1,4,16];
C = [200,300,400,500];
LAMBDA = [1,2,4,8,16];

B = [0.1,0.2,0.3];
signal=' ';
max_acc=0;
max_std=0;
max_para=[];
[max_acc_a,max_acc_b,max_acc_ab,max_acc_weight] = deal(0);
[max_std_a,max_std_b,max_std_ab,max_std_weight] = deal(0);
[max_para_a,max_para_b,max_para_ab,max_para_weight] = deal([]);
original_result = [];
max_result= [];
for c = C
    for a = A
        for d = D
            for lambda = LAMBDA
                for b =B
                    
                [mean_accuracy1,std_accuracy1,mean_accuracy2,std_accuracy2,mean_accuracy3,std_accuracy3,mean_accuracy4,std_accuracy4,mean_accuracymax,std_accuracymax,max_signal]= crossvalidation(data,c,a,b,d,lambda);
                if mean_accuracymax>max_acc
                    max_acc = mean_accuracymax;
                    max_std = std_accuracymax;
                    max_para = [c,a,b,d,lambda];
                    signal = max_signal;
                end
                if mean_accuracy1>max_acc_a
                    max_acc_a = mean_accuracy1;
                    max_std_a = std_accuracy1;
                    max_para_a = [c,a,b,d,lambda];
                end
                if mean_accuracy2>max_acc_b
                    max_acc_b = mean_accuracy2;
                    max_std_b = std_accuracy2;
                    max_para_b = [c,a,b,d,lambda];
                end
                if mean_accuracy3>max_acc_ab
                    max_acc_ab = mean_accuracy3;
                    max_std_ab = std_accuracy3;
                    max_para_ab = [c,a,b,d,lambda];
                end
                if mean_accuracy4>max_acc_weight
                    max_acc_weight = mean_accuracy4;
                    max_std_weight = std_accuracy4;
                    max_para_weight = [c,a,b,d,lambda];
                end
                end
            end
        end
    end
end
max_acc
original_result = [i,max_acc_a,max_std_a,max_para_a;
                    i,max_acc_b,max_std_b,max_para_b;
                    i,max_acc_ab,max_std_ab,max_para_ab;
                    i,max_acc_weight,max_std_weight,max_para_weight]
max_result = {[i],[signal],[max_acc,max_std,max_para]}
% [mean_accuracy1,std_accuracy1,mean_accuracy2,std_accuracy2,mean_accuracy3,std_accuracy3,mean_accuracy4,std_accuracy4,mean_accuracymax,std_accuracymax]= crossvalidation(data,128,-1.04,16,0.1);
%                 if mean_accuracymax>max_acc
%                     acc1=mean_accuracy1;
%                     std1=std_accuracy1;
%                     acc2=mean_accuracy2;
%                     std2=std_accuracy2;
%                     acc3=mean_accuracy3;
%                     std3=std_accuracy3;
%                     acc4=mean_accuracy4;
%                     std4=std_accuracy4;
%                     max_acc = mean_accuracymax;
%                     max_std = std_accuracymax;
end