.include "macros.s"
.include "crt0.s" 
.data
	w: .word 0x4444

;Exercici 4.7
.text 
main: 

	$MOVEI R1, w
	LD R1, 0(R1)
	$PUSH R1
	$CALL R6, mostra
	HALT


;funcio mostra:
;PRE: R1 = w = 0x4444
mostra:
	$MOVEI R2, 16
	MOVI R4, 1
	MOVI R3, 0
	OUT Rfil_pant, R3
	do_while:
		$CMPGT R0, R2, R3
		BZ R0, fi_while
		SUB R2, R2, R4	; col--
		OUT Rcol_pant, R2


		;out(Rdat_pant,’0’+(i&0x1));
		$PUSH R3
		MOVI R3, '0'
		AND R5, R1, R4	; i&0x1
		ADD R5, R3, R5	; suma valor ascii de 0 més
		OUT Rdat_pant, R5

		;out(Rcon_pant, 0x8000)
		$MOVEI R3, 0x8000
		OUT Rcon_pant, R3
		$POP R3

		;SHL
		;i = i >> 1 
		$PUSH R4
		MOVI R4, -1
		SHL R1, R1, R4
		$POP R4

	BNZ R0, do_while
	fi_while:
	JMP R6
