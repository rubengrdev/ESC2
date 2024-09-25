.include "macros.s"
.include "crt0.s" 
.text 
main: 
;Exercici 4.3: Escriu una nova versió del programa en alt nivell anterior per tal que, en
;comptes d’una ‘A’, escrigui el caràcter associat a la tecla polsada. Fixa’t que es tracta de
;fer sols un petit canvi en la finalització. Recorda que per traduir el codi de rastreig del
;teclat es disposa del vector tteclat.
;Ara, tradueix l’anterior codi a assemblador SISA-F en el mateix fitxer s4b.s (sols cal afegir
;les modificacions). Assembla’l i comprova que funciona, amb el simulador.

MOVI R0, 0
out Rcon_tec, R0
$MOVEI R3, tteclat

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


HALT