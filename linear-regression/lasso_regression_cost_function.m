function [Error] = lasso_regression_cost_function(Theta, Y, FeMatrix, lambda)

  m = size(FeMatrix, 1); 
  [l c] = size(Theta);
  
  % linia 1 a lui Theta nu se considera, deoarece ar corespunde coeficientului 0
  % care are valoarea 0  
  Theta1 = Theta(2:l, :);

  % calculeaz costul functiei folosind regularizarea Lasso
  Error = (1/m) * sum((FeMatrix * Theta1 - Y).^2);
  Error = Error + lambda * sum(abs(Theta1(:)));
  
end
