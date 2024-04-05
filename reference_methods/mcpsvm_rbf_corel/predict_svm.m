function accuracy=predict_svm(model,x,y)
    [n,~]=size(x);
%     label=kernel(x,model.Xsv,model.kerType,model.gamma)*model.W+model.b;
    for i=1:n
        temp=0;
        for j=1:model.svnum
            temp=temp+model.Ysv(j)*model.a(j)*kernel(model.Xsv(j,:),x(i,:),model.kerType,model.gamma);
        end
        label(i)=temp+model.b;
%         label(i)=model.W*x(i,:)'+model.b;

        if label(i)>=0
            label(i)=1;
        else
            label(i)=-1;
        end
    end
    accuracy=length(find(y'-label==0))/n;
end