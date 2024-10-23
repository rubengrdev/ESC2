.include "macros.s"
.include "crt0.s" 
.data
	w: .word 0xFFF9
;Exercici 4.7 modificacions:
.text 
main: 
	
;2) Esperar fins que es polsi una tecla.
	MOVI R0, 0
	out Rcon_tec, R0
	MOVI R5, 1

do_1:
    BZ R5, do_1
    $MOVEI R3, tteclat
    ;mentres R1 = 0, significa que cap tecla ha sigut presionada
do:
    IN R1, Rest_tec
    BZ R1, do

    ;si arriba aqui es que ha pulsat una tecla
    IN R4, Rdat_tec   ; R4 <- codigo rastreo
    ADD R4, R4, R3      ;tteclat[codi rastreo]
    LDB R4, 0(R4)       ; R4 = lletra ascii

    $PUSH R1, R2, R3, R4, R5

    $MOVEI R1, w
	LD R1, 0(R1)	;carrega valor de w a R1

    MOVI R2, 'A'
if1:	;if(tecla_polsada == 'A')
	$CMPEQ R0, R4, R2
	BZ R0, fi_if1
	MOVI R2, 1
	SHL R1, R1, R2	;shift logic 1 lloc a l'esquerra
fi_if1:

	MOVI R2, 'B'
if_2:	;if(tecla_polsada == 'B')
    $CMPEQ R0, R4, R2
	BZ R0, fi_if2
	MOVI R2, -1
	SHL R1, R1, R2	;shift logic 1 lloc a la dreta
fi_if2:

	MOVI R2, 'C'
if_3:	;if(tecla_polsada == 'C')
    $CMPEQ R0, R4, R2
	BZ R0, fi_if3
	MOVI R2, -1
	SHA R1, R1, R2	;desplaçament aritmetic a la dreta
fi_if3:

	MOVI R2, 'D'
if_4:	;if(tecla_polsada == 'D')
    $CMPEQ R0, R4, R2
	BZ R0, fi_if4
	MOVI R2, 2
	DIV R1, R1, R2		;dividir entre 2 l'enter w
fi_if4:

	MOVI R2, '0
if_5:
	$CMPGE R0, R4, R2
	BZ R0, fi_if5

	MOVI R2, '9
	$CMPLE R0, R4, R2
	BZ R0, fi_if5

	MOVI R2, '0
	SUB R1, R4, R2
	MOVI R2, 1
	SHL R1, R2, R1
	ADDI R1, R1, -1
	$MOVEI R2, w
	LD R2, 0(R2)
	XOR R1, R2, R1 
fi_if5:





	
	;guardar la modificació a la variable w
	$PUSH R0
	$MOVEI R0, w
	ST 0(R0), R1 
	$POP R0


	$CALL R6, mostra
	$POP R5, R4, R3, R2, R1

BNZ R5, do_1


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
