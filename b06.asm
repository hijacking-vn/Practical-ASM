
PRINT MACRO BIEN1
    MOV AH,9
    LEA DX,BIEN1
    INT 21h
ENDM

;6b: chuyen DEC sang HEX, BIN (16bit)
;Nhap NUM [10,170,255,500]
.MODEL SMALL
.STACK 100
.DATA
    MSG1    DB        'NHAP SO HE 10: $'
    MSG2    DB  10,13,'DANG HEX: $'
    MSG3    DB  10,13,'DANG BIN: $'
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
        
        PRINT MSG2
        CALL DEC_2_HEX
        
        PRINT MSG3    
        CALL DEC_2_BIN
                  
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
    DEC_2_HEX PROC    
        MOV AX,NUM
        MOV BX,16
        MOV CX,0 
        MOV DX,0
        DIV_HEX:
            DIV BX
            PUSH DX
            INC CX
            CMP AL,0
            JNE DIV_HEX
        
        MOV AH,2
        FOR_HEX:
            POP DX
            CMP DX,10
            JB PRINT_HEX  ;DX<10
            ADD DX,'A'
            SUB DX,10
            SUB DX,'0'
        PRINT_HEX:
            ADD DX,'0'
            INT 21h              
            LOOP FOR_HEX
        RET 
    DEC_2_HEX ENDP
    ;------------------------------- 
    DEC_2_BIN PROC    
        MOV AX,NUM
        MOV BX,2
        MOV CX,0  
        MOV DX,0
        DIV_BIN:
            DIV BX
            PUSH DX
            INC CX
            CMP AL,0
            JNE DIV_BIN
        
        MOV AH,2
        FOR_BIN:
            POP DX
            ADD DX,'0'
            INT 21h              
            LOOP FOR_BIN
        RET  
    DEC_2_BIN ENDP   
    
END
