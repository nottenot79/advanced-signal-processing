%% Exercice 3 - Affichage simultane du signal et de sa reconstruction
% Enonce : afficher dans deux sous-graphes le bruit blanc gaussien original et
% le signal restitue apres FFT/IFFT.
%
% Remarque : le code propose utilisait "X" dans le deuxieme subplot, alors que
% X n'etait pas defini. Il faut afficher z = ifft(fft(K)).

clear; close all; clc;

rng(2);
N = 1024;
K = randn(1, N);

X = fft(K);
K_rec = real(ifft(X));  % la partie imaginaire est numeriquement nulle

figure;
subplot(2, 1, 1);
plot(0:N-1, K, 'r.');
grid on;
xlabel('Indice n');
ylabel('Amplitude');
title('Signal original K = randn(1,N)');

subplot(2, 1, 2);
plot(0:N-1, K_rec, 'b.');
grid on;
xlabel('Indice n');
ylabel('Amplitude');
title('Signal restitue z = ifft(fft(K))');

fprintf('Erreur maximale de reconstruction : %.3e\n', max(abs(K - K_rec)));
