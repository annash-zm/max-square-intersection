function ir=iris_graf(A)
[m n]=size(A);
for i=1:m
    t=0;
    a=A(i,1)+0.5:A(i,2)-0.5;
    b=A(i,3)+0.5:A(i,4)-0.5;
    for j=1:m
        if i~=j
            c=A(j,1)+0.5:A(j,2)-0.5;
            d=A(j,3)+0.5:A(j,4)-0.5;
            irisan1=intersect(c,a);
            irisan2=intersect(d,b);
            if isempty(irisan1)==0 && isempty(irisan2)==0
                t=t+1;
                ir(i,t)=j;
            end
            c=0;d=0;
        end
    end
    a=0;b=0;
end
ir