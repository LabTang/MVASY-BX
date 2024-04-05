function accuracy=predict_svm2k(model,x,x2,y)
    [n,~] = size(x);
    x=[x,ones(n,1)];
    x2=[x2,ones(n,1)];
    label=kernel(x,model.x,model.kerType,model.gamma)*model.Wa+kernel(x2,model.x2,model.kerType,model.gamma)*model.Wb;
    label=label/2;
    for i=1:n
%         label(i)=model.Wa*x(i,:)'+model.b1+model.Wb*x2(i,:)'+model.b2;
%         label(i)=label(i)/2;
        if label(i)>=0
            label(i)=1;
        else
            label(i)=-1;
        end
    end
%   disp(label);   
% disp((find(y'-label==0)));
    accuracy=length(find(y-label==0))/n;
end