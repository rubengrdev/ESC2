.include "macros.s"
.include "crt0.s" 
.data
    v: .byte 'F', 'i'
.text 
main: 
;R1 = n
;R2 = v[0]
;R3 = &v[n]

$MOVEI R1, n
LD R1, 0(R1)

$MOVEI R2, v

print:
    ADD R3, R2, R1

    MOVI R0, 0
    OUT Rcon_imp, R0
    $MOVEI R4, 0x8000

for:
    ;&v[i] < &v[n]
    $CMPLTU R5, R2, R3
    BZ R5, fi_for

do:
    ;encuesta si la impresora está preparada
    IN R5, Rest_imp
    BZ R5, do

    ;impresora ya preparada
    LDB R5, 0(R2)   ;R5 <- v[i]
    OUT Rdat_imp, R5
    OUT Rcon_imp, R4
    ADDI R2, R2, 1
    BNZ R2, for
fi_for:
do_2:
    IN R5, Rest_imp
    BZ R5, do_2
    JMP R6



halt