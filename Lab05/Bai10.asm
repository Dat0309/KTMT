.MODEL SMALL
.STACK 100h
.DATA
    MSG1 DB 10,13, 'Nhap chieu dai: $'
    MSG2 DB 10,13, 'Nhap chieu rong: $'
    MSG3 DB 10,13, 'Dien tich: $'
    MSG4 DB 10,13, 'Chu vi: $'
    
    DAI DW ?
    RONG DW ?
.CODE
    MOV AX, @DATA
    MOV DS, AX
    
    ; Nhap chieu dai
    NHAP_DAI:
        LEA DX, MSG1
        CALL XUAT_CHUOI
        
        CALL NHAP_THAP_PHAN
        CMP DX, 0
        JE NHAP_DAI
    
    MOV DAI, BX
    
    ; Nhap chieu rong
    NHAP_RONG:
        LEA DX, MSG2
        CALL XUAT_CHUOI
        
        CALL NHAP_THAP_PHAN
        CMP DX, 0
        JE NHAP_RONG
        
    MOV RONG, BX
    
    ; Gan gia tri vao BX, CX
    MOV BX, DAI
    MOV CX, RONG
    
    ; Xuat dien tich
    LEA DX, MSG3
    CALL XUAT_CHUOI
    
    CALL TINH_DIEN_TICH
    CALL XUAT_THAP_PHAN
    
    ; Xuat chu vi
    LEA DX, MSG4
    CALL XUAT_CHUOI
    
    CALL TINH_CHU_VI
    CALL XUAT_THAP_PHAN
    
    MOV AH, 4Ch
    INT 21h

    ; Khai bao thu tuc
    XUAT_CHUOI PROC
        MOV AH, 9
        INT 21h
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

    ; Input:
    ;   - BX: Chieu dai
    ;   - CX: Chieu rong
    ; Output:
    ;   - AX: Dien tich    
    TINH_DIEN_TICH PROC
        MOV AX, BX
        MUL CX
        RET
    TINH_DIEN_TICH ENDP

    ; Input:
    ;   - BX: Chieu dai
    ;   - CX: Chieu rong
    ; Output:
    ;   - AX: Chu vi
    TINH_CHU_VI PROC
        PUSH BX
        
        ADD BX, CX
        MOV AX, 2
        MUL BX
        
        POP BX
        RET
    TINH_CHU_VI ENDP
END