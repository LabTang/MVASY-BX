function model=train_svm(x,y,kerType,C,gamma)
%x����������y��������
%�Ƚ�yתΪ������
    y=y';
    [n,dim] = size(x);
    options = optimset;    % Options�����������㷨��ѡ�����������
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
    a0 = zeros(n,1);  % a0�ǽ�ĳ�ʼ����ֵ
%     H=H+1e-10*eye(size(H));
%   [a,fval,eXitflag,output,lambda]  = quadprog(H,f,A,b,Aeq,beq,lb,ub,a0,options);
    [a]  = quadprog(H,f,A,b,Aeq,beq,lb,ub,a0,options);
    epsilon = 1e-10; 
    sv_label = find(abs(a)>epsilon);  %0<a<a(max)����ΪxΪ֧������
    a = a(sv_label);
    Xsv = x(sv_label,:);
    Ysv = y(sv_label);
    svnum = length(sv_label);
    model.Xsv = Xsv;
    model.Ysv = Ysv;
    model.kerType=kerType;
    model.gamma=gamma;
    model.svnum = svnum;
    num = length(Ysv);
     
    model.a=a;
    W = zeros(1,dim);
%     for i = 1:num
%         W = W+ a(i,1)*Ysv(i)*Xsv(i,:);
%  
%     model.W = W;
%     end

    b = 0;
    for i = 1:num
        tmp =0;
        for j=1:num
            tmp = tmp+a(j,1)*Ysv(j)*kernel(Xsv(j,:),Xsv(i,:),kerType,gamma);
%             ;
%         tmp = tmp+a(j,1)*Ysv(j)*Xsv(j,:)*Xsv(i,:)';
        end
        b = b+Ysv(i)-tmp;
    end
    b = b/num;
    model.b = b;
end