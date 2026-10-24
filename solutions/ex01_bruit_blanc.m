%% Exercice 1 - Affichage d'un bruit blanc gaussien
% Enonce : afficher un bruit blanc gaussien de 1024 points avec randn.
%
% Remarque : le code propose etait correct. On ajoute seulement un generateur
% reproductible, un axe des abscisses et les statistiques estimees.

clear; close all; clc;

rng(0);                 % rend le tirage reproductible
N = 1024;               % nombre d'echantillons
K = randn(1, N);        % bruit blanc gaussien centre, de variance 1

figure;
plot(0:N-1, K, '.');
grid on;
xlabel('Indice n');
ylabel('Amplitude');
title(sprintf('Bruit blanc gaussien - %d points', N));

fprintf('Moyenne estimee   : %.4f  (theorie : 0)\n', mean(K));
fprintf('Ecart-type estime : %.4f  (theorie : 1)\n', std(K, 1));
