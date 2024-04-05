function model = svmtest(x,y)
%SVM0311  解决2分类的SVM方法，优化使用matlab优化工具箱quadprog函数实现
%by LiFeiteng     email:lifeiteng0422@gmail.com
%Reference: stptool
%           Pattern Recognition and Machine Learning P333 7.32-7.37

% input aruments
%-------------------------------------------
tic

% % data=c2s(data);
[dim,num_data]=size(x');
options.C=1;
options.mu = 1e-12;
options.eps = 1e-12;
X = x';
data.X=x';
data.y=y';
t = y';
t(t==2) = -1;

% Set up QP task
%----------------------------
K = X'*X;
T = t'*t;% 注意t是横向量
H = K.*T;
disp(size(H));
% save('H0311.mat','H')
H = H + options.mu*eye(size(H));

f = -ones(num_data,1);
Aeq = t;
beq = 0;
lb = zeros(num_data,1);
ub = options.C*ones(num_data,1);

x0 = zeros(num_data,1);
qp_options = optimset('Display','off');
[Alpha,fval,exitflag] = quadprog(H, f,[],[], Aeq, beq, lb, ub, x0, qp_options);

inx_sv = find(Alpha>options.eps);

% compute bias
%--------------------------
% take boundary (f(x)=+/-1) support vectors 0 < Alpha < C
b = 0;
inx_bound = find( Alpha > options.eps & Alpha < (options.C - options.eps));
Nm = length(inx_bound);
for n = 1:Nm
    tmp = 0;
    for m = 1:length(inx_sv) %PRML7.37
        tmp = tmp+Alpha(inx_sv(m))*t(inx_sv(m))*K(inx_bound(n),inx_sv(m));
    end
    b = b + t(inx_bound(n))-tmp;
end
b = b/Nm;
model.b = b;   
    
%-----------------------------------------
w = zeros(dim,1);
for i = 1:num_data   
    w = w+ Alpha(i)*t(i)*X(:,i);%PRML 7.29
end

margin = 1/norm(w);
%-------------------------------------------
%此处与stprtool保持接口一致  用于画图展示等
model.Alpha = Alpha( inx_sv );
model.sv.X = data.X(:,inx_sv );
model.sv.y = data.y(inx_sv );
model.sv.inx = inx_sv;
model.nsv = length( inx_sv );
model.margin = margin;
model.exitflag = exitflag;
model.options = options;
model.kercnt = num_data*(num_data+1)/2;
model.fun = 'svmclass';

model.W = model.sv.X*model.Alpha;

% used CPU time
model.cputime=toc;

return;
