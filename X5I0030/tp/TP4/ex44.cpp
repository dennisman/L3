#include<cstdio>
#include<cstdint>
#include<cstdlib>
#include <iostream>
#include<string>
using namespace std;
int main(){

//var
	string chaine;
	int taille;
	int indice;
	int cpt;
	

//initialisation
	cpt = 0;
	indice = 0;
	
	cin >> chaine;
	taille = chaine.length();
	
	
//pgm

	while(indice < taille){

		if(chaine.at(indice)=='e'){
			cpt++;
		}
		indice++;
		
	}
	
	cout << "il y a " << cpt << " -e";


	
	
	
return 0;
}

