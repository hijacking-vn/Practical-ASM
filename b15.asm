 
PRINT MACRO BIEN1
    MOV AH,9
    LEA DX,BIEN1
    INT 21h
ENDM

;15b: xoa 1 tep tin co san
.MODEL SMALL
.STACK 100
.DATA
    MSG1        DB  'XOA FILE THANH CONG!$'
                                                      
    FILE_NAME   DB  'data.txt',0
    FILE_HANDLE DW  ?
.CODE
    MAIN PROC
        ;Khoi tao DS, ES
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        
        ;File dang mo
        MOV AH,3Dh
        LEA DX,FILE_NAME
        MOV AL,0
        INT 21h
        MOV FILE_HANDLE,AX
        
        ;Close file
        MOV AH,3Eh
        MOV BX,FILE_HANDLE
        INT 21h
        
        ;Xoa file
        MOV AH,41h
        LEA DX,FILE_NAME
        INT 21h
        
        PRINT MSG1
        
        ;Thoat DOS
        MOV AH,4Ch
        INT 21h
    MAIN ENDP
END