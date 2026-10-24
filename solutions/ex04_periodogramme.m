%% Exercice 4 - Estimation de la densite spectrale de puissance
% Enonce : pour un signal ergodique stationnaire, estimer la moyenne du
% periodogramme
%       Gamma(v) = E{|X(v)|^2} ~= (1/M) * sum_{m=1}^{M} |X_m(v)|^2
% et l'afficher.
%
% Remarque sur le corrige propose :
%   S = (1/N)*sum(abs(fft(K)).^2) est un scalaire (l'energie totale), et non
%   une fonction de la frequence. La quantite qui depend de v est le
%   periodogramme D(v) = (1/N)*|X(v)|^2. Pour estimer son esperance, il faut
%   moyenner D(v) sur plusieurs realisations independantes.
%
% Pour un bruit blanc de variance 1, E{D(v)} = 1 pour tout v.

clear; close all; clc;

rng(3);
N = 1024;               % longueur de chaque realisation
M = 200;                % nombre de realisations independantes

K = randn(M, N);        % M lignes = M realisations
X = fft(K, [], 2);      % FFT sur chaque ligne
D = (1/N) * abs(X).^2;  % periodogramme de chaque realisation (M x N)
Gamma = mean(D, 1);     % moyenne d'ensemble, estimation de E{|X(v)|^2}

v = (0:N-1) / N;        % frequence normalisee (cycles/echantillon)
idx = 1:N/2+1;          % frequences positives (signal reel)

figure;

subplot(2, 1, 1);
plot(v(idx), D(1, idx), 'b');
grid on;
xlabel('Frequence normalisee v');
ylabel('D_1(v)');
title('Periodogramme d''une seule realisation');

subplot(2, 1, 2);
plot(v(idx), Gamma(idx), 'b');
hold on;
plot([0 0.5], [1 1], 'r--', 'LineWidth', 1.5);
grid on;
xlabel('Frequence normalisee v');
ylabel('\Gamma(v)');
title(sprintf('Moyenne du periodogramme sur %d realisations', M));
legend('Estimation', 'Theorie (bruit blanc : 1)', 'Location', 'best');

% Verification : la moyenne sur les frequences du periodogramme redonne la
% puissance moyenne du signal (relation de Parseval).
fprintf('Puissance moyenne du signal      : %.4f\n', mean(K(:).^2));
fprintf('Moyenne frequentielle de Gamma   : %.4f\n', mean(Gamma));
