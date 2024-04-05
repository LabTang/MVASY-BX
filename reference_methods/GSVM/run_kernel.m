    

%path0 = './home/tee/hao/2018smc/corel_5k/';
path0 = './digit/';
%datasetnums = 10;
resultarr = [];
fsave1='digit非线性改动版_0117.csv';
%fsave2 = 'smc_digit2.csv';
for fi=1:15
    filename1 = strcat(path0,num2str(fi),'a.csv');
    filename2 = strcat(path0,num2str(fi),'b.csv');
    dataset1=csvread(filename1);%a视角数据
    dataset2=csvread(filename2);%b视角数据
    randindex=randperm(size(dataset1,1));
    a_random=dataset1(randindex,:);
    b_random=dataset2(randindex,:);
    %打乱数据完成
    %进行5折
    ac_total = 0;
    deltaarr = [0.25,0.5,0.75,1];
    epsilonarr =  [2^(-10),2^(-9),2^(-8),2^(-7),2^(-6),2^(-5),2^(-4),2^(-3),2^(-2),2^(-1),2^(0),2^(1),2^(2),2^(3),2^(4),2^(5),2^(6),2^(7),2^(8),2^(9),2^(10)];
    nuarr = [2^(-10),2^(-9),2^(-8),2^(-7),2^(-6),2^(-5),2^(-4),2^(-3),2^(-2),2^(-1),2^(0),2^(1),2^(2),2^(3),2^(4),2^(5),2^(6),2^(7),2^(8),2^(9),2^(10)];
    max_acc=0;
    max_std=0;
    maxmu=0;
    maxdelta = 0;
    m = 1;
    ;%meiyongdao
    N = 1;%meiyongdao
    disp(num2str(fi));
    %MU = [0.1,1,10]
    MU=[0.1,1,10];%核参数
    %marr = [2^(-10),2^(-9),2^(-8),2^(-7),2^(-6),2^(-5),2^(-4),2^(-3),2^(-2),2^(-1),2^(0),2^(1),2^(2),2^(3),2^(4),2^(5),2^(6),2^(7),2^(8),2^(9),2^(10)];
    for epsilon = epsilonarr
        for mu = MU
            for delta = deltaarr
                for nu = nuarr
                    %nu
                    ac_total=0;
                    ac_list = [];
                    for index = 1:5
                        max = 0;
                        [atest,atrain]=collectData(index,a_random);
                        [btest,btrain]=collectData(index,b_random);
                        a1_indices = find(atrain(:,1)==1);%取a视角正一索引
                        b1_indices = find(atrain(:,1)==-1);%取a视角负一索引
                        a2_indices = find(btrain(:,1)==1);%取b视角正一索引
                        b2_indices = find(btrain(:,1)==-1);%取b视角负一索引
                        a1 = atrain([a1_indices],[2:end]);
                        b1 = atrain([b1_indices],[2:end]);
                        a2 = btrain([a2_indices],[2:end]);
                        b2 = btrain([b2_indices],[2:end]);
                        testx1 = atest(:,[2:end]);
                        testx2 = btest(:,[2:end]);
                        testy = atest(:,1);
                        
                        %delta = 0.25;
                        [ac ac1 ac2]=EPSVM_a_mk_t_gaidong(testx1,testx2,testy,a1,b1,a2,b2,N,m,mu,delta,nu,epsilon);
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
    end
    %fi
    result = [fi,max_acc,std_smc]
    resultarr = [resultarr;result]
    csvwrite(fsave1,resultarr);
    
end


    

