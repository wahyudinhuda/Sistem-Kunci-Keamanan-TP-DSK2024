include emu8086.inc
.MODEL SMALL
.DATA   
        SIZE EQU 10
        HEAD DB '============SISTEM KUNCI KEAMANAN============','$'
        MSG1 DB 13, 10, 'Masukkan Kode Nama anda: $'
        MSG2 DB 13, 10, 'Masukkan Kode Angka: $'
        MSG3 DB 13, 10, 'GAGAL, tidak ditemukan!$'
        MSG4 DB 13, 10, 'Salah! Data ditolak dan coba lagi$'
        MSG5 DB 13, 10, 'Berhasil! Data di terima dan perangkat anda telah aman$'
        MSG6 DB 13, 10, 'Angka terlalu panjang!$'
        NAMA DW 1 DUP(?),0
        KATA_SANDI DB 1 DUP(?)
        CodeNama = $-NAMA
        CodeAngka = $-ANGKA
        Namacod  DW        'WHY1', 'DMS2', 'GVN3', 'RZ4', 'GLG5', 'FWZ6', 'DRT7', 'FND8', 'ZEK9', 'DVA0' 
        Angkacod DB   5,      4,      3,      2,       1,     10,     9,     8,     7,      6
    
.CODE
MAIN        PROC
            MOV AX,@DATA
            MOV DS,AX
            MOV AX,0000H
            

Ket:        LEA DX,HEAD
            MOV AH,09H
            INT 21H

PERMIN:     LEA DX,MSG1
            MOV AH,09H
            INT 21H
            
            
MASUK:      MOV BX,0
            MOV DX,0
            LEA DI,NAMA
            MOV DX,CodeNama
            CALL get_string
            

Cekk:       MOV BL,0
            MOV SI,0

COBALAGI:   MOV AX,Namacod[SI] 
            MOV DX,NAMA
            CMP DX,AX
            JE  PERMIN_A
            INC BL
            ADD SI,4
            CMP BL,SIZE
            JB  COBALAGI
            
ERRORMSG:   LEA DX,MSG3
            MOV AH,09H
            INT 21H
            JMP PERMIN
             
            
PERMIN_A:   LEA DX,MSG2
            MOV AH,09H
            INT 21H
            
A_MASUK:    CALL   scan_num
            CMP    CL,0FH
            JAE    PANJANG
            MOV    BH,00H
            MOV    DL,Angkacod[BX]
            CMP    CL,DL
            JE     BERHASIL 

            
GAGAL:      LEA DX,MSG4
            MOV AH,09H
            INT 21H
            JMP PERMIN
            
BERHASIL:   LEA DX,MSG5
            MOV AH,09H
            INT 21H
            JMP Selesai

PANJANG:    LEA DX,MSG6
            MOV AH,09H
            INT 21H
            JMP PERMIN_A
            

DEFINE_SCAN_NUM
DEFINE_GET_STRING
Selesai:        
END MAIN        