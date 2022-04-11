*-----------------------------------------------------------
* Title      : Aufgabe2
* Written by : Roland Burke / Tim Koehler
* Date       : 03.05.2019
* Description: This Programm adds the ASCII Values of each letter in the String 'Kuenstliche-Intelligenz'
*              and calculates the average of all values
*-----------------------------------------------------------
        ORG    $2500
START:                                          ; first instruction of program
        
        LEA     STRING, A0                      ; Initialize address register A0 with address of 'STRING'
        LEA     summe,  A1                      ; Initialize address register A1 with address of 'summe'
        LEA     mittel, A2                      ; Initialize address register A2 with address of 'mittel'
        
        CLR.W   summe                           ; Clear 2 Bytes at 'summe'
        
        
LOOP ; while( (A0) != '\0' )
        MOVE.B  (A0)+,   D0                     ; Moves the ASCII value of the Letter in D0
        ADD.W   D0,     (A1)                    ; Add the current value to the sum of all at 'summe' in memory
        ADD.B   #1,     D1                      ; Counts how many letters the string has; for calculating the average
        
        CMP.B   #0,     (A0)                    ; if current value != 0... (0 is the end of the string)
        BNE     LOOP                            ; ... go to LOOP
        
        
        MOVE.W  (A1),   D0                      ; Prepare the sum of all for calculation of average
        DIVS.W  D1,     D0                      ; Divide the sum of all (D0) by the number of letters in the string (D1)
        MOVE.L  D0,     (A2)                    ; Write the average in memory at 'mittel'
     
        
        SIMHALT                                 ; halt simulator

STRING  DC.B    'Kuenstilche-Intelligenz', 0    ; String definition with '\0' at the end
summe   DS.W    1                               ; Storage for the sum of all: 2 Bytes
mittel  DS.L    1                               ; Storage for the average: 4 Bytes

        END    START                            ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
