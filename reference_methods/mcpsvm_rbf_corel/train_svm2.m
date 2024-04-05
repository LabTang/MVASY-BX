function model=train_svm2(x,y,kerType,C,gamma)
%x是列向量，y是列向量
%先将y转为行向量
    y=y';
    [n,dim] = size(x);
    x=[x,ones(n,1)];
    options = optimset;    % Options是用来控制算法的选项参数的向量
    options.LargeScale = 'off';
    options.Display = 'off';
    H = (y'*y).*kernel(x,x,kerType,gamma);
    f = -ones(n,1);
%   f = cat(1,zeros(plen,1),-ones(nlen,1));
    A = [];
    b = [];
    Aeq = y; 
    beq = 0;
    lb = zeros(n,1);
    ub = C*ones(n,1);
    a0 = zeros(n,1);  % a0是解的初始近似值
     H=H+1e-10*eye(size(H));
     options.Algorithm='interior-point-convex';
%   [a,fval,eXitflag,output,lambda]  = quadprog(H,f,A,b,Aeq,beq,lb,ub,a0,options);
    [a]  = quadprog(H,f,A,b,[],[],lb,ub,a0,options);
    model.kerType=kerType;
    model.x=x;
    model.gamma=gamma;
%     epsilon = 1e-10; 
%     sv_label = find(abs(a)>epsilon);  %0<a<a(max)则认为x为支持向量
%     a = a(sv_label);
%     Xsv = x(sv_label,:);
%     Ysv = y(sv_label);
%     svnum = length(sv_label);
%     model.Xsv = Xsv;
%     model.Ysv = Ysv;
%     model.kerType=kerType;
%     model.gamma=gamma;
%     model.svnum = svnum;
%     num = length(Ysv);
     
    model.W=a.*y';
end