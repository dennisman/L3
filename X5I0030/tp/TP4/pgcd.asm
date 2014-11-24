# Feuille de TP 4 -- X5I0030, ex4.4

# Auteur: dennis BORDET

	.text
	.globl __start

__start:
	
	
	
	
	#appel de max(3,7)
	li $a0,24
	li $a1, 32
	li $t0, 59
	jal pgcd
	
	
	
	#affichage du resultat
	move $a0, $v0
	move $a0, $t0
	li $v0, 1
	syscall
	
	
	#fin du pgm
	li $v0,10
	syscall
	
	

	pgcd:
		sub $sp, $sp, 24  # Réserver de l'espace en pile (16 registreA+8ra4+4reste) 	CONVENTION
		sw  $ra, 16($sp)  # Sauvegarder l'adresse de retour 
		sw  $t0, 20($sp) # on sauvegarde la variable t0
				# dans nos 4 octets restant pour l'utiliser
		
		si1: beqz $a1, sinon1  
		alors1: 
			move $t0,$a1
			rem $a1, $a0, $a1
			move $a0, $t0
			jal pgcd
			b finsi1
		sinon1: #a0<a1
			move $v0, $a0
		finsi1:
		lw $t0, 20($sp)	#on remet dans t0 sa valeur
		lw  $ra, 16($sp)  # Récupérer l'adresse de retour
		add $sp, $sp, 24  # Libérer l'espace en pile
		jr $ra
		
