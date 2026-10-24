clear; close all; clc;

rng(7);
N = 100000;
x = randn(1, N);
nbin = 100;

if exist('histcounts', 'file') || exist('histcounts', 'builtin')
    [counts, edges] = histcounts(x, nbin);
    centers = (edges(1:end-1) + edges(2:end)) / 2;
else
    [counts, centers] = hist(x, nbin);
end

largeur = mean(diff(centers));
pdf_est = counts / (sum(counts) * largeur);

figure;
bar(centers, pdf_est, 1, 'FaceColor', [0.75 0.80 0.95], ...
    'EdgeColor', 'none');
hold on;

xx = linspace(min(x), max(x), 500);
pdf_theo = exp(-xx.^2 / 2) / sqrt(2*pi);
plot(xx, pdf_theo, 'r', 'LineWidth', 2);

grid on;
xlabel('x');
ylabel('Densite de probabilite');
title(sprintf('Densite estimee avec %d classes', nbin));
legend('Estimation par histogramme', 'Loi normale centree reduite', ...
       'Location', 'best');
xlim([-4 4]);
