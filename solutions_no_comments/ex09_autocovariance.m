clear; close all; clc;

rng(8);
Nt = 100;
M = 2000;

Y = randn(M, Nt);
C = cov(Y);

figure;
imagesc(1:Nt, 1:Nt, C);
axis image;
colorbar;
xlabel('Instant j');
ylabel('Instant i');
title('Matrice d''autocovariance estimee C_{i,j} (bruit blanc)');

C_theo = eye(Nt);
erreur = max(abs(C(:) - C_theo(:)));
fprintf('Variance estimee (moyenne de la diagonale) : %.4f\n', ...
        mean(diag(C)));
fprintf('Ecart maximal a la matrice identite        : %.4f\n', erreur);
hors_diagonale = C - diag(diag(C));
fprintf('Valeur maximale hors diagonale             : %.4f\n', ...
        max(abs(hors_diagonale(:))));
