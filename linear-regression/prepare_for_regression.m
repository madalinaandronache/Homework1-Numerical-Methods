function [FeatureMatrix] = prepare_for_regression(InitialMatrix)
  
  % determinarea numarului de linii si coloane al matricei InitialMatrix
  [m n] = size(InitialMatrix);
  
  % initializarea matricei FeatureMatrix
  FeatureMatrix = zeros(m, n + 1);
  
  % variabila ok va primi valoarea 1 daca exista celule cu text care nu sunt
  % situate pe ultima coloana a matricei
  ok = 0;

  for i = 1 : m
    for j = 1 : n
      
      % daca celula reprezinta un text se va inlocui cu valorile 
      % corespunzatoare, conform cerintei
      if ischar(InitialMatrix{i,j}) && strcmp(InitialMatrix{i,j}, 'yes')
        FeatureMatrix(i, j) = 1;
      elseif ischar(InitialMatrix{i,j}) && strcmp(InitialMatrix{i,j}, 'semi-furnished')
         FeatureMatrix(i, j) = 1;
         FeatureMatrix(i, j + 1) = 0;
         if j != n
            ok = 1;
         endif
      elseif ischar(InitialMatrix{i,j}) && strcmp(InitialMatrix{i,j}, 'unfurnished')
         FeatureMatrix(i, j) = 0;
         FeatureMatrix(i, j + 1) = 1;
         if j != n 
            ok = 1;
         endif
     elseif ischar(InitialMatrix{i,j}) && strcmp(InitialMatrix{i,j}, 'furnished')
         FeatureMatrix(i, j) = 0;
         FeatureMatrix(i, j + 1) = 0;
         if j != n 
            ok = 1;
         endif
      elseif isdigit(InitialMatrix{i,j}) && j != n
        FeatureMatrix(i,j) = str2double(InitialMatrix{i,j});
      endif
    endfor
  endfor
  
  % initializarea vectorului Y - reprezentand prima coloana a matricei 
  % FeatureMatrix
  Y = zeros(m, 1);
  
  % transformarea din celula de tip cell in tip numeric
  for i = 1 : m
    if ischar(InitialMatrix{i, 1})
      Y(i) = str2double(InitialMatrix{i, 1});
    endif
  endfor
  
  % adaugarea valorilor in matrice
  FeatureMatrix(:, 1) = Y;
  
  % daca mai exista coloane dupa ultima coloana text, adaugam valorile in 
  % FeatureMatrix
  if ok == 1
    for i = 1 : m
      if ischar(InitialMatrix{i, n})
        Y(i) = str2double(InitialMatrix{i, n});
      endif
    endfor
    FeatureMatrix(:, n + 1) = Y;
  endif

endfunction