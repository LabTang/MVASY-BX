%% Experiments for primal and dual problems for NPSVM
tic;
clear;close all;clc;
format compact;

%% datasets
name1={'Ionosphere','DataConvRes'};
%path0={'/home/public/Documents/MVMK/MVdata/corel/'};
%pathsave = '/home/public/Documents/MVMK/Results/';
fsave = strcat('svm2k_noisy_corel2','.csv');
dataset = 'C:\Users\Administrator\Desktop\labtang\linex0118\corel_noise/'
re1=[];iter_run=5;v=5;para_run=4;
for fi =0.05:0.05:0.5
    tic;
    filename1 = strcat(dataset,"corel_2_",string(fi),'.mat');
    data1 = load(filename1)
     %filename2 = strcat(dataset,'vinoise_',string(fi*0.05),"_view2",'.mat');
    %data2 = load(filename2);
    name=num2str(fi);%name1{fi};
    disp(['The current runing dataset is ',name]);
   % filename1= strcat(path0{1},name,'.mat');
    %S=load(filename1);
    vv1=data1.x1;[m1,n1]=size(vv1);
    vv2=data1.x2;[m2,n2]=size(vv2);
    label=data1.y;
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
            accuracy1=zeros(1,iter_run);err1=zeros(1,iter_run);
        for iter=1:iter_run
            disp(['The crossvalidation iteration is ',num2str(iter)]);            
            [TX1,TY1,EX1,EY1]=Crossvalidation(DX1,v,iter);
            [TX2,TY2,EX2,EY2]=Crossvalidation(DX2,v,iter);
            [mt,nt]=size(TX1);[me,ne]=size(EX1);
            model=svm2k(TX1,TX2,TY1,'linear',CA,CB,CD,0.1);
            accuracy1(iter)=predict_svm2k(model,EX1,EX2,EY1);
        end
        Acc(ic,id)=mean(accuracy1)
        st(ic,id)=std(accuracy1)
        A(ic,id).ac=accuracy1;
        end
    end
    AC=max(max(Acc));
    [acx,acy]=find(Acc==AC,1);
    ST=st(acx,acy);
    ler=A(acx,acy).ac;
    toc;
    time=double(toc)/(iter_run*para_run*5);
    disp(['The best accuracy of ',name,' is ',num2str(AC)]);
    re1=[re1;acx AC ST time 0 ler];resu=re1';
    csvwrite(fsave,resu);
end

