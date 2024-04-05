    

path0 = 'C:\Users\Administrator\Desktop\data/vi/';
%path0 = './awaperclass100_map/';
datasetnums = 10;
resultarr = [];
%fsave = 'smc_c5k.csv';
fsave1='noisymaxvi.csv'
%fsave2 = 'smc_digit2.csv';
for fi=0:10
    t1 = clock();

     filename1 = strcat(path0,'vinoise_',string(fi*0.05),"_view1",'.csv')
     filename2 = strcat(path0,'vinoise_',string(fi*0.05),"_view2",'.csv');
    dataset1=csvread(filename1);%a�ӽ�����
    dataset2=csvread(filename2);%b�ӽ�����
    randindex=randperm(size(dataset1,1));
    a_random=dataset1(randindex,:);
    b_random=dataset2(randindex,:);
    %�����������
    %����5��
    ac_total = 0;
    deltaarr = [0.25,0.5,0.75,1];
    epsilonarr =  [2^(-10),2^(-9),2^(-8),2^(-7),2^(-6),2^(-5),2^(-4),2^(-3),2^(-2),2^(-1),2^(0),2^(1),2^(2),2^(3),2^(4),2^(5),2^(6),2^(7),2^(8),2^(9),2^(10)];
    nuarr = [2^(-10),2^(-9),2^(-8),2^(-7),2^(-6),2^(-5),2^(-4),2^(-3),2^(-2),2^(-1),2^(0),2^(1),2^(2),2^(3),2^(4),2^(5),2^(6),2^(7),2^(8),2^(9),2^(10)];
    max_acc=0;
    max_std=0;
    maxmu=0;
    maxdelta = 0;
    m = 1;
    mu = 1;
    ;%meiyongdao
    N = 1;%meiyongdao
    disp(num2str(fi));
    epsilonarr=[1];
    %MU = [0.1,1,10]
 %�˲���
    %marr = [2^(-10),2^(-9),2^(-8),2^(-7),2^(-6),2^(-5),2^(-4),2^(-3),2^(-2),2^(-1),2^(0),2^(1),2^(2),2^(3),2^(4),2^(5),2^(6),2^(7),2^(8),2^(9),2^(10)];
    for epsilon = epsilonarr
        for delta = deltaarr
            for nu = nuarr
                %nu
                ac_total=0;
                ac_list = [];
                for index = 1:5
                    max = 0;
                    [atest,atrain]=collectData(index,a_random);
                    size(atest);
                    size(atrain);
                    [btest,btrain]=collectData(index,b_random);
                    a1_indices = find(atrain(:,1)==1);%ȡa�ӽ���һ����
                    b1_indices = find(atrain(:,1)==-1);%ȡa�ӽǸ�һ����
                    a2_indices = find(btrain(:,1)==1);%ȡb�ӽ���һ����
                    b2_indices = find(btrain(:,1)==-1);%ȡb�ӽǸ�һ����
                    a1 = atrain([a1_indices],[2:end]);
                    b1 = atrain([b1_indices],[2:end]);
                    a2 = btrain([a2_indices],[2:end]);
                    b2 = btrain([b2_indices],[2:end]);
                    testx1 = atest(:,[2:end]);
                    testx2 = btest(:,[2:end]);
                    testy = atest(:,1);
                    
                    %delta = 0.25;
                    [ac ac1 ac2]=EPSVM_a_ml_t(testx1,testx2,testy,a1,b1,a2,b2,N,m,mu,delta,nu);
                    %[ac ac1 ac2]=EPSVM_a_ml_t(testx1,testx2,testy,a1,b1,a2,b2,N,m,mu,delta,nu,epsilon);
                    if (ac>max)
                        max = ac;
                    end
                    if (ac1>max)
                        max = ac1;
                    end
                    if (ac2>max)
                        max = ac2;
                    end
                    ac_total = ac_total+max;
                    ac_list = [ac_list;max];
                    %                 if(ac_total>maxac)
                    %                     maxac=ac_total;
                    %                     maxdelta=delta;
                    %                     maxnu=nu;
                    % ac_std = [ac_std;max]
                end
                now_acc = ac_total/5;
                if(now_acc>=max_acc)
                    max_acc = now_acc;
                    std_smc = std2(ac_list);
                end
            end
        end
    end
    
                
            %std
        
    
    
    
%     size(dataset1);
%     size(dataset2);
%     A1 = a_random([21:100],[2:end]);%a�ӽ�20-100��
%     A2 = b_random([21:100],[2:end]);%b�ӽ�20-100��
%     B1 = a_random([121:200],[2:end]);%a�ӽ�120-200��
%     B2 = b_random([121:200],[2:end]);%b�ӽ�120-200��
%     testX1 = a_random([1:20],[2:end]);%a�ӽ�ǰ20��
%     testX1 = [testX1;a_random([101:120],[2:end])];
%     size(testX1)
%     testX2 = b_random([1:20],[2:end]);
%     testX2 = [testX2;b_random([101:120],[2:end])];
%     testY = a_random([1:20],1);
%     testY = [testY;a_random([101:120],1)];    
%     size(A1);
%     size(A2);
%     size(B1);
%     size(B2);
%     disp('dataset loaded')
%     size(testX1);
%     size(testX2);
%     
% 
%     
% 
% 
%     delta = 0.25;
%     mu = 1;%muû�õ�
%     N = 1;%Nû�õ�
%     nu = 1;
%     M=1;
%     
%     
%     [ac ac1 ac2]=EPSVM_a_ml_t(testX1,testX2,testY,A1,B1,A2,B2,N,M,mu,delta,nu);
%     
%     deltaarr = [0.25,0.5,0.75,1];
%     nuarr = [2^(-10),2^(-9),2^(-8),2^(-7),2^(-6),2^(-5),2^(-4),2^(-3),2^(-2),2^(-1),2^(0),2^(1),2^(2),2^(3),2^(4),2^(5),2^(6),2^(7),2^(8),2^(9),2^(10)];
%     marr = [2^(-10),2^(-9),2^(-8),2^(-7),2^(-6),2^(-5),2^(-4),2^(-3),2^(-2),2^(-1),2^(0),2^(1),2^(2),2^(3),2^(4),2^(5),2^(6),2^(7),2^(8),2^(9),2^(10)];
%     M =1
%     
%     max = 0;
%     for delta = deltaarr
%         for nu = nuarr
%             for m = [1]
%                 for index = 1:5
%                    [xtest,xtrain,ytest,ytrain]=collectData(index,data) 
%                    [ac ac1 ac2]=EPSVM_a_ml_t(testX1,testX2,testY,A1,B1,A2,B2,N,m,mu,delta,nu);
%                 
%             end
%         end
%     end
t2 = clock();
t = etime(t2,t1);
    result = [fi,max_acc,std_smc,t];
    resultarr = [resultarr;result]
    csvwrite(fsave1,resultarr);
    
end


    

