//ex3.cpp BORDET Dennis

#include <iostream>
#include <string>
#include <cassert>
#include <stdlib.h>
#include <stdio.h>
#include <cmath>
using namespace std;

// programme du professeur
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

//--------------------------------------
//const void *x  ca veut dire que x est un pointeur vers un type inconnu 
int decroissant(const void *x, const void *y)
{
  /* Cast en le type effectif */
  double *a = (double*)(x);
  double *b = (double*)(y);

  if (*a > *b) {
    return -1;
  } else {
    if (*a < *b) {
      return 1;
    } else {
      return 0;
    }
  }
}

int abs_croissant(const void *x, const void *y)
{
  /* Cast en le type effectif */
  double *a = (double*)(x);
  double *b = (double*)(y);

  if (fabs(*a) < fabs(*b)) {
    return -1;
  } else {
    if (fabs(*a) > fabs(*b)) {
      return 1;
    } else {
      return 0;
    }
  }
}

int abs_decroissant(const void *x, const void *y)
{
  /* Cast en le type effectif */
  double *a = (double*)(x);
  double *b = (double*)(y);

  if (fabs(*a) > fabs(*b)) {
    return -1;
  } else {
    if (fabs(*a) < fabs(*b)) {
      return 1;
    } else {
      return 0;
    }
  }
}

double somme_recursive(double T[], int sz)
{
	double res = 0.0;
	for (int i=0; i< sz; i++)
	{
	  res += T[i];
	}
  return res;
}

double somme_croissante(double T[],int sz)
{
  qsort(T,sz,sizeof(double),croissant);
  return somme_recursive(T, sz);
}

double somme_decroissante(double T[],int sz)
{
  qsort(T,sz,sizeof(double),decroissant);
  return somme_recursive(T, sz);
}

double somme_abs_croissante(double T[],int sz)
{
  qsort(T,sz,sizeof(double),abs_croissant);
  return somme_recursive(T, sz);
}

double somme_abs_decroissante(double T[],int sz)
{
  qsort(T,sz,sizeof(double),abs_decroissant);
  return somme_recursive(T, sz);
}

int main(void)
{
cout.precision(99);
  const int sz = 31;
  double T[sz] = 
  { 9007199254740992.0, 999999999999.9, -999999999998.9, 3.56, 12.8766, 
    0.0123, 999394.4453, 1265356.434536, 23.53, 7889.123, 0.00002145, 0.5, 
    0.06456, 1254534536.4574, -1254534536.4575, -9007199254740992.0, 
    -999999999999.9, 999999999998.9, -3.56, -12.8766, -0.0123, 
    -999394.4453, -1265356.434536, -23.53, -7889.123, -0.00002145, 
    -0.5, -0.06456, -1254534536.4574, 1254534536.4575, 2.6 };

  affiche_tableau(T,sz);
  cout << " \n\n\nsomme recursive : " << somme_recursive(T,sz) << "\n";
    cout << " somme croissante : " << somme_croissante(T,sz) << "\n";
    cout << " somme decroissante : " << somme_decroissante(T,sz) << "\n";
    cout << " somme abs_croissante : " << somme_abs_croissante(T,sz) << "\n";
    cout << " somme abs_decroissante : " << somme_abs_decroissante(T,sz) << "\n\n\n\n\n";
  affiche_tableau(T,sz);
  return 0;
}
