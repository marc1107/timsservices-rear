*-----------------------------------------------------------
* Title      : Aufgabe3
* Written by : Roland Burke  / Tim Koehler
* Date       : 21.05.2019
* Description: Converts each number(ASCII) from a String to the representing decimal number
*-----------------------------------------------------------
        ORG    $2500
START:                                  ; First instruction of program
        LEA     DEZ,    A0              ; Get address from the number String
        MOVE.L  #10000, D2              ; Startng by valence (Wertigkeit) 10000  


LOOP ; while( currentChar((A0)+) != '\0' )      
        CLR.L   D1                      ; Clear D1 because multiplication with valence could be bigger than 1 Byte
        MOVE.B  (A0)+,  D1              ; Get current number
        SUB.B   #$30,   D1              ; Convert asci number to matching decimal number    
        MULU.W  D2,     D1              ; Multiply the decimal number by the valence
        DIVU.W  #10,    D2              ; Unsigned devision to reduce valence
        ADD.L   D1,     D5              ; Add current value to sum of all
        
        CMP.B   #0,     (A0)            ; Checks if end of string is reached
        BNE     LOOP                    ; Jump if != EndOfString
        
        MOVE.W D5,      DUAL            ; Moves result to DUAL in memory
        
        SIMHALT                         ; Halt simulator
        
DEZ     DC.B    '23456', 0              ; Number as ASCII String
DUAL    DS.L    1                       ; Storage for the result

        END    START                    ; Last line of source







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
