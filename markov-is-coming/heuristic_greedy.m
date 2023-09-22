function [path] = heuristic_greedy(start_position, probabilities, Adj)
  
  % determinam numarul de elemente din vectorul probabilities
  n = length(probabilities);
  
  % initializam vectorul de elemente vizitate cu false
  visited = false(n, 1);
  
  % deoarece pornim din start_position, vectorul visited va avea valoare true
  % in start_position
  visited(start_position) = true;
  path = start_position;
  
  while not(isempty(path))
    % preluam ultimul element din path
    position = path(end);
    
    % daca am ajuns la starea de win functia se opreste
    if probabilities(position) == 1
        return
    end
    
    % determinam vecinii nevizitati ai elementului curent
    neighbours = find(Adj(position, :) & ~visited');
    
    % daca nu avem vecini nevizitati, eliminam ultimul element adaugat in path
    if isempty(neighbours)
        path = path(1:end-1);
    else
        % alegem vecinul cu probabilitatea maxima si il adaugam in path
        [prob_max, idx] = max(probabilities(neighbours));
        neigh = neighbours(idx);
        visited(neigh) = true;
        path = [path, neigh];
    end
  end
endfunction
