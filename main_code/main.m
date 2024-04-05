
dataset = 'C:\Users\Administrator\Desktop\labtang\2018smc\awaperclass100_map/'
path = dir(strcat(dataset,'*.mat'))
file_name={path.name};
len = length(file_name);
original_resultarr = []; 
max_resultarr = {};
pathsave = './'; 
fsave0 = strcat(pathsave,'awa_ori_final2-45','.csv');
fsave1 = strcat(pathsave,'awa_max_final2-45','.csv');

for i =2:45
    t1 = clock();
    i
    filename1 = strcat(dataset,'c',string(i),'.mat');
    data = load(filename1);
    [original_result,max_result]=find_para(data,i); 
    max_result;
    t2 = clock();
    'result'
    %title = ['ÐòºÅ','acc1','std1','acc2','std2','acc3','std3','max_acc','mac_std'];
    t = etime(t2,t1)
%     original_result=[original_result,t];
   % max_result=[max_result,t];
    original_resultarr = [original_resultarr;original_result];
    max_resultarr = [max_resultarr;max_result]
    t = table(max_resultarr);
    csvwrite(fsave0,original_resultarr,1,1);
    writetable(t,fsave1);
    %csvwrite(fsave1,max_resultarr,1,1);
    
end