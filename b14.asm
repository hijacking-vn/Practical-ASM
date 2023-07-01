

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
    MSG1        DB  'NOI DUNG FILE: ',10,13,'$'
                                                      
    FILE_NAME   DB  'data.txt',0
    FILE_HANDLE DW  ?
    
    TEXT        DB  251 DUP('$')
.CODE
    MAIN PROC
        ;Khoi tao DS, ES
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        
        ;Mo file da co
        MOV AH,3Dh
        LEA DX,FILE_NAME
        MOV AL,2
        INT 21h
        MOV FILE_HANDLE,AX
        
        ;Doc noi dung -> TEXT
        MOV AH,3Fh
        MOV BX,FILE_HANDLE
        LEA DX,TEXT
        MOV CX,250
        INT 21h
        
        ;Dong file
        MOV AH,3Eh
        MOV BX,FILE_HANDLE
        INT 21h
        
        ;Hien thi va dung man hinh
        PRINT MSG1
        PRINT TEXT
        MOV AH,8
        INT 21h
        
        ;Thoat DOS
        MOV AH,4Ch
        INT 21h
    MAIN ENDP
END