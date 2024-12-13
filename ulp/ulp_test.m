clc;
clear all;
close all;

##x = 0.;
##
##fprintf(1, "ulp(%g) = %25.25g\n", x, ulp(x))
##
##x = 1.;
##
##fprintf(1, "ulp(%g) = %25.25g\n", x, ulp(x))
##
##x = 42.;
##
##fprintf(1, "ulp(%g) = %25.25g\n", x, ulp(x))
##
##x = -1.;
##
##fprintf(1, "ulp(%g) = %25.25g\n", x, ulp(x))



u1 = [4., 0., -2., 0., 1.];
u2 = [4., 0., -1., 0., 2.];
u3 = [128, 0., 2.^(-45),2.^(-97),2.^(-98)];
u4 = [128, 0., 2.^(-45) - 2.^(-46),2.^(-98) - 2.^(-99)];

delnull = @(u)(u(find(u!=0.)));

u11 = delnull(u1);
u21 = delnull(u2);
u31 = delnull(u3);
u41 = delnull(u4);
#########
####1####
#########

u = u11;
check = 1;
for i=1:size(u)(2)-1
  if(abs(u(i)) < abs(u(i+1)))
    check = 0;
    break
  end
end

if(check)
  fprintf(1,"all reight!\n");
else
   fprintf(1,"not good :(\n");
end




#########
####2####
#########
u = u41;
check = 1;
for i=1:size(u)(2)-1
  if(ulp(u(i)) < abs(u(i+1)))
    check = 0;
    break
  end
end

if(check)
  fprintf(1,"all reight!\n");
else
   fprintf(1,"not good :(\n");
end


#########
####3####
#########
u = u41;
check = 1;
for i=1:size(u)(2)-1
  if(ulp(u(i)) <= abs(u(i+1)))
    check = 0;
    break
  end
end

if(check)
  fprintf(1,"all reight!\n");
else
   fprintf(1,"not good :(\n");
end



#########
####4####
#########
u = u41;
check = 1;
for i=1:size(u)(2)-1
  if(ulp(u(i)) <= 2.*abs(u(i+1)))
    check = 0;
    break
  end
end

if(check)
  fprintf(1,"all reight!\n");
else
   fprintf(1,"not good :(\n");
end
