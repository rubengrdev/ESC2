.include "macros.s"
.include "crt0.s" 
.text 
main: 

;Exercici 4.1 Escriu programa en alt nivell que mostri una ‘A’ a la posició [4,8] de la
;pantalla, amb atribut invers, i una ’B’ a la posició [4,9] amb atribut normal. Observa que
;la fila és la mateixa en els dos casos, així que sols cal escriure-la un cop:

$MOVEI R3,0x8000 
MOVI R1, 4
OUT Rfil_pant, R1
MOVI R1, 8
OUT Rcol_pant, R1 
$MOVEI R2, 0x100 + 'A
OUT Rdat_pant, R2 
OUT Rcon_pant, R3
;B
ADDI R1, R1, 1 
OUT Rcol_pant, R1 
$MOVEI R2, 0x000 + 'B
OUT Rdat_pant, R2 
OUT Rcon_pant, R3

HALT
