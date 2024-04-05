%% Experiments for primal and dual problems for NPSVM
tic;
clear;close all;clc;
format compact;

%% datasets
name1={'Ionosphere','DataConvRes'};
path0={'/home/public/Documents/MVMK/MVdata/corel/'};
pathsave = '/home/public/Documents/MVMK/Results_rbf/';
fsave = strcat(pathsave,'svm2k_corel_rbf','.xls');

re1=[];iter_run=5;v=5;para_run=4;
for fi=1:50
    tic;
    name=num2str(fi);%name1{fi};
    disp(['The current runing dataset is ',name]);
    filename1= strcat(path0{1},name,'.mat');
    S=load(filename1);
    vv1=S.x;[m1,n1]=size(vv1);
    vv2=S.x2;[m2,n2]=size(vv2);
    label=S.y;
    DX1=[label vv1];clear vv1;
    DX2=[label vv2];clear vv2;
    rng(1,'v5uniform');
    s=randperm(m1);DX1=DX1(s,:);DX2=DX2(s,:);

    Acc=zeros(1,para_run);err=zeros(1,para_run);st=zeros(1,para_run);
    dlist=[0.05 0.5 1 3 5];
    for ic=1:para_run
        disp(['The parameter iteration is ',num2str(ic)]);
        CA=10^(ic-3);CB=CA;
        for id=1:5
            CD=dlist(id);
            for igamma=1:5
                gamma=10^(igamma-3);
                accuracy1=zeros(1,iter_run);err1=zeros(1,iter_run);
                for iter=1:iter_run
                    disp(['The crossvalidation iteration is ',num2str(iter)]);
                    [TX1,TY1,EX1,EY1]=Crossvalidation(DX1,v,iter);
                    [TX2,TY2,EX2,EY2]=Crossvalidation(DX2,v,iter);
                    [mt,nt]=size(TX1);[me,ne]=size(EX1);
                    model=svm2k(TX1,TX2,TY1,'rbf',CA,CB,CD,gamma);
                    accuracy1(iter)=predict_svm2k(model,EX1,EX2,EY1);
                end
                Acc(ic,id,igamma)=mean(accuracy1)
                st(ic,id,igamma)=std(accuracy1)
                A(ic,id,igamma).ac=accuracy1;
            end
        end
    end
    AC=max(max(max(Acc)));
    [acx,acy,acz]=ind2sub(size(Acc),find(Acc==AC,1));
    ST=st(acx,acy,acz);
    ler=A(acx,acy,acz).ac;
    toc;
    time=double(toc)/(iter_run*para_run*5*5);
    disp(['The best accuracy of ',name,' is ',num2str(AC)]);
    re1=[re1;acx AC ST time 0 ler];resu=re1';
    csvwrite(fsave,resu);
end

