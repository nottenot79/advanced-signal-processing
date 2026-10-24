clear; close all; clc;

rng(0);
N = 1024;
K = randn(1, N);

figure;
plot(0:N-1, K, '.');
grid on;
xlabel('Indice n');
ylabel('Amplitude');
title(sprintf('Bruit blanc gaussien - %d points', N));

fprintf('Moyenne estimee   : %.4f  (theorie : 0)\n', mean(K));
fprintf('Ecart-type estime : %.4f  (theorie : 1)\n', std(K, 1));
