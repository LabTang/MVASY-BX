function [l]=fanshu(a)
    
        count = 0;
        [~,k] = size(a);
        for i =1:k
        
            count=count+a(i)^2;
        end
        

        l=count^0.5;
end