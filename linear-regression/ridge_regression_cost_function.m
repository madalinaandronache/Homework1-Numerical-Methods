function [Error] = ridge_regression_cost_function(Theta, Y, FeMatrix, lambda)
  % Calculează numărul de exemple și numărul de caracteristici
  [m, n] = size(FeMatrix);
    
  [l c] = size(Theta);
  
  % linia 1 a lui Theta nu se considera, deoarece ar corespunde coeficientului 0
  % care are valoarea 0
  Theta1 = Theta(2:l, :);
    
  % calculez valoarea prezisa pentru fiecare predictor
  h = FeMatrix * Theta1;
  
  % calculez diferența dintre valoarea prezisa și valoarea reala
  error = h - Y; 
 
  % calculeaz costul functiei folosind regularizarea Ridge
  Error = (1/(2*m)) * sum(error.^2) + lambda * sum(Theta1(:).^2);
end
