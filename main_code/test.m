a=[1;3;5;7;9;1;4;6;8;10];
[M,N]=size(a);
indices=crossvalind('Kfold',a(1:M,N),5)
i=find(indices==2);
indices(i(1))=1;
indices