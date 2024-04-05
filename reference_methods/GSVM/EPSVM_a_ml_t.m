
function[ac ac1 ac2]=EPSVM_a_ml_t(testX1,testX2,testY,A1,B1,A2,B2,N,M,mu,delta,nu) %multi-view with liner classifier
    [M,~]=size(testX1)
    [a,d1]=size(A1); %number of points in A1;
    b=size(B1,1); %number of points in B1
    d2=size(A2,2);  
    
%-----multiplane liner kernel classifier 
   
    G1=[A1,ones(a,1)]'*[A1,ones(a,1)];
    H1=[B1,ones(b,1)]'*[B1,ones(b,1)];
    MA1=[A1,ones(a,1)];
    MB1=[B1,ones(b,1)];
    
    G2=[A2,ones(a,1)]'*[A2,ones(a,1)];
    H2=[B2,ones(b,1)]'*[B2,ones(b,1)];
    MA2=[A2,ones(a,1)];
    MB2=[B2,ones(b,1)];
    
    K1=[(1+delta)*G1-nu*H1,-delta*MA1'*MA2;-delta*MA2'*MA1,(1+delta)*G2-nu*H2];
    
    K1=(K1'+K1)/2;
    size(testX1)
    
    [V1,D1] = eig(K1) ;  %plane1
    eigenvalue1_min=min(diag(D1)); %smallest eigenvalues
    order1_min= find(diag(D1)==eigenvalue1_min);
    eigenvector1_min=V1(:,order1_min(1));
    
    w11=eigenvector1_min(1:d1);  %plane 1 view
    gama11=eigenvector1_min(d1+1);
    size(w11)
    w12=eigenvector1_min(d1+2:d1+1+d2);%plane1 view2
    gama12=eigenvector1_min(d1+1+d2+1);
    
%     [V1,D1] = eig(K1,T1,flag) ;  %plane1
%     vect1=diag(D1);
%     eigenvalue11_min=min(vect1(1:d1+1)) %smallest eigenvalues
%     order11_min= find(diag(D1)==eigenvalue11_min);
%     eigenvector11_min=V1(:,order11_min(1));
%     
%     w11=eigenvector11_min(1:d1);  %plane 1 view1
%     gama11=eigenvector11_min(d1+1);
%     
%     eigenvalue12_min=min(vect1(d1+2:end)) %smallest eigenvalues
%     order12_min= find(diag(D1)==eigenvalue12_min);
%     eigenvector12_min=V1(:,order12_min(1));
%     
%     w12=eigenvector12_min(d1+2:end-1);  %plane 1 view2
%     gama12=eigenvector12_min(end);
    
    K2=[(1+delta)*H1-nu*G1,-delta*MB1'*MB2;-delta*MB2'*MB1,(1+delta)*H2-nu*G2];
    K2=(K2'+K2)/2;
    
    [V2,D2] = eig(K2) ; %plane2
    eigenvalue2_min=min(diag(D2)); % smallest eigenvalues
    order2_min= find(diag(D2)==eigenvalue2_min);
    eigenvector2_min=V2(:,order2_min(1));
    
    w21=eigenvector2_min(1:d1);  %plane 2 view1
    gama21=eigenvector2_min(d1+1);
    w22=eigenvector2_min(d1+2:d1+1+d2);   %plane 2 view2
    gama22=eigenvector2_min(d1+1+d2+1);
    
    
     fdsatop11=testX1*w11+gama11.*ones(M,1);   %function distances to plane1 with view1
     fdsatop12=testX2*w12+gama12.*ones(M,1);    %function distances to plane1 with view2
    
     fdsatop21=testX1*w21+gama21.*ones(M,1); %function distances to plane2 with view1
     fdsatop22=testX2*w22+gama22.*ones(M,1); %function distances to plane2 with view2
     
 %  multi-view predict    
     dist11=abs(fdsatop11)/norm(w11);
     dist12=abs(fdsatop12)/norm(w12);
     dist21=abs(fdsatop21)/norm(w21);
     dist22=abs(fdsatop22)/norm(w22);

       
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



