function [result]=svmGridCrossmcpk(k,dataname1,dataname2)
% Gridsearch + cross validation
data1=load(dataname1);
data2=load(dataname2);
x=data1.x1;
x2=data2.x2;
y=data1.y;
Da=1;Db=1;
folds = 5;
base=10;
c=(-2:2);
g=(-2:2);

k
for i = 1:5
    i
    for j = g
        
    [Accuracy10,Accuracy11] = svm_cross_plusmcpk(x,x2,y, base^c(1),base^j,2,folds,Da,Db);
    acc10(i) = Accuracy10.mean;
    Std_acc10(i) = Accuracy10.std;
    acc11(i) = Accuracy11.mean;
    Std_acc11(i) = Accuracy11.std;

    time10(i)=Accuracy10.time;
    time11(i)=Accuracy11.time;

   
end

[Max_acc10,Idx10] = max(acc10);
[Max_acc11,Idx11] = max(acc11);

Std_acc10 = Std_acc10(Idx10);
Std_acc11 = Std_acc11(Idx11);

time10=time10(Idx10);
time11=time11(Idx11);

best_c10=c(Idx10);
best_c11=c(Idx11);

best_g10=g(Idx10);
best_g11=g(Idx11);

best_gamma10=gamma(Idx10);
best_gamma11=gamma(Idx11);

result.best_c10=best_c10;
result.best_c11=best_c11;

result.best_g10=best_g10;
result.best_g11=best_g11;

result.best_gamma10=best_gamma10;
result.best_gamma11=best_gamma11;

result.Max_acc10=Max_acc10;
result.Std_acc10=Std_acc10;

result.Max_acc11=Max_acc11;
result.Std_acc11=Std_acc11;

result.time10=time10;
result.time11=time11;


end
