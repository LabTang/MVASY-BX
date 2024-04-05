clear
path = 'C:\Users\Administrator\Desktop\data/';
addpath ../mcpsvm_rbf_corel/;

save(['0#',datestr(now,30),'.mat'],'');
for i=0:6
    out=svmGridCrossmcpk(i,strcat(path,'data_line_',string(i*0.05),'.mat'),strcat(path,'data_moon_',string(i*0.05),'.mat'));
    save(strcat(num2str(i),'.mat'),'out');
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