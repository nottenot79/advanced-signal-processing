%% Exercice 9 - Matrice d'autocovariance d'un processus aleatoire
% Enonce : calculer et afficher la matrice de covariance C(i,j) d'un processus
% aleatoire.
%
% Remarque : le corrige proposait
%       y = randn(nbin,n); c = cov(y); plot(y);
%   - "plot(y)" affiche les realisations, pas la matrice de covariance ;
%   - il faut choisir clairement l'orientation. cov attend les observations
%     en lignes et les variables (ici les instants) en colonnes. On construit
%     donc Y avec une ligne par realisation et une colonne par instant.
%
% Pour un bruit blanc, C est proche de sigma^2 * I (matrice diagonale).

clear; close all; clc;

rng(8);
Nt = 100;               % nombre d'instants
M = 2000;               % nombre de realisations

Y = randn(M, Nt);       % ligne m = realisation m, colonne i = instant i
C = cov(Y);             % matrice Nt x Nt, normalisation par M-1

figure;
imagesc(1:Nt, 1:Nt, C);
axis image;
colorbar;
xlabel('Instant j');
ylabel('Instant i');
title('Matrice d''autocovariance estimee C_{i,j} (bruit blanc)');

% Comparaison avec la matrice theorique sigma^2 * I.
C_theo = eye(Nt);
erreur = max(abs(C(:) - C_theo(:)));
fprintf('Variance estimee (moyenne de la diagonale) : %.4f\n', ...
        mean(diag(C)));
fprintf('Ecart maximal a la matrice identite        : %.4f\n', erreur);
hors_diagonale = C - diag(diag(C));
fprintf('Valeur maximale hors diagonale             : %.4f\n', ...
        max(abs(hors_diagonale(:))));
