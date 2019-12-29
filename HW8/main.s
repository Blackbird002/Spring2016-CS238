; File: main.s
 
; This file needs to be in a Keil version 5 project, together with file init.s,
; for all CS 238 programming Home Assignments

; This is a demo program, which you will need to change for each Home Assignment

; Executable code in this file should start at label main
	INCLUDE		LM4F120H5QR.inc
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

;------------------------------------------- START OF MODIFIABLE CODE ------------------------------------

	PUSH	{LR}							; save return address of caller in init.s

	LDR	R0, =Msg1							; R0 = address Prompt1 (in code area)
	BL	PutStr								; display prompt for asking name
	
	BL GetDec
	MOV R1, R0
	
	LDR R0, =Msg2
	BL PutStr
	
	MOV R0, R1
	BL PutDec
	
	LDR R0, =Msg3
	BL PutStr
	
	MOV R0, R1
	
	BL PutBin
	
	
	
	POP	{PC}								; return from main
;----------------------------------------------------------------------------------------------------------
PutBin
	PUSH {LR}
	
	;if (decval < 0)
		CMP R0, #0
		BGT L1
		;do
			MOV R10, #1										;R10 := 1 if decval is negative
			MOV R11 , #-1
			MUL R2, R0, R1
			MOV R0, R2
		;enddo
	;endif
L1
	MOV R12,R0											;Saves a copy of decval
	MOV R5,#0											;Sets the counter to 0
L2
	;repeat
		MOV R1, #2										;Sets R1:= 2 so division can occur
		BL UDivMod										; R0 = R0 % 2, and R1 = R0 / 2
														
													
		PUSH{R0}
		ADD R5,R5,#1
		MOV R0, R1
	;until (count == 0)
		CMP R1,#0
		BGT L2
L3	
	;repeat
		POP {R0}
		ADD R0,R0,#0
		SUB R5,R5,#1
		BL	UART_OutChar
	;until (count == 0)
		CMP R5,#0
		BGT L3
		
		
		


	
	POP{PC}
	
	
	
	
; Some commonly used ASCII codes

CR	EQU	0x0D	; Carriage Return (to move cursor to beginning of current line)
LF	EQU	0x0A	; Line Feed (to move cursor to same column of next line)

; The following data items are in the CODE area, so address of any of
; these items can be loaded into a register by the ADR instruction,
; e.g. ADR   R0, Prompt1 (using LDR is possible, but not efficient)

Msg1	DCB	"Please enter a decimal number you wish to convert to binary: ", LF, 0
Msg2	DCB "The binary representation of ", 0
Msg3	DCB " is ",0

	ALIGN
		
; The following data items are in the DATA area, so address of any of
; these items must be loaded into a register by the LDR instruction,
; e.g. LDR   R0, =Name (using ADR is not possible)

	AREA    MyData, DATA, READWRITE
		
	ALIGN
	
Value	SPACE	4		; 4 bytes for storing input number

;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file
