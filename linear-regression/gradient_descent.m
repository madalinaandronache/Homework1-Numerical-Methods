function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)

  % initializam vectorul Theta cu 0
  Theta = zeros(n, 1);

  for i = 1 : iter
    % calculez functia valoarilor prezise pentru fiecare predictor
    h = FeatureMatrix * Theta;

    % calculez diferența dintre valoarea prezisa și valoarea primita pentru 
    % fiecare intrare
    error = h - Y;

    % calculez gradientul
    gradient = (1/m) * FeatureMatrix' * error;

    % actualizam valoarea lui Theta
    Theta = Theta - alpha * gradient;
  end
  
  % adaugam coeficientul 0 al lui Theta
  Theta = [0; Theta(:)];
endfunction

