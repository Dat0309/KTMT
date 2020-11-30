.MODEL SMALL
.STACK 100h
.DATA
    STR1 DB 10,13, 'Hay nhap mot ky tu: $'
    STR2 DB 10,13, 'Ky tu da nhap: $'
    
    KYTU DB ?
.CODE
    ; Lay du lieu tu DATA vao DS
    MOV AX, @DATA
    MOV DS, AX
    
    ; Xuat thong bao yeu cau nguoi dung nhap 1 ki tu
    MOV AH, 9
    LEA DX, STR1
    INT 21h
    
    ; Nhap 1 ki tu => ki tu vua nhap duoc luu trong AL
    MOV AH, 1
    INT 21h
    
    MOV KYTU, AL ; => luu ki tu vua nhap vao bien KYT
    
    ; Xuat thong bao ket qua
    MOV AH, 9
    LEA DX, STR2
    INT 21h
    
    ; Xuat ky tu
    MOV AH, 2
    MOV DL, KYTU
    INT 21h
    
    ; Thoat chuong trinh
    MOV AH, 4Ch
    INT 21h

END