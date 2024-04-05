clear
n=50;
dataset='mcpk_result_rbf';
fname=['/Users/tjj/Downloads/allpaper/IS_MCPK/mcpsvm_code/mcpsvm_rbf_corel'];
cd (fname);
for i=1:n
    filename=[num2str(i),'$*.mat'];
    output=dir(filename);
    dataname=output.name;
    load (dataname);
    col=['A',num2str(i)];
    colL=['J',num2str(i)];
%     xlswrite(['.\',dataset,'.xls'],[resu(3,:)],'sheet1',col);
%     xlswrite(['.\',dataset,'.xls'],[resu(4,:)],'sheet1',colL);
    
%     xlswrite(['.\',dataset,'.xls'],[out.Max_acc1,out.Max_acc2,out.Max_acc3,out.Max_acc4,out.Max_acc5,out.Max_acc6,out.Max_acc7],'sheet1',col);
%     xlswrite(['.\',dataset,'.xls'],[out.Std_acc1,out.Std_acc2,out.Std_acc3,out.Std_acc4,out.Std_acc5,out.Std_acc6,out.Std_acc7],'sheet1',colL);
    acc(i)=resu(2,:);
    std(i)=resu(3,:);


end
    result(:,1)=acc';
    result(:,2)=std';