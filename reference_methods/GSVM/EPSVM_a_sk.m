
function[ac]=EPSVM_a_sk(testX,testY,A,B,N,M,mu,delta,nu) % single view with nonliner kernel classifier         

    a=size(A,1); %number of points in A;
    b=size(B,1); %number of points in B
%----multiplane nonliner kernel classifier
    C=[A;B];
   
    %flag='qz';
    K_ac=exp(-mu*dist2(A,C));
    K_bc=exp(-mu*dist2(B,C));
    G=[K_ac,ones(a,1)]'*[K_ac,ones(a,1)];
    H=[K_bc,ones(b,1)]'*[K_bc,ones(b,1)];
    K1=G-nu*H;
    [V1,D1]=eig((K1'+K1)/2);   %plane1
    eigenvalue1_min=min(diag(D1)) %smallest eigenvalues
    order1_min= find(diag(D1)==eigenvalue1_min);
    eigenvector1_min=V1(:,order1_min(1));
    
    L=[K_bc,ones(b,1)]'*[K_bc,ones(b,1)];
    S=[K_ac,ones(a,1)]'*[K_ac,ones(a,1)];
    K2=L-nu*S;
    [V2,D2]=eig((K2'+K2)/2);  %plane2
    
    eigenvalue2_min=min(diag(D2)) % smallest eigenvalues
    order2_min= find(diag(D2)==eigenvalue2_min);
    eigenvector2_min=V2(:,order2_min(1));
    %---test 
    u1=eigenvector1_min(1:end-1);  %plane 1
    gamma1=eigenvector1_min(end);
    
    u2=eigenvector2_min(1:end-1);  %plane 2
    gamma2=eigenvector2_min(end);
    
    K_tc=exp(-mu*dist2(testX,C)); %Gaussian kernel
    K_cc=exp(-mu*dist2(C,C));
    
    f_distances_to_plane1=K_tc*u1+gamma1.*ones(M,1);  %function distance to plane1 plane2
    f_distances_to_plane2=K_tc*u2+gamma2.*ones(M,1);  
    
    distances_to_plane1=abs(f_distances_to_plane1 ./ sqrt(u1'*K_cc*u1)); % distance to plane1 plane2
    distances_to_plane2=abs(f_distances_to_plane2 ./ sqrt(u2'*K_cc*u2));
    
    distances_subtract=distances_to_plane1-distances_to_plane2;
    
    %---predict
    yest(distances_subtract<=0)=1;
    yest(distances_subtract>0)=-1;
    confuse(:,:) = confusionmat(testY,yest);   %# confusion matrix
    ac= sum(diag(confuse(:,:)))/sum(sum(confuse(:,:))); % accrute
end