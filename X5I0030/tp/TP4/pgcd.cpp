#include<cstdio>
#include<cstdint>
#include<cstdlib>
#include <iostream>
#include<string>
using namespace std;

int pgcd(int a, int b){
	//return b ?  pgcd(b,a%b) : a;
	if(b==0){
		return a;
	}else{
		return pgcd(b, a%b);
	}
	
}

int main(){
	cout<<pgcd(33,24);
}

