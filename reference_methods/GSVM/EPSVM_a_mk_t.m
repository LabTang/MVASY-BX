
function[ac,ac1,ac2]=EPSVM_a_mk_t(testX1,testX2,testY,A1,B1,A2,B2,N,M,mu,delta,nu) %multi-view with nonliner kernel classifier

n=N;

%----multiplane nonliner kernel classifier
    a=size(A1,1); %number of points in A;
    b=size(B1,1); %number of points in B
    C1=[A1;B1]; C2=[A2;B2];
    %flag='qz';
    %view 1
    K1_ac=exp(-mu*dist2(A1,C1));
    K1_bc=exp(-mu*dist2(B1,C1));
    G1=[K1_ac,ones(a,1)]'*[K1_ac,ones(a,1)];
    H1=[K1_bc,ones(b,1)]'*[K1_bc,ones(b,1)];
    MA1=[K1_ac,ones(a,1)];
    MB1=[K1_bc,ones(b,1)];
    %view2 
    K2_ac=exp(-mu*dist2(A2,C2));
    K2_bc=exp(-mu*dist2(B2,C2));
    G2=[K2_ac,ones(a,1)]'*[K2_ac,ones(a,1)];
    H2=[K2_bc,ones(b,1)]'*[K2_bc,ones(b,1)];
    MA2=[K2_ac,ones(a,1)];
    MB2=[K2_bc,ones(b,1)];
%---------------------------------------------------    

%     [v1,d1]=eig((1+delta)*G1-nu*H1);
%     c=min(diag(d1));
%     [v2,d2]=eig((1+delta)*G2-nu*H2);
%     d=min(diag(d2));
    %plane1
    K1=[(1+delta)*G1-nu*H1,-delta*MA1'*MA2;-delta*MA2'*MA1,(1+delta)*G2-nu*H2];
    K1=(K1'+K1)/2;
    [V1,D1]=eig(K1);   %plane1
   
    eigenvalue1_min=min(diag(D1)) %smallest eigenvalues
    order1_min= find(eigenvalue1_min==diag(D1));
    eigenvector1_min=V1(:,order1_min(1));
    
    w11=eigenvector1_min(1:n);  %plane 1 view
    gama11=eigenvector1_min(n+1);
    w12=eigenvector1_min(n+2:n+1+n);%plane1 view2
    gama12=eigenvector1_min(n+1+n+1);

%----------------------------------------------------
    %plane2
    K2=[(1+delta)*H1-nu*G1,-delta*MB1'*MB2;-delta*MB2'*MB1,(1+delta)*H2-nu*G2];
   
    K2=(K2'+K2)/2;
    [V2,D2]=eig(K2);  %plane2
    
    eigenvalue2_min=min(diag(D2)) % smallest eigenvalues
    order2_min= find(diag(D2)==eigenvalue2_min);
    eigenvector2_min=V2(:,order2_min(1));
    
    w21=eigenvector2_min(1:n);  %plane 2 view1
    gama21=eigenvector2_min(n+1);
    w22=eigenvector2_min(n+2:n+1+n);   %plane 2 view2
    gama22=eigenvector2_min(n+1+n+1);
%-------------------------------------------------------    
   %test
    K1_tc=exp(-mu*dist2(testX1,C1)); %Gaussian kernel view1
    K1_cc=exp(-mu*dist2(C1,C1));
    
    K2_tc=exp(-mu*dist2(testX2,C2)); %view2
    K2_cc=exp(-mu*dist2(C2,C2));
    
    fdsatop11=K1_tc*w11+gama11.*ones(M,1);   %function distances to plane1 with view1
    fdsatop12=K2_tc*w12+gama12.*ones(M,1);    %function distances to plane1 with view2
     
     fdsatop21=K1_tc*w21+gama21.*ones(M,1); %function distances to plane2 with view1
     fdsatop22=K2_tc*w22+gama22.*ones(M,1); %function distances to plane2 with view2
     
     dist11=abs(fdsatop11)./sqrt(w11'*K1_cc*w11);
     dist12=abs(fdsatop12)./sqrt(w12'*K2_cc*w12); % sum distance of point to plane1; 
     dist21=abs(fdsatop21)./sqrt(w21'*K1_cc*w21);
     dist22=abs(fdsatop22)./sqrt(w22'*K2_cc*w22); % sum distance of point to plane2;
     
     distances_subtract=dist11+dist12-dist21-dist22;
     %--------------------------------view 1
     dist_sub1=dist11-dist21;
     yest1(dist_sub1<=0)=1;
     yest1(dist_sub1>0)=-1;
     confuse1(:,:) = confusionmat(testY,yest1);   %# confusion matrix
     ac1= sum(diag(confuse1(:,:)))/sum(sum(confuse1(:,:))); % accrute
     
      %--------------------------------view 2
     dist_sub2=dist12-dist22;
     yest2(dist_sub2<=0)=1;
     yest2(dist_sub2>0)=-1;
     confuse2(:,:) = confusionmat(testY,yest2);   %# confusion matrix
     ac2= sum(diag(confuse2(:,:)))/sum(sum(confuse2(:,:))); % accrute
    %---------
    yest(distances_subtract<=0)=1;
    yest(distances_subtract>0)=-1;
    confuse(:,:) = confusionmat(testY,yest);   %# confusion matrix
    ac= sum(diag(confuse(:,:)))/sum(sum(confuse(:,:))); % accrute
end