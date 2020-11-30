.MODEL SMALL
.STACK 100h
.DATA
    END1 DB 10,13, 'Bam phim bat ki de thoat chuong trinh...$'
    MSG1 DB 10,13, 'Nhap mot ky tu: $'
    RES1 DB 10,13, 'Ki tu da nhap la chu!$'
    RES2 DB 10,13, 'Ki tu da nhap la so!$'
    RES3 DB 10,13, 'Ki tu da nhap khac chu/ so!$'
    
    KYTU DB ?   
    
.CODE
    ; Lay du lieu tu DATA vao DS
    MOV AX, @DATA
    MOV DS, AX
    
    ; Chay chuong trinh
    CALL XULY_KITU
   
    ; Thoat chuong trinh
    CALL THOAT_CHUONG_TRINH
    
    
    
   
    
    ; =======================================================
    ; KHAI BAO THU TUC
    ; =======================================================
    
    XULY_KITU PROC
        INPUT:
            MOV AH, 9
            LEA DX, MSG1
            INT 21h
            
            MOV AH, 1
            INT 21h
            
            CMP AL, 0Dh
            JE EXIT
            
            CMP AL, '0'
            JB KHAC
            CMP AL, '9'
            JBE SO
            CMP AL, 'A'
            JB KHAC
            CMP AL, 'Z'
            JBE CHU
            CMP AL, 'a'
            JB KHAC
            CMP AL, 'z'
            JBE CHU
            
            KHAC:
                MOV AH, 9
                LEA DX, RES3
                INT 21h
                
                JMP CONTINUE
                
            CHU:
                MOV AH, 9
                LEA DX, RES1
                INT 21h
                
                JMP CONTINUE
                
            SO:
                MOV AH, 9
                LEA DX, RES2
                INT 21h
        
        CONTINUE:
            JMP INPUT
                
        EXIT:            
            RET
    XULY_KITU ENDP
    
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