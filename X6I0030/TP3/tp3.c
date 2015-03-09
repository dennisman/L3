/* Utilisation de GLPK en mode bibliothèque */
/* Il s'agit de l'exercice 2.2 des feuilles de TD, qui a servi à illustrer l'utilisation d'une matrice creuse avec GNUMathProg */
/* Ici, toutes les données sont saisies "en dur" dans le code, et nous nous permettons donc des allocations statiques. 
   En cas de lecture des données dans un fichier, des allocations dynamiques seraient nécessaires. */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <glpk.h> /* Nous allons utiliser la bibliothèque de fonctions de GLPK */
#define N 16 //nb caisses
#define M 3 //nb wagons

#define NBVAR N*M+1 //n*m + cmax
#define NBCONTR N+M //n+m
#define NBCREUX M+2*(N*M)// 2 *(n*m) + m = 2*(16*3)


int main(int argc, char *argv[])
{	
	/* structures de données propres à GLPK */
	
	glp_prob *prob; // déclaration d'un pointeur sur le problème
	int ia[1 + NBCREUX];
	int ja[1 + NBCREUX];
	double ar[1 + NBCREUX]; // déclaration des 3 tableaux servant à définir la partie creuse de la matrice des contraintes
	int p[N+1];
	p[1] = 34;
	  p[2] = 6; p[3] = 8; p[4] = 17; p[5] = 16; p[6] = 5; p[7] = 13; p[8] = 21; p[9] = 25; p[10] = 31; p[11] = 14; p[12] = 13; p[13] = 33; p[14] = 9; p[15] = 25; p[16] = 25;

	/* variables récupérant les résultats de la résolution du problème (fonction objectif et valeur des variables) */

	int i,j;
	double z; 
	double x[NBVAR]; 
	
	/* Les déclarations suivantes sont optionnelles, leur but est de donner des noms aux variables et aux contraintes.
	   Cela permet de lire plus facilement le modèle saisi si on en demande un affichage à GLPK, ce qui est souvent utile pour détecter une erreur! */
	
	char nomcontr[NBCONTR][8]; /* ici, les contraintes seront nommées "caisse1", "caisse2",... */
	char numero[NBCONTR][3]; /* pour un nombre à deux chiffres */	
	char nomvar[NBVAR][3]; /* "xA", "xB", ... */
	
	/* Création d'un problème (initialement vide) */
	
	prob = glp_create_prob(); /* allocation mémoire pour le problème */ 
	glp_set_prob_name(prob, "wagons"); /* affectation d'un nom (on pourrait mettre NULL) */
	glp_set_obj_dir(prob, GLP_MIN); /* Il s'agit d'un problème de minimisation, on utiliserait la constante GLP_MAX dans le cas contraire */
	
	/* Déclaration du nombre de contraintes (nombre de lignes de la matrice des contraintes) : NBCONTR */
	
	glp_add_rows(prob, NBCONTR); 

	/* On commence par préciser les bornes sur les constrainte, les indices des contraintes commencent à 1 (!) dans GLPK */

	for(i = 1;i <= N;i++)
	{
		/* partie optionnelle : donner un nom aux contraintes */
		strcpy(nomcontr[i-1], "caisse");
		sprintf(numero[i-1], "%d", i);
		strcat(nomcontr[i-1], numero[i-1]); /* Les contraintes sont nommés "salle1", "salle2"... */		
		glp_set_row_name(prob, i, nomcontr[i-1]); /* Affectation du nom à la contrainte i */
		
		/* partie indispensable : les bornes sur les contraintes */
		glp_set_row_bnds(prob, i, GLP_FX, 1.0, 1.0);
		/* Avec GLPK, on peut définir simultanément deux contraintes, si par exemple, on a pour une contrainte i : "\sum x_i >= 0" et "\sum x_i <= 5",
		   on écrit alors : glp_set_row_bnds(prob, i, GLP_DB, 0.0, 5.0); la constante GLP_DB signifie qu'il y a deux bornes sur "\sum x_i" qui sont ensuite données.
		   Ici, nous n'avons qu'une seule contrainte du type "\sum x_i >= 1" (ou "\sum x_i >= 2" pour la contrainte 4) soit une borne inférieure sur "\sum x_i", on écrit donc glp_set_row_bnds(prob, i, GLP_LO, 1.0, 0.0); le paramètre "0.0" est ignoré. 
		   Les autres constantes sont GLP_UP (borne supérieure sur le membre de gauche de la contrainte) et GLP_FX (contrainte d'égalité).   
		 Remarque : les membres de gauches des contraintes "\sum x_i ne sont pas encore saisis, les variables n'étant pas encore déclarées dans GLPK */ 
	}	
for(i = N+1;i <= N+M;i++)
	{
	/* partie optionnelle : donner un nom aux contraintes */
		strcpy(nomcontr[i-1], "chargeMax");
		sprintf(numero[i-1], "%d", i);
		strcat(nomcontr[i-1], numero[i-1]); /* Les contraintes sont nommés "chargemax", "chargemax2"... */		
		glp_set_row_name(prob, i, nomcontr[i-1]); /* Affectation du nom à la contrainte i */
		
		glp_set_row_bnds(prob, i, GLP_LO, 0.0, 0.0);
		//<=0
		// on met cmax a gauche car c'est une variable
		// il aura le coeff -1 dans la mat creuse
	}

	/* Déclaration du nombre de variables : NBVAR */
	
	glp_add_cols(prob, NBVAR); 
	
	/* On précise le type des variables, les indices commencent à 1 également pour les variables! */
	
	for(i = 1;i <= NBVAR;i++)
	{
		if(i=NBVAR){
			sprintf(nomvar[i-1],"Cmax");
			glp_set_col_name(prob, i , nomvar[i-1]);
			glp_set_col_bnds(prob, i, GLP_DB, 0.0, 100.0);
		}else{
			/* partie optionnelle : donner un nom aux variables */
			sprintf(nomvar[i-1],"x%c",i-1);
			glp_set_col_name(prob, i , nomvar[i-1]); /* Les variables sont nommées "xA", "xB"... afin de respecter les noms de variables de l'exercice 2.2 */
		
			/* partie obligatoire : bornes éventuelles sur les variables, et type */
			glp_set_col_bnds(prob, i, GLP_DB, 0.0, 1.0); /* bornes sur les variables, comme sur les contraintes */
			glp_set_col_kind(prob, i, GLP_BV);	/* les variables sont par défaut continues, nous précisons ici qu'elles sont binaires avec la constante GLP_BV, on utiliserait GLP_IV pour des variables entières */	
		}
	} 

	/* définition des coefficients des variables dans la fonction objectif */

	for(i = 1;i <= N*M;i++) glp_set_obj_coef(prob,i,0.0); // Tous les coûts sont ici à 0! Mais on doit specifier quand meme
	glp_set_obj_coef(prob,N*M+1,1.0); // 1 fois cmax
	
	/* Définition des coefficients non-nuls dans la matrice des contraintes, autrement dit les coefficients de la matrice creuse */
	/* Les indices commencent également à 1 ! */



// pour i de 1 a n
//pour i de 1 a m
 /* xij intervient dans la ligne i avec un coeff 1 et dans la ligne 
 n+j avec un coeff pi
 
 ia -> i et n+j
 ar -> 1 et pi
 ja -> xij -> (i-1)*m+j
*/

int pos = 1;
	for(i=1; i<=N; i++){
		for(j=1; j<=M; j++){
			ia[pos] = i;		ja[pos] = j;				ar[pos] = 1;pos++; 
			ia[pos] = N+j;	ja[pos] = (i-1)*M+j;	ar[pos] = p[i];pos++;
		}
	}
for(i=N*M+1; i<=N*M+M;i++){
	ia[pos] = N;		ja[pos] = i-2;				ar[pos] = -1;
	pos++; 	
}
	
//Cmax a -1 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	
	/* chargement de la matrice dans le problème */
	
	glp_load_matrix(prob,NBCREUX,ia,ja,ar); 
	
	/* Optionnel : écriture de la modélisation dans un fichier (TRES utile pour debugger!) */

	glp_write_lp(prob,NULL,"wagons.lp");

	/* Résolution, puis lecture des résultats */
	
	glp_simplex(prob,NULL);	glp_intopt(prob,NULL); /* Résolution */
	z = glp_mip_obj_val(prob); /* Récupération de la valeur optimale. Dans le cas d'un problème en variables continues, l'appel est différent : z = glp_get_obj_val(prob); */
	for(i = 0;i < NBVAR; i++) x[i] = glp_mip_col_val(prob,i+1); /* Récupération de la valeur des variables, Appel différent dans le cas d'un problème en variables continues : for(i = 0;i < p.nbvar;i++) x[i] = glp_get_col_prim(prob,i+1); */

	printf("z = %lf\n",z);
	for(i = 0;i < NBVAR;i++) printf("x%c = %d, ",'B'+i,(int)(x[i] + 0.5)); /* un cast est ajouté, x[i] pourrait être égal à 0.99999... */ 
	puts("");

	/* libération mémoire */
	glp_delete_prob(prob); 

	/* J'adore qu'un plan se déroule sans accroc! */
	return 0;
}
