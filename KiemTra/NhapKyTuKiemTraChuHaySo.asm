.MODEL SMALL
.STACK 100h
.DATA
TBkhac DB 10,13, 'Ky tu vua nhap khac chu/so!$'
TBchu DB 10,13, 'Ky tu vua nhap la chu!$'
TBso DB 10,13, 'Ky tu vua nhap la so!$'

TB DB 10,13, 'Moi nguoi dung nhap vao 1 ky tu : $'

.CODE
MOV AX,@DATA
MOV DS,AX

;THONG BAO NHAP
MOV AH,9
LEA DX,TB
INT 21h

;nhap
MOV AH,1
INT 21h

CMP AL, 'O'
JB KHAC
CMP AL, '9'
JBE SO
CMP AL, 'A'
JB KHAC
CMP AL, 'Z'
JBE CHU
CMP AL, 'a'
JB KHAC
CMP AL, 'z'
JBE CHU

JMP KHAC

KHAC:
MOV AH,9
LEA DX, TBkhac
INT 21h

JMP EXIT

CHU:
MOV AH,9
LEA DX, TBchu
INT 21h

JMP EXIT

SO:
MOV AH,9
LEA DX,TBso
INT 21h

JMP EXIT

EXIT:
MOV AH,4Ch
INT 21h
END