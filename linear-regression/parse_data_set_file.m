function [Y, InitialMatrix] = parse_data_set_file(file_path)

  % deschidem fisierul fin in modul citire de la calea relativa file_path
  fin = fopen (file_path, 'r');
  
  % citim din fin numarul de linii si de coloane ale matricei InitialMatrix
  m = fscanf(fin, "%d", 1);
  n = fscanf(fin, "%d", 1);
  
  % initializarea matricei cu tipul Cell si a vectorului Y
  InitialMatrix = cell(m, n);
  Y = zeros(m, 1);

  % citirea datelor pentru Y si InitialMatrix
  for i = 1 : m
    Y(i, 1) = fscanf(fin, "%d", 1);
    for j = 1 : n
      InitialMatrix{i,j} = fscanf(fin, "%s", 1);
    endfor
  endfor
  
  % inchiderea fisierului fin
  fclose(fin);
endfunction
