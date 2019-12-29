; Riad Shash 
; n845y337
; HW#9

;File: main.s
 
; This file needs to be in a Keil version 5 project, together with file init.s,
; for all CS 238 programming Home Assignments

; This is a demo program, which you will need to change for each Home Assignment

; Executable code in this file should start at label main

	PRESERVE8			; needed to interface with c code
	EXPORT	main		; this line is needed to interface with init.s
	EXPORT gcd			; So gcd function can interface with gcd6 C code function
	
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
	IMPORT	gcd6						;So the assembly code can use the gcd6 C code function

	AREA    MyCode, CODE

	ALIGN			; highly recommended to start and end any area with ALIGN

; Start of executable code is at following label: main

main

;-------------------- START OF MODIFIABLE CODE ----------------------

	PUSH	{LR}		; save return address of caller in init.s

	LDR R0,=Msg1
	BL PutStr
	
	LDR R0,=Msg2
	BL PutStr
	
	BL GetDec
	PUSH{R0}
	
	BL GetDec
	PUSH{R0}
	
	BL GetDec
	MOV R3, R0
	
	BL GetDec
	MOV R2, R0
	
	BL GetDec
	MOV R1, R0
	
	BL GetDec
	MOV R10,R0
	
	LDR R0,=Msg3
	BL PutStr
	
	MOV R0,R10
	
	BL gcd6								;Calls the C code function
	ADD SP,SP,#8						;Cleans up the stack
	
	BL PutDec
	
	POP	{PC}		; return from main
	
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

Msg1	DCB	"This program find the GCD for 6 numbers.",LF, 0
Msg2	DCB "Please enter 6 numbers (pressing enter after each input):",LF, 0
Msg3	DCB "The GCD is: ",0

	ALIGN
		
; The following data items are in the DATA area, so address of any of
; these items must be loaded into a register by the LDR instruction,
; e.g. LDR   R0, =Name (using ADR is not possible)

	AREA    MyData, DATA, READWRITE
		
	ALIGN
	

;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file
