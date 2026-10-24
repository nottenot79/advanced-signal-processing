clear; close all; clc;

rng(3);
N = 1024;
M = 200;

K = randn(M, N);
X = fft(K, [], 2);
D = (1/N) * abs(X).^2;
Gamma = mean(D, 1);

v = (0:N-1) / N;
idx = 1:N/2+1;

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

fprintf('Puissance moyenne du signal      : %.4f\n', mean(K(:).^2));
fprintf('Moyenne frequentielle de Gamma   : %.4f\n', mean(Gamma));
