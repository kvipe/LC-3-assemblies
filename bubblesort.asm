; Bubblesorting of ten-elements array
; KVIPE
; 01-2019
.ORIG x3000

;Greet user
LEA R0, Greeting0
PUTS
LD R0, NEWLINE
JSR PUTSYMB
LEA R0, Greeting1
PUTS
;
;Fill the 10-elements array
AND R1, R1, #0
ADD R1, R1, #10 ; R1 <- #10 (loop counter)
LD R2, CHAR0 ; R2 <- ASCII 1 (elements counter) 
LEA R4, ARRELEM0 ; Pointer to 0-element of array
;
FILLING LD R0, NEWLINE
JSR PUTSYMB
LEA R0, Prompt
PUTS
AND R0, R0, #0
ADD R0, R0, R2 ; R0 <- R2 (for output elements counter to console)
JSR PUTSYMB
LD R0, PROMPTSYMB
JSR PUTSYMB
ST R1, SaveR1
LEA R7, #2 ; PC Marker after INPDIGIT subroutine
ST R7, SaveR7 ; Save PC
JSR INPDIGIT
LD R1, SaveR1 ; Restore R1 after INPDIGIT subroutine
STR R0, R4, #0 ; Store entered digit in respectevely memory cell
ADD R4, R4, #1
ADD R2, R2, #1 ; R2 <- R2+1 (next digit char)
ADD R1, R1, #-1 ; R1 <- R1-1
BRnp FILLING
;
;Sort array
;R0 as arr[i-1], R1 as arr[i]
SORTING LEA R0, ARRELEM0
LEA R1, ARRELEM1
AND R2, R2, #0
ADD R2, R2, #9 ; Counter
AND R6, R6, #0

ARRLOOP LDR R3, R0, #0
;R3, R4 - values, R5 - result of compare, R6 - flag
LDR R4, R1, #0
;R5 <- R3-R4
NOT R5, R4
ADD R5, R5, #1
ADD R5, R3, R5 
BRnz #4
;flag=true
AND R6, R6, #0
ADD R6, R6, #1
;swapping (mem[r1]=r3, rmem[r0]=r4)
STR R3, R1, #0
STR R4, R0, #0

;R0+1, R1+1
ADD R0, R0, #1
ADD R1, R1, #1
;counter--
ADD R2, R2, #-1
BRp ARRLOOP
;IF swapped
ADD R6, R6, #0
BRp SORTING
;
;Print the array
LD R0, NEWLINE
JSR PUTSYMB
LEA R0, Result
PUTS
LD R0, SPACE
JSR PUTSYMB
LEA R2, ARRELEM0
AND R1, R1, #0
ADD R1, R1, #10
ARRLOOP2 LDR R0, R2, #0
JSR PUTSYMB
LD R0, SPACE
JSR PUTSYMB
ADD R2, R2, #1
ADD R1, R1, #-1
BRp ARRLOOP2
;
HALT

;SUBROUTINES

;Print one symbol
;R0 - Input arg
;R3 - Need to restore
PUTSYMB LDI R3, DSR
BRzp PUTSYMB
STI R0, DDR
RET
;

;Input digit
;R1, R3 - need to restore
INPDIGIT GETC
AND R1, R1, #0
ADD R1, R1, R0

LD R3, CHECKDIGIT0
ADD R1, R1, R3
BRn INPDIGIT
AND R1, R1, #0
ADD R1, R1, R0
LD R3, CHECKDIGIT9
ADD R1, R1, R3
BRp INPDIGIT
JSR PUTSYMB
LD R7, SaveR7 ; restore PC after calling another subroutines
RET

;VARIABLES

DSR .FILL xFE04 ; Display status
DDR .FILL xFE06 ; Display data
NEWLINE .FILL x000A
SPACE .FILL x0020
CHAR0 .FILL x0030
Greeting0 .STRINGZ "Welcome to the program! This is the array bubblesorting!"
Greeting1 .STRINGZ "Fill the 10-elements array and get a result."
Prompt .STRINGZ "Value of element "
Result .STRINGZ "Sorted array:"
PROMPTSYMB .FILL x003E ; > symbol
CHECKDIGIT0 .FILL #-48
CHECKDIGIT9 .FILL #-57
ARRELEM0 .BLKW 1
ARRELEM1 .BLKW 1
ARRELEM2 .BLKW 1
ARRELEM3 .BLKW 1
ARRELEM4 .BLKW 1
ARRELEM5 .BLKW 1
ARRELEM6 .BLKW 1
ARRELEM7 .BLKW 1
ARRELEM8 .BLKW 1
ARRELEM9 .BLKW 1
SaveR1 .BLKW 1
SaveR7 .BLKW 1

.END