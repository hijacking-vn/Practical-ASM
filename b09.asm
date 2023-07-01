
PRINT MACRO BIEN1
    MOV AH,9
    LEA DX,BIEN1
    INT 21h
ENDM

;9b: dao nguoc chuoi ky tu dung ngan xep
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
        CALL REVERSE_STR
                  
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
    REVERSE_STR PROC
        LEA SI,STR+2
        MOV CX,0
        FOR_STR:
            PUSH [SI]
            INC SI
            INC CX
            CMP [SI],13
            JNE FOR_STR
                
        MOV AH,2    
        PRINT_RE:
            POP DX
            INT 21h
            LOOP PRINT_RE:
        RET
    REVERSE_STR ENDP
    ;------------------------------- 
    
END
