.include "macros.s"
.include "crt0.s"
.data
    v: .byte 'A', 'q', 'u', 'e', 's', 't', ' ', 'p', 'r', 'o', 'g', 'r', 'a', 'm', 'a', ' ', 'f', 'u', 'n', 'c', 'i', 'o', 'n', 'a'
.text
main:
;R1 = 0
$MOVEI R1, 0
;R2 = v
$MOVEI R2, v
;R3 = v[i]

print:
    MOVI R0, 0
    OUT Rcon_imp, R0
    $MOVEI R4, 0x8000

for:
    ;v[i] == &v[n]
    LDB R3, 0(R2)
    $CMPLTU R5, R1, R3
    BZ R5, fi_for

do:
    ;encuesta si la impresora está preparada
    IN R5, Rest_imp
    BZ R5, do

    ;impresora ya preparada
    LDB R5, 0(R2)   ;R5 <- v[i]
    OUT Rdat_imp, R5
    OUT Rcon_imp, R4
    ADDI R2, R2, 1    ;seguent lletra
    BNZ R2, for
fi_for:
do_2:
    IN R5, Rest_imp
    BZ R5, do_2
    JMP R6


