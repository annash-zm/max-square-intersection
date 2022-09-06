function out=mat_adjacency(A)
[m n]=size(A);
for i=1:m
    for j=1:n
        if A(i,j)~=0
            out(i,A(i,j))=1;
        end
    end
end