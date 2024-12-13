function res = MultE(a, b, k)
  if(length(a) <= k)
      x = [a, zeros(1, k -length(a))];
  else
      x = a(1:k);
  end
  
  if(length(b) <= k)
      y = [b, zeros(1, k -length(b))];
  else
      y = b(1:k);
  end
 

  r = zeros(1, k+1);
  e = zeros(1, k^2);
  p = e1 = zeros(1, k);
  [r(1), e(1)] = Dekker(x(1), y(1));

  for n = 2:k
    for i = 1:n
      [p(i), e1(i)] = Dekker(x(i), y(n+1-i));
    endfor
    z = VecSum([p(1:n), e(1:(n-1)^2)]);
    r(n) = z(1);  e(1:(n-1)^2+n-1) = z(2:length(z));
    e(1:(n)^2) = [e(1:(n-1)^2+n-1), e1(1:n)];
  endfor

  %k+1 diag
  for i = 2:k
    r(k+1) = r(k+1) + x(i)*y(k+2-i);
  endfor
  for i = 1:k^2
    r(k+1) = r(k+1) + e(i);
  endfor

  r = Renormalize(r);
  res = r(1:k);
endfunction