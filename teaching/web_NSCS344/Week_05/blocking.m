function [r, A, B] = blocking(T)

T1 = round(T/2);

for i = 1:T1
   r(i) = 1;
   A(i) = 1;
   B(i) = 0;
end

for i = T1+1:T
   r(i) = 1;
   A(i) = 1;
   B(i) = 1;
end