#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L5_E3()

    LOCAL aNum  := {}
    LOCAL nCont := 0
    LOCAL cMsg  := ''

    for nCont := 1 TO 30

        aadd(aNum, nCont)
        cMsg += 'Numero: ' + ALLTRIM(STR(aNum[nCont])) +CRLF

    next
    FWAlertSucess(cMsg)
RETURN
