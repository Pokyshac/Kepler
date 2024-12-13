function z = expansionProduct(x, y)
    n = length(x);
    m = length(y);
    prods = zeros(1, 2*n*m);
    for i = 1:n
        for j = 1:m
            [s, p] = Dekker(x(i), y(j));
            prods(i * m + j) = s;
            prods(n * m + i * m + j) = p;
        end
    end
    z = SortByAbs(prods);
    z = Renormalize(z);
    z = z(find(z!=0.));
endfunction
