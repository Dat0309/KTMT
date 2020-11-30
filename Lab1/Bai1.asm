.MODEL SMALL
.STACK 100h
.DATA
    STR1 DB 10,13, 'Hello, world!$'
    STR2 DB 10,13, 'solar system!$'
    STR3 DB 10,13, 'Hello, universe!$'

.CODE
    ; Lay du lieu tu DATA vao DS
    MOV AX, @DATA
    MOV DS, AX
    
    
    ; Xuat chuoi thu nhat
    MOV AH, 9
    LEA DX, STR1
    INT 21h
    
    ; Xuat chuoi thu hai
    MOV AH, 9
    LEA DX, STR2
    INT 21h
    
    ; Xuat chuoi thu ba
    MOV AH, 9
    MOV DX, OFFSET STR3
    INT 21h
    
    
    ; Thoat chuong trinh
    MOV AH, 4Ch
    INT 21h

END