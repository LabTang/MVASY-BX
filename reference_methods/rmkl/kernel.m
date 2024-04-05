
function K = kernel(X,Y,type,gamma,p)
switch type
    case 'linear'
        K = X*Y';
    case 'rbf'
        gamma = gamma*gamma;
        XX = sum(X.*X,2);
        YY = sum(Y.*Y,2);
        XY = X*Y';
        K = abs(repmat(XX,[1 size(YY,1)]) + repmat(YY',[size(XX,1) 1]) - 2*XY);
        K = exp(-K./gamma);
    case 'poly'
        K = X*Y';
        K = (K + 1).^p;
end
end