function [modela, modelb] = mvlinex(X1,X2,Y,a,b,C1,C2,C3,rbf_sig)

%构造核矩阵
[l, l1] = size(X1);
[m, m1] = size(X2);


One = ones(1,l);


Ka = kernel(X1,X1,'linear',rbf_sig);
Kb = kernel(X2,X2,'linear',rbf_sig);


%-----------------------我们的绝对值约束-------------------------------------------------------
% cvx_begin
% 
% variable Alp(l,1)       %alpha
% variable Bet(l,1)
% variable Eta(l,1)
% 
% 
% 
% minimize(0.5 *Alp' *Ka *Alp +0.5 *gamma *Bet' *Kb *Bet + C1 * One *(exp(a .*(Y .*(Ka *Alp ) -1 )) -  a .*(Y .*(Ka *Alp ) -1 ) -1) ...
%    + C2 * One *(exp(b .*(Y .*(Kb *Bet )-1 )) -  b .*(Y .*(Kb *Bet ) -1) -1)  + One * Eta );
%  
% 
%      
% 
% subject to 
% Ka * Alp - Kb *Bet >= -Eta ;
% Ka * Alp - Kb *Bet <= Eta ;
% 0  <= Eta;
% cvx_end

%--------------------------------我们的无约束模型-----------------------------------------------
% 
% cvx_begin
% 
% variable Alp(l,1)       %alpha
% variable Bet(l,1)
% 
% % 新模型
% % minimize(0.5 *Alp' *Ka *Alp +0.5 *gamma *Bet' *Kb *Bet + C1 * (One * (exp(a .*(Y .*(Ka *Alp)-1)) - a .*(Y .*(Ka *Alp)-1) -1)) ...
% %     + C2 * (One *(exp(b .*(Y .*(Kb *Bet )-1)) - b .*(Y .*(Kb *Bet )-1) -1)) + C3 * One *(( (Y .*( Ka *Alp ) -1)-(Y .*( Kb *Bet ) - 1) ).*( (Y .*( Ka *Alp ) -1)-(Y .*( Kb *Bet ) - 1) ) ) );
% 
% 
%         
% cvx_end

%--------------------------------mvlssvm-----------------------------------------------
cvx_begin

variable Alp(l,1)       %alpha
variable Bet(l,1)



% MVLSSVM
minimize( 0.5 *Alp' *Ka *Alp +0.5  *Bet' *Kb *Bet + C1 * One *((Y .*(Ka *Alp )-1) .* (Y .*(Ka *Alp )-1) )  + C2 * One *((Y .*(Kb *Bet )-1) .* (Y .*(Kb *Bet )-1) ) + C3 * One *(( (Y .*( Ka *Alp ) -1)-(Y .*( Kb *Bet ) - 1) ).*( (Y .*( Ka *Alp ) -1)-(Y .*( Kb *Bet ) - 1) ) ));
  

  

        
cvx_end

%--------------------------------linex-svm-----------------------------------------------

% 
% cvx_begin
% 
% variable Alp(l,1)
% 
% %linex svm_non
% minimize(0.5 *Alp' *Ka *Alp + C1 * (One * (exp(a .*(Y .*(Ka *Alp)-1)) - a .*(Y .*(Ka *Alp)-1) -1))  );
% 
% 
% cvx_end

modela.w = Alp;
modela.x = X1;


modelb.w = Bet;
modelb.x = X2;



end 