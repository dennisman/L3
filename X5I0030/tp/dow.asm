# Feuille de TP 4 -- X5I0030, Faculté des sciences et des Techniques de Nantes
# Auteur: Frédéric Goualard <Frederic.Goualard@univ-nantes.fr>

	.data
dim:		.asciiz "dimanche"
lun:		.asciiz "lundi"
mar:		.asciiz "mardi"
mer:		.asciiz "mercredi"
jeu:		.asciiz "jeudi"
ven:		.asciiz "vendredi"
sam:		.asciiz "samedi"
jour_str: 	.word dim, lun, mar, mer, jeu, ven, sam
qjour: 		.asciiz "Jour ? "
qmois:		.asciiz "Mois ? "
qannee:		.asciiz "Année ? "
res_str:	.asciiz "Résultat: "
t:		.byte 0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4


	.text
	.globl __start

__start:
	li $v0, 4
	la $a0, qjour
	syscall
	li $v0, 5
	syscall
	move $t2, $v0

	li $v0, 4
	la $a0, qmois
	syscall
	li $v0, 5
	syscall
	move $t1, $v0

	li $v0, 4
	la $a0, qannee
	syscall
	li $v0, 5
	syscall
	move $t0, $v0

	
if:	bge $t1, 3, endif
then:	sub $t0, $t0, 1
endif:
	move $t3, $t0
	srl $t4, $t0, 2
	add $t3, $t3, $t4
	div $t4, $t0, 100
	sub $t3, $t3, $t4
	srl $t4, $t4, 2
	add $t3, $t3, $t4
	la $t5, t
	sub $t4, $t1, 1
	add $t4, $t4, $t5
	lb $t4, ($t4)
	add $t3, $t3, $t4
	add $t3, $t3, $t2
	rem $t3, $t3, 7
	sll $t3, $t3, 2	

	la $t5, jour_str
	add $t5, $t5, $t3
	lw $a0, ($t5)
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall