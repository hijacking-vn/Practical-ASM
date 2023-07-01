
PRINT MACRO BIEN1
    MOV AH,9
    LEA DX,BIEN1
    INT 21h
ENDM

;2b: tong cac phan tu trong chuoi so
.MODEL SMALL
.STACK 100
.DATA
    MSG1    DB        'NHAP SO PHAN TU: $'
    MSG2    DB  10,13,'TONG CAC PHAN TU = $'
    MSG3    DB  10,13,'NHAP PHAN TU THU '
    INDEX   DB  ?,': $'
    MUOI    DW  10
    
    NUM     DW  ?
    RES     DW  ?
.CODE
    MAIN PROC
        ;Khoi tao DS, ES
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        
        PRINT MSG1
        CALL NHAP_NUM
        
        ;Tinh tong             
        MOV RES,0
        MOV CX,NUM
        MOV INDEX,'1'
        CAL_SUM:
            PRINT MSG3
            INC INDEX
            CALL NHAP_NUM
            MOV AX,NUM
            ADD RES,AX        
            LOOP CAL_SUM
        
        ;Hien thi KQ
        PRINT MSG2
        CALL PRINT_RES
                  
        EXIT:
        MOV AH,4Ch
        INT 21h
    MAIN ENDP
    
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