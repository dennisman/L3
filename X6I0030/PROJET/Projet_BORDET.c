// modele implicite
/* BORDET Dennis */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <glpk.h> // nous allons utiliser la bibliothèque de fonctions de GLPK 

/* Déclarations pour le compteur de temps CPU */
#include <time.h>
#include <sys/time.h>
#include <sys/resource.h>
/*
#define nbvilles N 
#define NBCONTR 2*N
#define NBCREUX 2*N*N 
*/
struct timeval start_utime, stop_utime;

void crono_start()
{
	struct rusage rusage;
	
	getrusage(RUSAGE_SELF, &rusage);
	start_utime = rusage.ru_utime;
}

void crono_stop()
{
	struct rusage rusage;
	
	getrusage(RUSAGE_SELF, &rusage);
	stop_utime = rusage.ru_utime;
}

double crono_ms()
{
	return (stop_utime.tv_sec - start_utime.tv_sec) * 1000 +
    (stop_utime.tv_usec - start_utime.tv_usec) / 1000 ;
}
/* Structure contenant les données du problème */

typedef struct {
	int nbvilles; // Nombre de villes
	int **distances; // Tableau des couts
} donnees;


/* lecture des donnees */

void lecture_data(char *file, donnees *p)
{

	FILE *fin; // Pointeur sur un fichier
	int i,j;	
	int val;
	
	fin = fopen(file,"r"); // Ouverture du fichier en lecture
	
	/* Première ligne du fichier, on lit le nombre de variables */

	fscanf(fin,"%d",&val);
	p->nbvilles = val;
		
	/* On peut maintenant faire les allocations dynamiques dépendant du nombre de variables et du nombre de contraintes */
	
	p->distances = (int **) malloc (p->nbvilles * sizeof(int *));
	for(i = 0;i < p->nbvilles;i++) p->distances[i] = (int *)  malloc (p->nbvilles * sizeof(int));

 // Il restera ensuite à dimensionner chaque "ligne" de la matrice creuse des contraintes
	
	/* Deuxième ligne du fichier, on lit les coefficients de la fonction objectif */
	
	for(i = 0;i < p->nbvilles;i++)
	{
		for(j=0; j< p->nbvilles;j++)
		{
			fscanf(fin,"%d",&val);
			p->distances[i][j] = val;
		}
		
	}	
	fclose(fin); // Fermeture du fichier
}


