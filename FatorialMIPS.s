# Factorial 
#
# Objective: Computes the factorial of integers.
# Input: Requests one numbers.
# Output: Outputs the factorial.
################### Data segment ###################
.data
prompt: .asciiz   "Digite um valor inteiro: \n "
fact_msg:  .asciiz    "Fatorial de "
fact_msg2: .asciiz  " é igual a: \n "
reprise_msg: .asciiz "\n\nDezeja fazer novamento (1-sim/0-não): \n "
################### Code segment ###################
.text
.globl main
main:

    
    REFAZER: 
    la	 $a0,prompt 		# display prompt string
	li	 $v0,4
	syscall

	li $v0, 5               # ler valor inteiro e adiciona em $a0
	syscall
	move $a0, $v0
    move $t1, $v0

	jal fact                # Chamada da função Factorial
    
    move $t0, $v0           # move resultado do fatorial para $t0

    la	 $a0,fact_msg 		# display fact_msg string
	li	 $v0,4
	syscall

    move	 $a0,$t1 		# display vauler of intro
	li	 $v0,1
	syscall

    la	 $a0,fact_msg2 		# display fact_msg2 string
	li	 $v0,4
	syscall
	
	move $a0, $t0           # display Factorial
	li $v0, 1
	syscall
    
    la	 $a0,reprise_msg    # display reprise_msg string
	li	 $v0,4
	syscall


    li $v0, 5               # verificar se é desejado refazer um novo processo
	syscall
    bne $v0, $0, REFAZER
    

	
	li	 $v0,10             # exit
	syscall



# trecho de codigo retirado de: "https://drive.google.com/file/d/1ASoC3_3pT68nHwRxk6JEBWwQMi0y8m6n/view"
# Function Factorial ##############################################
	fact: 	slti	 $t0,$a0,2       		   # (n<2)?
		 
			beq 	 $t0,$0,else               # if false branch to else
			li 		 $v0,1                     # $v0 = 1
			jr 		 $ra                       # return to caller

	else: 	addiu 	 $sp,$sp,-8                # allocate 2 words on stack
 
			sw		 $a0,4($sp)                # save argument n
			sw 		 $ra,0($sp)                # save return address
			addiu	 $a0,$a0,-1                # argument = n-1
			jal 	 fact                      # call fact(n-1)
			lw 		 $a0,4($sp)                # restore argument
			lw		 $ra,0($sp)                # restore return address
			mul 	 $v0,$a0,$v0               # $v0 = n*fact(n-1)
			addi	 $sp,$sp,8                 # free stack frame
			jr		 $ra                    
#####################################################################


# by: Francisco Pereira and Ewelly Fabiane
