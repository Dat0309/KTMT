.MODEL SMALL
.STACK 100h
.DATA

    MSG1 DB 10,13, 'Nhap vao 1 day thap luc phan: $'
    MSG2 DB 10,13, 'Day thap luc phan vua nhap la: $'
    END1 DB 10,13, 'Bam phim bat ki de thoat chuong trinh...$'

.CODE
    ; LAY DU LIEU TU DATA VAO DS
    MOV AX, @DATA
    MOV DS, AX    
    ; =========================================
    
    NHAP_16:                       
        LEA DX, MSG1
        CALL XUAT_CHUOI
    
        CALL NHAP_HEXA
        CMP DX, 0
        JE NHAP_16
        
    LEA DX, MSG2
    CALL XUAT_CHUOI
    
    CALL XUAT_HEXA        
                               
                           
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
    
    NHAP_HEXA PROC
        PUSH AX
        PUSH CX
        
        XOR BX, BX
        XOR CX, CX
        MOV DX, 1
        
        INPUT:
            MOV AH, 1
            INT 21h
            
            CMP AL, 0Dh
            JE BREAK
            
            CMP AL, '0'
            JB XULY_LOI
            CMP AL, '9'
            JBE XULY_SO
            CMP AL, 'A'
            JB XULY_LOI
            CMP AL, 'F'
            JBE XULY_CHU
            
            XULY_LOI:
                MOV DX, 0
                XOR BX, BX
                JMP BREAK
                
            XULY_SO:
                AND AL, 0Fh
                JMP XULY
                
            XULY_CHU: 
                SUB AL, 37h
                
            XULY:   
                SHL BX, 4
                OR BL, AL
                
                INC CX
                
                CMP CX, 4
                JB INPUT                                    
            
        BREAK:            
            POP CX
            POP AX
            RET
    NHAP_HEXA ENDP
    
    XUAT_HEXA PROC
        PUSH AX
        PUSH CX
        PUSH DX
        
        MOV CX, 4
        PRINT:
            MOV DL, BH
            SHR DL, 4
            
            CMP DL, 9
            JBE XUAT_SO
            JA XUAT_CHU
            
            XUAT_SO:
                MOV AH, 2
                OR DL, 30h
                INT 21h
                JMP CONTINUE                        
                       
            XUAT_CHU:
                MOV AH, 2
                ADD DL, 37h
                INT 21h                
            
            CONTINUE:
                ROL BX, 4
        LOOP PRINT
                
        POP DX
        POP CX
        POP AX                
        RET
    XUAT_HEXA ENDP
    
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