function [Link] = get_link_matrix(Labyrinth)
  
  % determinam dimensiunile matricei Labyrinth si cream matricea rara Adj
  % care are numarul de linii si de coloane egale cu m * n + 2 
  [m, n] = size(Labyrinth);
  Link = sparse(m * n + 2, m * n + 2);
  
  % determinam numarul coloanei/liniei corespunzatoare starilor de win si lose
  win = m * n + 1; 
  lose = m * n + 2; 

  Link(win, win) = 1;
  Link(lose, lose) = 1;

  for i = 1:m
    for j = 1:n
      
      % calculam numarul nodului de pe pozitia curenta
      node = (i - 1) * n + j;      
      
      % extragem bitii corespunzatori peretilor N, S, E, V conform enuntului
      vest = bitget(Labyrinth(i,j), 1);            
      est = bitget(Labyrinth(i,j), 2);            
      sud = bitget(Labyrinth(i,j), 3);         
      nord = bitget(Labyrinth(i,j), 4);        
      
      % memoram in aceasta variabila pentru fiecare nod, cati vecini valizi
      % are aceasta
      number = 0;

      if nord == 0
        number = number + 1;
      endif

      if sud == 0
        number = number + 1;
      endif

      if est == 0
        number = number + 1;
      endif

      if vest == 0
        number = number + 1;
      endif
      
      % completam matricea Link in functie de valoarea obtinuta in variabila
      % number si tinand cont de starile win si lose
      if nord == 0 && i > 1
        Link(node, node - n) = 1/number;
      endif

      if sud == 0 && i < m
        Link(node, node + n) = 1/number;
      endif

      if est == 0 && j < n
        Link(node, node + 1) = 1/number;
      endif

      if vest == 0 && j > 1
        Link(node, node - 1) = 1/number;
      endif
      
       if i == 1 && j > 1 && j < n
        if nord == 0
          Link(node, win) = 1/number;
        endif
        if sud == 0
          Link(node, node + n) = 1/number;
        endif
        if est == 0
          Link(node, node + 1) = 1/number;
        endif
        if vest == 0
          Link(node, node -1) = 1/number;
        endif
      endif

       if i == m && j > 1 && j < n
        if nord == 0
          Link(node, node - n) = 1/number;
        endif
        if sud == 0
          Link(node, win) = 1/number;
        endif
        if est == 0
          Link(node, node + 1) = 1/number;
        endif
        if vest == 0
          Link(node, node - 1) = 1/number;
        endif
      endif

      if j == 1 && i > 1 && i < m
        if nord == 0
          Link(node, node - n) = 1/number;
        endif
        if sud == 0
          Link(node, node + n) = 1/number;
        endif
        if est == 0
          Link(node, node + 1) = 1/number;
        endif
        if vest == 0
          Link(node, lose) = 1/number;
        endif
      endif

      if j == n && i > 1 && i < m
        if nord == 0
          Link(node, node - n) = 1/number;
        endif
        if sud == 0
          Link(node, node + n) = 1/number;
        endif
        if est == 0
          Link(node, lose) = 1/number;
        endif
        if vest == 0
           Link(node, node - 1) = 1/number;
        endif
      endif

      if i == 1 && j == 1 && nord == 0
        Link(node, win) = 1/number;
      endif

      if i == 1 && j == 1 && vest == 0
        Link(node, lose) = 1/number;
      endif

      if i == 1 && j == n && nord == 0
        Link(node, win) = 1/number;
      endif

      if i == 1 && j == n && est == 0
        Link(node, lose) = 1/number;
      endif

      if i == m && j == 1 && sud == 0
        Link(node, win) = 1/number;
      endif

      if i == m && j == 1 && vest == 0
        Link(node, lose) = 1/number;
      endif

      if i == m && j == n && sud == 0
        Link(node, win) = 1/number;
      endif

      if i == m && j == n && est == 0
        Link(node, lose) = 1/number;
      endif
    end
  end
endfunction
