function [modela, modelb,r1,r2] = mvlinex(train_x1,train_x2,train_target,c,a,b,d,lambda)
learn_rate=0.0005;
r1 = 0.5;
r2 = 0.5;
times = 200;
[n1,k1] = size(train_x1);
[n2,k2] = size(train_x2);
wa = zeros(k1,1);
wb = zeros(k2,1);
    count=0;
for admm = 1:2
    batch = round(n1/5);
    for time =1:500
        grad_xa=zeros(k1,1);
        grad_xa2=zeros(k1,1);
        RANDOM = randperm(n1,batch);
        xa = train_x1(RANDOM,:);
        xb = train_x2(RANDOM,:);
        isnanxa = isnan(xa);
        isnanxb = isnan(xb);
        for random = RANDOM
            i_xa = train_x1(random,:);
            i_xb = train_x2(random,:);
            i_y = train_target(random,:);
            cesi_a = (i_y *(i_xa*wa))-1;
            cesi_b = (i_y *(i_xb*wb))-1;
            linex_a = exp(a*(cesi_a+cesi_b))-a*(cesi_a+cesi_b)-1;
            blinex_a = b/(1+b*linex_a)/(1+b*linex_a);
            linex_a_derivative=exp(a*(cesi_a+cesi_b))-1;
            for dimension =1:k1
                
                grad_xa(dimension)=grad_xa(dimension)+a*i_y*i_xa(dimension)*linex_a_derivative*blinex_a;
                grad_xa2(dimension)= grad_xa2(dimension)+2*i_y*i_xa(dimension)*(cesi_a-cesi_b);
            end
        end
        for dimension =1:k1
            grad_xa(dimension)=r1*wa(dimension)+c*grad_xa(dimension)/batch+d*grad_xa2(dimension)/batch;
        end
        for dimension =1:k1
            wa(dimension) = wa(dimension)-grad_xa(dimension)*learn_rate;
        end
        %%%%%%%%%
        grad_xb=zeros(k2,1);
        grad_xb2=zeros(k2,1);
        RANDOM = randperm(n2,batch);
        for random = RANDOM
             i_xa = train_x1(random,:);
            i_xb = train_x2(random,:);
            i_y = train_target(random,:);
            cesi_a = (i_y *(i_xa*wa))-1;
            cesi_b = (i_y *(i_xb*wb))-1;
            linex_a = exp(a*(cesi_a+cesi_b))-a*(cesi_a+cesi_b)-1;
            blinex_a = b/(1+b*linex_a)/(1+b*linex_a);
            linex_a_derivative=exp(a*(cesi_a+cesi_b))-1;
            for dimension =1:k2
                grad_xb(dimension)=grad_xb(dimension)+a*i_y*i_xb(dimension)*linex_a_derivative*blinex_a;
                grad_xb2(dimension)= grad_xb2(dimension)+2*i_y*i_xb(dimension)*(cesi_b-cesi_a);
            end
        end
        for dimension =1:k2
            grad_xb(dimension)=r2*wb(dimension)+c*grad_xb(dimension)/batch+d*grad_xb2(dimension)/batch;
            
        end
        grad_xb;
        r2;
        batch;
        grad_xb2;
        no = isnan(grad_xb);

        %sum(no(:))
        for dimension =1:k2
            
            wb(dimension) = wb(dimension)-grad_xb(dimension)*learn_rate;
        end
        wb;
    end

    f1 = fanshu(wa);
    f2 = fanshu(wb);
    cvx_clear;
    cvx_begin quiet;
    variable Theta1(1,1)
    variable Theta2(1,1)
    nan1 = isnan(f1);
    nan2 = isnan(f2);

    if nan1(1) == 1
        f1=1;
    end
    if nan2(1) ==1
        f2=1;
    end
    minimize( 0.5*Theta1 *f1 + 0.5*Theta2* f2  + 0.5 *lambda *Theta1*Theta1 + 0.5 *lambda *Theta2*Theta2 );
    subject to
    0 <= Theta1;
    0 <= Theta2;
    Theta1 + Theta2 == 1;
    cvx_end 
    nan3 = isnan(Theta1);
    nan4 = isnan(Theta2);
   if nan3(1) ==1
        Theta1=0.5
        Theta2=0.5
   end
    if nan4(1) ==1
        Theta1=0.5
        Theta2=0.5
    end
count=count+1;
    r1 = Theta1;
    r2 = Theta2;
    modela = wa;
    modelb=wb;

    
% a
% c
% d
% lambda
end
