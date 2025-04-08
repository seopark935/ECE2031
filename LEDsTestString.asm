; LED Controller
; Displays morse code of alphabetical character
; Switch 8 and 9 control modes, switches[7:0] determines ASCII values
; If switch 9 raised -> display morse code of input string
; If switch 8 raised and all switches down -> display next character
; If switch 8 raised and switches[7:0] have valid ASCII -> display switches[7:0]
; otherwise, do nothing

ORG 0
WAIT_TO_START:
					LOADI 0
                    OUT LEDs
                    IN Switches
                    JZERO START
                    JUMP WAIT_TO_START ; wait for all switches to be down to start
START:
                    IN Switches
                    ADDI -512
                    JNEG START ; if switches < 512, switch 9 is not raised
				
DISPLAY_STRING:
					LOADI Char1 ; starting address of string
LOOP:
                    STORE CurrAddr
                    ILOAD CurrAddr ; get current character
                    JZERO WAIT_TO_START ; reached end of string, return to beginning
                    OUT LEDs
                    CALL Delay
                    
                    LOAD CurrAddr
                    ADDI 1
                    STORE CurrAddr ; increment address
                    JUMP LOOP
                    
DELAY:
					OUT Timer
WAITING_LOOP:
                    IN Timer
                    ADDI -15 ;; change to -100 to account for morse code
                    JNEG WAITING_LOOP
                    RETURN

;; VARIABLES AND CONSTANTS
Switches: EQU 000
Timer: EQU 002
LEDs: EQU 001 ; change to Morse

ORG &H0020
CurrAddr: DW ; current address when iterating through string
Char1: DW &H45
Char2: DW &H43
Char3: DW &H45
CharEnd: DW &H0 ; null byte
