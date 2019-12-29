; File: ha3.s - used for CS 238, Home Assignment 3

; You need to edit this file by replacing all occurrences of "???" in the file,
; and submit the edited file on Blackboard as your Home Assignment 3 submission

; First, enter your Name and myWSUID on the following comment lines:

; Your Name: Riad Shash (Ray)
; Your myWSUID: n845y337

; ------------------------------------------------------------------------------------------

; Always include lines in this block - we'll understand them later

; Vector Table Mapped to Address 0 at Reset
; Linker requires __Vectors to be exported
 
		AREA    RESET, DATA, READONLY
		EXPORT  __Vectors
 
__Vectors 
		DCD  0x6C00     ; stack pointer value when stack is empty
		DCD  Reset_Handler  ; reset vector
  
		ALIGN
 
; Linker requires Reset_Handler
 
		AREA    MYCODE, CODE, READONLY
 
		ENTRY
		EXPORT Reset_Handler
 
 
Reset_Handler

; ------------------------------------------------------------------------------------------

; Single-step thru the following program in the debugger,
; observe the register contents after each instruction, and
; answer the questions asked.

; WRITE ALL YOUR ANSWERS IN THE HEX NOTATION, e.g. 0xA92C
; THE FIRST LINE IS ALREADY ANSWERED AS AN EXAMPLE

		MOV		R0, #14				; R0 = 0x0000000E

		MOV		R1, #1234			; R1 = 0x000004D2

		ADD		R2, R1, R0			; R2 = 0x000004E0, R1 = 0x000004D2, R0 = 0x0000000E

Ten		EQU		10
		LDR		R3, Data1
		ADD		R3, R3, #Ten			; R3 = 0x00000016
		
		MOV		R4, #-1				; R4 = 0xFFFFFFFF
		
		ADD		R5, R3, R4			; R5 = 0x00000015

		ADR		R0, Data1 + 4			; R0 = 0x00000030
		
		LDR		R6, [R0]			; R6 = 0x00000016
		
		LDR		R7, [R0,#4]			; R7 = 0x00000020

		SWI		&11				; Last executable instruction

 		ALIGN

Data1		DCD		12, 22, 32

		END						; End of program