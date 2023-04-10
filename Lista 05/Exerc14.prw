/* 14 � Carregar um array com 12 caracteres gerados
aleatoriamente (rand�micos). Ser�o v�lidos
apenas caracteres que representem letras
min�sculas (de �a� at� �z�). A carga do array
dever� ser feita atrav�s de uma fun��o est�tica
que � chamada automaticamente no programa
principal. Os caracteres N�O podem se repetir. No
final, exibir o vetor gerado.
Obs: A exibi��o dever� ser feita fun��o est�tica.*/

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
    FWAlertSucess("Existem " + alltrim(str(nCon))+ " entre �a� at� �z�: " +CRLF + cMsg2)


RETURN
