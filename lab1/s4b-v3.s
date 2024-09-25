.include "macros.s"
.include "crt0.s" 
.text 
main: 
;Exercici 4.4: Escriu en alt nivell una nova versió del programa anterior, tal que faci la
;mateixa tasca (llegir una tecla i escriure-la en pantalla) però repetidament, fins que la
;tecla polsada sigui una ’F’. Fixa’t que es tracta sols d’insertar l’anterior programa dins un
;bucle.

MOVI R0, 0
out Rcon_tec, R0
MOVI R5, 1
do_1:
    BZ R5, do_1
    $MOVEI R3, tteclat
    MOVI R0, 'F
    ;mentres R1 = 0, significa que cap tecla ha sigut presionada
do:
    IN R1, Rest_tec
    BZ R1, do

    ;si arriba aqui es que ha pulsat una tecla
    IN R4, Rdat_tec   ; R4 <- codigo rastreo
    ADD R4, R4, R3      ;tteclat[codi rastreo]
    LDB R4, 0(R4)       ; R4 = lletra ascii

    $MOVEI R3,0x8000
    MOVI R1, 4
    OUT Rfil_pant, R1
    MOVI R1, 8
    OUT Rcol_pant, R1 
    ;R4 = SUMA de 0x000 (atribut normal) + R4 ascii tecla presionada
    ADDI R2, R4, 0   ;0x000: atribut normal 0x100 atribut invers
    OUT Rdat_pant, R2 
    OUT Rcon_pant, R3

XOR R5, R4, R0
BNZ R5, do_1

HALT