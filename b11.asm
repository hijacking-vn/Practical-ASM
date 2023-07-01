
PRINT MACRO BIEN1
    MOV AH,9
    LEA DX,BIEN1
    INT 21h
ENDM

INPUT_STR MACRO BIEN1
    MOV AH,10
    LEA DX,BIEN1
    INT 21h
ENDM

INPUT_CHAR MACRO BIEN1
    MOV AH,1
    INT 21h
    MOV BIEN1,AL
ENDM            

;10b: so sanh 2 chuoi ky tu
.MODEL SMALL
.STACK 100
.DATA
    MSG1        DB        'NHAP CHUOI KY TU: $'
    MSG2        DB  10,13,'NHAP KY TU CAN TIM: $'
    MSG3        DB  10,13,'VI TRI XUAT HIEN: $' 
    TAB         DB  09,'$'
                      
    MUOI        DW  10
    RES         DW  ?    
    STR         DB  256 DUP('$')
    CHAR        DB  ?
.CODE
    MAIN PROC
        ;Khoi tao DS, ES
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        
        PRINT MSG1
        INPUT_STR STR
        
        PRINT MSG2
        INPUT_CHAR CHAR
        
        PRINT MSG3         
        CALL FIND_CHAR
        
        MOV AH,4Ch
        INT 21h
    MAIN ENDP
    ;-------------------------------
    FIND_CHAR PROC
        LEA SI,STR+2
        MOV BL,CHAR
        MOV CX,0
        FOR_COUNT:
            CMP [SI],BL
            JNE NOT_FOUND
                PRINT TAB
                MOV RES,CX
                CALL PRINT_RES
                MOV CX,RES
            NOT_FOUND:
            INC SI
            INC CX
            CMP [SI],13 ;Ky tu xuong dong
            JNE FOR_COUNT
        RET
    FIND_CHAR ENDP
    ;-------------------------------
    PRINT_RES PROC
        MOV AX,RES
        MOV CX,0
        
        ITOS:     
            MOV DX,0
            DIV MUOI
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