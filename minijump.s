

.data 
displayAddress: .word 0x10008000
x: .word 0
y: .word 0

.text
lw $t0, displayAddress # $t0 stores the base address for display
# colours
li $s0, 0x37d8de # blue 
li $s1, 0xffffff # white
li $s2, 0x000000 # black
li $s3, 0xfff647# yellow
li $s4, 0xffc757 # orange
li $s5, 0x756056 # brown 
li $s6, 0x329938  # green 



main:


# DRAWING THE BACKGROUND:
li $t8, 0x10008000 #coordinate counter
loop:
	beq $t8, 0x100090AC, exit
	sw $s0, 0($t8) # paint the current unit blue
	addi $t8, $t8, 4
	j loop
exit:

# DRAW THE GROUND:
li $t3, 0x10008F82
groundLoop:
	beq, $t3, 0x10009002, groundExit
	sb $s6, 0($t3) # paint green
	addi $t3, $t3, 4
	j groundLoop
groundExit:


# GENERATE RANDOM LOCATIONS FOR PLATFORMS
li $v0, 42
li $a0, 0
li $a1, 28
syscall


# Temporarily draw the platforms and doodler in some positions

li $a1, 0x10008940
li $t6, 0
platformLoop0: 
beq $t6, 28, pExit0
	sw $s6, 0($a1)
	sw $s5, 128($a1)
	addi $a1, $a1, 4
	addi $t6, $t6, 4
	j platformLoop0
pExit0:

li $a2, 0x10008cc0
li $t3, 0 # loop counter
Loop0: 
beq $t3, 28, exit1
	sw $s6, 0($a2)
	sw $s5, 128($a2)
	addi $a2, $a2, 4
	addi $t3, $t3, 4
	j Loop0
exit1:


li $a0, 0x10008710
li $t7, 0 # loop counter
platformLoop: 
beq $t7, 28, pExit
	sw $s6, 0($a0)
	sw $s5, 128($a0)
	addi $a0, $a0, 4
	addi $t7, $t7, 4
	j platformLoop
pExit:


# DOODLER INITIAL POSITION
li $a3, 0x10008C38
jal doodleUp
jal doodleDown

#addi $a3, $a3, 128
#jal drawDoodler



# JUMP UP
doodleUp:
# start
li $t5, 0
upLoop:
beq $t5, 5, upLoopExit
	# row 1
	sw $s1, 0($a3)
	sw $s1, 4($a3)
	sw $s1, 8($a3)
	sw $s1, 12($a3)
	# row 2
	sw $s1, 124($a3)
	sw $s1, 128($a3)
	sw $s3, 132($a3)
	sw $s3, 136($a3)
	sw $s1, 140($a3)
	sw $s1, 144($a3)
	# row 3
	sw $s1, 252($a3)
	sw $s2, 256($a3)
	sw $s3, 260($a3)
	sw $s3, 264($a3)
	sw $s2, 268($a3)
	sw $s1, 272($a3)
	# row 4
	sw $s1, 380($a3)
	sw $s4, 384($a3)
	sw $s3, 388($a3)
	sw $s3, 392($a3)
	sw $s4, 396($a3)
	sw $s1, 400($a3)
	# row 5
	sw $s1, 508($a3)
	sw $s1, 512($a3)
	sw $s3, 516($a3)
	sw $s3, 520($a3)
	sw $s1, 524($a3)
	sw $s1, 528($a3)
	# row 6
	sw $s1, 640($a3)
	sw $s1, 644($a3)
	sw $s1, 648($a3)
	sw $s1, 652($a3)

	# add to doodler position
	addi $a3, $a3, -128
	
	# erase bottom part of old doodler
	sw $s0, 764($a3)
	sw $s0, 896($a3)
	sw $s0, 900($a3)
	sw $s0, 904($a3)
	sw $s0, 908($a3)
	sw $s0, 784($a3)


	# show this scene for .. ms
	li $v0, 32
	li $a0, 500
	syscall
	# add to counter
	addiu $t5, $t5, 1

	j upLoop

upLoopExit:
doodleUpReturn:
	j doodleDown




# JUMP DOWN
doodleDown:
li $t4, 0
downLoop:
bgt $t4, 5, downLoopExit
	# row 1
	sw $s1, 0($a3)
	sw $s1, 4($a3)
	sw $s1, 8($a3)
	sw $s1, 12($a3)
	# row 2
	sw $s1, 124($a3)
	sw $s1, 128($a3)
	sw $s3, 132($a3)
	sw $s3, 136($a3)
	sw $s1, 140($a3)
	sw $s1, 144($a3)
	# row 3
	sw $s1, 252($a3)
	sw $s2, 256($a3)
	sw $s3, 260($a3)
	sw $s3, 264($a3)
	sw $s2, 268($a3)
	sw $s1, 272($a3)
	# row 4
	sw $s1, 380($a3)
	sw $s4, 384($a3)
	sw $s3, 388($a3)
	sw $s3, 392($a3)
	sw $s4, 396($a3)
	sw $s1, 400($a3)
	# row 5
	sw $s1, 508($a3)
	sw $s1, 512($a3)
	sw $s3, 516($a3)
	sw $s3, 520($a3)
	sw $s1, 524($a3)
	sw $s1, 528($a3)
	# row 6
	sw $s1, 640($a3)
	sw $s1, 644($a3)
	sw $s1, 648($a3)
	sw $s1, 652($a3)

	# add to doodler position
	addi $a3, $a3, 128

	# erase top part of old doodler
	sw $s0, 764($a3)
	sw $s0, 896($a3)
	sw $s0, 900($a3)
	sw $s0, 904($a3)
	sw $s0, 908($a3)
	sw $s0, 784($a3)

	# show this scene for .. ms
	li $v0, 32
	li $a0, 500
	syscall
	# add to counter
	addiu $t4, $t4, 1

	j upLoop

downLoopExit:
doodleDownReturn:
#jr $ra

# if a3 goes to illegal area, show game over or retry


Exit:
li $v0, 10 # terminate the program gracefully
syscall
