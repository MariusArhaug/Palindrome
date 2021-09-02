.global _start

.section .text

_start:
	// Here your execution starts
	mov r0, #0
	ldr r1, =input
	mov r2, #0
	ldr r3, [r1]
	
	bl check_input
	b exit 
	
	
check_input:
	// check length of input string 
	cmp r1, 0x00
	ble check_input_main
	mov pc, lr
	
	check_input_main:
	add r2, r2, #1 	// add 1 to r0 
	b check_input 	//branch to loop
	
	
check_palindrome:
	// Here you could check whether input is a palindrome or not
	cmp r0, r2
	bl while_palindrome
	
	while_palindrome:
	cpm 
	
	
palindrome_found:
	// Switch on only the 5 rightmost LEDs
	// Write 'Palindrome detected' to UART
	
	
palindrom_not_found:
	// Switch on only the 5 leftmost LEDs
	// Write 'Not a palindrome' to UART
	
	
exit:
	// Branch here for exit
	b exit
	

.section .data
.align
	// This is the input you are supposed to check for a palindrome
	// You can modify the string during development, however you
	// are not allowed to change the label 'input'!
	input: .asciz "level"
	space: .asciz " " 
	// input: .asciz "8448"
    // input: .asciz "KayAk"
    // input: .asciz "step on no pets"
    // input: .asciz "Never odd or even"


.end

