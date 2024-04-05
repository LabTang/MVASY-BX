%QP实现svm+  5折交叉验证，输入【y,x】训练集，输出5折的准确率;
clear;
load ionosphere;
x=mapminmax(X1,0,1);
x2=mapminmax(X2,0,1);
data=x;
data2=x2;
for t=1:10
[M,N]=size(data);%数据集为一个M*N的矩阵，其中每一行代表一个样本
indices=crossvalind('Kfold',data(1:M,N),5);%进行随机分包
for k=1:5%交叉验证k=10，10个包轮流作为测试集
    test = (indices == k); %获得test集元素在数据集中对应的单元编号
    train = ~test;%train集元素的编号为非test元素的编号
    train_data=data(train,:);%从数据集中划分出train样本的数据
    train_data2=data2(train,:);%从数据集中划分出train样本的数据
    train_target=y(train,:);%获得样本集的测试目标，在本例中是实际分类情况
    test_data=data(test,:);%test样本集
    test_data2=data2(test,:);%test样本集
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