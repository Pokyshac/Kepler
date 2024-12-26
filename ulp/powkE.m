function res = powkE(a, n, k)
  ## calk a^n
  ##whre a = (a1, a2, a3, ..., a_n)
  ##return res = (res1, res2, ..., res_n)
  if(length(a) <= k)
      x = [a, zeros(1, k -length(a))];
  else
      x = a(1:k);
  end
  res = x;
  for i = 2:n
    res = MultE(x, res, k);
  endfor
  
endfunction