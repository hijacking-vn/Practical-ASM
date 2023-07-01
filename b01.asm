
PRINT MACRO BIEN1
    MOV AH,9
    LEA DX,BIEN1
    INT 21h
ENDM  

;1b. Nhap n: n<8 va tinh giai thua
.MODEL SMALL
.STACK 100
.DATA
    MSG1    DB        'NHAP SO N  = $'
    MSG2    DB  10,13,'KET QUA N! = $'
    MUOI    DW  10
    
    NUM     DW  ?
.CODE
    MAIN PROC
        ;Khoi tao DS, ES
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        
        PRINT MSG1
        CALL NHAP_NUM
                  
        CALL GIAI_THUA
        
        PRINT MSG2
        CALL PRINT_NUM
                  
        EXIT:
        MOV AH,4Ch
        INT 21h
    MAIN ENDP
    ;-------------------------------
    GIAI_THUA PROC
        MOV CX,NUM
        MOV AX,1
        CALC:   
            MUL CX
            DEC CX
            CMP CX,1
            JNE CALC
        MOV NUM,AX
        RET
    GIAI_THUA ENDP
    ;-------------------------------
    NHAP_NUM PROC
        MOV NUM,0
        
        INPUT:
            MOV AH,1
            INT 21h  
            CMP AL,0Dh
            JE  EXIT_INPUT    
            MOV BL,AL
            SUB BL,'0'
            MOV AX,NUM
            MUL MUOI
            ADD AX,BX
            MOV NUM,AX
            JMP INPUT
                          
        EXIT_INPUT:   
        RET
    NHAP_NUM ENDP
    ;-------------------------------    
    PRINT_NUM PROC
        MOV AX,NUM
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
    PRINT_NUM ENDP
END