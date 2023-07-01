

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
    MSG1        DB        'NHAP TEN FILE: $'
    MSG2        DB  10,13,'NHAP NOI DUNG: $'
                                                      
    FILE_NAME   DB  20  DUP('$')
    LEN         DW  ? 
    FILE_HANDLE DW  ?
    
    TEXT        DB  255 DUP('$')
    TEXT_SIZE   DW  ?
.CODE
    MAIN PROC
        ;Khoi tao DS, ES
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        
        PRINT MSG1
        INPUT FILE_NAME
        
        GET_SIZE FILE_NAME
        MOV LEN,AX
        
        ;Dua zero ve cuoi FILE_NAME
        MOV AL,0
        LEA BX,FILE_NAME+2
        ADD BX,LEN
        MOV [BX],AL
        
        ;Tao file
        MOV AH,3Ch
        LEA DX,FILE_NAME+2
        MOV CX,0
        INT 21h
        MOV FILE_HANDLE,AX
        
        PRINT MSG2
        INPUT TEXT
        GET_SIZE TEXT
        MOV TEXT_SIZE,AX
               
        ;Viet vao file
        MOV AH,40h
        MOV BX,FILE_HANDLE
        LEA DX,TEXT+2
        MOV CX,TEXT_SIZE
        INT 21h
        
        ;Dong file
        MOV AH,3Eh
        MOV BX,FILE_HANDLE
        INT 21h
        
        ;Thoat DOS
        MOV AH,4Ch
        INT 21h
    MAIN ENDP
END