function [Theta] = normal_equation(FeaturesMatrix, Y, tol, iter)
  
  % calculam matricea si vectorii corespunzatori sistemului Ax=b
  A = FeaturesMatrix' * FeaturesMatrix;
  b = FeaturesMatrix' * Y;
  x = b' / A;
  
  % initizam vectorul Theta
  [m, n] = size(A);
  Theta = zeros(n, 1);

  % verificam daca A este pozitiv definita
  if m != n
    disp("A nu este o matrice patratica");
    Theta = [0; Theta(:)];
    return;
  elseif (min(eig(A)) < 0)
    Theta = [0; Theta(:)];
    disp("A nu este pozitiv definita");
    return;
  end
  
  % Theta este egal cu vectorul x transpus
  Theta = x';
  
  % adaugam coeficientul 0 al lui Theta
  Theta = [0; Theta(:)];

endfunction
