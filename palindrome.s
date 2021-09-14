.global _start

.section .text

_start:
	mov r0, #0 						// r0 = i = 0
	ldr r1, =input				// input words
	mov r2, #0						// r2 = j = 0, but we need it to be length of word - 1 				
	
	ldrb r3, [r1, r2] 		// first char 
	
	bl find_length
	sub r2, r2, -1 				// j = len(string) - 1
	
	bl check_palindrome
	
	b exit 
	
	
find_length: 					// find and set length of input string 
	cmp r3, #0
	bne check_input_main
	mov pc, lr					// Move pc back to start function call 	
	
	find_length_main:
	add r2, r2, #1 				// Increment r2 (j++)
	ldrb r3 [r1, r2]			// update r3 to be next char, string[j]
	b check_input 				// branch to loop
	
	
check_palindrome: 				// Check if input is a palindrome
	cmp r0, r2							// check for r0 < r2 
	blt while_palindrome
	
	while_palindrome:				// while r0 < r2 { } 
	
	
is_capital:								// if current char is capital

is_non_capital:						// if current char is non capital
	
is_number:								// if current char is a number


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
 
	light_address: .word 0xff200000
	
	// input: .asciz "8448"
    // input: .asciz "KayAk"
    // input: .asciz "step on no pets"
    // input: .asciz "Never odd or even"


.end

