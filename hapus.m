function out=hapus(A)
[m n]=size(A);
t=0;
for i=1:m
    if A(i,1)~=A(i,2) || A(i,3)~=A(i,4)
        t=t+1;
        out(t,:)=A(i,:);
    end
end
