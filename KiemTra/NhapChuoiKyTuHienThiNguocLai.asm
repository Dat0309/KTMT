                         .MODEL SMALL
.STACK 100h
.DATA
    END1 DB 10,13, 'Bam phim bat ki de thoat chuong trinh...$'
    MSG1 DB 10,13, 'Nhap mot chuoi ky tu: $'
    MSG2 DB 10,13, 'Chuoi dao nguoc: $'
    
.CODE
    ; Lay du lieu tu DATA vao DS
    MOV AX, @DATA
    MOV DS, AX
    

    ; Xuat thong bao nhap chuoi
    MOV AH, 9
    LEA DX, MSG1
    INT 21h
    
    XOR CX, CX
    
    INPUT:
        MOV AH, 1
        INT 21h
        
        CMP AL, 0Dh
        JE BREAK
        
        XOR AH, AH
        PUSH AX
        INC CX
        
        JMP INPUT
        
BREAK:          
    ; Xuat thong bao chuoi dao nguoc
    MOV AH, 9
    LEA DX, MSG2
    INT 21h
    
    MOV AH, 2
    OUTPUT:
        POP DX
        INT 21h
        LOOP OUTPUT
       
    
    ; Thoat chuong trinh
    MOV AH, 9
    LEA DX, END1
    INT 21h
    
    MOV AH, 7
    INT 21h
    
    MOV AH, 4Ch
    INT 21h
    
END