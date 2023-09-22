function [Labyrinth] = parse_labyrinth(file_path)
  
  % deschidem fisierul fin in modul citire de la calea relativa file_path
  fid = fopen(file_path, 'r');
  
  % citim din fin numarul de linii si de coloane ale matricei labirint
  m = fscanf(fid, '%d', 1);
  n = fscanf(fid, '%d', 1);
  
  % citeste din fisierul fin o matrice cu n * m elemente pe care
  % o transpunem la final pentru a avea orientarea dorita
  data = fscanf(fid, '%d', [n, m])';
  
  % inchidem fisierul fin
  fclose(fid);
  
  % utilizand acest format, functia find returneaza indicii elementelor nenule
  % si vectorul v in care sunt memorate valorile
  [i, j, v] = find(data);
  
  % se creaza matricea rara Labyrinth care contine datele citite din fisier
  Labyrinth = sparse(i, j, v, m, n);
  
endfunction