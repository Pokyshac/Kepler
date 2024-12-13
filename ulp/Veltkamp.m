function [xh, xl] = Veltkamp(x, s)
  c = 2. ^s + 1.;

  g = c*x;
  d = x - g;
  xh = d + g;
  xl = x - xh;
endfunction
