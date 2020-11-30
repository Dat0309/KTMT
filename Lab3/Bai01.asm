.MODEL SMALL
.STACK 100h
.DATA
    TB1 DB 10,13, 'BAY GIO LA BUOI SANG, BUOI CHIEU HAY BUOI TOI! $'
    KQ1 DB 10,13, 'CHAO BUOI SANG!$'
    KQ2 DB 10,13, 'CHAO BUOI CHIEU!$'
    KQ3 DB 10,13, 'CHAO BUOI TOI!$'
.CODE
    MOV AX, @DATA
    MOV DS,AX
    
    INPUT:
    ; THONG BAO NGUOI DUNG NHAP VAO MOT KY TU
    MOV AH,1
    INT 21H
    
    ;LENH SO SANH
    CMP AL, 'S'
    JE SANG
    CMP AL, 's'
    jE SANG
    
    CMP AL, 'C'
    JE TRUA
    CMP AL,'c'
    JE TRUA
    
    CMP AL, 'T'
    JE TOI
    CMP AL, 't'
    JE TOI
    
    JMP INPUT
    
    SANG:
    MOV AH,9
    LEA DX,KQ1
    INT 21h
    
    jMP EXIT
    
    TRUA:
    MOV AH,9
    LEA DX,KQ2
    INT 21h
    
    JMP EXIT
    
    TOI:
    MOV AH,9
    LEA DX,KQ3
    INT 21h
    
    JMP EXIT
    
    EXIT:
    MOV AH,4ch
    INT 21h
    END