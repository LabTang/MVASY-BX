clc;
clear
dataset = 'C:\Users\Administrator\Desktop\labtang\linex0118\corel_noise/'
%strcat(dataset,'*.mat')
%path = dir(strcat(dataset,'*.mat'))
%file_name={path.name};
%len = length(file_name);
resultarr = [];

pathsave = './'; 
fsave = strcat(pathsave,'noisy_corel3n','.csv');


for i =0.05:0.05:0.5 
    filename1 = strcat(dataset,"corel_3_",string(i),'.mat');
    filename2 = strcat(dataset,'vinoise_',string(i*0.05),"_view2",'.mat');
    data1 = load(filename1);
    data2 = load(filename1);
%     RandIndex = randperm( length( data ) ); 
%     data = data( RandIndex );
    
    [max_acc,std,max_acc3,std3]=ACC_MVLSSVM(data1,data2);
    'result'
    result = [i,max_acc,std,max_acc3,std3]
    resultarr = [resultarr;result]
    csvwrite(fsave,resultarr);
    
end