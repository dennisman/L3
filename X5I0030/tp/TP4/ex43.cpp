#include<cstdio>
#include<cstdint>
#include<cstdlib>
#include <iostream>
using namespace std;
int main(){

//var
	string question;
	string plus;
	string moins;
	string fin;
	int32_t entier;
	int32_t mystere;
	int cpt;
	

//initialisation
	question = "entier ? ";
	plus = "non, plus";
	moins = "non, moins";
	fin = "bravo, vous avez trouve en avec le nombre de tentatives = ";
	srand(time(NULL));
	cpt = 0;
	mystere = rand()%100;
	entier = -1;
	
	
//pgm

	while(entier != mystere){
		cout<< question << endl;
		cin>> entier;
		cpt++;
		if(entier < mystere){
			cout<< plus << endl;
		}else if (entier > mystere){
			cout << moins << endl;
		}
		
	}
	cout<<fin<< cpt <<endl;


	
	
	
return 0;
}

