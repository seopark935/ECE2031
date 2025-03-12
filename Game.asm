FullReset:					
					LOADI 0
					STORE TotalScore
RoundReset:
					LOADI 0
                    STORE Rand
					OUT Hex0
					STORE Time
					STORE Solution
					CALL ShowScore
RoundStart:
					IN Switches
					OUT LEDs
					JZERO StartTimer
					JUMP RoundStart
StartTimer:	
					LOAD Rand
					ADDI 1
					STORE Rand
					IN Switches
					OUT LEDs
					SUB Bit10
					JZERO Guessing
					JUMP StartTimer
Guessing:
					LOAD Rand
					AND Mask8
					JZERO ZeroCase
					JUMP ShowRand
ZeroCase:
					LOAD Rand
					SHIFT -8
ShowRand:
					OUT Hex0
					CALL FindLowestSetBit
					STORE Solution
					OUT Timer
Check:					
					IN Switches
					OUT LEDs
					SUB Bit10
					JZERO Check
					IN Timer
					STORE Time
					IN Switches
					CALL FindLowestSetBit
					SUB Solution
					JZERO Correct
					JUMP FullReset ; Incorrect
Correct:
					LOADI 20
					SUB Time
                    JPOS Positive
					LOADI 0
                    ADD TotalScore
                    STORE TotalScore
                    JUMP RoundReset

Positive:
					ADD TotalScore
                    STORE TotalScore
                    JUMP RoundReset	
					
ShowScore:			; Function to show score on Hex0
					STORE ACValue
					LOAD TotalScore
					OUT Hex1 ; Outputs to the 2-digit display on the left
					LOAD ACValue
					RETURN
ACValue: 			DW 0

FindLowestSetBit:	; Function to find lowest bit in AC, returns count from 0-index LSB
					STORE FLSB_Temp
					LOADI 0
					STORE FLSB_Counter
StartLoop: 
					LOAD FLSB_Temp
					AND FLSB_Mask
					JPOS FLSB_Found
					LOAD FLSB_Counter
					ADD FLSB_Mask
					STORE FLSB_Counter
					SUB FLSB_Difference
					JPOS FLSB_NotFound
					LOAD FLSB_Temp
					SHIFT -1
					STORE FLSB_Temp
					JUMP StartLoop
FLSB_Found: 	  
					LOAD FLSB_Counter
					RETURN
FLSB_NotFound: 		
					LOADI 0
					SUB FLSB_Mask
					RETURN

FLSB_Counter: 	  	DW 0
FLSB_Difference:  	DW 16
FLSB_Temp: 		  	DW 0
FLSB_Mask: 		  	DW 1



Bit10:				DW &H200	; Constants
Mask8:				DW &HFF		;
Bit1: 				DW 1

TotalScore:			DW 0 		; Variables used during game
Rand:				DW 0
Time: 				DW 0
Solution: 			DW 0


Switches: 		 	EQU 000 	; Peripheral constants
LEDs:      			EQU 001
Timer:     			EQU 002
Hex0:      			EQU 004
Hex1:      			EQU 005