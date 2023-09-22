function [classes] = predict_classes(X, weights, input_layer_size, hidden_layer_size, output_layer_size)
  
  % determinam numarul de exemple de antrenare
  [m n] = size(X);
  
  % se construieste vectorul activarilor neuronilor conform enuntului
  % acesta contine si termenul de bias
  a1 = [ones(m, 1), X];
  
  % calculam numarul de linii si coloane ale matricilor Theta1 si Theta 2
  l1 = hidden_layer_size;
  c1 = input_layer_size + 1;
  l2 = output_layer_size;
  c2 = hidden_layer_size + 1;
  
  % vectorul params este reshape-uit in matricele Theta1 si Theta2
  Theta1 = reshape(weights(1 : l1 * c1), l1, c1);
  Theta2 = reshape(weights((1 + l1 * c1) : end), l2, c2);
  
  % se aplica functia de activare si se adauga termenul de bias
  a2 = sigmoid(a1 * Theta1');
  a2 = [ones(m, 1), a2];

  % se aplica si a treia transformare liniara 
  a3 = sigmoid(a2 * Theta2');

  % functia max returneaza valoarea maxima de pe fiecare linie si coloana pe care
  % aceasta se gaseste
  [~, classes] = max(a3, [], 2);

endfunction
