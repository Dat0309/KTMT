.MODEL SMALL
.STACK 100h
.DATA
    MSG1 DB 10,13, 'Nhap vao 1 so thap phan: $'
    MSG2 DB 10,13, 'So thap phan vua nhap la: $'
       
.CODE
    MOV AX, @DATA
    MOV DS, AX    
    
    NHAP_10:
        LEA DX, MSG1
        CALL XUAT_CHUOI
        
        CALL NHAP_THAP_PHAN
        
        CMP DX, 0
        JE NHAP_10
        
    LEA DX, MSG2
    CALL XUAT_CHUOI
    
    MOV AX, BX
    CALL XUAT_THAP_PHAN        
            
    MOV AH, 4Ch
    INT 21h
    

    ; ====================================
    ; KHAI BAO THU TUC
    ; ====================================
    
    XUAT_CHUOI PROC
        PUSH AX
        
        MOV AH, 9
        INT 21h
        
        POP AX
        RET
    XUAT_CHUOI ENDP
    
    NHAP_THAP_PHAN PROC
        PUSH AX
        PUSH CX
        PUSH SI
        
        XOR BX, BX
        
        INPUT:
            MOV AH, 1
            INT 21h
            
            CMP AL, 0Dh
            JE BREAK
            
            CMP AL, '0'
            JB XULY_LOI
            CMP AL, '9'
            JA XULY_LOI
            
            AND AL, 0Fh
            MOV CL, AL
            XOR CH, CH
            
            MOV AX, BX
            MOV SI, 10
            MUL SI
            MOV BX, AX
            ADD BX, CX
            
            JMP INPUT
            
            XULY_LOI:
                XOR BX, BX
                MOV DX, 0
                JMP EXIT
        
        BREAK:
            MOV DX, 1
        
        EXIT:
            POP SI
            POP CX
            POP AX
        RET
    NHAP_THAP_PHAN ENDP

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
END