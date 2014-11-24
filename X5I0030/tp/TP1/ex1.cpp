//ex1.cpp BORDET Dennis

#include <iostream>
#include <string>
#include <cassert>
using namespace std;


string base_converter(string ch, int dep, int arr)
{
  assert(dep>1 && dep<37);
  assert(arr<37 && arr>1);
  
  int lon, i, resint, soustraction,cbis;
  string res = "";
  char c;
  
  
  lon = ch.length();
  i = 0;
  resint= 0;
  
  // conversion dep->10
  while (i < lon)
  {
    c = ch[i];
    if ( c >= 'A' && c <= 'Z')
    {
      soustraction = 'A'-10;
    }
    else
    {
      if ( c >= 'a' && c <= 'z')
      {
        soustraction = 'a'-10;
      }
      else
      {
        if ( c>='0' && c <='9')
        {
        	soustraction = '0';
        }
        else
        {
          cout << "error  car -> base \n";
        }
      } 
    }
    cbis = c;
    resint = resint*dep + cbis - soustraction;
    //cout<<resint<<"    "<<cbis<< "    "<<soustraction<<"\n";
    i++;
  }
  
  // resint = resultat en base 10
  
  // conversion 10-> arr
  string conver="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  while (resint > 0)
  {
    i = resint%arr;
    resint = resint/arr;
    //cout << "--"<<i<<"--";
    c = conver[i];
    //cout << "^^"<<c<<"^^";
    res = c +res;
  }
  return res;
}

int main()
{
	cout << "___";
	//cout << "";
	cout << base_converter("3eh12",18,30);
	cout << "___";
  return 0;
} 

	
