# Feuille de TP 4 -- X5I0030, Faculté des sciences et des Techniques de Nantes
# Auteur: Frédéric Goualard <Frederic.Goualard@univ-nantes.fr>

	.data
invite_str:	.asciiz	"Année ? "
bissextile:	.asciiz "Bissextile"
pas_bissextile:	.asciiz "Pas bissextile"

	.text
	.globl __start
	
__start:
	li $v0, 4 # load immediat   v0 =4
	la $a0, invite_str#load etiq  a0 = annee ?
	syscall  # 4: affiche une chaine a0
	
	li $v0, 5# load immedia v0 = 5
	syscall  # lit un entier
	move $t0, $v0#	t0 = v0  v0 entier rentré
	
if1:	li $t2, 100
	rem $t1, $t0, $t2#  t1 = t0%10  (reste)
	bnez $t1, else1#  si t1 != 0 on va a else1 sinon on va a then1
then1:#t1 == 0
	la $a0, pas_bissextile# a0 = "pas bissextile"
	li $v0, 4# v0 = 4
	syscall # affiche une chaine a0
	b endif1
else1:
if2:	li $t2, 4
	rem $t1, $t0, $t2# t1 = t0%4
	bnez $t1, else2#si t1 != 0 on va a else1 sinon on va a then1
then2:
	la $a0, bissextile
	li $v0, 4
	syscall  # affiche bissextile
	b endif2
else2:
	la $a0, pas_bissextile
	li $v0, 4
	syscall  # affiche pas bissextile
endif2:
endif1:
	
	# exit()
	li $v0, 10
	syscall
