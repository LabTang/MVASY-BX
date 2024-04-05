clear
dataset = 'C:\Users\Administrator\Desktop\labtang\linex0118\corel_noise/'
addpath ../mcpsvm_rbf_corel/;

save(['0#',datestr(now,30),'.mat'],'');
for fi =0.05:0.05:0.5
    out=svmGridCrossmcpk(fi,strcat(dataset,"corel_3_",string(fi),'.mat'),strcat(dataset,"corel_3_",string(fi),'.mat'));
    save(strcat(num2str(fi),"_corelnoise3",'.mat'),'out');
    clear out;
end
cd ..

% clear
% path = 'C:\Users\tjj\Desktop\dataset_map\corel_map\';
% addpath ..\psvm2v_rbf_dadb1\;
% pathsave = '.\results\'; 
% fsave = strcat(pathsave,'rbf_corel_dadb1','.xls');
% %save(['0#',datestr(now,30),'.mat'],'');
% for i=1:50
%     out=svmGridCross([path,num2str(i),'.mat']);
% %     save([num2str(i),'#',datestr(now,30),'.mat'],'out');
% %     clear out;
%     result(i,:) = out;
%     xlswrite(fsave,result,1,'B2');
%     clear out;
% end
% cd ..