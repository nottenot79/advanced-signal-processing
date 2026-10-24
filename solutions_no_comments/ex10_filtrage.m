clear; close all; clc;

rng(9);

Fs = 1000;
Ts = 1 / Fs;
N = 8192;
t = (0:N-1) * Ts;

x = sqrt(Fs) * randn(1, N);

a_list = [2 10 20];
couleurs = [0.00 0.45 0.74;
            0.85 0.33 0.10;
            0.47 0.67 0.19];

figure;
hold on;
grid on;

for k = 1:numel(a_list)
    a = a_list(k);

    L = min(N, ceil(8 / (a*Ts)) + 1);
    th = (0:L-1) * Ts;
    h = exp(-a * th);

    y = conv(x, h) * Ts;
    y = y(1:N);

    plot(t, y, 'Color', couleurs(k,:));
end

xlabel('Temps t (s)');
ylabel('Sortie y(t)');
title('Sortie du filtre H(s) = 1/(s+a) pour differentes valeurs de a');
legend(arrayfun(@(a) sprintf('a = %g', a), a_list, ...
       'UniformOutput', false), 'Location', 'best');
xlim([0 min(2, t(end))]);
