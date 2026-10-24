clear; close all; clc;

rng(6);
N = 1024;
x = randn(1, N);

m = mean(x);
v = mean((x - m).^2);
sigma = sqrt(v);

v_biais = var(x, 1);
sigma_biais = std(x, 1);
v_n1 = var(x);
sigma_n1 = std(x);

fprintf('Moyenne                     m_x      = %.6f\n', m);
fprintf('Variance (1/N)              Var_x    = %.6f\n', v);
fprintf('Ecart-type (1/N)            sigma_x  = %.6f\n', sigma);
fprintf('Variance (1/(N-1))                   = %.6f\n', v_n1);
fprintf('Ecart-type (1/(N-1))                 = %.6f\n', sigma_n1);
fprintf('Verification var(x,1)                = %.6f\n', v_biais);
fprintf('Verification std(x,1)                = %.6f\n', sigma_biais);
