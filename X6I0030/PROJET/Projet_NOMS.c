/* BORDET Dennis - NOM2 Prénom2 */

//MODELE EXPLICITE

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <glpk.h> // nous allons utiliser la bibliothèque de fonctions de GLPK 

/* Déclarations pour le compteur de temps CPU */
#include <time.h>
#include <sys/time.h>
#include <sys/resource.h>

#define NBVAR N 
#define NBCONTR 2*N
#define NBCREUX 2*N*N 

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


int main(int argc, char *argv[])
{
	double temps;
	int nbsol = 0; /* Compteur du nombre d'appels au solveur GLPK */ 
	int nbcontr = 0; /* Compteur du nombre de contraintes ajoutées pour obtenir une solution composée d'un unique cycle */

	/* Déclarations à compléter... */

	crono_start(); /* Lancement du compteur (juste après le chargement des données à partir d'un fichier */

	glp_prob *prob; /* déclaration du pointeur sur le problème */
	int ia[1 + NBCREUX];
	int ja[1 + NBCREUX];
	double ar[1 + NBCREUX]; // déclaration des 3 tableaux servant à définir la partie creuse de la matrice des contraintes
	
	int i,j,pos;
	double z;
	double x[NBVAR];
	
	prob = glp_create_prob(); /* allocation mémoire pour le problème */ 
	glp_set_prob_name(prob, "Robots"); /* affectation d'un nom */
	glp_set_obj_dir(prob, GLP_MIN); /* Il s'agit d'un problème de minimisation */

	glp_smcp parm;
	glp_init_smcp(&parm);
	parm.msg_lev = GLP_MSG_OFF; /* Paramètre de GLPK dans la résolution d'un PL en variables continues afin de couper les affichages (dans lesquels on se noierait) */

	glp_iocp parmip;
	glp_init_iocp(&parmip);
	parmip.msg_lev = GLP_MSG_OFF; /* Paramètre de GLPK dans la résolution d'un PL en variables entières afin de couper les affichages (dans lesquels on se noierait) */
	
	/* Les appels glp_simplex(prob,NULL); et gpl_intopt(prob,NULL); (correspondant aux paramètres par défaut) seront ensuite remplacés par glp_simplex(prob,&parm); et glp_intopt(prob,&parmip); */

	char nomcontr[NBCONTR][6]; /* ici, les contraintes seront nommées "contr1", "contr2",... */
	char numero[NBCONTR][3]; /* pour un nombre à deux chiffres */	
	char nomvar[NBVAR][4]; /* "x11", "x12", ... */
	
	glp_add_rows(prob, NBCONTR);
	for(i=1; i<=NBCONTR; ++i){
		strcpy(nomcontr[i-1], "contr");
		sprintf(numero[i-1], "%d", i);
		strcat(nomcontr[i-1], numero[i-1]);
		
		glp_set_row_name(prob, i, nomcontr[i-1]); /* Affectation du nom à la contrainte i */
		/* partie indispensable : les bornes sur les contraintes */
		glp_set_row_bnds(prob, i, GLP_FX, 1.0, 1.0);
	}
	
	/* Déclaration du nombre de variables : NBVAR */
	glp_add_cols(prob, NBVAR);
	
	
	/* On précise le type des variables, les indices commencent à 1 également pour les variables! */
	
	for(i = 1;i <= N;i++)
	{
		for(j = 1;j <= N;j++)
		{
			/* partie optionnelle : donner un nom aux variables */
			sprintf(nomvar[(i-1)*N+j-1],"x%d%d",i-1,j-1);
			glp_set_col_name(prob, (i-1)*N+j , nomvar[(i-1)*N+j-1]); 
		}
	}
	for(i = 1;i <= NBVAR;i++)
	{
		/* partie obligatoire : bornes éventuelles sur les variables, et type */
		glp_set_col_bnds(prob, i, GLP_DB, 0.0, 1.0); /* bornes sur les variables, comme sur les contraintes */
		glp_set_col_kind(prob, i, GLP_BV);
	}
	
	for(i = 1;i <= N;i++)
	{
		for(j = 1;j <= N;j++)
		{
			glp_set_obj_coef(prob,i,c[i][j]);
		}
	}
	
	
	/* définition des coefficients des variables dans la fonction objectif */

	
	/* A compléter ...
			.
			.
			.
	*/
	
	/* Résolution achevée, arrêt du compteur de temps et affichage des résultats */
	crono_stop();
	temps = crono_ms()/1000,0;

	printf("\n");
	puts("Résultat :");
	puts("-----------");
	/* Affichage de la solution sous la forme d'un cycle avec sa longueur à ajouter */
	printf("Temps : %f\n",temps);	
	printf("Nombre d'appels à GPLK : %d\n",nbsol);
	printf("Nombre de contraintes ajoutées : %d\n",nbcontr);

}
