clear; close all; clc;

rng(1);

Fs = 1000;
Ts = 1 / Fs;
N = 8192;
t = (0:N-1) * Ts;

a_list = [2 10 20];
M = 50;
n0 = find(t >= 4, 1);

h = cell(1, numel(a_list));
for k = 1:numel(a_list)
    a = a_list(k);
    L = min(N, ceil(8 / (a*Ts)) + 1);
    th = (0:L-1) * Ts;
    h{k} = exp(-a * th);
end

P_temps = zeros(size(a_list));
P_fft = zeros(size(a_list));
moyenne = zeros(size(a_list));

for m = 1:M
    x = sqrt(Fs) * randn(1, N);

    for k = 1:numel(a_list)
        y = conv(x, h{k}) * Ts;
        y = y(1:N);
        y_utile = y(n0:end);

        moyenne(k) = moyenne(k) + mean(y_utile);
        P_temps(k) = P_temps(k) + mean(y_utile.^2);

        n = numel(y_utile);
        P_fft(k) = P_fft(k) + (1 / n^2) * sum(abs(fft(y_utile)).^2);
    end
end

moyenne = moyenne / M;
P_temps = P_temps / M;
P_fft = P_fft / M;
P_theorie = 1 ./ (2 * a_list);

fprintf(' a     moyenne      puissance    Parseval     theorie 1/(2a)\n');
fprintf('-------------------------------------------------------------\n');
for k = 1:numel(a_list)
    fprintf('%2d  %10.5f  %11.5f  %11.5f  %14.5f\n', ...
            a_list(k), moyenne(k), P_temps(k), P_fft(k), P_theorie(k));
end

figure;
bar(1:numel(a_list), P_temps, 0.6);
hold on;
plot(1:numel(a_list), P_theorie, 'ro', 'MarkerFaceColor', 'r', ...
     'MarkerSize', 8);
grid on;
set(gca, 'XTick', 1:numel(a_list), ...
         'XTickLabel', arrayfun(@(a) sprintf('a = %g', a), a_list, ...
                                'UniformOutput', false));
xlabel('Parametre a');
ylabel('Puissance moyenne');
title('Puissance de sortie en fonction de a');
legend('Estimation temporelle', 'Theorie 1/(2a)', 'Location', 'best');
