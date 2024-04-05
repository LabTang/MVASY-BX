function  k = Kerfun(ker,u,v,p1,p2)

  %  用途：求核矩阵。
  
  %  参数：  Ｋｅｒ-核的类型。
  %          ｕ，ｖ代表核中的训练点。
  %          ｐ１，ｐ２代表核中的参数。
  
  %　　　作者：齐志泉　（电子邮箱：qizhiquan2003@163.net ）。   
    switch lower(ker)
      case 'linear'
        k = u*v';
      case 'poly'
        k = (u*v' + p1)^p2;
      case 'rbf'
        k = exp(-(u-v)*(u-v)'/(p1^2))+p2;
      case 'erbf'
        k = exp(-sqrt((u-v)*(u-v)')/(2*p1^2))+p2;
      case 'sigmoid'
        k = tanh(p1*u*v'/length(u) + p2);
      case 'fourier'
        z = sin(p1 + 1/2)*2*ones(length(u),1)+p2;
        i = find(u-v);
        z(i) = sin(p1 + 1/2)*(u(i)-v(i))./sin((u(i)-v(i))/2);
        k = prod(z);
      case 'spline'
        z = 1 + u.*v + (1/2)*u.*v.*min(u,v) - (1/6)*(min(u,v)).^3+p1+p2;
        k = prod(z);
      case 'bspline'
        z = 0;
        for r = 0: 2*(p1+1)
          z = z + (-1)^r*binomial(2*(p1+1),r)*(max(0,u-v + p1+1 - r)).^(2*p1 + 1)+p2;
        end
        k = prod(z);
      case 'anovaspline1'
        z = 1 + u.*v + u.*v.*min(u,v) - ((u+v)/2).*(min(u,v)).^2 + (1/3)*(min(u,v)).^3+p1+p2;
        k = prod(z); 
      case 'anovaspline2'
        z = 1 + u.*v + (u.*v).^2 + (u.*v).^2.*min(u,v) - u.*v.*(u+v).*(min(u,v)).^2 + (1/3)*(u.^2 + 4*u.*v + v.^2).*(min(u,v)).^3 - (1/2)*(u+v).*(min(u,v)).^4 + (1/5)*(min(u,v)).^5+p1+p2;
        k = prod(z);
      case 'anovaspline3'
        z = 1 + u.*v + (u.*v).^2 + (u.*v).^3 + (u.*v).^3.*min(u,v) - (3/2)*(u.*v).^2.*(u+v).*(min(u,v)).^2 + u.*v.*(u.^2 + 3*u.*v + v.^2).*(min(u,v)).^3 - (1/4)*(u.^3 + 9*u.^2.*v + 9*u.*v.^2 + v.^3).*(min(u,v)).^4 + (3/5)*(u.^2 + 3*u.*v + v.^2).*(min(u,v)).^5 - (1/2)*(u+v).*(min(u,v)).^6 + (1/7)*(min(u,v)).^7+p1+p2;
        k = prod(z);
      case 'anovabspline'
        z = 0;
        for r = 0: 2*(p1+1)
          z = z + (-1)^r*binomial(2*(p1+1),r)*(max(0,u-v + p1+1 - r)).^(2*p1 + 1)+p2;
        end
        k = prod(1 + z);
      otherwise
        k = u*v'+p1+p2;
    end

    
