.MODEL SMALL
.STACK 100h
.DATA
    END1 DB 10,13,10, 'Bam 1 phim bat ki de thoat chuong trinh ...$'

    MSG1 DB 10,13, 'Nhap vao so thu nhat: $'
    MSG2 DB 10,13, 'Nhap vao so thu hai : $'
    RES1 DB 10,13, 'Ket qua cua phep chia: $'
    RES2 DB 10,13, 'Phan thuong: $'
    RES3 DB 10,13, 'Phan du: $'    
    
    NUM1 DW ?
    NUM2 DW ?
    
.CODE
    ; KHOI TAO CHUONG TRINH
    CALL KHOI_TAO_CHUONG_TRINH
    
    ; Xuat thong bao nhap so thu nhat
    MOV DX, OFFSET MSG1
    CALL XUAT_CHUOI
    
    ; Nhap so thu nhat
    CALL NHAP_THAP_PHAN
    MOV NUM1, BX
    
    ; Xuat thong bao nhap so thu hai
    MOV DX, OFFSET MSG2
    CALL XUAT_CHUOI
    
    ; Nhap so thu hai
    CALL NHAP_THAP_PHAN
    MOV NUM2, BX
    
    ; Xuat thong bao ket qua
    MOV DX, OFFSET RES1
    CALL XUAT_CHUOI
    MOV AX, NUM1
    CALL XUAT_THAP_PHAN
    
    MOV AH, 2
    MOV DL, '/'
    INT 21h
    
    MOV AX, NUM2
    CALL XUAT_THAP_PHAN
    
    ; Chia 2 so
    XOR DX, DX
    MOV AX, NUM1
    MOV CX, NUM2
    DIV CX
    
    MOV BX, AX ; Phan thuong luu tren BX
    MOV CX, DX ; Phan du luu tren CX
    
    ; Xuat ket qua phan thuong voi phan du
    MOV DX, OFFSET RES2
    CALL XUAT_CHUOI
    
    MOV AX, BX
    CALL XUAT_THAP_PHAN
    
    MOV DX, OFFSET RES3
    CALL XUAT_CHUOI
    
    MOV AX, CX
    CALL XUAT_THAP_PHAN
    
    
                           
    ; Thoat chuong trinh
    CALL THOAT_CHUONG_TRINH
               
    
              
               
    ; ===========================================================
    ; PHAN KHAI BAO THU TUC
    ; ===========================================================
    
    ; THU TUC HAM XUAT 1 CHUOI RA MAN HINH
    ; Input: 
    ;       - DS: Dia chi cua chuoi can xuat
    ; Output: khong
    XUAT_CHUOI PROC
        PUSH AX
        PUSH DX
        
        MOV AH, 9
        INT 21h
        
        POP DX
        POP AX
        RET
    XUAT_CHUOI ENDP
    
    ; THU TUC KHOI TAO CHUONG TRINH
    KHOI_TAO_CHUONG_TRINH PROC
        MOV AX, @DATA
        MOV DS, AX
        
        XOR AX, AX
        XOR BX, BX
        XOR CX, CX
        XOR DX, DX
        RET
    KHOI_TAO_CHUONG_TRINH ENDP
    

    ; THU TUC NHAP 1 SO THAP PHAN
    ; Input: khong
    ; Output:
    ;       - BX: so thap phan nhap tu ban phim
    NHAP_THAP_PHAN PROC
        PUSH AX
        PUSH CX
        PUSH DX
        
        XOR BX, BX
        
        INPUT:
            MOV AH, 7
            INT 21h
            
            CMP AL, 0Dh
            JE EXIT1
            
            CMP AL, '0'
            JB XULY_LOI
            CMP AL, '9'
            JA XULY_LOI
            
            MOV CL, AL
            
            MOV AH, 2
            MOV DL, CL
            INT 21h
            
            AND CL, 0Fh
            
            MOV AX, BX
            MOV DX, 10
            MUL DX
            
            MOV BX, AX
            XOR CH, CH
            ADD BX, CX
            
            XULY_LOI:
            JMP INPUT
            
        EXIT1:                                    
            POP DX
            POP CX
            POP AX
            
            RET
    NHAP_THAP_PHAN ENDP
    
    
    ; THU TUC XUAT 1 SO THAP PHAN
    ; Input:
    ;       - AX: So thap phan can xuat
    XUAT_THAP_PHAN PROC
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        
        MOV BX, 10
        XOR CX, CX
        
        XULY_STACK:
            XOR DX, DX
            DIV BX
            PUSH DX
            INC CX
            
            CMP AX, 0
            JA XULY_STACK
            
        PRINT:
            POP DX
            OR DX, 30h
            MOV AH, 2
            INT 21h
            LOOP PRINT            
            
        POP DX
        POP CX
        POP BX
        POP AX            
        RET
    XUAT_THAP_PHAN ENDP

    
    ; THU TUC DUNG VA THOAT CHUONG TRINH
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