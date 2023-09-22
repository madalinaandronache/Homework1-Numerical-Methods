function [X_train, y_train, X_test, y_test] = split_dataset(X, y, percent)
  
  % determinam dimensiunile matricei X
  [m n] = size(X);
  
  % amestecam dataset-ul cu exemplele de antrenare
  shuffle = randperm(m);
  X = X(shuffle, :);
  y = y(shuffle);
  
  % nr reprezinta numarul de exemple folosite pentru antrenament
  nr = round(m * percent);
  
  % determinam vectorii corespunzatori pentru setul de antrenament
  X_train = X(1 : nr, :);
  y_train = y(1 : nr, :);

  % determinam vectorii corespunzatori pentru datele de testare
  X_test = X(nr + 1 : end, :);
  y_test = y(nr + 1 : end, :);

endfunction
