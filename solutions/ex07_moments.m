%% Exercice 7 - Moyenne, variance et ecart-type
% Enonce : calculer numeriquement
%       m_x   = (1/N) * sum x_i
%       Var_x = E{(x - E{x})^2}
%       sigma_x = sqrt(Var_x)
%
% Remarque : var(x) et std(x) utilisent par defaut la normalisation par N-1
% (estimateur sans biais). La formule de l'enonce utilise 1/N. Pour retrouver
% exactement les formules, on utilise mean((x-m).^2), var(x,1) ou std(x,1).

clear; close all; clc;

rng(6);
N = 1024;
x = randn(1, N);

m = mean(x);                    % moyenne empirique
v = mean((x - m).^2);           % variance au sens 1/N
sigma = sqrt(v);                % ecart-type au sens 1/N

v_biais = var(x, 1);            % identique a v
sigma_biais = std(x, 1);        % identique a sigma
v_n1 = var(x);                  % normalisation par N-1
sigma_n1 = std(x);

fprintf('Moyenne                     m_x      = %.6f\n', m);
fprintf('Variance (1/N)              Var_x    = %.6f\n', v);
fprintf('Ecart-type (1/N)            sigma_x  = %.6f\n', sigma);
fprintf('Variance (1/(N-1))                   = %.6f\n', v_n1);
fprintf('Ecart-type (1/(N-1))                 = %.6f\n', sigma_n1);
fprintf('Verification var(x,1)                = %.6f\n', v_biais);
fprintf('Verification std(x,1)                = %.6f\n', sigma_biais);
