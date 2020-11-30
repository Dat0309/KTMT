.MODEL SMALL
.STACK 100h
.DATA
    STR1 DB 10,13, 'Hay nhap mot ky tu: $'
    STR2 DB 10,13, 'Ky tu dung truoc: $'
    STR3 DB 10,13, 'Ky tu dung sau: $'
    
    KYTU DB ?
.CODE
    ; Lay du lieu tu DATA vao DS
    MOV AX, @DATA
    MOV DS, AX
    
    ; Xuat thong bao nhap 1 ki tu
    MOV AH, 9
    LEA DX, STR1
    INT 21h
    
    ; Nhap 1 ki tu 
    MOV AH, 1
    INT 21h ; Ki tu vua nhap duoc luu trong AL
    
    MOV KYTU, AL
    
    ; Xuat thong bao ky tu dung truoc
    MOV AH, 9
    LEA DX, STR2
    INT 21h
    
    ; Xuat ki tu dung truoc
    MOV DL, KYTU
    MOV AH, 2
    DEC DL
    INT 21h
    
    ; Xuat thong bao ki tu dung sau
    MOV AH, 9
    LEA DX, STR3
    INT 21h
    
    ; Xuat ki tu dung sau
    MOV DL, KYTU
    INC DL
    MOV AH, 2
    INT 21h
    
    ; Thoat chuong trinh
    MOV AH, 4Ch
    INT 21h

END