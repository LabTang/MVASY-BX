
function[ac]=EPSVM_a_sl(testX,testY,A,B,N,M,mu,delta,nu)  %single view with liner classifier

    a=size(A,1); %number of points in A;
    b=size(B,1); %number of points in B
    d=size(A,2);
%-----multiplane liner kernel classifier
    G=[A,ones(a,1)]'*[A,ones(a,1)];
    H=[B,ones(b,1)]'*[B,ones(b,1)];
    [V1,D1] = eig(G-nu*H) ;  %plane1
    eigenvalue1_min=min(diag(D1)) %smallest eigenvalues
    order1_min= find(diag(D1)==eigenvalue1_min);
    eigenvector1_min=V1(:,order1_min(1));
    w1=eigenvector1_min(1:d);  
    gama1=eigenvector1_min(end);
    
    
    L=[B,ones(b,1)]'*[B,ones(b,1)];
    S=[A,ones(a,1)]'*[A,ones(a,1)];
    L=(L+L')/2;
    S=(S+S')/2;
    [V2,D2] = eig(L-nu*S) ; %plane2
    eigenvalue2_min=min(diag(D2)) % smallest eigenvalues
    order2_min= find(diag(D2)==eigenvalue2_min);
    eigenvector2_min=V2(:,order2_min(1));
    w2=eigenvector2_min(1:d);  %plane 2 view1
    gama2=eigenvector2_min(end);
    
    fdsatop1=testX*w1+gama1.*ones(M,1);   %function distances to plane1 with view
     
    fdsatop2=testX*w2+gama2.*ones(M,1); %function distances to plane2 with view
     
    distances_to_plane1=abs(fdsatop1)/norm(w1); %  distance of point to plane1; 
    distances_to_plane2=abs(fdsatop2)/norm(w2); % distance of point to plane2;
     
    distances_subtract=distances_to_plane1-distances_to_plane2;
%----multiplane nonliner kernel classifier
%     C=[A;B];
%    
%     flag='chol';
%     %flag='qz';
%     K_ac=GassKer(A,C',mu);
%     K_bc=GassKer(B,C',mu);
%     G=[K_ac,ones(a,1)]'*[K_ac,ones(a,1)]+delta*eye(N+1);
%     H=[K_bc,ones(b,1)]'*[K_bc,ones(b,1)];
%     G=(G+G')/2;
%     H=(H+H')/2;
%     
%     [V1,D1]=eig(G,H,flag);   %plane1
%     eigenvalue1_min=min(diag(D1)) %smallest eigenvalues
%     order1_min= find(diag(D1)==eigenvalue1_min);
%     eigenvector1_min=V1(:,order1_min(1));
%     
%     L=[K_bc,ones(b,1)]'*[K_bc,ones(b,1)]+delta*eye(N+1);
%     S=[K_ac,ones(a,1)]'*[K_ac,ones(a,1)];
%     L=(L+L')/2;
%     S=(S+S')/2;
%     [V2,D2]=eig(L,S,flag);  %plane2
%     
%     eigenvalue2_min=min(diag(D2)) % smallest eigenvalues
%     order2_min= find(diag(D2)==eigenvalue2_min);
%     eigenvector2_min=V2(:,order2_min(1));
%     %---test 
%     u1=eigenvector1_min(1:end-1);  %plane 1
%     gamma1=eigenvector1_min(end);
%     
%     u2=eigenvector2_min(1:end-1);  %plane 2
%     gamma2=eigenvector2_min(end);
%     
%     K_tc=GassKer(testX,C',mu); %Gaussian kernel
%     K_cc=GassKer(C,C',mu);
%     
%     f_distances_to_plane1=K_tc*u1+gamma1.*ones(M,1);  %function distance to plane1 plane2
%     f_distances_to_plane2=K_tc*u2+gamma2.*ones(M,1);  
%     
%     distances_to_plane1=abs(f_distances_to_plane1 ./ sqrt(u1'*K_cc*u1)); % distance to plane1 plane2
%     distances_to_plane2=abs(f_distances_to_plane2 ./ sqrt(u2'*K_cc*u2));
%     
%     distances_subtract=distances_to_plane1-distances_to_plane2;
%     
    %---predict
    yest(distances_subtract<=0)=1;
    yest(distances_subtract>0)=-1;
    confuse(:,:) = confusionmat(testY,yest);   %# confusion matrix
    ac= sum(diag(confuse(:,:)))/sum(sum(confuse(:,:))); % accrute
end