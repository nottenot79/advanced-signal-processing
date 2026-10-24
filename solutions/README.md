# Solutions des exercices — Signaux aléatoires

Chaque exercice est traité dans un script MATLAB indépendant. Les scripts sont
commentés en français et peuvent être exécutés séparément.

| Fichier | Exercice |
|---|---|
| `ex01_bruit_blanc.m` | Affichage d'un bruit blanc gaussien |
| `ex02_fft_ifft.m` | FFT et transformée inverse |
| `ex03_affichage_fft_ifft.m` | Affichage original / signal reconstruit |
| `ex04_periodogramme.m` | Périodogramme et moyenne d'ensemble |
| `ex05_autocorrelation.m` | Autocorrélation d'un bruit blanc |
| `ex06_psd_blackman_tukey.m` | DSP par autocorrélation tronquée |
| `ex07_moments.m` | Moyenne, variance, écart-type |
| `ex08_densite_histogramme.m` | Densité estimée par histogramme |
| `ex09_autocovariance.m` | Matrice d'autocovariance |
| `ex10_filtrage.m` | Filtrage par `H(s) = 1/(s+a)` |
| `ex11_puissance.m` | Puissance moyenne en sortie du filtre |

## Principales corrections apportées au corrigé

1. **Exercice 3** : `X` n'était pas défini ; il faut afficher `ifft(fft(K))`.
2. **Exercice 4** : `(1/N)*sum(abs(fft(K)).^2)` est un scalaire (l'énergie
   totale), pas une DSP. Le périodogramme vaut
   `D(v) = (1/N)*|X(v)|^2` et son espérance s'estime en moyennant sur plusieurs
   réalisations.
3. **Exercice 5** : `xcorr(Q)` n'est pas normalisé. `xcorr(Q,'biased')` donne
   une estimation de `E{x(t)x(t+tau)}`, avec `R(0) ≈ 0.01`.
4. **Exercice 6** : le corrigé affichait seulement l'autocorrélation tronquée.
   La DSP s'obtient en calculant la transformée de Fourier de cette
   autocorrélation (méthode de Blackman–Tukey).
5. **Exercice 7** : `var` et `std` utilisent `N-1` par défaut, alors que
   l'énoncé définit la variance avec `1/N`. Utiliser `var(x,1)`, `std(x,1)` ou
   `mean((x-mean(x)).^2)`.
6. **Exercice 8** : `hist` est obsolète ; le script utilise `histcounts` quand
   il est disponible, avec repli sur `hist`.
7. **Exercice 9** : `plot(y)` n'affiche pas la matrice de covariance. Le script
   calcule `C = cov(Y)` avec les réalisations en lignes et les instants en
   colonnes, puis affiche `C` avec `imagesc`.
8. **Exercice 10** : le cas `a = 10` manquait, les noms de variables étaient
   incohérents et la réponse impulsionnelle était tronquée trop tôt. Le script
   utilise un pas d'échantillonnage `Ts`, une troncature à 8 constantes de
   temps et trace les trois cas.
9. **Exercice 11** : `(1/n)*sum(abs(fft(y)).^2)` vaut `n` fois la puissance
   moyenne. La relation correcte est
   `mean(|y|^2) = (1/n^2)*sum(|fft(y)|^2)`. Le script compare les puissances
   estimées à la théorie `1/(2a)`.

## Remarques d'exécution

- `xcorr` (exercices 5 et 6) fait partie de la **Signal Processing Toolbox**.
- Les scripts utilisent `rng` pour être reproductibles.
- Les scripts sont autonomes : ils redéfinissent les signaux dont ils ont
  besoin et ne dépendent pas de l'ordre d'exécution.
- Pour les exercices 10 et 11, la convolution continue est approchée par
  `y(t) ≈ Ts·Σ h(kTs)x(t-kTs)`. Le bruit est normalisé pour représenter une
  DSP unitaire, ce qui permet de comparer la puissance estimée à la théorie
  `1/(2a)`. Sans cette normalisation, les puissances absolues dépendraient de
  `Ts`, mais l'ordre relatif resterait le même.
