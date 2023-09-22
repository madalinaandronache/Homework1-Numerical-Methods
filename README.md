# Metode Numerice - Tema 1

Student: Andronache Madalina-Georgiana
Grupa: 312CC

Urmatorul fisier contine informatii despre rezolvarea problemelor propuse in 
tema 1 de la MN. Punctajul obtinut la testarea locala este de 120 de puncte.

Cea mai mare provocare intalnita a fost rezolvarea corecta si cat mai eficienta
a problemele propuse intr-un timp cat mai scurt. Aceasta tema a fost rezolvata
pe parcursul a 21 zile: in total am lucrat la aceasta tema 41 h, dintre care 
2 h fiind necesare pentru scrierea fisierului README, iar restul pentru codare 
si testarea problemele. Lipsa checker-ului in prima parte a perioadei de lucru
a ingreuna destul de mult procesul de rezolvare, iar ulterior am stat destul de
mult timp pentru a rezolva greseli rezultate din neintelegrea corecta a 
enuntului. In viitor, imi doresc rezolvarea mai rapida a cerintelor.

Cuprins:
1. Problema 1 - Markov is coming...
2. Problema 2 - Linear Regression
3. Problema 3 - MNIST 101


# 1. Problema 1 - Markov is coming...

Pentru rezolvarea acestei cerinte am implementat urmatoarele functii:
* function [Labyrinth] = parse_labyrinth(file_path) - primind calea 
relativa catre un fisier text, citim din acesta numarul de linii si de coloane
ale matricii ce reprezinta codificarea zecimala a labirintului. In plus, 
matricea Labyrinth este salvata ca o matrice rara, folosind functia sparse
din Octave.
* function [Adj] = get_adjacency_matrix(Labyrinth) - considerand matricea 
Labyrinth creata anterior, graful/lantul Markov asociat acesteia va contine 
m * n + 2 noduri, deoarece avem nevoie si de noduri destinate starilor WIN 
si LOSE. Pentru fiecare element din matricea initiala Labyrinth, calculam 
reprezentarea binara a elementului si respectam codificarea corespunzatoare
enuntului, bitii b3b2b1b0 - corespund peretilor NSEV. Tinand cont de ce biti 
sunt activi (1) si de pozitia in matricea initiala, se completeaza matricea de 
adiacenta Adj, tinandu-se cont ca pentru sectorul Adj(1 : m * n, 1 : m * n), 
matricea Adj va fi simetrica, deoarece peretii labirintului sunt 
bidirectionali. In matricea Adj, valoarea 1 pe pozitia Adj(i, j) semnifica 
faptul ca exista tranzitie de la nodul i la nodul j, iar 0 semnifica faptul ca 
intre aceste doua noduri nu exista tranzitie. Pentru a economisi memorie, 
stocam matricea Adj ca o matrice rara.
* function [Link] = get_link_matrix(Labyrinth) - asemanator matricii Adj din
functia anterioara, elementele matricii Link sunt chiar probabilitatile de 
tranzitie de la o stare la alta în lantul Markov. Astfel, se completeaza 
matricea Link tinand cont de cati vecini valizi are nodului (cati biti de 0 
are codificarea elementului) si de starile WIN si LOSE.
* function [G, c] = get_Jacobi_parameters(Link) - initializam matricea G si 
vectorul c pentru a aplica ulterior metoda iterativa Jacobi. Matricea G, va fi
tot o matrice rara, care va contine primele m - 2 linii si n - 2 coloane din 
matricea Link primita ca parametru al functiei. Vectorul c va contine valorile 
aflate pe coloana n - 1 a matricei Link construita anterior, practic 
probabilitatile starii WIN.
* function [x, err, steps] = perform_iterative(G, c, x0, tol, max_steps) -
aceasta functie calculeaza la fiecare pas noua valoare a vectorului x, 
x^(k+1) fiind egal cu G * x^(k) + c. In plus, daca s-a atins toleranta sau 
numarul maxim de pasi, functia se opreste.
* function [path] = heuristic_greedy(start_position, probabilities, Adj) -
functia implementeaza un algoritm euristic de cautare, care genereaza o cale
pornind de la pozitia start_position, si determinand la fiecare pas vecinii 
nevizitati ai nodului in care se afla, la calea curenta adaugandu-se veciunul
cu probabilitatea cea mai mare.
* function [decoded_path] = decode_path(path, lines, cols) - ultima functiei
a problemei, primeste ca argument un vector care contine o cale valida catre 
WIN si returneaza decoded_path, o matrice cu 2 linii in care, pentru fiecare 
element al vectorului path, se va trece, linia si coloana corespunzatoare 
pozitiei acestuia din matrice.

# 2. Problema 2 - Linear Regression

