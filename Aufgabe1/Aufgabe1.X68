*-----------------------------------------------------------
* Title      : Aufgabe1
* Written by : Roland Burke / Tim Koehler 
* Date       : 29.04.2019
* Description: Adds two constants and stores the result in memory. Then decreases it 200x by 1 and stores each value in memory.
*              Adds the positiv difference between the n and n-1 value in memory 200x starting at Anfang + 2.
*              Checks how much of the first 140 stored values are divisible by 2 and saves the number.
*-----------------------------------------------------------
            ORG     $3000
START:                      ; first instruction of program
    MOVE.W  ANFANG, A0      ; Prepares the address in ANFANG for use 
    MOVE.W  RES_SUM,A2      ; Prepares the address in RES_SUM for use
    MOVE.W  RES_DIFF,A3     ; Prepares the address in RES_DIFF for use
    CLR.B   ERGEB           ; Clear 1 Byte at ERGEB because we only need to count to 70
    CLR.W   (A0)            ; Clear 2 Bytes at ANFANG because the the sum of K1 and K2 can't be bigger than 2 bytes
    CLR.L   (A2)            ; Clear 4 Bytes at RES_SUM because the sum of all can be bigger than 2 bytes
    CLR.B   (A3)            ; Clear 1 Byte at RES_DIFF because the highest possbile result is 200

    MOVE.W  K1,     D0      ; Get K1 for addition
    ADD.W   K2,     D0      ; Add K2 and store the sum in 'D0'
         
    MOVE.L  D0,     (A2)    ; Set Start value for sum of all values; Longword because sum could be larger than 2 bytes
    MOVE.L  A0,     A1      ; Get copy of ANFANG address to have a second pointer
    MOVE.W  D0,     (A0)+   ; Moves the result of the constants in memory at the address ANFANG
    
    MOVE.W  ANFANG, A4      ; Calculating final address for the...
    ADD.L   #402,   A4      ; ...following loop (200 words = 400 byte), 402 because of post increment   
    
LOOP
    SUB.W   #1,     D0      ; Decrease value by 1
    MOVE.W  D0,     (A0)    ; Write decreased value in memory
    ADD.L   D0,     (A2)    ; Add value to RES_SUM
    
    MOVE.W  (A1)+,  D2      ; Get number (bigger) from current address - 1; 'A1' is current address - 1
    SUB.W   (A0)+,  D2      ; Get number (smaller) from current address for calculating the differenz
    ADD.B   D2,     (A3)    ; Add Differenz to RES_DIFF
    CMP     A4,     A0      ; If current address != final address...
    BNE     LOOP            ; ...jump to LOOP
      
    MOVE.W  ANFANG, A4      ; Calculating final address for the...
    ADD.L   #278,   A4      ; ...following loop (140 words = 280 byte) 
    
    MOVE.W  ANFANG, A0      ; Reset of current address

LOOP2
    MOVE.W  (A0)+,  D0      ; Writes value at current address in 'D0'
    LSR.L   #1,     D0      ; 1 Bit right shift, the least significant bit will then be the carry bit
    BCS     LOOP2           ; Jump if carry bit is set (odd number)
    ADD.B   #1,     ERGEB   ; ...no jump means even number and ERGEB will be incremented
    CMP.W   A4,     A0      ; If current addres != final address...
    BNE     LOOP2           ; ...jump
        
            SIMHALT         ; halt simulator

K1          DC.W    $1111   ; Constant K1 for addition
K2          DC.W    $6999   ; Constant K2 for addition
ANFANG      DC.W    $4000   ; Address for result of the sum K1 and K2
RES_SUM     DC.W    $4500   ; Address for the sum of all values (n + n-1 + n-2...)
RES_DIFF    DC.W    $4510   ; Address for the sum of difference between every value
            ORG     $4600   ; Set origin to position where the following storage should be defined
ERGEB       DS.B    1       ; Reserve 1 byte of storage, because we only count to 70
            END     START   ; last line of source



























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
