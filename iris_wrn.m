function matwarna=iris_wrn(A,B)
a=A(1):A(2);
b=A(3):A(4);
c=B(1):B(2);
d=B(3):B(4);
ir1=intersect(c,a);
ir2=intersect(d,b);
if isempty(ir1)==0 && isempty(ir2)==0
    matwarna=[ir1(1) ir1(length(ir1)) ir2(1) ir2(length(ir2))];
else
    matwarna=A;
end