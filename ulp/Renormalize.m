function e = Renormalize(x)
  e = VecSumErrBranch(VecSum(x));
 % e = e(find(e!=0.));
endfunction
