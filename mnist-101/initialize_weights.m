function [matrix] = initialize_weights(L_prev, L_next)
  
  % epsilon este caclulat conform precizarilor din enunt
  epsilon = sqrt(6) / sqrt(L_prev + L_next);
  
  % calculam matricea matrix cu elemente aleatoare
  matrix = 2 * rand(L_next, L_prev + 1) * epsilon - epsilon;
  
endfunction
