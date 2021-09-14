.global _start

.section .text

_start:
	mov r0, #0 					// r0 = i = 0
	ldr r1, =input				// input words
	mov r2, #0					// r2 = j = 0, but we need it to be length of word - 1 				
	mov r5, #1					// isPalindrome = 1 (True)
	
	ldrb r3, [r1, r2] 			// first char 
	
	b find_length
	sub r2, r2, #-1 			// j = len(string) - 1
	
	ldrb
	b check_palindrome
	cmp r5, #1					// if r5 == 1 (True) => isPalindrome
	beq palindrome_found
	b palindrome_not_found
	

	b exit 
	
	
find_length: 					// find and set length of input string 
	cmp r3, #0
	bne check_input_main
	mov pc, lr					// Move pc back to start function call 	
	
	find_length_main:
	add r2, r2, #1 				// Increment r2 (j++)
	ldrb r3 [r1, r2]			// update r3 to be next char, string[j]
	b find_length 				// branch to loop
	
	
check_palindrome: 				// Check if input is a palindrome
	cmp r0, r2					// check for r0 < r2 
	blt while_palindrome
	mov pc, lr
	while_palindrome:			// while r0 < r2  
		ldrb r3, [r1, r0]		// r3 = string[i]
		ldrb r4, [r1, r2]		// r4 = string[j]
	
		cmp r3, #0x20				// if string[i] == ' ' => i++
		beq increment_i		
		increment_i:
			add r0, r0, #1

		cmp r4, 0x20				// if string[j] == ' ' => j--
		beq decrement_j
		decrement_j:
			sub r1, r1, #-1

		b compare_chars
		add r0, r0, #1
		sub r1, r1, #-1
		b check_palindrome
	


compare_chars:
	cmp r3, #0x41
	bgt is_capital_i
	
	cmp r4, #0x41
	bgt is_capital_j

	cmp r3, r4					//if string[i] != string[j] => palindrome not found
	bne not_equal
	not_equal:
	mov r5, #0
	

	
is_capital_i:					// if current char is capital |  0x41 < string[i] < 0x5A
	cmp r3, #0x5A						
	blt is_capital_main_i
	
	is_capital_main_i:
	add r3, r3, #0x20			// convert capital letter to non capital letter
		

is_capital_j:
	cmp r4, 0x5A
	blt is_capital_main_j
	
	is_capital_main_i:
	add r4, r4, #0x20			// convert capital letter to non capital letter



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

