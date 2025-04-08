						ORG 0
WAIT_TO_START:
						IN Switches
						;JZero START
                        JZero SWITCH_8
						JUMP WAIT_TO_START ; wait for all switches to be down to start
START:
						LOADI 65
						STORE ASCII ; initialize ascii value
CHECK_SWITCH_UP:
						IN Switches
						JZERO CHECK_SWITCH_UP ; wait for switch to be raised
SWITCHES_UP:
						LOAD ASCII
                        OUT LEDs
					;	OUT SevSeg ; display character on 7 segment display
						;OUT Morse
						IN Switches
						JZERO NEXT_CHARACTER ; if all switches lowered, go to SWITCHES_DOWN
						JUMP SWITCHES_UP ; wait for user to lower all switches
NEXT_CHARACTER:
						LOAD ASCII 
						ADDI 1 ; go to next character
						STORE ASCII
						SUB Last_Val ; check if it is last value
						JPOS START ;; restart if past last value
						JUMP CHECK_SWITCH_UP
                        
SWITCH_8:
						IN Switches ; Takes in the input from the switches
                        STORE ASCII
                        SHIFT -7 ; This will see if the input is within the range
                        AND A 
                        JPOS SWITCH_8 ; If AC is Pos that means its too large and will loop until it is in the range
                        IN Switches ; The input is within the top range
                        SHIFT 10 ;This number will determine the letter if its in range 1-26 or 65-90.
                        ; The prev shift will cut off so we only look at the input
                        SHIFT -10 ; A goes from 65 to 1
                        AND B
                        ;STORE ASCII
                        ;SUB MAX
                        ADDI -27
                        JNEG DISPLAY ; within top and bottom range 
                        JZERO SWITCH_8; within top and bottom range
                        JPOS SWITCH_8
                        
DISPLAY:
						LOAD ASCII
						;OUT Morse
                        OUT LEDs
                        JUMP SWITCH_8
                        

;; VARIABLES AND STUFF
ASCII: DW 0 ;; stores current ascii value
Switches: EQU 000
Timer: EQU 002
LEDs: EQU 001
;Morse: EQU 032
;SevSeg: EQU 007 
Last_Val: DW &H5A
A: DW 1
B: DW 63
MAX: DW 27