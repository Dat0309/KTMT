.MODEL SMALL
.STACK 100h
.DATA
TB DB 10,13, 'TAT CA CHU HOA LA: $'

.CODE
MOV AX,@DATA
MOV DX,AX

INPUT:
MOV AH,9
LEA DX,TB
INT 21H

;LAP
MOV CX,26
MOV DL, 'A'

PRINT:
MOV AH,2
INT 21H
INC DL
LOOP PRINT

MOV AH,4CH
INT 21H
END