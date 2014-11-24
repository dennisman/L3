# Feuille de TP 4 -- X5I0030, ex4.4

# Auteur: dennis BORDET

	.text
	.globl __start

__start:
	
	
	
	
	#appel de max(3,7)
	li $a0,14
	li $a1, 42
	li $a2, 19
	li $a3, 9
	li $t0, 59
	jal max4
	
	
	
	#affichage du resultat
	move $a0, $v0
	#move $a0, $t0
	li $v0, 1
	syscall
	
	
	#fin du pgm
	li $v0,10
	syscall
	
	
	max:
		
		
		si1: blt $a0,$a1, sinon1  
		alors1: #a0>=a1
			move $v0, $a0
			b finsi1
		sinon1: #a0<a1
			move $v0, $a1
		finsi1:
		
		
		jr $ra
		
	max4:
		sub $sp, $sp, 24  # Réserver de l'espace en pile (16 registreA+8ra4+4reste) 	CONVENTION
		sw  $ra, 16($sp)  # Sauvegarder l'adresse de retour 
		sw  $t0, 20($sp) # on sauvegarde la variable t0
				# dans nos 4 octets restant pour l'utiliser
				
		jal max
		
		
		move $t0, $v0
		
		move $a0, $a2
		move $a1, $a3
		jal max
		
		move $a0, $v0
		move $a1, $t0
		jal max
		
		lw $t0, 20($sp)	#on remet dans t0 sa valeur
		lw  $ra, 16($sp)  # Récupérer l'adresse de retour
		add $sp, $sp, 24  # Libérer l'espace en pile
		jr $ra
		
