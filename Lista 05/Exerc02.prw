#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L5_E2()

    LOCAL aNum  := {}
    LOCAL nCont := 0
    LOCAL cMsg  := ''
    LOCAL nNum  := 0

    for nCont := 1 TO 10

        nNum :=vAL(FwInputBox("Digite o "+ ALLTRIM(STR(nCont)) + "° número:  "))
        aadd(aNum, nNum)

    next

    for nCont := 10 to 1 step -1
        cMsg += 'Numero: ' + ALLTRIM(STR(aNum[nCont])) +CRLF
    
        FWAlertSucess(cMsg)
    NEXT
RETURN
