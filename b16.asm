

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

GET_SIZE MACRO STR
    MOV AX,0
    MOV AL,[STR+1]
ENDM

;12b: so sanh 2 chuoi ky tu
.MODEL SMALL
.STACK 100
.DATA                                                 
    OLD_FILE    DB  'data.txt',0
    NEW_FILE    DB  'new-data.txt',0
    FILE_HANDLE DW  ?
.CODE
    MAIN PROC
        ;Khoi tao DS, ES
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
      
        ;Rename file
        MOV AH,56h
        LEA DX,OLD_FILE
        LEA DI,NEW_FILE
        INT 21h
        
        ;Thoat DOS
        MOV AH,4Ch
        INT 21h
    MAIN ENDP
END