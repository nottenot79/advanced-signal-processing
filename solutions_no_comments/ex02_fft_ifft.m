clear; close all; clc;

rng(1);
N = 1024;
k = randn(1, N);

K = fft(k);
z = ifft(K);

erreur = max(abs(k - z));
fprintf('Erreur maximale de reconstruction |k - ifft(fft(k))| = %.3e\n', ...
        erreur);

energie_temps = sum(abs(k).^2);
energie_freq  = (1/N) * sum(abs(K).^2);
fprintf('Energie temporelle      : %.6f\n', energie_temps);
fprintf('Energie frequentielle   : %.6f\n', energie_freq);
