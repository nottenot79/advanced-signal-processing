%% Exercice 5 - Autocorrelation d'un bruit blanc gaussien
% Enonce : multiplier un bruit blanc gaussien par 0.1 et afficher sa fonction
% d'autocorrelation avec xcorr :
%       gamma_x(tau) = E{x(t) x(t+tau)}
%
% Remarque : xcorr(Q) sans option renvoie sum(Q.*Q) a l'origine, soit environ
% N*sigma^2, et non sigma^2. Pour estimer gamma_x(tau), il faut normaliser par
% N : on utilise l'option 'biased' (ou on divise le resultat par N).

clear; close all; clc;

rng(4);
N = 1024;
K = randn(1, N);
Q = 0.1 * K;            % variance theorique = 0.1^2 = 0.01

[R, lags] = xcorr(Q, 'biased');   % R(tau) = (1/N) * sum Q(n)Q(n+tau)

figure;
plot(lags, R, '.-');
grid on;
xlabel('Retard \tau (echantillons)');
ylabel('\gamma_x(\tau)');
title('Autocorrelation estimee de Q = 0.1*K');
xlim([-200 200]);

R0 = R(lags == 0);
fprintf('R(0) estime      : %.4f\n', R0);
fprintf('R(0) theorique   : %.4f  (sigma^2 = 0.1^2)\n', 0.1^2);
fprintf('Moyenne de Q     : %.4f\n', mean(Q));
