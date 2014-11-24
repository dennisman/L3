# Implémentation exemple de la fonction récursive factorielle.
# F. Goualard, X5I0030, 2014--2015, v. 1.0

	.text
	.globl __start
	
# Point d'entrée du programme
# Ne fait qu'appeler la fonction main() et arrêter le programme
__start:
	jal main
	
	# exit()
	li $v0, 10
	syscall

# int main(void)
# {
#   cout << facto(5) << endl;
#   return 0;
# }
# La fonction main() appelle une autre fonction avec moins de 5 paramètres; elle doit donc
# créer un bloc P de 4*4=16 octets et un bloc R d'au moins 8 octets (4 octets pour $ra et 4 octets 
# de padding) dans le cadre de pile.
main:
	sub $sp, $sp, 24 # 24 = 16+ 8
	sw $ra, 16($sp) # Sauvegarde de $ra au début du bloc R
	
	li $a0, 5
	jal facto
	# On récupère le résultat dans $v0
	# Affichage de $v0
	move $a0, $v0
	li $v0, 36 # print_uint (affichage d'un entier non signé)
	syscall
	# Passage à la ligne (affichage d'un '\n')
	li $a0, '\n'
	li $v0, 11 # print_char
	syscall
	
	lw $ra, 16($sp)
	add $sp, $sp, 24
	jr $ra
	

# unsigned int facto(unsigned int n)
# {
#   if (n <= 1) {
#      return 1;
#   } else {
#      return n*facto(n-1);
#   }
# }	
# La fonction facto() appelle une autre fonction avec moins de 5 paramètres; elle doit donc
# créer un bloc P de 4*4=16 octets et un bloc R d'au moins 8 octets (4 octets pour $ra et 4 octets 
# de padding) dans le cadre de pile.
# La fonction facto() a besoin de garder la valeur de son paramètre d'entrée pour faire la multiplication avec
# le résultat de l'appel récursif facto(n-1). On sauvegarde donc $a0 au début dans le bloc P de l'appelant. Comme
# on remet $a0 à sa valeur d'entrée en sortie, on a la garantie que la valeur de $a0 avant un appel à facto() est
# identique à sa valeur après l'appel.

facto:
	sub $sp, $sp, 24
	sw $ra, 16($sp)
	sw $a0, 24($sp) # Sauvegarde de $a0 dans le bloc P du cadre de pile de l'appelant
	
if:	bgtu $a0, 1, else # Attention: 'bgtu' et 'non bgt' car $a0 est un nombre non signé
then:
	li $v0, 1
	b endif
else:
	sub $a0, $a0, 1
	jal facto  # facto($a0-1)
	# Après l'appel de facto(), $a0 contient la même valeur qu'avant l'appel, i.e., $a0-1
	# donc, en ajoutant 1, on retrouve le paramètre d'entrée sans avoir besoin de le reprendre sur la pile.
	add $a0, $a0, 1 
	mul $v0, $a0, $v0
endif:

	lw $a0, 24($sp)
	lw $ra, 16($sp)
	add $sp, $sp, 24
	jr $ra
	
			
		  
