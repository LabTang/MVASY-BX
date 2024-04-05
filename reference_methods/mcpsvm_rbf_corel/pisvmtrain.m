function model=pisvmtrain(x,x2,y,kerType,C,gamma,gammaForIPSVM)
    [n,dim] = size(x);
    x=[x,ones(n,1)];
    x2=[x2,ones(n,1)];
    options = optimset;    % Options是用来控制算法的选项参数的向量
    options.LargeScale = 'off';
    options.Display = 'off';
    H1 = (y*y').*kernel(x,x,kerType,gamma);
    H2 = (1/gammaForIPSVM)*kernel(x2,x2,kerType,gamma);
    H=[H1+H2,H2;H2,H2];
    H=H+1e-10*eye(size(H));
    for k=1:n
      for j=1:n
      f1(k,j)=(-C/gammaForIPSVM)*kernel(x2(k,:),x2(j,:),kerType,gamma);
      end
    end
    for l=1:n
      f2(l)=sum(f1(l,:));
    end
    f3=f2-ones(1,n);
    f=[f3,f2];
    f=f';
    A = [];
    b = [];
    lb = zeros(2*n,1);
    ub = C*ones(2*n,1);
    a0 = zeros(2*n,1);  % a0是解的初始近似值
    options.Algorithm='interior-point-convex';
    [a]  = quadprog(H,f,A,b,[],[],lb,[],a0,options);
    a=a(1:n,1);
    model.x=x;
    model.x2=x2;
    model.kerType=kerType;
    model.gamma=gamma;
    model.W=a.*y;
 
end