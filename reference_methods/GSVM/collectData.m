function [test,train]=collectData(index,data)
    size_data = round(size(data,1)/5);
    test=[];
    train=[];
    if index == 1
        %第一折有21个数据
        test = [test;data([size_data*(index-1)+1:size_data*(index)+1],:)];%1:21
        train = [train;data([size_data*(index)+2:end],:)];
       
    elseif index == 2
        %第二折有19个
        test = [test;data([size_data*(index-1)+2:size_data*(index)],:)];%22:40
        train = [train;data([1:size_data*(index-1)+1],:);data([size_data*(index)+1:end],:)];%1:21,41:end
        
    elseif index ==5
        test = [test;data([size_data*(index-1)+1:end],:)];
        train = [train;data([1:size_data*(index-1)],:)];
    else
        test = [test;data([size_data*(index-1)+1:size_data*(index)],:)];
        train = [train;data([1:size_data*(index-1)],:);data([size_data*(index)+1:end],:)];
    end
        
end