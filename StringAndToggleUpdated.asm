; LED Controller Tester
; Displays morse code of alphabetical character
; Switch 8 and 9 control modes, switches[7:0] determines ASCII values

; 1. Lower all switches to start
; 2. Raise switch 9 to display string
;	- after displaying, switch 9 must be lowered (turned off) to continue
; 3. Raise switch 8 to display current ASCII represented by switches[0:7]
;	- if invalid ASCII input, display nothing
; 4. To change to other mode, current switch must first be lowered

ORG 0
WAIT_TO_START:
                    LOADI 0
                    OUT LEDs
                    IN Switches
                    JZERO START
                    JUMP WAIT_TO_START ; wait for all switches to be down to start
START:
					LOADI 0
                    OUT LEDs
                    IN Switches
                    ADDI -256
                    JNEG START ; if switches < 256, neither switch is raised
                    ADDI -256
                    JNEG TOGGLE_MODE ; if switches < 512, switch 9 is not raised
DISPLAY_STRING:
                    LOADI Char1 ; starting address of string
LOOP_STRING:
                    STORE CurrAddr
                    ILOAD CurrAddr ; get current character
                    JZERO END_STRING ; reached end of string, return to beginning
                    OUT LEDs ; display to LEDs
                    OUT Hex ; display to Hex
                    CALL Delay ; delay for LED display
					; increment to next character
                    LOAD CurrAddr
                    ADDI 1
                    STORE CurrAddr 
                    JUMP LOOP_STRING
END_STRING:			; wait for switch 9 to be lowered
					LOADI 0
                    OUT LEDs
END_STRING_LOOP:
                    IN Switches
                    ADDI -512
                    JNEG START
                    JUMP END_STRING_LOOP
TOGGLE_MODE:        
                    ; check whether input is valid or not (between 65 and 90)
                    IN Switches
                    AND Mask
                    ADDI -65
                    JNEG INVALID_INPUT ; input is less than 65
                    IN Switches
                    AND Mask
                    ADDI -90
                    JPOS INVALID_INPUT ; input is greater than 90
                   	IN Switches
                    AND Mask
                    OUT LEDs
                    
                    ; check switch 8
                    IN Switches
                    AND Bit8
                    JZERO START
                    JUMP TOGGLE_MODE

INVALID_INPUT:
					LOADI 0
                    OUT LEDs ; turn off all LEDs
                    JUMP START

DELAY: ; 1.5 second delay (for string display)
                    OUT Timer
WAITING_LOOP:
                    IN Timer
                    ADDI -15 ;; change to -100 to account for morse code
                    JNEG WAITING_LOOP
                    RETURN

;; Peripherals
Switches: EQU 000
Timer: EQU 002
LEDs: EQU 001
Morse: EQU &H020 ; change LEDs to Morse
Hex: EQU 004

; String to Display
CurrAddr: DW ; current address when iterating through string
Char1: DW &H45 ; first character of string (address of string)
Char2: DW &H43 ; second character of string
Char3: DW &H45 ; third character of string
CharEnd: DW &H0 ; null byte to signify end of string

; Tools for Toggle
Mask: DW &b0011111111 ; mask to get input for character select (switches[0:7])
Bit8: DW &b0100000000
