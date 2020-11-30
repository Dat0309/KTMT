.MODEL SMALL
.STACK 100h
.DATA
    END1 DB 10,13,10, 'Bam 1 phim bat ki de thoat chuong trinh ...$'

    MSG1      DB 10,13, '=== THONG TIN NGAY GIO CUA HE THONG === $'
    MSG_THU   DB 10,13, 'Hom nay la: $'
    MSG_NGAY  DB 10,13, '- Ngay: $'
    MSG_THANG DB 10,13, '- Thang: $'
    MSG_NAM   DB 10,13, '- Nam: $'
    
    MSG_GIO   DB 10,13, '- Gio: $'
    MSG_PHUT  DB 10,13, '- Phut: $'
    MSG_GIAY  DB 10,13, '- Giay: $'
    
    THU_HAI DB 'thu Hai$'
    THU_BA  DB 'thu Ba$'
    THU_TU  DB 'thu Tu$'
    THU_NAM DB 'thu Nam$'
    THU_SAU DB 'thu Sau$'
    THU_BAY DB 'thu Bay$'
    CHUNHAT DB 'Chu Nhat$'
    
    NGAY  DB ?
    THANG DB ?
    NAM   DW ?
    THU   DB ?
    
    GIO   DB ?
    PHUT  DB ?
    GIAY  DB ?
    
.CODE
    ; KHOI TAO CHUONG TRINH
    CALL KHOI_TAO_CHUONG_TRINH
                           
    ; LAY NGAY/ THANG/ NAM CUA HE THONG
    MOV AH, 2Ah
    INT 21h
    
    MOV NGAY, DL
    MOV THANG, DH
    MOV NAM, CX
    MOV THU, AL
                               
    ; Xuat thong bao ngay thang nam he thong
    MOV DX, OFFSET MSG1
    CALL XUAT_CHUOI
    
    ; Xuat thong bao thu ngay
    MOV DX, OFFSET MSG_THU
    CALL XUAT_CHUOI
    
    MOV BL, THU
    CALL PRINT_DAY_OF_WEEK
    
    ; Xuat thong bao ngay
    MOV DX, OFFSET MSG_NGAY
    CALL XUAT_CHUOI
    
    XOR AH, AH
    MOV AL, NGAY ; AX = AH | AL 
    CALL XUAT_THAP_PHAN
    
    
    ; Xuat thong bao thang
    MOV DX, OFFSET MSG_THANG
    CALL XUAT_CHUOI
    
    XOR AH, AH
    MOV AL, THANG
    CALL XUAT_THAP_PHAN
    
    ; Xuat thong bao nam
    MOV DX, OFFSET MSG_NAM
    CALL XUAT_CHUOI
    
    MOV AX, NAM
    CALL XUAT_THAP_PHAN
    
    
    ; LAY GIO/ PHUT/ GIAY CUA HE THONG
    MOV AH, 2Ch
    INT 21h
    
    MOV GIO, CH
    MOV PHUT, CL
    MOV GIAY, DH
    
    ; Xuat thong bao gio cua he thong
    MOV DX, OFFSET MSG_GIO
    CALL XUAT_CHUOI
    
    XOR AH, AH
    MOV AL, GIO
    CALL XUAT_THAP_PHAN
    
    ; Xuat thong bao phut cua he thong
    MOV DX, OFFSET MSG_PHUT
    CALL XUAT_CHUOI
    
    XOR AH, AH
    MOV AL, PHUT
    CALL XUAT_THAP_PHAN
    
    ; Xuat thong bao giay cua he thong
    MOV DX, OFFSET MSG_GIAY
    CALL XUAT_CHUOI
    
    XOR AH, AH
    MOV AL, GIAY
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
        MOV AH, 9
        INT 21h
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
    
    ; THU TUC XUAT 1 SO THAP PHAN
    ; Input:
    ;       - AX: So thap phan can xuat
    XUAT_THAP_PHAN PROC
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
        RET
    XUAT_THAP_PHAN ENDP
    
    ; THU TUC XUAT THU NGAY
    ; Input
    ;       - BL: 1 so nguyen (00: CN, 01 thu Hai, 02 thu Ba...>
    PRINT_DAY_OF_WEEK PROC
        CMP BL, 0
        JE CN
        CMP BL, 1
        JE T2
        CMP BL, 2
        JE T3
        CMP BL, 3
        JE T4
        CMP BL, 4
        JE T5
        CMP BL, 5
        JE T6
        CMP BL, 6
        JE T7
        
        CN:
            MOV DX, OFFSET CHUNHAT
            CALL XUAT_CHUOI
            JMP EXIT

        T2:
            MOV DX, OFFSET THU_HAI
            CALL XUAT_CHUOI
            JMP EXIT

        T3:
            MOV DX, OFFSET THU_BA
            CALL XUAT_CHUOI
            JMP EXIT

        T4:
            MOV DX, OFFSET THU_TU
            CALL XUAT_CHUOI
            JMP EXIT

        T5:
            MOV DX, OFFSET THU_NAM
            CALL XUAT_CHUOI
            JMP EXIT

        T6:
            MOV DX, OFFSET THU_SAU
            CALL XUAT_CHUOI
            JMP EXIT

        T7:
            MOV DX, OFFSET THU_BAY
            CALL XUAT_CHUOI
            
            JMP EXIT
            
            
        EXIT:            
            RET
    PRINT_DAY_OF_WEEK ENDP
    
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