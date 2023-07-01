
PRINT MACRO BIEN1
    MOV AH,9
    LEA DX,BIEN1
    INT 21h
ENDM

;8b: ky tu in HOA thanh in thuong
.MODEL SMALL
.STACK 100
.DATA
    MSG1    DB        'NHAP CHUOI KY TU: $'
    MSG2    DB  10,13,'CHUOI BIEN DOI: $'
                                     
    STR     DB  255 DUP('$')
.CODE
    MAIN PROC
        ;Khoi tao DS, ES
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        
        PRINT MSG1
        CALL NHAP_STR
        
        PRINT MSG2
        CALL LOWER_STR
                  
        EXIT:
        MOV AH,4Ch
        INT 21h
    MAIN ENDP
    ;-------------------------------
    NHAP_STR PROC
        LEA DX,STR
        MOV AH,10
        INT 21h
        RET
    NHAP_STR ENDP
    ;------------------------------- 
    LOWER_STR PROC
        MOV AH,2
        LEA SI,STR+2
        FOR_STR:
            MOV DL,[SI]
            CMP DL,'a'
            JAE PRINT_LOWER
            CMP DL,'A'      ;Ky tu space
            JB  PRINT_LOWER 
            ADD DL,32       ;UPPER->LOWER
            
            PRINT_LOWER:
            INT 21h
            INC SI
            CMP [SI],13     ;Ky tu xuong dong
            JNE FOR_STR
        RET
    LOWER_STR ENDP
    ;------------------------------- 
    
END
