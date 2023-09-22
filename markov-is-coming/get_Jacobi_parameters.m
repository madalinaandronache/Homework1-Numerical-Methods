function [G, c] = get_Jacobi_parameters(Link)

  [m, n] = size(Link);
  
  % se initializeaza matricea si vectorul de iteratie sub forma unor matrici
  % rare
  G = sparse(m - 2, n - 2);
  c = sparse(m - 2, 1);
  
  % matricea G va contine primele m - 2 linii si n - 2 coloane din matricea 
  % Link primita ca parametru a functiei
  for i = 1 : m - 2
    for j = 1 : n - 2
        G(i, j) = Link(i, j);
    end
  end
  
  % vectorul c va contine valorile aflate pe coloana n - 1 a matricei Link
  % primita ca parametru a functiei
  for i = 1 : m - 2
    c(i, 1) = Link(i, n - 1);
  end

endfunction
