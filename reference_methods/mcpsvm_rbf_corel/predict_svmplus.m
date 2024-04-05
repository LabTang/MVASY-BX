function accuracy=predict_svmplus(model,x,y)
    [n,~]=size(x);
    x=[x,ones(n,1)];
    label=kernel(x,model.x,model.kerType,model.gamma)*model.W;
    for i=1:n
        if label(i)>=0
            label(i)=1;
        else
            label(i)=-1;
        end
    end
    accuracy=length(find(y-label==0))/n;
end