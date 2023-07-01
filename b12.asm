

PRINT MACRO BIEN1
    MOV AH,9
    LEA DX,BIEN1
    INT 21h
ENDM

INPUT MACRO BIEN1
    MOV AH,10
    LEA DX,BIEN1
    INT 21h
ENDM

;10b: so sanh 2 chuoi ky tu
.MODEL SMALL
.STACK 100
.DATA
    MSG1        DB        'NHAP CHUOI KY TU: $'
    MSG2        DB  10,13,'SO KY TU TRONG CHUOI LA: $'
       
    STR         DB  256 DUP('$')                     
    RES         DW  ?
.CODE
    MAIN PROC
        ;Khoi tao DS, ES
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        
        PRINT MSG1
        INPUT STR
                  
        CALL COUNT_CHAR
        PRINT MSG2
        CALL PRINT_RES
        
        MOV AH,4Ch
        INT 21h
    MAIN ENDP
    ;-------------------------------
    COUNT_CHAR PROC
        LEA SI,STR+2
        MOV CX,0
        FOR_COUNT:
            INC SI
            INC CX
            CMP [SI],13 ;Ky tu xuong dong
            JNE FOR_COUNT
        MOV RES,CX
        RET
    COUNT_CHAR ENDP
    ;-------------------------------
    PRINT_RES PROC
        MOV AX,RES
        MOV BX,10
        MOV CX,0
        
        ITOS:     
            MOV DX,0
            DIV BX
            ADD DX,'0'
            PUSH DX
            INC CX
            CMP AX,0
            JNE ITOS
                    
        MOV AH,2
        OUTPUT:
            POP DX
            INT 21h
            LOOP OUTPUT
            
        RET
    PRINT_RES ENDP
END