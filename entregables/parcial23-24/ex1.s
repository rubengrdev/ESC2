.include "macros.s"
.include "crt0.s"

;Fes un programa en SISA-F que imprimeixi 4 línies de text, introduïdes pel teclat. Una línia es defineix com una seqüència de 64 caràcters consecutius o bé una seqüència de menys de 64 caràcters acabada amb el caràcter ’\n’ (tecla return). Disposem d’un vector de 64 caràcters, anomenat línia. Es demana el codi en alt nivell i el codi SISA-F. Fes la sincronització amb els dispositius que ho requereixin per enquesta o bé per interrupció, indica clarament com vols fer-ho


;sincronització per enquesta
.data
    max_letters: .word 64
    max_lines: .word 4
    linea: .fill 64
.text
main:

;m'ha faltat fer un bucle que repeteixi 4 vegades
$CALL R6, llegir_lletres


HALT





llegir_lletres:
   MOVI R0, 0
   $MOVEI R2, max_letters
   LD R2, 0(R2)
   MOVI R5, 0 ; contador lletres
   OUT Rcon_tec, R0
   $MOVEI R3, tteclat
   MOVI R4, 10  ; ascii enter \n
do:
    IN R1, Rest_tec
    BZ R1, do

    IN R1, Rdat_tec
    ADD R1, R3, R1
    ADDI R5, R5, 1   ; contador++
    LDB R1, 0(R1)
    XOR R0, R1, R4
        $PUSH R0, R1, R2, R3, R4, R5
        ADDI R1, R5, 0   ; R1 = R5, paso per valor el num de lletres introduides
        ADDI R2, R1, 0    ; R2 = lletra en ascii
        $CALL R6, imprimeix
        $POP R5, R4, R3, R2, R1, R0
    BNZ R0, do
    JMP R6



imprimeix:
    MOVI R0, 0
    OUT Rcon_imp, R0
    $PUSH R4
    $MOVEI R4, 0x8000

    MOVI R4, 0
    MOVHI R4, 0

    ;$MOVEI R3, max_letters
    ;LDB R3, 0(R3)
    ;$CMPLT R4, R1, R3


    ;encuesta si la impresora está preparada
    IN R5, Rest_imp
    BZ R5, do

    ;impresora ya preparada
    LDB R5, 0(R2)   ;R5 <- v[i]
    OUT Rdat_imp, R5
    $POP R4
    OUT Rcon_imp, R4
    IN R5, Rest_imp
    JMP R6