

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
    MSG1        DB        'NHAP CHUOI KY TU 1: $'
    MSG2        DB  10,13,'NHAP CHUOI KY TU 2: $'
    DIFF_MSG    DB  10,13,'2 CHUOI KHAC NHAU!$'
    SAME_MSG    DB  10,13,'2 CHUOI GIONG NHAU.$' 
    
    STR1         DB  256 DUP('$')
    STR2         DB  256 DUP('$')
.CODE
    MAIN PROC
        ;Khoi tao DS, ES
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        
        PRINT MSG1
        INPUT STR1
                  
        PRINT MSG2
        INPUT STR2
        
        CALL CHECK_STR
        
        MOV AH,4Ch
        INT 21h
    MAIN ENDP
    ;-------------------------------
    CHECK_STR PROC
        CLD             ;Chieu xu ly
        MOV CX, 30      ;So ky tu can xu ly
        LEA SI, STR1 
        LEA DI, STR2 
        REPE CMPSB      ;So sanh tung ky tu/byte 
        JNE DIFF
            PRINT SAME_MSG
            JMP EXIT_CHECK
        DIFF:
            PRINT DIFF_MSG
        EXIT_CHECK:
        RET
    CHECK_STR ENDP    
END