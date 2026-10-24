%% Exercice 6 - DSP estimee par autocorrelation tronquee (Blackman-Tukey)
% Enonce : deduire la densite spectrale de puissance avec une fenetre
% d'autocorrelation limitee a Ntau = 100.
%
% Remarque : le corrige propose se contentait d'afficher l'autocorrelation
% [C,tau] = xcorr(K,Ntau). Pour obtenir la DSP, il faut encore calculer la
% transformee de Fourier de cette autocorrelation tronquee (theoreme de
% Wiener-Khinchin).

clear; close all; clc;

rng(5);
N = 1024;
K = randn(1, N);
Ntau = 100;             % retard maximal conserve

% Autocorrelation estimee pour les retards -Ntau ... Ntau
[R, lags] = xcorr(K, Ntau, 'biased');

% Transformee de Fourier discrete de R(tau). R etant paire et reelle, sa
% transformee est reelle et paire. ifftshift replace le retard 0 en premiere
% position avant le calcul de la FFT.
Nfft = 1024;
S = real(fft(ifftshift(R), Nfft));
f = (0:Nfft-1) / Nfft;  % frequence normalisee
idx = 1:Nfft/2+1;

figure;

subplot(2, 1, 1);
plot(lags, R, '.-');
grid on;
xlabel('Retard \tau');
ylabel('R(\tau)');
title(sprintf('Autocorrelation tronquee a |\\tau| \\leq %d', Ntau));

subplot(2, 1, 2);
plot(f(idx), S(idx), 'b');
hold on;
plot([0 0.5], [1 1], 'r--', 'LineWidth', 1.5);
grid on;
xlabel('Frequence normalisee f');
ylabel('S(f)');
title('DSP estimee par autocorrelation tronquee (Blackman-Tukey)');
legend('Estimation', 'Theorie (bruit blanc : 1)', 'Location', 'best');

% La moyenne de S sur toutes les frequences vaut R(0) (Parseval).
fprintf('R(0)                     : %.4f\n', R(lags == 0));
fprintf('Moyenne de S sur Nfft    : %.4f\n', mean(S));
