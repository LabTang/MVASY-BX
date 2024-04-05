clear clc
dataset = 'C:\Users\Administrator\Desktop\labtang\linex0118\linex-noisy\generate_data\view_inconsistent\'
for fi=1:10
    tic;
    fi
    name=num2str(fi);%name1{fi}
    disp(['The current runing dataset is ',name]);


     filename1 = strcat(dataset,'vinoise_',string(fi*0.05),"_view1",'.mat');
     filename2 = strcat(dataset,'vinoise_',string(fi*0.05),"_view2",'.mat');
     a_out = strcat(dataset,'vinoise_',string(fi*0.05),"_view1",'.csv')
     b_out = strcat(dataset,'vinoise_',string(fi*0.05),"_view2",'.csv');
    data1 = load(filename1);
    data2 = load(filename2);
    csvwrite(a_out,[data1.y,data1.xa]);
    csvwrite(b_out,[data2.y,data2.xb]);
end