clear
path = '/Users/tjj/Downloads/allpaper/IS_MCPK/mcpsvm_dataset/digit/';
addpath ../mcpsvm_rbf_corel/;

save(['0#',datestr(now,30),'.mat'],'');
for i=1:1
    out=svmGridCrossmcpk([path,num2str(i),'.mat']);
    save([num2str(i),'$',datestr(now,30),'.mat'],'out');
    clear out;
end
cd ..