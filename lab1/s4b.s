.include "macros.s"
.include "crt0.s" 
.text 
main: 
;Exercici 4.2: Escriu un programa en alt nivell que esperi fins que es polsi una tecla
;qualsevol, i llavors escrigui una ‘A’ a la posició [4,8] de la pantalla, amb atribut normal.

MOVI R0, 0
out Rcon_tec, R0
$MOVEI R3, tteclat

;mentres R1 = 0, significa que cap tecla ha sigut presionada
do:
    IN R1, Rest_tec
    BZ R1, do

;si arriba aqui es que ha pulsat una tecla

$MOVEI R3,0x8000 
MOVI R1, 4
OUT Rfil_pant, R1
MOVI R1, 8
OUT Rcol_pant, R1 
$MOVEI R2, 0x000 + 'A   ;0x000: atribut normal 0x100 atribut invers
OUT Rdat_pant, R2 
OUT Rcon_pant, R3


HALT