Pentru rezolvarea acestei cerinte am implementat urmatoarele functii:
* function [Y, InitialMatrix] = parse_data_set_file(file_path) - primind 
calea relativa catre un fisier text, citim din acesta numarul de linii si 
de coloane ale matricii InitialMatrix. Deoarece, tipurile de date ale matricii
sunt diferite, o vom stoca folosind tipul cell. Vectorul Y reprezinta prima 
coloana din datele citite. Respectand aceste precizari, realizam citirea din 
fisier.
* function [FeatureMatrix] = prepare_for_regression(InitialMatrix) - in 
aceasta functie se realizeaza transformarea in date numerice ale valorilor 
citite initial in matricea InitialMatrix. Fiecare pozitie din matrice ce 
contine string-ul ’yes’ se înlocuieste cu tipul 1, iar fiecare pozitie ce 
contine string-ul ’no’ se înlocuieste cu 0. Pentru pozitiile ce contin 
’semi-furnished’, ’unfurnished’ sau ’furnished’, acestea se vor descompune 
în două pozitii cu valori numerice de 0 si 1, conform cerintei.
* function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix) -
in aceasta functie se calculeaza valoarea prezisa pentru fiecare predictor, 
eroarea error ca diferența dintre valoarea prezisa și valoarea reala si 
ulterior se calculeaza functia de cost dupa formula 
Error = 1 / (2*m) * sum(error .^ 2);
* function [Y, InitialMatrix] = parse_csv_file(file_path) - aceasta functie 
primeste calea relativa catre un fisier .csv din care citeste vectorul coloana
Y si matricea InitialMatrix. Pentru citirea datelor, am folosit functia 
textscan.
* function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter) -
functia calculeaza cu ajutorul metodei gradientului descendent, Theta dupa
efectuarea celor iter pasi. Gradientul este calculat din formula 
gradient = (1/m) * FeatureMatrix' * error, unde error este diferența dintre 
valoarea prezisa și valoarea primita pentru fiecare intrare. La final se adauga
la Theta un 0, reprezentand chiar coeficientul 0.
* function [Theta] = normal_equation(FeaturesMatrix, Y, tol, iter) - acesta 
functie rezolva sistemul Ax = b, unde A = FeaturesMatrix' * FeaturesMatrix si
b = FeaturesMatrix' * Y. De asemenea, daca matricea A nu este pozitiv definita,
vectorul Theta va contine valori egale cu 0.
* function [Error] = lasso_regression_cost_function(Theta, Y, FeMatrix, 
lambda) - aceasta functie calculeaza costul functiei folosind regularizarea 
Lasso, astfel, Error va fi calculat dupa formula prezentata in sectiunea 
teoretica.
* function [Error] = ridge_regression_cost_function(Theta, Y, FeMatrix, 
lambda) - aceasta functie calculeaza costul functiei folosind regularizarea 
Ridge, astfel, Error va fi calculat dupa formula prezentata in sectiunea 
teoretica.

# 3. Problema 3 - MNIST 101

Pentru rezolvarea acestei cerinte am implementat urmatoarele functii:
* function [X, y] = load_dataset(path) - primind o cale relativa citim datele 
folosind functia load, ulterior, atribuim matricei X dataset-ul de antrenare
si vectorului y, clasele corespunzatoare. 
* function [X_train, y_train, X_test, y_test] = split_dataset(X, y, percent) -
in aceasta functie, se realizeaza amestecarea datelor din matricea X si 
vectorul y folosind functia randperm. Ulterior, punem in fiecare data 
returnata numarul corespunzator de elemente, in functie de procentul primit 
ca parametru de intrare.
* function [matrix] = initialize_weights(L_prev, L_next) - initializam 
matricea matrix cu elemente din intervalul (-epsilon, epsilon), unde 
epsilon este calculat conform enuntului dupa formula 
epsilon = sqrt(6) / sqrt(L_prev + L_next);
* function [J, grad] = cost_function(params, X, y, lambda, input_layer_size,
hidden_layer_size, output_layer_size) - din vectorul primit ca date de intare,
params, cream matricile Theta1 si Theta2. Ulterior, aplicam algoritmul de 
forward propagation, in modul in care acesta a fost prezentat in sectiunea 
teoretica. Ca rezultat obtinem vectorul h de predictori. Calculam matricea Y 
formata din 0 si 1 care contine vectori corespunzători fiecărei clase de 
ieșire, pentru fiecare exemplu din y. Avem toate datele necesare pentru a 
calcula functia de cost J folosind cross-entrophy. In plus, valoarea acesteia 
va fi minimizata. Pentru a determina si gradientii, aplicam algoritmul de 
backpropagation, exact asa cum acesta ne este prezentat in cerinta.
* function [classes] = predict_classes(X, weights, input_layer_size,
hidden_layer_size, output_layer_size) - folosind forward propagation, calculam 
vectorul de predictii a3. Folosind functia max, determin vectorul classes, 
acesta fiind reprezentat de coloana pe care se gaseste valoarea maxima de pe 
fiecare linie.

