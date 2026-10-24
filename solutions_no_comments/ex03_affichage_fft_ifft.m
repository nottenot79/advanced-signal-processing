clear; close all; clc;

rng(2);
N = 1024;
K = randn(1, N);

X = fft(K);
K_rec = real(ifft(X));

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
