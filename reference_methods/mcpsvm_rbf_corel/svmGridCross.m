function [result]=svmGridCross(dataname)
% Gridsearch + cross validation
load(dataname);
x=x;
x2=x2;
Da=1;Db=1;
folds = 5;
base=10;
[c, g] = meshgrid(-3:3,-3:3);
for i = 1:numel(c)
    [Accuracy1,Accuracy2,Accuracy3] = svm_cross(x,x2,y, base^c(i),base^g(i),folds);
    acc1(i) = Accuracy1.mean;
    Std_acc1(i) = Accuracy1.std;
    time1(i)=Accuracy1.time;
    acc2(i) = Accuracy2.mean;
    Std_acc2(i) = Accuracy2.std;
    time2(i)=Accuracy2.time;
    acc3(i) = Accuracy3.mean;
    Std_acc3(i) = Accuracy3.std;
    time3(i)=Accuracy3.time;
end
[Max_acc1,Idx1] = max(acc1);
[Max_acc2,Idx2] = max(acc2);
[Max_acc3,Idx3] = max(acc3);

Std_acc1 = Std_acc1(Idx1);
Std_acc2 = Std_acc2(Idx2);
Std_acc3 = Std_acc3(Idx3);

time1=time1(Idx1);time2=time2(Idx2);time3=time3(Idx3);
best_c1=c(Idx1);
best_c2=c(Idx2);
best_c3=c(Idx3);
best_g1=g(Idx1);
best_g2=g(Idx2);
best_g3=g(Idx3);
clear c g;

[c,g,gamma] = meshgrid(-3:3,-3:3,-3:3);
for i = 1:numel(c)
    [Accuracy4,Accuracy5,Accuracy6,Accuracy7,Accuracy8,Accuracy9,Accuracy10,Accuracy11] = svm_cross_plus(x,x2,y, base^c(i),base^g(i),base^gamma(i),folds,Da,Db);
    acc4(i) = Accuracy4.mean;
    Std_acc4(i) = Accuracy4.std;
    acc5(i) = Accuracy5.mean;
    Std_acc5(i) = Accuracy5.std;
    acc6(i) = Accuracy6.mean;
    Std_acc6(i) = Accuracy6.std;
    acc7(i) = Accuracy7.mean;
    Std_acc7(i) = Accuracy7.std;
    acc8(i) = Accuracy8.mean;
    Std_acc8(i) = Accuracy8.std;
    acc9(i) = Accuracy9.mean;
    Std_acc9(i) = Accuracy9.std;
    acc10(i) = Accuracy10.mean;
    Std_acc10(i) = Accuracy10.std;
    acc11(i) = Accuracy11.mean;
    Std_acc11(i) = Accuracy11.std;

    time4(i)=Accuracy4.time;
    time5(i)=Accuracy5.time;
    time6(i)=Accuracy6.time;
    time7(i)=Accuracy7.time;
    time8(i)=Accuracy8.time;
    time9(i)=Accuracy9.time;
    time10(i)=Accuracy10.time;
    time11(i)=Accuracy11.time;

   
end
[Max_acc4,Idx4] = max(acc4);
[Max_acc5,Idx5] = max(acc5);
[Max_acc6,Idx6] = max(acc6);
[Max_acc7,Idx7] = max(acc7);
[Max_acc8,Idx8] = max(acc8);
[Max_acc9,Idx9] = max(acc9);
[Max_acc10,Idx10] = max(acc10);
[Max_acc11,Idx11] = max(acc11);
Std_acc4 = Std_acc4(Idx4);
Std_acc5 = Std_acc5(Idx5);
Std_acc6 = Std_acc6(Idx6);
Std_acc7 = Std_acc7(Idx7);
Std_acc8 = Std_acc8(Idx8);
Std_acc9 = Std_acc9(Idx9);
Std_acc10 = Std_acc10(Idx10);
Std_acc11 = Std_acc11(Idx11);

time4=time4(Idx4);time7=time7(Idx7);time10=time10(Idx10);
time5=time5(Idx5);time8=time8(Idx8);time11=time11(Idx11);
time6=time6(Idx6);time9=time9(Idx9);

best_c4=c(Idx4);
best_c5=c(Idx5);
best_c6=c(Idx6);
best_c7=c(Idx7);
best_c8=c(Idx8);
best_c9=c(Idx9);
best_c10=c(Idx10);
best_c11=c(Idx11);
best_g4=g(Idx4);
best_g5=g(Idx5);
best_g6=g(Idx6);
best_g7=g(Idx7);
best_g8=g(Idx8);
best_g9=g(Idx9);
best_g10=g(Idx10);
best_g11=g(Idx11);
best_gamma4=gamma(Idx4);
best_gamma5=gamma(Idx5);
best_gamma6=gamma(Idx6);
best_gamma7=gamma(Idx7);
best_gamma8=gamma(Idx8);
best_gamma9=gamma(Idx9);
best_gamma10=gamma(Idx10);
best_gamma11=gamma(Idx11);

result.best_c1=best_c1;
result.best_c2=best_c2;
result.best_c3=best_c3;
result.best_c4=best_c4;
result.best_c5=best_c5;
result.best_c6=best_c6;
result.best_c7=best_c7;
result.best_c8=best_c8;
result.best_c9=best_c9;
result.best_c10=best_c10;
result.best_c11=best_c11;
result.best_g1=best_g1;
result.best_g2=best_g2;
result.best_g3=best_g3;
result.best_g4=best_g4;
result.best_g5=best_g5;
result.best_g6=best_g6;
result.best_g7=best_g7;
result.best_g8=best_g8;
result.best_g9=best_g9;
result.best_g10=best_g10;
result.best_g11=best_g11;
% result.best_gamma1=best_gamma1;
% result.best_gamma2=best_gamma2;
% result.best_gamma3=best_gamma3;
result.best_gamma4=best_gamma4;
result.best_gamma5=best_gamma5;
result.best_gamma6=best_gamma6;
result.best_gamma7=best_gamma7;
result.best_gamma8=best_gamma8;
result.best_gamma9=best_gamma9;
result.best_gamma10=best_gamma10;
result.best_gamma11=best_gamma11;

result.Max_acc1=Max_acc1;
result.Std_acc1=Std_acc1;
result.Max_acc2=Max_acc2;
result.Std_acc2=Std_acc2;
result.Max_acc3=Max_acc3;
result.Std_acc3=Std_acc3;
result.Max_acc4=Max_acc4;
result.Std_acc4=Std_acc4;
result.Max_acc5=Max_acc5;
result.Std_acc5=Std_acc5;
result.Max_acc6=Max_acc6;
result.Std_acc6=Std_acc6;
result.Max_acc7=Max_acc7;
result.Std_acc7=Std_acc7;
result.Max_acc8=Max_acc8;
result.Std_acc8=Std_acc8;
result.Max_acc9=Max_acc9;
result.Std_acc9=Std_acc9;
result.Max_acc10=Max_acc10;
result.Std_acc10=Std_acc10;
result.Max_acc11=Max_acc11;
result.Std_acc11=Std_acc11;

result.time1=time1;
result.time2=time2;
result.time3=time3;
result.time4=time4;
result.time5=time5;
result.time6=time6;
result.time7=time7;
result.time8=time8;
result.time9=time9;
result.time10=time10;
result.time11=time11;


end
