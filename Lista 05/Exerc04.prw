#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L5_E4()

    LOCAL aNum  := {}
    LOCAL nCont := 0
    LOCAL cMsg  := ''

    for nCont := 1 TO 20
        aadd(aNum, nCont)
        if nCont % 2== 0 
        cMsg += 'Numero: ' + ALLTRIM(STR(aNum[nCont])) +CRLF
        ENDIF
    next
    FWAlertSucess(cMsg)
RETURN
