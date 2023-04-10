#INCLUDE 'PROTHEUS.CH'

USER FUNCTION L5_E5()

    LOCAL aNum  := {}
    LOCAL aNum2 := {}
    LOCAL nNum  := 0
    LOCAL nCont := 0
    LOCAL cMsg  := ''
    LOCAL nSoma := 0
    LOCAL aNum3 := {}

    for nCont := 1 TO 10
        nNum :=vAL(FwInputBox("Digite o "+ ALLTRIM(STR(nCont)) + "° número do 1 array:  "))
        nNum :=vAL(FwInputBox("Digite o "+ ALLTRIM(STR(nCont)) + "° número do 2 array:  "))
        
        aadd(aNum, nNum)
        aadd(aNum2, nNum)
    next

    for nCont := 1 to 10
        nSoma := aNum[nCont] + aNum2[nCont]
        aadd(aNum3, nSoma)
        cMsg += 'Numero: ' + ALLTRIM(STR(aNum3[nCont])) + " "
    NEXT
    FWAlertSucess(cMsg)
RETURN
