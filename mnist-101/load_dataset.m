function [X, y] = load_dataset(path)
  
  % memoram datele de la calea path in matricea data
  data = load(path);
  
  % matricea X dataset-ul de antrenare  
  X = data.X;
  
  % vectorul y contine clasele corespunzatoare
  y = data.y;

endfunction
