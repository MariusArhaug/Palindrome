.global _start

.section .text

_start:
	LDR r0, =input						// input words
	MOV r1, #0								// r0 = i = 0 				
	MOV r2, #0 								// r2 = j = 0
	LDR r5, =0xFF200000				// address of LEDs
	STR r1, [r5]							// reset LEDs

	B find_length							// update j value to be length of word
	
	
find_length: 								// find and set length of input string
	LDRB r3, [r0, r2]					// r3 = string[i]
	CMP r3, #0								// check if string[i] is at end of string
	BEQ main									// if end of string go to main 
	ADD r2, r2, #1 						// Increment r2 (j++)
	B find_length 						// iterate again


main: 
	SUB r2, r2, #1	 					// j = len(string) - 1
	B check_palindrome


check_palindrome: 					
	CMP r1, r2								// while r1 < r2 (i < j) do while_palindrome
	BLT while_palindrome
	B palindrome_found

while_palindrome:						// while r0 < r2  
	LDRB r3, [r0, r1]					// r3 = string[i]
	LDRB r4, [r0, r2]					// r4 = string[j]
	CMP r3, #0x20							// if string[i] is space
	ADDEQ r1, r1, #1					// i++

	CMP r4, #0x20							// if string[j] is space
	SUBEQ r2, r2, #1					// j--

	LDRB r3, [r0, r1]					// r3 = string[i]
	LDRB r4, [r0, r2]					// r4 = string[j]

	CMP r3, #0x40							// if (0x40 < r3 < 0x5B) then r3 is capital 
	CMPGT r3, #0x5B					
	ADDLT r3, r3, #0x20				// make r3 non capital

	CMP r4, #0x40							// if (0x40 < r4 < 0x5B) then r4 is capital
	CMPGT r4, #0x5B			
	ADDLT r4, r4, #0x20				// make r4 non capital


	CMP r3, r4								//if string[i] != string[j] => palindrome not found
	BNE palindrom_not_found 	// exit while loop

	ADD r1, r1, #1						// i++
	SUB r2, r2, #1						// j--
	B check_palindrome				// go to iterate checker
	


palindrome_found:						// Switch on only the 5 rightmost LEDs. Write 'Palindrome detected' to UART
	LDR r6, =success
	LDR r8, =0xFE0
	
	B print_message
	
palindrom_not_found: 				//Switch on only the 5 leftmost LEDs. Write 'Not a palindrome' to UART
	LDR r6, =error
	LDR r8, =0x1F
	B print_message

print_message:
	LDR r5, =0xFF201000 		// load JTAG address
	MOV r7, #0							// i = 0
	print_loop:
		LDRB r2, [r6, r7] 		// string[i]
		CMP r2, #0		  			// if string is at end of line, exit
		BEQ light_up	  			// When done printing, light up
		STR r2, [r5]					// store string[i] in r5
		ADD r7, r7, #1	  		// i++
		B print_loop

light_up:
	LDR r5, =0xFF200000			// load LED address
	STR r8, [r5]
	B exit
	
	
exit:	// exit program
	B exit	
	

.section .data
.align

	
 	error: .asciz "Not a palindrome \n"
	success: .asciz "Palindrome detected \n"
	
	// Test Palindromes: 
	input: .asciz "level"				// ok!			
	// input: .asciz "LEVEL"				// ok!
	// input: .asciz "LEvel" 				// ok! 							
	// input: .asciz "8448"					// ok!					
    // input: .asciz "KayAk"				// ok!				
    // input: .asciz "step on no pets"		// ok!
    // input: .asciz "Never odd or even"	// ok!	
	
	// Test non palindromes: 
	//input: .asciz "Palindrome"			// ok!
	//input: .asciz "84418"					// ok!
	//input: .asciz "First level"			// ok!

.end

