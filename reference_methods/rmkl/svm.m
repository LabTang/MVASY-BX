function model=svm(x1,x2,y,kerType1,kerType2,C,p1,p2)
[n,~] =size(x1);
rn=floor(n*0.9);
rng(1,'v5uniform');
rs=randperm(n);
%     x1=x1(rs,:);%??????????????????????????????????????????xx1=....
%     x2=x2(rs,:);
xx1=x1(rs,:);
xx2=x2(rs,:);
rx1=xx1(1:rn,:);
rx2=xx2(1:rn,:);

temp1=kernel(x1,rx1,kerType1,1,p1);
temp2=kernel(x2,rx2,kerType2,1,p2);
temp=0.5*(temp1+temp2);
D=diag(y);
options = optimset;    % Options??????????????????????????????
options.LargeScale = 'off';
options.Display = 'off';

H = [eye(rn),zeros(rn,n+1);
    zeros(1,rn),eye(1),zeros(1,n);
    zeros(n,rn+n+1)];
f=[zeros(rn+1,1);C*ones(n,1)];
A = [-D*temp,D*ones(n,1),-eye(n);
    zeros(n,rn+1),-eye(n)];
b = [-ones(n,1);zeros(n,1)];

lb = []; %??????Quadprog????????LB??UB
ub = [];
a0 = zeros(rn+n+1,1);
options.Algorithm='interior-point-convex';
[a]  = quadprog(H,f,A,b,[],[],lb,ub,a0,options);
v=a(1:rn);
r=a(rn+1);
model.v=v;
model.r=r;
model.rx1=rx1;
model.rx2=rx2;
model.kerType1=kerType1;
model.kerType2=kerType2;
model.p1=p1;
model.p2=p2;
end