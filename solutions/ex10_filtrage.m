%% Exercice 10 - Filtrage d'un bruit blanc par un filtre du premier ordre
% Enonce : generer la sortie du filtre H(s) = 1/(s+a), de reponse
% impulsionnelle h(t) = exp(-a*t)*u(t), pour a = 2, 10 et 20.
%
% Remarque sur le corrige propose :
%   - le cas a = 10 etait absent ;
%   - les noms de variables changeaient (K, x, Y, z, R) ;
%   - la reponse impulsionnelle etait tronquee a 100 echantillons, ce qui est
%     tres insuffisant pour a = 2 ;
%   - il manquait l'intervalle d'echantillonnage Ts. Pour approximer la
%     convolution continue, on calcule y(t) ~= Ts * sum h(k*Ts) x(t-k*Ts).
%
% Le bruit x est mis a l'echelle sqrt(Fs) pour representer un bruit blanc a
% bande limitee de densite spectrale de puissance unitaire. La sortie est donc
% directement comparable a la theorie (puissance ~ 1/(2a)).

clear; close all; clc;

rng(9);

Fs = 1000;                      % frequence d'echantillonnage (Hz)
Ts = 1 / Fs;
N = 8192;                       % nombre d'echantillons
t = (0:N-1) * Ts;               % axe temporel

x = sqrt(Fs) * randn(1, N);     % bruit blanc discret

a_list = [2 10 20];
couleurs = [0.00 0.45 0.74;     % bleu
            0.85 0.33 0.10;     % orange
            0.47 0.67 0.19];    % vert

figure;
hold on;
grid on;

for k = 1:numel(a_list)
    a = a_list(k);

    % Reponse impulsionnelle echantillonnee, tronquee a 8 constantes de temps.
    L = min(N, ceil(8 / (a*Ts)) + 1);
    th = (0:L-1) * Ts;
    h = exp(-a * th);           % heaviside(th) = 1 car th >= 0

    % Convolution continue approchee par une somme de Riemann.
    y = conv(x, h) * Ts;
    y = y(1:N);                 % on garde la meme base de temps que x

    plot(t, y, 'Color', couleurs(k,:));
end

xlabel('Temps t (s)');
ylabel('Sortie y(t)');
title('Sortie du filtre H(s) = 1/(s+a) pour differentes valeurs de a');
legend(arrayfun(@(a) sprintf('a = %g', a), a_list, ...
       'UniformOutput', false), 'Location', 'best');
xlim([0 min(2, t(end))]);
