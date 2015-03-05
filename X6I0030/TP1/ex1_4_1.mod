/* soit on met les créneaux de 0 a 11, soit on va devoir bidouiller les
indices des infirmieres qui travaillent au créneau j*/
#implicite
 #Déclaration des ensembles utilisés

	param tailleC; # nombre de creneaux
	set C := 1..tailleC; # ensemble des indices des creneaux
	
	param mdroite{C}; # coefficients des membres de droite

# Déclaration de variables non-négatives sous la forme
# d'un tableau de variables indicées sur les Creneaux
	
	var infis{C} >= 0 integer;

# Fonction objectif minimiser le nombre d'infirmieres en tout

	minimize nbInf : sum{j in C} infis[j];

# Contraintes

	s.t. NbMinParCren{i in C} :  infis[i] + infis[((i-2) mod 12) +1] + infis[((i-4) mod 12)+1] + infis[((i-5) mod 12) +1] >= mdroite[i];

# Résolution (qui est ajoutée en fin de fichier si on ne le précise pas)
	solve;

# Affichage des résultats
	display : infis;	# affichage "standard" des variables
	display : 'z=',sum{j in C} infis[j]; # affichage de la valeur optimale
	
# Des données peuvent être séparés de la modélisation, on parle alors de modélisation implicite

data;

	param tailleC := 12;



	param mdroite := 1 	35
	                 2 	40
	                 3	40
	                 4	35
	                 5	30
	                 6	30
	                 7	35
	                 8	30
	                 9	20
	                 10 15
	                 11	15
	                 12	15;

end;


