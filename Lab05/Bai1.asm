.MODEL SMALL
.STACK 100h
.DATA

    MSG1 DB 10,13, 'Nhap vao 1 day nhi phan: $'
    MSG2 DB 10,13, 'Day nhi phan vua nhap la: $'
    END1 DB 10,13, 'Bam phim bat ki de thoat chuong trinh...$'

.CODE
    ; LAY DU LIEU TU DATA VAO DS
    MOV AX, @DATA
    MOV DS, AX    
    ; =========================================
    
    NHAP_NP:
        LEA DX, MSG1
        CALL XUAT_CHUOI
        
        CALL NHAP_NHI_PHAN
        CMP DX, 0
        JE NHAP_NP
        
    LEA DX, MSG2
    CALL XUAT_CHUOI
    
    CALL XUAT_NHI_PHAN        
    
    ; =========================================
    ; DUNG MAN HINH, XEM KET QUA
    CALL THOAT_CHUONG_TRINH
    
    
    ; =========================================
    ; KHAI BAO THU TUC
    ; =========================================
    
    XUAT_CHUOI PROC
        PUSH AX
        
        MOV AH, 9
        INT 21h
        
        POP AX
        RET
    XUAT_CHUOI ENDP
    
    NHAP_NHI_PHAN PROC
        PUSH AX
        PUSH CX
        
        MOV DX, 1
        XOR BX, BX
        XOR CX, CX
            
        INPUT:
            MOV AH, 1
            INT 21h
                
            CMP AL, 0Dh
            JE BREAK
                
            CMP AL, '0'
            JE XULY
            CMP AL, '1'
            JE XULY
                
            MOV DX, 0
            JMP BREAK
                
            XULY:
                AND AL, 0Fh
                SHL BX, 1
                OR BL, AL
                    
                INC CX
                    
                CMP CX, 16
                JB INPUT
                
        BREAK:
            POP CX
            POP AX
            RET
    NHAP_NHI_PHAN ENDP
    
    XUAT_NHI_PHAN PROC
        PUSH AX
        PUSH CX
        PUSH DX
        
        MOV CX, 16
        MOV AH, 2
        
        PRINT:
            MOV DL, '0'
            
            ROL BX, 1
            JNC PRINT_ZERO:
            
            MOV DL, '1'
            
            PRINT_ZERO:
                INT 21h
                
        LOOP PRINT
        
        POP DX
        POP CX
        POP AX
        RET
    XUAT_NHI_PHAN ENDP
    
    THOAT_CHUONG_TRINH PROC
        MOV AH, 9
        LEA DX, END1
        INT 21h
        
        MOV AH, 7
        INT 21h
        
        ; THOAT CHUONG TRINH
        MOV AH, 4Ch
        INT 21h
        RET
    THOAT_CHUONG_TRINH ENDP
END