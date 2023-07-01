
PRINT MACRO BIEN1
    MOV AH,9
    LEA DX,BIEN1
    INT 21h
ENDM

;4b: so luong so chia het cho 5 (hoac so bat ky)
.MODEL SMALL
.STACK 100
.DATA
    MSG0    DB        'NHAP SO CHIA: $'
    MSG1    DB  10,13,'NHAP SO PHAN TU: $'
    MSG2    DB  10,13,'KET QUA = $'
    MSG3    DB  10,13,'NHAP PHAN TU THU '
    INDEX   DB  ?,': $'
    MUOI    DW  10
    
    N       DW  ?
    TMP     DW  ?
    NUM     DW  ?
    RES     DW  ?
.CODE
    MAIN PROC
        ;Khoi tao DS, ES
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
     
        ;Nhap N
        PRINT MSG0
        CALL NHAP_NUM
        MOV AX,NUM
        MOV N,AX
        
        PRINT MSG1
        CALL NHAP_NUM
        
        ;Nhap chuoi so, check chia het N             
        MOV RES,0
        MOV CX,NUM
        MOV INDEX,'1'
        PROCESS:
            PRINT MSG3
            INC INDEX
            CALL NHAP_NUM
            MOV TMP,CX
            CALL CHECK_CHIA_HET
            MOV CX,TMP       
            LOOP PROCESS
        
        ;Hien thi KQ
        PRINT MSG2
        CALL PRINT_RES
                  
        EXIT:
        MOV AH,4Ch
        INT 21h
    MAIN ENDP
    ;-------------------------------
    CHECK_CHIA_HET PROC
        MOV AX,NUM
        DIV N
        CMP DX,0
        JNE FALSE
        TRUE:
            INC RES
        FALSE:   
        RET
    CHECK_CHIA_HET ENDP
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
