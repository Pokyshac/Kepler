clc;
close all;
clear all;


%for i = 1:n
x = bitunpack(1.);
n = length(x);
x1 = [1, x(2:n)];
x2 = [0, 1, x(3:n)];
x3 = [1, 1, 1, 1, 1, 1, 1, x(8:n)];

a = [2e10*bitpack(logical(x1), 'double'),2e5* bitpack(logical(x), 'double') ];
b = [bitpack(logical(x3), 'double'),  bitpack(logical(x2), 'double') ];
%b = [1.65763e6, b(1)];
x1 = VecSum(a);%Renormalize(a);
y1 = VecSum(b);%Renormalize(b);

z = SortByAbs([a, b]);

ans = VecSum(z);% Renormalize(z);
ans = ans(find(ans!=0.));

function my_test(ans)
check = 1;
for i=1:size(ans)(2)-1
  if(my_ulp(ans(i)) < 2*abs(ans(i+1)))
    check = 0;
    break
  end
end


 fprintf(1,"for this sequence:\n");
 disp(ans);
if(check)
  fprintf(1,"all right!\n");

else
   fprintf(1,"not good :(\n");
end
endfunction
%disp("ans = ");
%for i = 1:length(ans)
%  fprintf(1, "%g\t", ans(i));
%end
%disp("\n");

ulp1 = 2*arrayfun(@my_ulp, z);
ulp2 = 2*arrayfun(@my_ulp, ans);

[a1, b1] = Dekker(10., 3.45);


dk = 2. ^27+1.;
first = [2e200];
first_rat = rat(first);
second = [2e100];
second_rat =  rat(second);
res = expansionProduct(first, second);
[res_rat, r1] = rat(res);
[res_rat_pr, r2] = rat(4e300);
ulp1 = 2*arrayfun(@my_ulp, res);
res = expansionProduct(2. /3., 1./3.);
[res_rat1, res_rat2] = rat(res);
s = [1., 2^-52];

for i = 1:5
  s = prodsKnum(s, s, 3);
end

num = [7];
q = 3;
my_test(res = InverseNum(num, q))

