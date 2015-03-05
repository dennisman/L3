/*
Exercice 2 du TP 2, partie 2
Modèle complètement implicite
Auteur : Thomas Minier, groupe 601A
*/
# Déclaration des ensembles utilisés
param tailleE; # nombre d'entrepôts
set E := 1..tailleE; # ensemble des entrepôts
param tailleP; # nombre de pourcentages de livraison
set P := 1..tailleP; # ensemble des pourcentages de livraison
param cout{E}; # Vecteur des coûts de construction des entrepôts
param capacite{E}; # Vecteur des capacités des entrepôts
param demande{P}; # Vecteur des demandes des clients
param coutCentrale{E,P}; # Vecteur des demandes d'une centrale par entrepôt
# Déclaration des variables
var b{E} binary;
var p{E,P} >= 0;
# Fonction objectif
minimize profit : sum{i in E}(cout[i]*b[i] + sum{j in P}(p[i,j]*coutCentrale[i,j]));
# Contraintes
s.t. SousContrA{i in E} : sum{j in P} p[i,j]*demande[j] <= capacite[i]*b[i];
s.t. SousContrB{j in P} : sum{i in E} p[i,j] = 1;
# Résolution
solve;
# Affichage des résultats
display : b; # affichage "standard" des variables
display : p;
display : "objectif : ", sum{i in E}(cout[i]*b[i] + sum{j in P}(p[i,j]*coutCentrale[i,j]));
data;
param tailleE := 12;
param tailleP := 12;
param cout := 1 3500 2 90000 3 10000 4 4000 5 3000 6 9000 7 9000 8 3000 9 4000 10 10000 11 9000 12 3500;
param capacite := 1 300 2 250 3 100 4 180 5 275 6 300 7 200 8 220 9 270 10 250 11 230 12 180;
param demande := 1 120 2 80 3 75 4 100 5 110 6 100 7 90 8 60 9 30 10 150 11 95 12 120;
param coutCentrale : 1 2 3 4 5 6 7 8 9 10 11 12 :=
1 100 80 50 50 60 100 120 90 60 70 65 110
2 120 90 60 70 65 110 140 110 80 80 75 130
3 140 110 80 80 75 130 160 125 100 100 80 150
4 160 125 100 100 80 150 190 150 130 50000 50000 50000
5 190 150 130 50000 50000 50000 200 180 150 50000 50000 50000
6 200 180 150 50000 50000 50000 100 80 50 50 60 100
7 100 80 50 50 60 100 120 90 60 70 65 110
8 120 90 60 70 65 110 140 110 80 80 75 130
9 140 110 80 80 75 130 160 125 100 100 80 150
10 160 125 100 100 80 150 190 150 130 50000 50000 50000
11 190 150 130 50000 50000 50000 200 180 150 50000 50000 50000
12 200 180 150 50000 50000 50000 100 80 50 50 60 100;
end;
