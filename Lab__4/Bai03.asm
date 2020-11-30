            .MODEL SMALL
.STACK 100h
.DATA
    END1 DB 10,13, 'Bam phim bat ki de thoat chuong trinh...$'
    MSG1 DB 10,13, 'Nhap vao 1 chu thuong: $'
    MSG2 DB 10,13, 'Chu hoa tuong ung la: $'
    
.CODE
    ; Lay du lieu tu DATA vao DS
    MOV AX, @DATA
    MOV DS, AX
    
    INPUT:
        ; Xuat thong bao nhap chu thuong
        MOV AH, 9
        LEA DX, MSG1
        INT 21h
        
        MOV AH, 1
        INT 21h
        
        CMP AL, 0Dh
        JE BREAK
        
        CMP AL, 'a'
        JB INPUT
        CMP AL, 'z'
        JA INPUT
        
        ; => Luu ki tu vua nhap vao BL
        ;  BL la tham so duy nhat cua ham CONVERT_lower_to_UPPER
        MOV BL, AL  
        
        ; Xuat thong bao ket qua
        MOV AH, 9
        LEA DX, MSG2
        INT 21h
        
        ; Xuat chu HOA tuong ung
        CALL CONVERT_lower_to_UPPER
        JMP INPUT
        
BREAK:        
    
    ; Thoat chuong trinh
    CALL THOAT_CHUONG_TRINH
    
    
    
    
    
    ; =========================================================
    ; KHAI BAO THU TUC
    ; =========================================================    
    
    CONVERT_lower_to_UPPER PROC
        MOV DL, BL
        SUB DL, 20h
        
        MOV AH, 2
        INT 21h
        RET
    CONVERT_lower_to_UPPER ENDP 
    
    THOAT_CHUONG_TRINH PROC
        MOV AH, 9
        LEA DX, END1
        INT 21h
        
        MOV AH, 7
        INT 21h
        
        MOV AH, 4Ch
        INT 21h
        RET
    THOAT_CHUONG_TRINH ENDP
END