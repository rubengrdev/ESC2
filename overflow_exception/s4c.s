.include "macros.s"
.include "crt0.s" 
.data
    f: .word 0x19C7
.text 
main: 
    $MOVEI R1, f
    LDF F1, 0(R1)
    MOVEI R2, 0
    MOVEI R3, 100
for:
    $CMPLT R0, R2, R3
    BZ R0, for
    MULF F1, F1, F1
    ADDI R2, R2, 1
    BNZ R0, fi_for
fi_for:

halt
