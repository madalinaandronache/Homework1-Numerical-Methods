function [x, err, steps] = perform_iterative(G, c, x0, tol, max_steps)

  steps = 0;
  [m n] = size(G);
  
  % vectorul x este initializat sub forma unei matrici rare
  x = sparse(n, 1);
  prev_x = x0;
  
  while(1)
    % calcularea valorii x curente
    x = G * prev_x + c;
    
    % calcularea erorii
    err = norm(x - prev_x);
    
    steps = steps + 1;
    
    % daca s-a atins toleranta sau numarul maxim de pasi, functia se opreste
    if((err <= tol) || (steps == max_steps))
      return
    endif
    
    % memorarea valorii x anterioare
    prev_x = x;
  endwhile

endfunction
