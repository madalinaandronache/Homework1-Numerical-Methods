function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)
  
  m = size(Y, 1); 
  [l c] = size(Theta);
  
  % linia 1 a lui Theta nu se considera, deoarece ar corespunde coeficientului 0
  % care are valoarea 0
  Theta1 = Theta(2:l, :);
  
  % calculez valoarea prezisa pentru fiecare predictor
  h = FeatureMatrix * Theta1;
  
  % calculez diferența dintre valoarea prezisa și valoarea reala
  error = h - Y;
  
  % calculez funcția de cost 
  Error = 1 / (2*m) * sum(error .^ 2);
  
end
