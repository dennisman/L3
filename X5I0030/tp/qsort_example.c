/*
  Exemple d'utilisation de la fonction qsort() pour trier un tableau d'entier
  
  Frederic Goualard <Frederic.Goualard@univ-nantes.fr>
  2013-09-27
*/

#include <stdlib.h>
#include <stdio.h>


/* Fonction de comparaison de deux 'double's */
int croissant(const void *x, const void *y)
{
  /* Cast en le type effectif */
  double *a = (double*)(x);
  double *b = (double*)(y);

  if (*a < *b) {
    return -1;
  } else {
    if (*a > *b) {
      return 1;
    } else {
      return 0;
    }
  }
}

/* Affichage d'un tableau de 'double's de taille sz à l'écran */
void affiche_tableau(double T[], int sz) 
{
  for (int i = 0; i < sz; ++i) {
    printf("%g ", T[i]);
  }
  printf("\n");
}


int main(void)
{
#define Tsz 4
  double T[Tsz] = { 2.4, 5.6, -1.3, -7.8 };

  affiche_tableau(T,Tsz);
  qsort(T,Tsz,sizeof(double),croissant);
  affiche_tableau(T,Tsz);
  return 0;
}

