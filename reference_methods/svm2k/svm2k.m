function model=svm2k(x,x2,y,kerType,Ca,Cb,D,gamma)
    epsilon=0.1;
    [~,~] = size(x);
    [n,~] =size(x2);
    x=[x,ones(n,1)];
    x2=[x2,ones(n,1)];
    options = optimset;    % Options是用来控制算法的选项参数的向量
    options.LargeScale = 'off';
    options.Display = 'off';
    temp1=kernel(x,x,kerType,gamma);
    temp2=kernel(x2,x2,kerType,gamma);
    tempy=ones(n,1)*y';
    A1=(y*y').*temp1;
    A2=(y*y').*temp2;
    A3=temp1+temp2;
    A4=tempy.*temp1;
    A5=tempy.*temp2;
    H=[A1,zeros(n,n),-A4',A4';zeros(n,n),A2,A5',-A5';-A4,A5,A3,-A3';A4,-A5,-A3,A3];
    f=[-ones(2*n,1);epsilon*ones(2*n,1)];
    A = [zeros(n,2*n),eye(n),eye(n)];
    b = D*ones(n,1);
%     Aeq = [y',zeros(1,n),-ones(1,n),ones(1,n);zeros(1,n),y',ones(1,n),-ones(1,n)]; 
%     beq = zeros(2,1);
    lb = zeros(4*n,1);
    ub = [Ca*ones(n,1);Cb*ones(n,1);D*ones(2*n,1)];
    a0 = zeros(4*n,1);  % a0是解的初始近似值
    options.Algorithm='interior-point-convex';
    [a]  = quadprog(H,f,A,b,[],[],lb,ub,a0,options);
    epsilon = 1e-8;
    alpha_a=a(1:n);
    alpha_b=a(n+1:2*n);
    beta_a=a(2*n+1:3*n);
    beta_b=a(3*n+1:4*n);
    model.Wa=alpha_a.*y+beta_b-beta_a;
    model.Wb=alpha_b.*y+beta_a-beta_b;
    model.x=x;
    model.x2=x2;
    model.kerType=kerType;
    model.gamma=gamma;
%     %%%%%%%%%%%%%%%%%%%%%%%%%%
%     %first view
%     a1=a(1:n,1);
%     sv_label1 = find(abs(a1)>epsilon);  %0<a<a(max)则认为x为支持向量
%     a1 = a1(sv_label1);
%     Xsv1 = x(sv_label1,:);
%     Ysv1 = y(sv_label1);
%     svnum1 = length(sv_label1);
%     model.a1 = a1;
%     model.Xsv1 = Xsv1;
%     model.Ysv1 = Ysv1;
%     model.svnum1 = svnum1;
%     num1 = length(Ysv1);
% 
%     Wa = zeros(1,dim);
%     for i = 1:num1
%         Wa = Wa+ a1(i,1)*Ysv1(i)*Xsv1(i,:);
%     end
%     model.Wa = Wa;
%     %%%%%%%%%%%%%%%%%%%%%%%%%%
%     b1 = 0;
%     for i = 1:num1
%         tmp1 =0;
%         for j=1:num1
%             tmp1 = tmp1+a1(j,1)*Ysv1(j)*(Xsv1(j,:)*Xsv1(i,:)');
%         end
%         b1 = b1+Ysv1(i)-tmp1;
%     end
%     b1 = b1/num1;
%     %%%%%%%%%%%%%%%%%%%%%%%%%%
%     %second view
%     a2=a((n+1):2*n,1);
%     sv_label2 = find(abs(a2)>epsilon);  %0<a<a(max)则认为x为支持向量
%     a2 = a2(sv_label2);
%     Xsv2 = x2(sv_label2,:);
%     Ysv2 = y(sv_label2);
%     svnum2 = length(sv_label2);
%     model.a2 = a2;
%     model.Xsv2 = Xsv2;
%     model.Ysv2 = Ysv2;
%     model.svnum2 = svnum2;
%     num2 = length(Ysv2);
%     Wb = zeros(1,dim2);
%     for i = 1:num2
%         Wb = Wb+ a2(i,1)*Ysv2(i)*Xsv2(i,:);
%     end
%     model.Wb = Wb;
    %%%%%%%%%%%%%%%%%%%%%%%%%%
%     b2 = 0;
%     for i = 1:num2
%         tmp2 =0;
%         for j=1:num2
%             tmp2 = tmp2+a2(j,1)*Ysv2(j)*(Xsv2(j,:)*Xsv2(i,:)');
%         end
%         b2 = b2+Ysv2(i)-tmp2;
%     end
%     b2 = b2/num2;
%     tmp = a'*Ysv*kernel(Xsv,pXsv,kerType);
%     tmp = a'.*Ysv*(Xsv*pXsv');
%     b = -mean(tmp);
  
end