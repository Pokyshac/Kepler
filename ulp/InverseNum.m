function res = InverseNum(a, q)
  k = length(a)

 if (k <= 2^q)
    a = [a, zeros(1, 2^q - k)];
 endif

    v = w = res = zeros(1, 2^q);
    res(1) = 1. / a(1);
    for i = 0:q-1
      num = 2^(i)
      v(1:num*2) = MultE(res(1:num), a(1:num), 2*num);

      w(1:num*2) = SubE([2.], v(1:2*num), 2*num);

      res(1:num*2) = MultE(res(1:num), w(1:2*num), 2*num);
    endfor


endfunction
