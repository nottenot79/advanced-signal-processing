%% Exercice 2 - FFT et transformee de Fourier inverse
% Enonce : calculer la FFT d'un signal de 1024 points puis sa transformee
% inverse.
%
% Remarque : les instructions proposees etaient correctes. On verifie en plus
% que ifft(fft(x)) restitue bien le signal d'origine.

clear; close all; clc;

rng(1);
N = 1024;
k = randn(1, N);        % signal temporel

K = fft(k);             % spectre complexe
z = ifft(K);            % retour au domaine temporel

erreur = max(abs(k - z));
fprintf('Erreur maximale de reconstruction |k - ifft(fft(k))| = %.3e\n', ...
        erreur);

% Verification de la relation de Parseval :
% sum(|k|^2) = (1/N) * sum(|K|^2)
energie_temps = sum(abs(k).^2);
energie_freq  = (1/N) * sum(abs(K).^2);
fprintf('Energie temporelle      : %.6f\n', energie_temps);
fprintf('Energie frequentielle   : %.6f\n', energie_freq);
