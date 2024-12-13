function e = SubE(a, b, k)
  %calk a - b with k precision
  a = SortByAbs(a);
  b = SortByAbs(b);


  e = VecSumErrBranch(VecSum([a, -b]));
  if(length(e)< k)
   e = [e, zeros(1, k - length(e))];
  else
    e = e(1:k);
  end

 % e = e(find(e!=0.));
endfunction
