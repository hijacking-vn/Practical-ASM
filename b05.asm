
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

;5b: Dem so luong phan tu am, duong trong chuoi so
.MODEL SMALL
.STACK 100
.DATA
    MSG1        DB        'NHAP SO PHAN TU: $'
    
    POS_MSG     DB  10,13,'SO LUONG SO DUONG: '
    POSITIVE    DB  ?,'$'                     
    
    NEG_MSG     DB  10,13,'SO LUONG SO AM: '
    NEGATIVE    DB  ?,'$'                       
    
    MSG2        DB  10,13,'NHAP PHAN TU THU '
    INDEX       DB  ?,': $'
    
    MUOI        DB  10
    TMP         DW  ?
    NUM         DW  ?
    BUFFER      DW  6 DUP('$')  ;Luu tru so nhap vao
.CODE
    MAIN PROC
        ;Khoi tao DS, ES
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        
        PRINT MSG1
        CALL NHAP_NUM
        
        ;Nhap chuoi so, dem so + -             
        MOV POSITIVE,'0'
        MOV NEGATIVE,'0'
        
        MOV CX,NUM
        MOV INDEX,'1'
        PROCESS:
            PRINT MSG2
            INC INDEX
            INPUT_STR BUFFER
            MOV TMP,CX
            CALL COUNT_POS_NEG
            MOV CX,TMP       
            LOOP PROCESS
        
        ;Hien thi KQ
        PRINT POS_MSG
        PRINT NEG_MSG
        
        EXIT:
        MOV AH,4Ch
        INT 21h
    MAIN ENDP
    ;-------------------------------
    COUNT_POS_NEG PROC
        LEA SI,BUFFER+2
        MOV BL,'-'
        CMP [SI],BL
        JE IS_NEG
            INC POSITIVE
            JMP EXIT_COUNT     
        IS_NEG:
            INC NEGATIVE
        EXIT_COUNT:   
        RET
    COUNT_POS_NEG ENDP
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
END