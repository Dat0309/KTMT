.MODEL SMALL
.STACK 100h
.DATA
TB DB 10,13, 'NHAP MOT KY TU!: $'
TB2 DB 10,13, '5 KY TU KE TIEP LA: $'

SO DB ?
.CODE
MOV AX,@DATA
MOV DS,AX

MOV AH,9
LEA DX,TB
INT 21H

MOV AH,1
INT 21H

MOV SO,AL

;KET QUA
MOV AH,9
LEA DX,TB2
INT 21H

;XUAT 5 KY TU
MOV CX,5

XUAT:
INC SO

MOV AH,2
MOV DL,SO
INT 21H

MOV DL,0Ah
INT 21H

LOOP XUAT

MOV AH,4CH
INT 21H
END