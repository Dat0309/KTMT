.MODEL SMALL
.STACK 100h
.DATA
    STR1 DB 10,13, 'Nhap ky tu thu nhat: $'
    STR2 DB 10,13, 'Nhap ky tu thu hai: $'
    STR3 DB 10,13, 'Ky tu tong: $'
    
    KYTU1 DB ?
    KYTU2 DB ?
    TONG DB ?
    
.CODE
    ; Lay du lieu tu DATA vao DS
    MOV AX, @DATA
    MOV DS, AX
    
    ; Xuat thong bao yeu cau nhap ki tu thu nhat
    MOV AH, 9
    LEA DX, STR1
    INT 21h
    
    ; Nhap ki tu thu nhat
    MOV AH, 1
    INT 21h
    
    MOV KYTU1, AL
    
    ; Xuat thong bao yeu cau nhap ki tu thu hai
    MOV AH, 9
    LEA DX, STR2
    INT 21h
    
    ; Nhap ki tu thu hai
    MOV AH, 1
    INT 21h
    
    MOV KYTU2, AL
    
    ; Xuat thong bao ki tu tong
    MOV AH, 9
    LEA DX, STR3
    INT 21h
    
    MOV AL, KYTU1
    MOV BL, KYTU2
    
    ADD AL, BL
    MOV TONG, AL
    
    ; Xuat ki tu tong
    MOV AH, 2
    MOV DL, TONG
    INT 21h
    
    ; Thoat chuong trinh
    MOV AH, 4Ch
    INT 21h

END