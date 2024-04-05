function [accuracy,F]=predict_svm(model,x1,x2,y)
[n,~] = size(x1);
temp1=kernel(x1,model.rx1,model.kerType1,1,model.p1);
temp2=kernel(x2,model.rx2,model.kerType2,1,model.p2);
temp=0.5*(temp1+temp2);
label=temp*model.v-ones(n,1)*model.r;
for i=1:n
    if label(i)>=0
        label(i)=1;
    else
        label(i)=-1;
    end
end
TP=0;
TN=0;
FP=0;
FN=0;
for i3=1:n
    if y(i3)==1 && label(i3)==1
        TP=TP+1;
    elseif y(i3)==1 && label(i3)==-1
        FN=FN+1;
    elseif y(i3)==-1 && label(i3)==1
        FP=FP+1;
    else
        TN=TN+1;
    end
end
accuracy=(TP+TN)/n;
F=(2*TP)/(2*TP+FN+FP);
end