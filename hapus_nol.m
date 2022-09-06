function out=hapus_nol(A)
n=length(A);
t=0;
for i=1:n
    if A(i)~=0
        t=t+1;
        out(t)=A(i);
    end
end