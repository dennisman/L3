#explicite, pourri nul, 0/20
/*var x1 >= 0 integer;
var x2 >= 0 integer;

maximize profit : 12*x1 + 20*x2;

s.t. heureA : 0.2*x1 + 0.4*x2 <=400;
s.t. heureB : 0.2*x1 + 0.6*x2 <=800;

solve;

display : x1 , x2, 'z= ', 12*x1 + 20*x2;

end;*/

#implicite
 #Déclaration des ensembles utilisés

	param tailleC; # nombre de chapeaux
	set C := 1..tailleC; # ensemble des indices des chapeaux

	param tailleA; # nombre d'ateliers utilisés
	set A := 1..tailleA; # ensemble des indices des Ateliers
	
	param obj{C}; # coefficients de la fonction objectif
	param coeffcontr{A,C}; # coefficients des membres de gauche des contraintes
	param mdroite{A}; # coefficients des membres de droite

# Déclaration de variables non-négatives sous la forme
# d'un tableau de variables indicées sur les creneaux
	
	var x{C} >= 0 integer;

# Fonction objectif

	maximize profit : sum{j in C} obj[j]*x[j];

# Contraintes

	s.t. Atelier{i in A} : sum{j in C} coeffcontr[i,j]*x[j] <= mdroite[i];

# Résolution (qui est ajoutée en fin de fichier si on ne le précise pas)
	solve;

# Affichage des résultats
	display : x;	# affichage "standard" des variables
	display : 'z=',sum{j in C} obj[j]*x[j]; # affichage de la valeur optimale
	
# Des données peuvent être séparés de la modélisation, on parle alors de modélisation implicite

data;

	param tailleC := 2;

	param tailleA := 2;

	param obj := 1 12
				 2 20;

	param coeffcontr : 1  	2 :=
	                 1 0.2 	0.4
	                 2 0.2	0.6;

	param mdroite := 1 400
	                 2 800;

end;
