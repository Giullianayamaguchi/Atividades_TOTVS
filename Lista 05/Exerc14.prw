/* 14 – Carregar um array com 12 caracteres gerados
aleatoriamente (randômicos). Serão válidos
apenas caracteres que representem letras
minúsculas (de “a” até “z”). A carga do array
deverá ser feita através de uma função estática
que é chamada automaticamente no programa
principal. Os caracteres NÃO podem se repetir. No
final, exibir o vetor gerado.
Obs: A exibição deverá ser feita função estática.*/

#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L5_E14()
    LOCAL aRan  := {}

    Carga(aRan)
    VALIDA(aRan)
    
RETURN

STATIC FUNCTION Carga(aRan)
    LOCAL cRan  := ''
    LOCAL nCont := 0
    LOCAL cMsg  := ''
    LOCAL nVali := 0

    for nCont := 1 to 12
        cRan := chr(RANDOMIZE( 0, 127 ))
        nVali := ASCAN(aRan, cRan)
        if nVali == 0

            aadd(aRan, cRan)
        ENDIF
        cMsg += aRan[nCont] + " "
    NEXT
    
    FWAlertSucess(cMsg, 'RANDOM')

RETURN aRan

STATIC FUNCTION VALIDA(aRan)
    
    LOCAL cMsg2 := ''
    LOCAL nCon  := 0
    LOCAL nCont := 0

    for nCont := 1 to 12
        if aRan[nCont] >= chr(97) .and. aRan[nCont] <= CHR(122)
           cMsg2 += aRan[nCont] + " "
            nCon++
        ENDIF
    NEXT
    FWAlertSucess("Existem " + alltrim(str(nCon))+ " entre “a” até “z”: " +CRLF + cMsg2)


RETURN
