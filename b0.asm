

PRINT MACRO BIEN1
    MOV AH,9
    LEA DX,BIEN1
    INT 21h
ENDM

;a. Nhap MSV, hien thi ten
.MODEL SMALL
.STACK 100
.DATA
    MSG1    DB  'NHAP MSV: $'
    MSV     DB  'THEM MSV VAO'    
    HOTEN   DB  10,13,'HO TEN: THEM HO TEN VAO$'
    MSG2    DB  10,13,'SAI MSV.$'
    
    STR     DB  10 DUP('$')
.CODE
    MAIN PROC
        ;Khoi tao DS, ES
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        
        ;Nhap MSV
        PRINT MSG1
        
        LEA DX,STR
        MOV AH,10
        INT 21h
        
        CLD         ;Chieu xu ly
        MOV CX,8    ;So ky tu can xu ly
        LEA SI, MSV 
        LEA DI, STR+2 
        REPE CMPSB  ;So sanh tung ky tu/byte 
        JE IN_HOTEN
        PRINT MSG2
        JMP EXIT
        
        IN_HOTEN:
            PRINT HOTEN
        
        EXIT:
        MOV AH,4Ch
        INT 21h
    MAIN ENDP
END