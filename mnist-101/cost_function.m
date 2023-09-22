function [J, grad] = cost_function(params, X, y, lambda, input_layer_size, hidden_layer_size, output_layer_size)

  % calculam numarul de linii si coloane ale matricilor Theta1 si Theta 2
  l1 = hidden_layer_size;
  c1 = input_layer_size + 1;
  l2 = output_layer_size;
  c2 = hidden_layer_size + 1;
  
  % vectorul params este reshape-uit in matricele Theta1 si Theta2
  Theta1 = reshape(params(1 : l1 * c1), l1, c1);
  Theta2 = reshape(params((1 + l1 * c1) : end), l2, c2);
  
  % determinam numarul de exemple de antrenare
  [m n] = size(X);

  % aplicam algoritmul pentru predictie forward propagation
  
  % se construieste vectorul activarilor neuronilor conform enuntului
  % acesta contine si termenul de bias
  a1 = [ones(m, 1), X];
  
  % se obtine vectorul rezultatelor intermediare
  z2 = a1 * Theta1';
  
  % se aplica functia de activare si se adauga termenul de bias
  a2 = sigmoid(z2);
  a2 = [ones(size(z2, 1), 1), a2];
  
  % se aplica si a treia transformare liniara 
  z3 = a2 * Theta2';
  a3 = sigmoid(z3);
  
  % Notam cu h predictori, pentru a corespunde formulelor
  h = a3;
  
  % calculam matricea Y formata din 0 si 1 care contine vectori
  % corespunzători fiecărei clase de ieșire pentru fiecare exemplu din y
  Matrix1 = repmat([1 : output_layer_size], m, 1);
  Matrix2 = repmat(y, 1, output_layer_size);
  Y = Matrix1 == Matrix2;

  % calculam functia de cost J folosind cross-entrophy
  J = (1 / m) * sum(sum((-Y .* log(h)) - ((1 - Y) .* log(1 - h))));
  
  % minimizarea functiei de cost 
  J = J + (lambda / (2 * m)) * (sum(sum(Theta1(:, 2 : end) .^ 2)) + sum(sum(Theta2(:, 2 : end) .^ 2)));

  % aplicam algoritmul de backpropagation pentru a determina gradientii
  
  % determinam eroarea in layer-ul de output
  delta3 = h - Y;
  
  % determinarea erorii in layer-ul intermediar
  delta2 = (delta3 * Theta2(:, 2 : end)) .* sigmoid(z2) .* (1 - sigmoid(z2));

  % acumularea gradientilor pentru parametrii care fac trecerea de la layerul
  % de input la cel intermediar, respectiv de la layerul intermediar la cel de 
  % output
  Delta1 = delta2' * a1;
  Delta2 = delta3' * a2;
  
  % excludem termenii de bias
  Theta1 = Theta1(:, 2 : end);
  Theta2 = Theta2(:, 2 : end);
  
  % adaugam o coloana cu 0, pentru a nu influenta calculul
  Theta1 = [zeros(l1, 1), Theta1];
  Theta2 = [zeros(l2, 1), Theta2];
  
  % calculam gradientii
  Theta1_grad = (1 / m) * Delta1 + (lambda / m) * Theta1;
  Theta2_grad = (1 / m) * Delta2 + (lambda / m) * Theta2;
  
  % le concatenam intr-un singur vector
  grad = [Theta1_grad(:) ; Theta2_grad(:)];

end