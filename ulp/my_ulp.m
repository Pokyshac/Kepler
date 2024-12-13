function e = my_ulp(x)

e = 1;
i = 0;
while (x + e > x)
  %printf ("%g + 2^(%3d) = %s\n", ...
  %        x, i, num2hex(x + e))
  e /= 2;
  i--;
endwhile
%printf ("%g + 2^(%3d) = %s  <-- 'e' too small\n", ...
 %       x, i, num2str(x + e))
e *=2;
endfunction
