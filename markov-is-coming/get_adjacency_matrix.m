function [Adj] = get_adjacency_matrix(Labyrinth)
  
  % determinam dimensiunile matricei Labyrinth si cream matricea rara Adj
  % care are numarul de linii si de coloane egale cu m * n + 2 
  [m, n] = size(Labyrinth);
  Adj = sparse(m * n + 2, m * n + 2);
  
  % determinam numarul coloanei/liniei corespunzatoare starilor de win si lose
  win = m * n + 1; 
  lose = m * n + 2; 
  
  Adj(win, win) = 1;
  Adj(lose, lose) = 1;

  for i = 1:m
    for j = 1:n
      
      % calculam numarul nodului de pe pozitia curenta
      node = (i - 1) * n + j;      
      
      % extragem bitii corespunzatori peretilor N, S, E, V conform enuntului
      vest = bitget(Labyrinth(i,j), 1);           
      est = bitget(Labyrinth(i,j), 2);             
      sud = bitget(Labyrinth(i,j), 3);           
      nord = bitget(Labyrinth(i,j), 4);            
      
      % in functie de bitii activati, completam legaturile din matricea Adj
      % tinand cont si de starile din win si lose
      if nord == 0 && i > 1
        Adj(node, node - n) = 1;
        Adj(node - n, node) = 1;
      endif

      if sud == 0 && i < m
        Adj(node, node + n) = 1;
        Adj(node + n, node) = 1;
      endif

      if est == 0 && j < n
        Adj(node, node + 1) = 1;
        Adj(node + 1, node) = 1;
      endif

      if vest == 0 && j > 1
        Adj(node, node - 1) = 1;
        Adj(node - 1, node) = 1;
      endif

      if i == 1 && j > 1 && j < n
        if nord == 0
          Adj(node, win) = 1;
        endif
        if sud == 0
          Adj(node, node + n) = 1;
          Adj(node + n, node) = 1;
        endif
        if est == 0
          Adj(node, node + 1) = 1;
          Adj(node + 1, node) = 1;
        endif
        if vest == 0
          Adj(node, node -1) = 1;
          Adj(node - 1, node) = 1;
        endif
      endif

      if i == m && j > 1 && j < n
        if nord == 0
          Adj(node, node - n) = 1;
          Adj(node - n, node) = 1;
        endif
        if sud == 0
          Adj(node, win) = 1;
        endif
        if est == 0
          Adj(node, node + 1) = 1;
          Adj(node + 1, node) = 1;
        endif
        if vest == 0
          Adj(node, node - 1) = 1;
          Adj(node - 1, node) = 1;
        endif
      endif

      if j == 1 && i > 1 && i < m
        if nord == 0
          Adj(node, node - n) = 1;
          Adj(node - n, node) = 1;
        endif
        if sud == 0
          Adj(node, node + n) = 1;
          Adj(node + n, node) = 1;
        endif
        if est == 0
          Adj(node, node + 1) = 1;
          Adj(node + 1, node) = 1;
        endif
        if vest == 0
          Adj(node, lose) = 1;
        endif
      endif

      if j == n && i > 1 && i < m
        if nord == 0
          Adj(node, node - n) = 1;
          Adj(node - n, node) = 1;
        endif
        if sud == 0
          Adj(node, node + n) = 1;
          Adj(node + n, node) = 1;
        endif
        if est == 0
          Adj(node, lose) = 1;
        endif
        if vest == 0
            Adj(node, node - 1) = 1;
            Adj(node - 1, node) = 1;
        endif
      endif

      if i == 1 && j == 1 && nord == 0
        Adj(node, win) = 1;
      endif

      if i == 1 && j == 1 && vest == 0
        Adj(node, lose) = 1;
      endif

      if i == 1 && j == n && nord == 0
        Adj(node, win) = 1;
      endif

      if i == 1 && j == n && est == 0
        Adj(node, lose) = 1;
      endif

      if i == m && j == 1 && sud == 0
        Adj(node, win) = 1;
      endif

      if i == m && j == 1 && vest == 0
        Adj(node, lose) = 1;
      endif

      if i == m && j == n && sud == 0
        Adj(node, win) = 1;
      endif

      if i == m && j == n && est == 0
        Adj(node, lose) = 1;
      endif
    end
  end
endfunction
