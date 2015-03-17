
/*
Exercice du TP 3
Auteur : Thomas Minier, groupe 601A
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <glpk.h>
// Données du problème
#define n 16 // Nombre de caisses
#define m 3 // Nombre de wagons
// Constantes du problème
#define NBVAR n*m + 1
#define NBCONTR n + m
#define NBCREUX 2*n*m + m
int main(int argc, char *argv[]) {
/* Structures de données propres à GLPK */
glp_prob *prob; // Déclaration d'un pointeur sur le problème
int ia[1 + NBCREUX];
int ja[1 + NBCREUX];
double ar[1 + NBCREUX]; // Déclaration des 3 tableaux servant à définir la partie creuse de la matrice des contraintes
/* Variables récupérant les résultats de la résolution du problème (fonction objectif et valeur des variables) */
int i, j;
double z;
double x[NBVAR];
// Autres variables
int * p = (int*)malloc(n * sizeof(int));
p[1] = 34;
p[2] = 6;
p[3] = 8;
p[4] = 17;
p[5] = 16;
p[6] = 5;
p[7] = 13;
p[8] = 21;
p[9] = 25;
p[10] = 31;
p[11] = 14;
p[12] = 13;
p[13] = 33;
p[14] = 9;
p[15] = 25;
p[16] = 25;
/* Transfert de ces données dans les structures utilisées par la bibliothèque GLPK */
prob = glp_create_prob(); /* allocation mémoire pour le problème */
glp_set_prob_name(prob, "wagons"); /* affectation d'un nom */
glp_set_obj_dir(prob, GLP_MIN); /* Il s'agit d'un problème de minimisation */
/* Déclaration du nombre de contraintes (nombre de lignes de la matrice des contraintes) */
glp_add_rows(prob, NBCONTR);
/* On commence par préciser les bornes sur les contraintes, les indices commencent à 1 (!) dans GLPK */
/* Premier ensemble de contraintes ( c = 1 ) */
for(i = 1; i <= n; i++) {
glp_set_row_bnds(prob, i, GLP_FX, 1.0, 1.0);
}
/* Second ensembles de contraintes (c <= 0 ) */
for(i = n + 1; i <= NBCONTR; i++) {
glp_set_row_bnds(prob, i, GLP_UP, 0.0, 0.0);
}
/* Déclaration du nombre de variables */
glp_add_cols(prob, NBVAR);
/* On précise le type des variables, les indices commencent à 1 également pour les variables! */
for(i = 1; i <= NBVAR - 1; i++) {
glp_set_col_bnds(prob, i, GLP_DB, 0.0, 1.0);
glp_set_col_kind(prob, i, GLP_BV); /* les variables sont binaires */	
}
glp_set_col_bnds(prob, NBVAR, GLP_LO, 0.0, 0.0); /* La dernière variables est continue (par défaut) non négative */
/* Définition des coefficients des variables dans la fonction objectif */
for(i = 1;i <= n*m;i++) {
glp_set_obj_coef(prob,i,0.0); // Tous les coûts sont à 0 (sauf le dernier)
}
/* Dernier coût (qui vaut 1) */
glp_set_obj_coef(prob,n*m + 1,1.0);
/* Définition des coefficients non-nuls dans la matrice des contraintes, autrement dit les coefficients de la matrice creuse */
int pos = 1;
for(i = 1; i <= n; i++) {
for(j = 1; j <= m; j++) {
// Première moitié de la matrice
ja[pos] = (i - 1)*m + j;
ia[pos] = i;
ar[pos] = 1;
pos++;
// Deuxième moitié de la matrice
ja[pos] = (i - 1)*m + j;
ia[pos] = n + j;
ar[pos] = p[i];
pos++;
}
}
// ajout des -1 dans la dernière colonne
for(i = n + 1; i <= n + m; i++) {
ja[pos] = n*m + 1;
ia[pos] = i;
ar[pos] = -1;
pos++;
}
/* Chargement de la matrice dans le problème */
glp_load_matrix(prob,NBCREUX,ia,ja,ar);
/* Ecriture de la modélisation dans un fichier */
glp_write_lp(prob,NULL,"wagons.lp");
/* Résolution, puis lecture des résultats */
glp_simplex(prob,NULL); glp_intopt(prob,NULL); /* Résolution */
z = glp_mip_obj_val(prob); /* Récupération de la valeur optimale. Dans le cas d'un problème en variables continues, l'appel est différent : z = glp_get_obj_val(prob); */
for(i = 0;i < NBVAR; i++) x[i] = glp_mip_col_val(prob,i+1); /* Récupération de la valeur des variables, Appel différent dans le cas d'un problème en variables continues : for(i = 0;i < p.nbvar;i++) x[i] = glp_get_col_prim(prob,i+1); */
printf("z = %lf\n",z);
for(i = 0;i < NBVAR;i++) printf("x%c = %d, ",'B'+i,(int)(x[i] + 0.5)); /* un cast est ajouté, x[i] pourrait être égal à 0.99999... */
puts("");
/* Libération de la mémoire */
glp_delete_prob(prob);
free(p);
return 0;
}

