; IODemo.asm
; Produces a "bouncing" animation on the LEDs.
; The LED pattern is initialized with the switch state.

ORG 0

	; Get and store the switch values
Start:
	IN  Switches
    STORE Temp
    LOADI 0
    STORE Counter
Loop:
    AND Bit10
    JZERO Skip
    LOAD Counter
    ADDI 1
    STORE Counter
Skip:
	LOAD Temp
    SHIFT 1
    STORE Temp
    JZERO End
    JUMP Loop
End:
   	LOAD Counter
    ADDI -2
    JPOS Start
    IN Switches
    STORE CurrentSwitch
    OUT    LEDs
	STORE  Pattern
    

Left:
	; Slow down the loop so humans can watch it.
	CALL   Check

	; Check if the left place is 1 and if so, switch direction
	
    
    LOAD   Pattern
	AND    Bit9         ; bit mask
	JPOS   Right        ; bit9 is 1; go right
	
	LOAD   Pattern
	SHIFT  1
	STORE  Pattern
	OUT    LEDs

	JUMP   Left
	
Right:
	; Slow down the loop so humans can watch it.
	CALL   Check

	; Check if the right place is 1 and if so, switch direction
	LOAD   Pattern
	AND    Bit0         ; bit mask
	JPOS   Left         ; bit0 is 1; go left
	
	LOAD   Pattern
	SHIFT  -1
	STORE  Pattern
	OUT    LEDs
	
	JUMP   Right
	
; To make things happen on a human timescale, the timer is
; used to delay for half a second.
Delay:
	OUT    Timer
WaitingLoop:
	IN     Timer
	ADDI   -5
	JNEG   WaitingLoop
	RETURN
    
Check:
	IN Switches
    SUB CurrentSwitch
    JZERO DelayRelay
    IN Switches
    OUT LEDs
    STORE Pattern
    STORE CurrentSwitch
DelayRelay:
	CALL Delay
    RETURN
    
    
ACValue: DW 0
; Variables
Pattern:   DW 0

; Useful values
Bit0:      DW &B0000000001
Bit9:      DW &B1000000000
Bit10:      DW &B10000000000

; IO address constants
Switches:  EQU 000
LEDs:      EQU 001
Timer:     EQU 002
Hex0:      EQU 004
Hex1:      EQU 005

; Variables for checking 2+ switches
Counter: DW 0
CurrentSwitch: DW 0
Temp: DW 0