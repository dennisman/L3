

# Donnée

	param nbEntr;
	set indEntr := 1..nbEntr; # index des entreprises

	param nbClient;
	set indClient := 1..nbClient;
	
	param coutLivraison{indEntr, indClient};
	
	
	
	param coutEntr{indEntr};
	
	param capaciteEntr{indEntr};

	param obj{indEntr}; 

	param demandeClient{indClient};

	
	

# Declaration d'un tableau de variables binaires
	
	var x{indEntr} binary;	
	var qteLivraison{indEntr, indClient} >=0;

# Fonction objectif
	 
	 minimize cout : sum{j in indEntr}(
		x[j]*coutEntr[j] +
		sum{i in indClient}(
	 		(qteLivraison[j,i]*coutLivraison[j,i])/demandeClient[i]  
	 	)
	 );

# Contraintes
 	s.t. limite_LivraisonCLient{i in indClient} : sum{j in indEntr} qteLivraison[j,i] = demandeClient[i];
 	
 	s.t.  limite_LivraisonEntr{i in indEntr} : sum{j in indClient} qteLivraison[i,j] <= capaciteEntr[i]*x[i];
 	

# Résolution

	solve;

# Affichage des résultats
	
	display : qteLivraison;
	display{entrepot_numero in indEntr : x[entrepot_numero] = 1} : entrepot_numero; # affichage plus lisible 
	 
	display : "objectif : ", sum{j in indEntr}(
		x[j]*coutEntr[j] +
		sum{i in indClient}(
	 		(qteLivraison[j,i]*coutLivraison[j,i])/demandeClient[i]  
	 	));



data;

	param nbEntr :=12;
	param nbClient := 12;
	
	param coutEntr :=
	1 	3500
	2 	9000
	3 	10000
	4 	4000
	5 	3000
	6 	9000
	7 	9000
	8 	3000
	9 	4000
	10 	10000
	11	9000
	12 	3500;
	
	param capaciteEntr :=
	1	300
	2	250
	3	100
	4	180
	5	275
	6	300
	7	200
	8	220
	9	270
	10	250
	11	230
	12	180;
	
	param demandeClient :=
	 1 120
	 2 80
	 3 75 
	 4 100 
	 5 110 
	 6 100 
	 7 90 
	 8 60 
	 9 30 
	 10 150 
	 11 95 
	 12 120;
	 
	param coutLivraison : 	1	2	3	4	5	6	7	8	9	10	11	12:=
						1	100	80	50	50	60	100	120	90	60	70	65	110
						2	120	90	60	70	65	110	140	110	80	80	75	130
						3 	140 110 80 	80 	75 	130 160 125 100 100 80 150
						4 	160 125 100 100 80 	150 190 150 130 5000 5000 5000
						5 	190 150 130 5000 5000 5000 200 180 150 5000 5000 5000
						6	200 180 150 5000 5000 5000 100 80 50 50 60 100
						7 	100 80 	50 	50 60 100 120 90 60 70 65 110
						8 	120 90 	60 	70 65 110 140 110 80 80 75 130
						9 	140 110 80 	80 75 130 160 125 100 100 80 150
						10 	160 125 100 100 80 150 190 150 130 5000 5000 5000
						11 	190 150 130 5000 5000 5000 200 180 150 5000 5000 5000
						12 	200 180 150 5000 5000 5000 100 80 50 50 60 100;

end;

