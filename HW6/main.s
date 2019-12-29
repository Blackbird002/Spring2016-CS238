; Riad Shash
; ID: n845y337
; File: main.s
; Home Assignment 6
; CS 238

 
; This file needs to be in a Keil version 5 project, together with file init.s,
; for all CS 238 programming Home Assignments

; This is a demo program, which you will need to change for each Home Assignment

; Executable code in this file should start at label main

	EXPORT	main		; this line is needed to interface with init.s

; Usable utility functions defined in file init.s
; Importing any label from another source file is necessary
; in order to use that label in this source file

	IMPORT	GetCh
	IMPORT	PutCh
	IMPORT	PutCRLF
        IMPORT	UDivMod
	IMPORT	GetDec					;Gets a integer from the screen and put it into R0
	IMPORT	PutDec					;Prints a integer to the screen 
	IMPORT	GetStr
	IMPORT	PutStr					;Prints a string to the screen

	AREA    MyCode, CODE

	ALIGN			; highly recommended to start and end any area with ALIGN

; Start of executable code is at following label: main

main

;-------------------- START OF MODIFIABLE CODE ----------------------

	PUSH	{LR}		; save return address of caller in init.s
L1
	LDR R0, =P1							; Address of P1
	BL PutStr							; Prints P1 to the screen
	BL GetDec							; Gets the size of the array from the user 
	;while (0 <= length <= max)			; Makes sure the sure the user enters a valid size value
		CMP R0, #0
		BLT L1
		CMP R0, #Max
		BGT L1
	;endwhile
	
	LDR R1, =Length
	STR R0, [R1]						;Moves the size of the array to memory
	LDR R0, =P2
	BL PutStr							;Prints P2 to the screen
	LDR R1, =Length
	LDR R0, [R1]
	BL PutDec							;Displays the size on the screen
	LDR R0, =P3		
	BL PutStr							;Displays P3 to the screen
	
	LDR R2, =Array						;R2 := address of the 1st element in the Array
	
	LDR R1,[R1]							;R1 contains the length and will be the counter
L2
	;for (i = 0 to (Length -1))
		CMP R1, #0
		BLE ReadFin
	;do
		BL GetDec
		STR R0, [R2]
		ADD R2, R2, #4					;Iterates to the next element in the array
		SUB R1, R1, #1					;Length = Length -1 (R1)  
		B L2							;Goes back to the start of the for loop
	;end for
ReadFin

ASKAGAIN
	LDR R0, =P4 
	BL PutStr							;Prints P4 to the screen
	BL GetCh
	;While (Prompted character input Y/N for searching = 'Y' or 'y')
		CMP R0, #'y'
		BEQ L3
		CMP R0, #'Y'
		BNE Finished
	;do
L3
		LDR R0, =P5
		BL PutStr
		BL GetDec						;Displays message that asks for the value to be searched for
		MOV R8, R0						;R8 contains the value to search for in the array
		
		LDR R1, =Length
		LDR R1, [R1]					;R1 := Length
		SUB R1, R1, #1					;Length = Length -1
		MOV R2, #0						;R2 contains the counter!
		
		MOV R10, #0						;(R10 := FOUND) and Found := False
		
		LDR R3, =Array
		
L4
		
		;for i := 0 to (Length-1)
			LDR R4, [R3]
			;if V = A[i]
				CMP R4, R8
			;then
				BNE	Elsepart
				MOV R10, #1					;Found := TRUE
				BEQ Break
			;else
Elsepart
				ADD R3, R3, #4				;Iterates to the next element in the array
				ADD R2, R2, #1				;Adds 1 to the counter
				CMP R2,R1
				BGT Break
				B L4
			;end if
		;end for
Break

		;if (found)
			CMP R10, #1
			BNE NotFound
		;then
			LDR R0, =P6
			BL PutStr						;Displays P6 to the screen
			MOV R0, R8
			BL PutDec						;Displays the value to be found on the screen
			LDR R0, =P7
			BL PutStr						;Displays P7 to the screen
			MOV R0, R2
			BL PutDec						;Displays the poition in the array where the wanted integer is located
			MOV R10, #0						;Resets the Found Boolean to False
			B ASKAGAIN						;Asks if the user wants to search for another element in the array (branches back)
			
NotFound
		;else
			LDR R0, =P8
			BL PutStr
			B ASKAGAIN						;Asks if the user wants to search for another element in the array (branches back)
Finished	
			
			

			LDR R0, =P9
			BL PutStr						;Displays P9 to the screen indicating that the program is done
			
			;end while
	
		

	
	
	POP	{PC}		; return from main
	
; Some commonly used ASCII codes

CR	EQU	0x0D	; Carriage Return (to move cursor to beginning of current line)
LF	EQU	0x0A	; Line Feed (to move cursor to same column of next line)

; The following data items are in the CODE area, so address of any of
; these items can be loaded into a register by the ADR instruction,
; e.g. ADR   R0, Prompt1 (using LDR is possible, but not efficient)

P1	DCB	"Please enter the length of the array (max is 100): ", 0
P2  DCB	"Please enter ", 0
P3  DCB " integers (press enter after each entered integer):" ,LF, 0
P4  DCB LF, "Do you want to search for an integer in the array? (Y/N): " ,LF, 0
P5  DCB LF, "What integer do you want to search for? ", 0
P6  DCB LF, "The value of ", 0
P7  DCB " was found in position ", 0
P8	DCB	"The value requested was not found in the array. ",0
P9	DCB LF, "End of program",0

	ALIGN
		
; The following data items are in the DATA area, so address of any of
; these items must be loaded into a register by the LDR instruction,
; e.g. LDR   R0, =Name (using ADR is not possible)

	AREA    MyData, DATA, READWRITE
		
	ALIGN

Max		EQU		100		;The max size of the array is 100 elements
	
Length	SPACE	4		;The size of the array value will go here

Array	SPACE	4*Max	;Storage space for the array in memory

;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file
