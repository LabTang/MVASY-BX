%% Experiments for primal and dual problems for NPSVM
tic;
clear;close all;clc;
format compact;
rand('seed',1);
%% datasets
% path0={'C:/Users/????/Desktop/dataset200/'};
dataset = 'C:\Users\Administrator\Desktop\labtang\linex0118\linex-noisy\generate_data\view_inconsistent\'
path0={'awaperclass100_map/'};
fsave = strcat('vi_noise_NOISERMKL','.csv');

re1=[];iter_run=5;v=5;para_run=7;
for fi=1:10
    tic;
    name=num2str(fi);%name1{fi};
    %disp(['The current runing dataset is ',name]);
     filename1 = strcat(dataset,'vinoise_',string(fi*0.05),"_view1",'.mat');
     filename2 = strcat(dataset,'vinoise_',string(fi*0.05),"_view2",'.mat')
    S=load(filename1);
    S2=load(filename2);
    vv1=S.xa;[m1,n1]=size(vv1);
vv2=S2.xb;[m2,n2]=size(vv2);

    vv1=mapminmax(vv1',0,1);vv2=mapminmax(vv2',0,1);
    data1=vv1';data2=vv2';
    label=S.y;
    DX1=[label data1];clear vv1;
DX2=[label data2];clear vv1;
    rng(1,'v5uniform');
    s=randperm(m1);DX1=DX1(s,:); DX2=DX2(s,:);    
plist=[0.8,0.9,1.0,1.1,1.2];
cc = size(plist,2)
    for ic=para_run
        disp(['The parameter iteration is ',num2str(ic)]);
        C=10^(ic-4);
            for ip1=1:cc
                p1=plist(ip1);
                accuracy=zeros(1,iter_run);F=zeros(1,iter_run);
                for iter=1:iter_run
                    disp(['The crossvalidation iteration is ',num2str(iter)]);
                    [TX1,TY1,EX1,EY1]=Crossvalidation(DX1,v,iter);
                    [TX2,TY2,EX2,EY2]=Crossvalidation(DX2,v,iter);
                    model=svm(TX1,TX2,TY1,'poly','linear',C,p1,1);
                    [accuracy(iter),F(iter)]=predict_svm(model,EX1,EX2,EY1);
                end
             Acc(ic,ip1)=mean(accuracy);
                sta(ic,ip1)=std(accuracy);
                F1(ic,ip1)=mean(F);
                stf(ic,ip1)=std(F);
            end
    end
    Acc
    AC=max(max(Acc));
    [acx1,acy1]=find(Acc==AC,1);
    STA=sta(acx1,acy1);
    FS=max(max(F1));
    [acx2,acy2]=find(F1==FS,1);
    STF=stf(acx2,acy2);

    toc;
    time=double(toc)/(iter_run*para_run*5);
    disp(['The best accuracy of ',name,' is ',num2str(AC)]);
    re1=[re1;acx1 acy1 AC STA acx2 acy2 FS STF time];resu=re1';
    csvwrite(fsave,resu);
end


