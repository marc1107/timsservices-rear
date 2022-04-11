*-----------------------------------------------------------
* Title      : Aufgabe4
* Written by : Roland Burke / Tim Koehler
* Date       : 03.06.2019
* Description: This programm sorts a String by its ASCII values with InsertionSort
*-----------------------------------------------------------
        ORG     $2500           ; Start of the programm
START:
        LEA     STRING,     A0      ; Get start address of String 'Rechnerarchitektur'
        MOVE.B  #1,         D1      ; Initialize D1 with 1; D1 is the counter for the for-loop            
        ADD.L   #1,         A0      ; Increase A0 by 1; its the pointer to the current position at the String

OUTERLOOP1: ; for (D1 < STRING.length; D1++)
        MOVE.B  (A0),       D0      ; D0 = key; key is the current element of the unsorted part of the String 
            
        MOVE.B  D1,         D2      ; Get copy of counter for the second loop...
        SUB.B   #1,         D2      ; ...and decrease it by 1 because we want to compare it        
            
        MOVE.L  A0,         A1      ; Get copy of current position for a second pointer of the String
        SUB.L   #1,         A1      ; A1 is current position - 1
            
        CMP.B   #0,         D2      ; Check if EndOfString is reached...
        BLT     OUTERLOOP2          ; ...branch to OUTERLOOP2 if true
        MOVE.B  (A1),       D5      ; Get current number in String
        CMP.B   D5,         D0      ; If current number is less than current number - 1
        BLT     INNERLOOP           ; ...branch to INNERLOOP
            
        BRA     OUTERLOOP2          ; If not branched to INNERLOOP, branch to OUTERLOOP2

INNERLOOP: ; while (D2 >= 0 && D0 < (A1))
        MOVE.B  (A1),       1(A1)   ; Move element of sorted part to make space for the key
        SUB.B   #1,         D2      ; Reduce Counter by 1
        SUB.L   #1,         A1      ; Reudce Pointer to current position at String by 1
            
        CMP.B   #0,         D2      ; Check if EndOfString is reached...
        BLT     OUTERLOOP2          ; ...branch to OUTERLOOP2 if true
        MOVE.B  (A1),       D5      ; Get current number in String
        CMP.B   D5,         D0      ; If current number is less than current number - 1
        BLT     INNERLOOP           ; ...branch to INNERLOOP

OUTERLOOP2: 
        MOVE.B  D0,         1(A1)   ; Set the key to current position in sorted part of the String to current position + 1
 
        ADD.B   #1,         D1      ; Increase D1 by 1 (Counter for for-loop)
        ADD.L   #1,         A0      ; Increase A0 by 1 pointer to current position at String
            
        CMP.B   #0,         (A0)    ; Checks if end of string is reached
        BNE     OUTERLOOP1          ; Jump if != EndOfString
        
        SIMHALT                     ; Halt simulator
        
STRING  DC.B 'Rechnerarchitektur', 0 ; Define String 'Rechnerarchitektur' with end 0 

END:
        END  START                  ; Last line of source










*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
