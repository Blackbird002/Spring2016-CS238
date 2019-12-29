; Name: Riad Shash (Ray)
; ID: n845y337
; HW# 7
; File: main.s
 
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
	IMPORT	GetDec
	IMPORT	PutDec
	IMPORT	GetStr
	IMPORT	PutStr

	AREA    MyCode, CODE

	ALIGN			; highly recommended to start and end any area with ALIGN

; Start of executable code is at following label: main

main
;-------------------- START OF MODIFIABLE CODE --------------------------------------------------------------------

	PUSH	{LR}									; save return address of caller in init.s

	;LDR R3, =Value1								;R3 := address of Value1
	;LDR R4, =Value2								;R4 := address of Value2

	LDR	R0, =Msg1									; R0 = address Msg1 (in code area)
	BL	PutStr									
	
L1
	LDR	R0, =Msg2								
	BL	PutStr									
	BL	GetDec
	;while(number >= 0)
		CMP R0,#0
		BLT	L1
	;endwhile
	
	;STR R0, [R3]								;Stores 1st value into memory
	
	MOV R2,R0									;Moves the first value into R2
	
L2
	LDR	R0, =Msg3								
	BL	PutStr									
	BL	GetDec
	;while(number >= 0)
		CMP R0,#0
		BLT	L2
	;endwhile
	
	;STR R0, [R4]								;Stores 2nd value into memory
	
	MOV R1, R0									; Moves the second value into R1 as specified by pseudo code
	
	LDR	R0, =Msg4								
	BL	PutStr
	MOV R0, R2
	BL PutDec
	LDR	R0, =Msg6								
	BL	PutStr
	MOV R0, R1;
	BL PutDec
	LDR	R0, =Msg7								
	BL	PutStr
	
							
	MOV R0, R2									; Moves the first value into R0 as specified by pseudo code

	BL gcd										; Calls the gcd function to compute the GCD (stores in R0)
	BL PutDec									; Displays the result on the screen
	
	LDR	R0, =Msg5								
	BL	PutStr									; Tells the user that the program is done
	
	POP	{PC}									; return from main
	
;------------------------------gcd-------------------------------------------------------------------------------	
; Reads the value in R0 and R1 and computes the GCD of the two values
; The GCD gets stored in the R0 (so it only modifies the R0 register)
; Recursive function 
; It restores the value in R1

gcd
	;unsigned int gcd ( unsigned int a, unsigned int b )
	PUSH {R1, LR}
	
	;if (A > B)
		CMP R0, R1
		SUBHI R0,R0,R1							;R0 := R0 - R1
		BLHI gcd								; calls itself if (A < B)
	;endif
	
	;if (A < B)
		SUBLO R1,R1, R0							;R1 := R1 - R0
		BLLO gcd								;calls itself again if (A < B)
	;endif
	
	POP {R1, PC}								; retruns address and restores R1 register  
	
;	End of GCD function
;---------------------------------------------------------------------------------------------------------------	
; Some commonly used ASCII codes

CR	EQU	0x0D	; Carriage Return (to move cursor to beginning of current line)
LF	EQU	0x0A	; Line Feed (to move cursor to same column of next line)

; The following data items are in the CODE area, so address of any of
; these items can be loaded into a register by the ADR instruction,
; e.g. ADR   R0, Prompt1 (using LDR is possible, but not efficient)

Msg1	DCB	"Welcome to the GCD Program!",LF, 0
Msg2	DCB "Please enter a non-negative number:",LF, 0
Msg3	DCB "Enter the second number:",LF,0
Msg4	DCB "The GCD of ",0
Msg6	DCB " and ",0
Msg7	DCB " is: ",0
Msg5	DCB LF, "End of Program!",LF,0


	ALIGN
		
; The following data items are in the DATA area, so address of any of
; these items must be loaded into a register by the LDR instruction,
; e.g. LDR   R0, =Name (using ADR is not possible)

	AREA    MyData, DATA, READWRITE
		
	ALIGN

;----------------------------------------- END OF MODIFIABLE CODE --------------------------------------------

	ALIGN

	END			; end of source program in this file
