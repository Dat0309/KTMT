.MODEL SMALL
.STACK 100h
.DATA
TB1 DB 10,13, 'NHAP VAO 1 KY TU : $'
TB2 DB 10,13, '5 KY TU UUNG TRUOC LA: $'
 
SO DB ?
.CODE
MOV AX,@DATA
MOV DS,AX

MOV AH,9
LEA DX,TB1
INT 21H

MOV AH,1
INT 21H

MOV SO,AL

;KEY QUA
MOV AX,9
LEA DX,TB2
INT 21H

SUB SO,5
MOV CX,5

XUAT:
MOV AH,2
MOV DL,SO
INT 21H

MOV DL,0Ah
INT 21H

INC SO

LOOP XUAT

MOV AH,4Ch
INT 21H
END