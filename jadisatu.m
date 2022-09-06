function dat=jadisatu(A)
 [m n]=size(A);in=0;s=0;h=0;
 for i=1:m
     t=0;
     cek=ismember(i,s);
     a=num2str(A(i,:));
     if cek==0
         for j=1:m
            b=num2str(A(j,:));
            N=strcmp(a,b);
            if N==1
                in=in+1;
                s(in)=j;
                t=1;
            end
         end
     end
     if t~=0
         h=h+1;
         dat(h,:)=A(i,:);
     end
 end