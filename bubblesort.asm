; Bubblesorting of ten-elements array
; KVIPE
; 01-2019

; R0 uses as the argument to PUTSYMB subroutine

.ORIG x3000
; Greeting
LEA R0, Greeting0
PUTS
LD R0, NEWLINE
JSR PUTSYMB
LEA R0, Greeting1
PUTS
;
; Array Filing
AND R1, R1, #0
ADD R1, R1, #10 ; R1 <- #10 (loop counter)
LD R2, CHAR0 ; ASCII char of current array index
LEA R4, ARRELEM0 ; Pointer of array zero-element

FILLING LD R0, NEWLINE ; filling loop
JSR PUTSYMB
LEA R0, Prompt
PUTS
AND R0, R0, #0
ADD R0, R0, R2
JSR PUTSYMB
LD R0, PROMPTSYMB
JSR PUTSYMB
ST R1, SaveR1 ; INPDIGIT uses R1, R7 and changes them
LEA R7, #2 
ST R7, SaveR7
JSR INPDIGIT
LD R1, SaveR1 ; Restore R1
STR R0, R4, #0 ; Store entered digit in the memory cell
ADD R4, R4, #1
ADD R2, R2, #1 ; Next array index ASCII char
ADD R1, R1, #-1 ; Decrease loop counter by 1
BRnp FILLING
;
; Array sorting
; R0 ~ arr[i-1], R1 ~ arr[i] (high level PL analogy)
SORTING LEA R0, ARRELEM0
LEA R1, ARRELEM1
AND R2, R2, #0
ADD R2, R2, #9 ; Loop counter. If we start with 1 (not 0) element it requires 9 iterations
AND R6, R6, #0

ARRLOOP LDR R3, R0, #0
; R3, R4 - values, R5 - result of compare, R6 - flag if the exchange was made
LDR R4, R1, #0
NOT R5, R4
ADD R5, R5, #1
ADD R5, R3, R5 
BRnz #4
AND R6, R6, #0
ADD R6, R6, #1
; Exchange (mem[r1]=r3, mem[r0]=r4)
STR R3, R1, #0
STR R4, R0, #0

ADD R0, R0, #1
ADD R1, R1, #1
; Decrease counter by 1
ADD R2, R2, #-1
BRp ARRLOOP
; if the exchange was made
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
;R0 is input argument
;R3 need to restore
PUTSYMB LDI R3, DSR
BRzp PUTSYMB
STI R0, DDR
RET
;

;Input digit
;R1, R3 need to restore
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
