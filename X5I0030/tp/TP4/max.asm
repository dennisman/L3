# Feuille de TP 4 -- X5I0030, ex4.4

# Auteur: dennis BORDET

	.text
	.globl __start

__start:
	
	
	
	
	#appel de max(3,7)
	li $a0,15
	li $a1, 11
	jal max
	
	
	
	#affichage du resultat
	move $a0, $v0
	li $v0, 1
	syscall
	
	
	#fin du pgm
	li $v0,10
	syscall
	
	
	max:
		#sub $sp, $sp, 8  # Réserver de l'espace en pile
		#sw  $ra, 0($sp)  # Sauvegarder l'adresse de retour
		si1: blt $a0,$a1, sinon1  
		alors1: #a0>=a1
			b finsi1
		sinon1: #a0<a1
			move $a0, $a1
		finsi1:
		move $v0, $a0
		#lw  $ra, 0($sp)  # Récupérer l'adresse de retour
		#add $sp, $sp, 8  # Libérer l'espace en pile
		jr $ra
