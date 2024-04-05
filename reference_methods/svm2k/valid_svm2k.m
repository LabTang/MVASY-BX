%QPʵ��svm+  5�۽�����֤�����롾y,x��ѵ���������5�۵�׼ȷ��;
clear;
load ionosphere;
x=mapminmax(X1,0,1);
x2=mapminmax(X2,0,1);
data=x;
data2=x2;
for t=1:10
[M,N]=size(data);%���ݼ�Ϊһ��M*N�ľ�������ÿһ�д���һ������
indices=crossvalind('Kfold',data(1:M,N),5);%��������ְ�
for k=1:5%������֤k=10��10����������Ϊ���Լ�
    test = (indices == k); %���test��Ԫ�������ݼ��ж�Ӧ�ĵ�Ԫ���
    train = ~test;%train��Ԫ�صı��Ϊ��testԪ�صı��
    train_data=data(train,:);%�����ݼ��л��ֳ�train����������
    train_data2=data2(train,:);%�����ݼ��л��ֳ�train����������
    train_target=y(train,:);%����������Ĳ���Ŀ�꣬�ڱ�������ʵ�ʷ������
    test_data=data(test,:);%test������
    test_data2=data2(test,:);%test������
    test_target=y(test,:);
    model=svm2k(train_data,train_data2,train_target,'rbf',1,1,1,1);
    accuracy(k)=predict_svm2k(model,test_data,test_data2,test_target);
%     model=svmtrain(train_target,train_data,'-t 0 -q');
%     [~,accuracy,~]=svmpredict(test_target,test_data,model,'-q');
%     disp(accuracy);
end
accuracy2(t)=mean(accuracy);
end
fprintf('%.4f\t%.4f\n',mean(accuracy2),std(accuracy,1));