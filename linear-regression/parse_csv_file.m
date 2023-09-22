function [Y, InitialMatrix] = parse_csv_file(file_path)

  % deschidem fisierul fin in modul citire de la calea relativa file_path
  fin = fopen(file_path, 'r');
  
  % citim datele din fisier in matricea data
  data = textscan(fin, '%f%s%s%s%s%s%s%s%s%s%s%s%s', 'Delimiter', ',', 'HeaderLines', 1);
  
  % inchiderea fisierului fin
  fclose(fin);
  
  % vectorul Y reprezinta prima coloana din data
  Y = data{1};
  
  % matricea InitialMatrix toate coloanele din data in afara de prima
  InitialMatrix = [data{2:end}];
  
end
