.MODEL SMALL
.STACK 100h
.DATA
MSG1 DB 10,13, 'NHAP VAO 1 KY TU : $'
RES1 DB 10,13, 'KY TU DA NHAP LA CHU! $'
RES2 DB 10,13, 'KY TU DA NHAP LA SO! $'
END1 DB 10,13, 'BAM PHIM ESC DE THOAT! $'
.CODE
MOV AX,@DATA
MOV DS,AX

INPUT:
;NHAP
MOV AH,9
LEA DX,MSG1
INT 21H

MOV AH,1
INT 21H

CMP AL,1Bh
JE BREAK

CMP AL, '0'
JB KHAC
CMP AL, '9'
JBE SO
CMP AL,'A'
JB KHAC
CMP AL, 'Z'
JBE CHU
CMP AL,'a'
JB KHAC
CMP AL, 'z'
JBE CHU

KHAC:
MOV AH,9
LEA DX,RES1
INT 21H

JMP TIEPTUC   

CHU:
MOV AH,9
LEA DX,RES1
INT 21H

JMP TIEPTUC

SO:
MOV AH,9
LEA DX,RES2
INT 21H

TIEPTUC:
JMP INPUT

BREAK:
CALL THOAT

THOAT PROC
    MOV AH,9
    LEA DX,END1
    INT 21H
    
    MOV AH,7
    INT 21H
    
    MOV AH,4CH
    INT 21H
    RET
THOAT ENDP
END