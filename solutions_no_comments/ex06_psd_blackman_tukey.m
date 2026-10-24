clear; close all; clc;

rng(5);
N = 1024;
K = randn(1, N);
Ntau = 100;

[R, lags] = xcorr(K, Ntau, 'biased');

Nfft = 1024;
S = real(fft(ifftshift(R), Nfft));
f = (0:Nfft-1) / Nfft;
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

fprintf('R(0)                     : %.4f\n', R(lags == 0));
fprintf('Moyenne de S sur Nfft    : %.4f\n', mean(S));
