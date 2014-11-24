# Feuille de TP 4 -- X5I0030, ex4.3
# Auteur: dennis BORDET

	.data
question:	.asciiz "entier ? "
plus:		.asciiz "non, plus"
moins:		.asciiz "non, moins"
fin:		.asciiz "bravo, nombre de tentative(s) = "




	.text
	.globl __start

__start:
	li $t1, 42 #chiffre mystere
	li $t3, 0 #compteur
	li $t2, -1
	
	tantque1: beq $t1, $t2, ftq1
		#entree/sortie
		li, $v0,4
		la $a0, question
		syscall
		li $v0, 5
		syscall
		move $t2, $v0
		
		#cpt++
		add $t3, $t3, 1
		
		si1: bgt $t2,$t1, sinon1  
		alors1: #x<=mystere
			si2:bge $t2,$t1, finsi2
			alors2: #x<mystere
				#plus
				li, $v0,4
				la $a0, plus
				syscall
				
			finsi2: #x >= mystere donc x=mystere
			b finsi1
		sinon1: #x>mystere
			#moins
			li, $v0,4
			la $a0, moins
			syscall
		finsi1:
		
		b tantque1
	ftq1: 
	
	li, $v0,4
	la $a0, fin
	syscall
	
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 10
	syscall
