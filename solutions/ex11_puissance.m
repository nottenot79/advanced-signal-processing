%% Exercice 11 - Puissance moyenne du processus filtre
% Enonce : calculer et comparer la moyenne/puissance du processus filtre pour
% a = 2, 10 et 20.
%
% Remarque sur le corrige propose :
%   - les variables y, o et z n'etaient pas definies ;
%   - l'expression (1/n)*sum(abs(fft(y)).^2) vaut n fois la puissance moyenne,
%     et non la puissance moyenne elle-meme. La bonne relation de Parseval est
%         mean(|y|^2) = (1/n^2) * sum(|fft(y)|^2).
%   - les trois valeurs de a n'etaient pas reellement comparees.
%
% Pour un filtre H(s)=1/(s+a) attaque par un bruit blanc de DSP unitaire, la
% puissance theorique de sortie est
%       P = integral |H(j2*pi*f)|^2 df = 1/(2a).
%
% La puissance est estimee en moyennant sur plusieurs realisations et sur le
% temps (apres le regime transitoire), afin de reduire la variance de
% l'estimation.

clear; close all; clc;

rng(1);

Fs = 1000;
Ts = 1 / Fs;
N = 8192;
t = (0:N-1) * Ts;

a_list = [2 10 20];
M = 50;                         % nombre de realisations
n0 = find(t >= 4, 1);           % on ignore les 4 premieres secondes

% Reponses impulsionnelles echantillonnees.
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
    x = sqrt(Fs) * randn(1, N); % bruit blanc de DSP unitaire

    for k = 1:numel(a_list)
        y = conv(x, h{k}) * Ts;
        y = y(1:N);
        y_utile = y(n0:end);

        moyenne(k) = moyenne(k) + mean(y_utile);
        P_temps(k) = P_temps(k) + mean(y_utile.^2);

        % Verification par Parseval (normalisation correcte).
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

% Rappel : l'expression erronee du corrige donnerait N fois la puissance.
fprintf('\nRappel : (1/n)*sum(|fft(y)|^2) = n * puissance moyenne.\n');