int main(int argc, char *argv[])
{
	double temps;
	int nbsol = 0; /* Compteur du nombre d'appels au solveur GLPK */ 
	int nbcontr = 0; /* Compteur du nombre de contraintes ajoutées pour obtenir une solution composée d'un unique cycle */

	/* Déclarations à compléter... */

	crono_start(); /* Lancement du compteur (juste après le chargement des données à partir d'un fichier */

	glp_prob *prob; /* déclaration du pointeur sur le problème */
	
	donnees p; 

	int *ia;
	int *ja;
	double *ar; // déclaration des 3 tableaux servant à définir la matrice "creuse" des contraintes
	
	/* Les déclarations suivantes sont optionnelles, leur but est de donner des noms aux variables et aux contraintes.
	   Cela permet de lire plus facilement le modèle saisi si on en demande un affichage à GLPK, ce qui est souvent utile pour détecter une erreur! */
	
	char **nomcontr;
	char **numero;	
	char **nomvar; 

    /* variables récupérant les résultats de la résolution du problème (fonction objectif et valeur des variables) */
	
	double z; 
	double *x; 
	
	/* autres déclarations */ 
	
	int i,j;
	int nbcreux; // nombre d'éléments de la matrice creuse
	int pos; // compteur utilisé dans le remplissage de la matrice creuse
		
	/* Chargement des données à partir d'un fichier */
	
	lecture_data(argv[1],&p);
	
	/* Transfert de ces données dans les structures utilisées par la bibliothèque GLPK */
	
	prob = glp_create_prob(); /* allocation mémoire pour le problème */ 
	glp_set_prob_name(prob, "Robots"); /* affectation d'un nom (on pourrait mettre NULL) */
	glp_set_obj_dir(prob, GLP_MIN); /* Il s'agit d'un problème de minimisation, on utiliserait la constante GLP_MAX dans le cas contraire */
	nbcontr =2*p.nbvilles;
	/* Déclaration du nombre de contraintes (nombre de lignes de la matrice des contraintes) : p.nbcontr */
	
	glp_add_rows(prob, nbcontr); 
	nomcontr = (char **) malloc (nbcontr * sizeof(char *));
	numero = (char **) malloc (nbcontr * sizeof(char *)); 

	/* On commence par préciser les bornes sur les contraintes, les indices commencent à 1 (!) dans GLPK */

	for(i=1;i<=p.nbvilles;i++)
	{
		/* partie optionnelle : donner un nom aux contraintes */
		nomcontr[i - 1] = (char *) malloc (8 * sizeof(char)); // hypothèse simplificatrice : on a au plus 7 caractères, sinon il faudrait dimensionner plus large! 
		numero[i - 1] = (char *) malloc (3  * sizeof(char)); // Même hypothèse sur la taille du problème
		strcpy(nomcontr[i-1], "contA");
		sprintf(numero[i-1], "%d", i);
		strcat(nomcontr[i-1], numero[i-1]); /* Les contraintes sont nommés "salle1", "salle2"... */		
		glp_set_row_name(prob, i, nomcontr[i-1]); /* Affectation du nom à la contrainte i */
		
		/* partie indispensable : les bornes sur les contraintes */
		glp_set_row_bnds(prob, i, GLP_FX, 1.0, 1.0); 
	glp_add_cols(prob, p.nbvilles); 
	nomvar = (char **) malloc (p.nbvilles * sizeof(char *));
	
	}
	
	for(i=p.nbvilles+1;i<=2*p.nbvilles;i++)
	{
		/* partie optionnelle : donner un nom aux contraintes */
		nomcontr[i - 1] = (char *) malloc (8 * sizeof(char)); // hypothèse simplificatrice : on a au plus 7 caractères, sinon il faudrait dimensionner plus large! 
		numero[i - 1] = (char *) malloc (3  * sizeof(char)); // Même hypothèse sur la taille du problème
		strcpy(nomcontr[i-1], "contB");
		sprintf(numero[i-1], "%d", i-p.nbvilles);
		strcat(nomcontr[i-1], numero[i-1]); 
		glp_set_row_name(prob, i, nomcontr[i-1]); /* Affectation du nom à la contrainte i */
		
		/* partie indispensable : les bornes sur les contraintes */
		glp_set_row_bnds(prob, i, GLP_FX, 1.0, 1.0); 
	glp_add_cols(prob, p.nbvilles); 
	nomvar = (char **) malloc (p.nbvilles * sizeof(char *));
	
	}
	
	
	for(i=1;i<=p.nbvilles;i++)
	{
		for(j=1;j<=p.nbvilles;j++){
			/* partie optionnelle : donner un nom aux variables */
			nomvar[(i-1)*p.nbvilles+j] = (char *) malloc (3 * sizeof(char));
			sprintf(nomvar[(i-1)*p.nbvilles+j],"V%d%d",i,j);
			glp_set_col_name(prob, (i-1)*p.nbvilles+j , nomvar[(i-1)*p.nbvilles+j]); 

			/* partie obligatoire : bornes éventuelles sur les variables, et type */
			glp_set_col_bnds(prob, (i-1)*p.nbvilles+j, GLP_DB, 0.0, 1.0); /* bornes sur les variables, comme sur les contraintes */
			glp_set_col_kind(prob, (i-1)*p.nbvilles+j, GLP_BV);	/* les variables sont par défaut continues, nous précisons ici qu'elles sont binaires avec la constante GLP_BV, on utiliserait GLP_IV pour des variables entières */	
		} 
	}
	/* définition des coefficients des variables dans la fonction objectif */

	for(i=1;i<=p.nbvilles;i++)
	{
		for(j=1;j<=p.nbvilles;j++){
			glp_set_obj_coef(prob,(i-1)*p.nbvilles,p.distances[i-1][j-1]);
		}
	}

	/* Définition des coefficients non-nuls dans la matrice des contraintes, autrement dit les coefficients de la matrice creuse */
	/* Les indices commencent également à 1 ! */

	nbcreux = p.nbvilles*p.nbvilles*(2);
	// on alloue un poil plus pour mettre les contraintes de sous tours apres
	
	/* SOUS TOURS
	sum(i,j € S)(Xij) <= #S -1
	
	POUR TOUT S 
	*/
	
	
	ia = (int *) malloc ((1 + nbcreux) * sizeof(int));
	ja = (int *) malloc ((1 + nbcreux) * sizeof(int));
	ar = (double *) malloc ((1 + nbcreux) * sizeof(double));
	pos = 1;
	for(i = 1;i <= p.nbvilles;i++)
	{
		for(j = 1;j <= p.nbvilles;j++)
		{
			ia[pos] = i;
			ja[pos] = (i-1)*p.nbvilles+j;
			ar[pos] = 1.0;
			pos++;
			
			ia[pos] = p.nbvilles +j;
			ja[pos] = (i-1)*p.nbvilles+j;
			ar[pos] = 1.0;
			pos++;
		}
	}
	
	/* chargement de la matrice dans le problème */
	
	glp_load_matrix(prob,nbcreux,ia,ja,ar); 
	
	/* Optionnel : écriture de la modélisation dans un fichier (utile pour debugger) */

	glp_write_lp(prob,NULL,"Robots.lp");

	/* Résolution, puis lecture des résultats */
	
	//REVOIR CI DESSOUS, CEST FAUX LE TRUC AVEC X[]
	glp_simplex(prob,NULL);	glp_intopt(prob,NULL); /* Résolution */
	z = glp_mip_obj_val(prob); /* Récupération de la valeur optimale. Dans le cas d'un problème en variables continues, l'appel est différent : z = glp_get_obj_val(prob);*/
	x = (double *) malloc (p.nbvilles * sizeof(double));
	for(i = 0;i < p.nbvilles; i++) x[i] = glp_mip_col_val(prob,i+1); /* Récupération de la valeur des variables, Appel différent dans le cas d'un problème en variables continues : for(i = 0;i < p.nbvilles;i++) x[i] = glp_get_col_prim(prob,i+1);	*/

	printf("z = %lf\n",z);
	
	for(i=1;i<=p.nbvilles;i++)
	{
		for(j=1;j<=p.nbvilles;j++){
			printf("x%d%d = %d, ",i,j,(int)(x[i] + 0.5));
		}
	}
	puts("");

	/* libération mémoire */
	glp_delete_prob(prob); 

	for(i = 0;i < p.nbvilles;i++) free(p.distances[i]);
	free(p.distances);
	//free(p.nbvilles);
	free(ia);
	free(ja);
	free(ar);
	free(x);

	/* J'adore qu'un plan se déroule sans accroc! */
	return 0;
}
