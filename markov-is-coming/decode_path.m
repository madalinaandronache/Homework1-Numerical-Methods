function [decoded_path] = decode_path(path, lines, cols)
  
  % determinam dimensiunile vectorului path primit ca argument al functiei
  [m, n] = size(path);
  
  % initializam decoded_path 
  decoded_path = zeros(n - 1, 2);
  
  for i = 1 : n - 1
    % determinam linia corespunzatoare pozitiei curente
    decoded_path(i, 1) = ceil(path(1, i) / cols);
    % determinam coloana corespunzatoare pozitiei curente
    decoded_path(i, 2) = mod(path(1, i) - 1, cols) + 1;
  endfor

endfunction
