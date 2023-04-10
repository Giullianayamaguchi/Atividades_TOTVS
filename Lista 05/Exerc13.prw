/* 13 – Carregar um Array com 50 caracteres gerados
aleatoriamente (randômicos). Serão válidos
apenas caracteres que representem letras
maiúsculas (de “A” até “Z”). A carga do array
deverá ser feita através de uma função estática
que é chamada automaticamente no programa
principal. Obs: Os caracteres podem se repetir.*/

#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L5_E13()
    LOCAL aRan  := {}

    Carga(aRan)
    VALIDA(aRan)
    
RETURN

STATIC FUNCTION Carga(aRan)
    LOCAL cRan  := ''
    LOCAL nCont := 0
    LOCAL cMsg  := ''

    for nCont := 1 to 50
        cRan := RANDOMIZE( 0, 127 )
        cRan := CHR( cRan )

        aadd(aRan, cRan)
        cMsg += aRan[nCont] + " "
    NEXT
    
    FWAlertSucess(cMsg, 'RANDOM')

RETURN aRan

STATIC FUNCTION VALIDA(aRan)
    
    LOCAL cMsg2 := ''
    LOCAL nCon  := 0
    LOCAL nCont := 0

    for nCont := 1 to 50
        if aRan[nCont] >= chr(65) .and. aRan[nCont] <= CHR( 90 )
           cMsg2 += aRan[nCont] + " "
            nCon++
        ENDIF
    NEXT
    FWAlertSucess("Existem " + alltrim(str(nCon))+ "entre “A” até “Z”: " +CRLF + cMsg2)


RETURN
