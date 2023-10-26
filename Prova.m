  clear all
  close all

  pkg load io  % Carica il pacchetto per il supporto ai file Excel

  % Specifica il percorso completo al file .xlsx precedentemente convertito
  file_xlsx = 'C:\Users\Utente\Desktop\dati.xlsx';

  % Leggi i dati dal file Excel nel range specificato
  dati = xlsread(file_xlsx, 'dati', 'B3:J10');

  % Seleziona i predittori e il target
  predittori = dati(:, 1:8);
  target = dati(:, 9);

  % Aggiungi una colonna di 1 per il termine noto (intercetta)
  predittori = [ones(size(predittori, 1), 1), predittori];

  % Calcola i coefficienti del modello di regressione lineare
  coeff = pinv(predittori' * predittori) * predittori' * target;

  % Visualizza i coefficienti del modello
  disp('Coefficients:');
  disp(coeff);

  % Fai una previsione
  previsione = predittori * coeff;

  % Calcola l'errore residuo
  errore = target - previsione;

  % Calcola il quadrato del residuo medio (MSE)
  mse = mean(errore .^ 2);
  disp(['Mean Squared Error (MSE): ', num2str(mse)]);

    data_to_send = dati;
    command = ["echo " data_to_send " > /dev/ttyACM0"];  % Use the correct port
    system(command);

    command = "cat < /dev/ttyACM0";  % Use the correct port
    data_received = strtrim(system(command, "output", "capture"));



