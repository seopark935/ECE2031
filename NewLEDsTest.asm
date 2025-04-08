						ORG 0
WAIT_TO_START:
						IN Switches
						JZero START
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

;; VARIABLES AND STUFF
ASCII: DW 0 ;; stores current ascii value
Switches: EQU 000
Timer: EQU 002
LEDs: EQU 001
;Morse: EQU 032
;SevSeg: EQU 007 
Last_Val: DW &H5A
