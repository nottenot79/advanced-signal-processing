clear; close all; clc;

rng(4);
N = 1024;
K = randn(1, N);
Q = 0.1 * K;

[R, lags] = xcorr(Q, 'biased');

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
